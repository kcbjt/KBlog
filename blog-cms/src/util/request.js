import axios from 'axios'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import { Message } from 'element-ui'

const request = axios.create({
  baseURL: process.env.VUE_APP_API_BASE_URL || '',
  timeout: 10000,
})

let CancelToken = axios.CancelToken

// 请求拦截
request.interceptors.request.use(config => {
  // 1. 修复访客模式逻辑
  const userJsonStr = window.localStorage.getItem('user')
  // 增加非空判断，防止 JSON.parse 报错
  if (userJsonStr && userJsonStr !== '{}') {
    const user = JSON.parse(userJsonStr)
    // 如果不是管理员 且 不是 GET 请求，则拦截
    if (user.role !== 'ROLE_admin' && config.method !== 'get') {
      config.cancelToken = new CancelToken(function executor(cancel) {
        cancel('演示模式，不允许操作')
      })
      return config
    }
  }

  NProgress.start()
  const token = window.localStorage.getItem('token')
  if (token) {
    // 建议加上 Bearer 前缀，除非你后端不需要
    config.headers.Authorization = token
  }
  return config
},
error => {
  console.error('请求拦截错误:', error)
  return Promise.reject(error)
}
)

// 响应拦截
request.interceptors.response.use(response => {
  NProgress.done()

  // --- 修改核心区域 START ---
  const res = response.data

  // 【关键调试代码】：请在浏览器控制台查看这个日志，确认后端返回的字段名
  // 如果后端返回的是 { success: true, url: ... }，这里会显示出来
  // console.log('🔍 响应数据:', res)

  // 兼容处理：检查 code 是否为 200，或者 success 是否为 true
  // 这样能适配你之前提到的后端代码 (success: true) 和标准代码 (code: 200)
  const isSuccess = res.code === 200 || res.success === true

  if (!isSuccess) {
    // 兼容 msg 和 message 字段
    let msg = res.msg || res.message || '系统错误'
    Message.error(msg)
    return Promise.reject(new Error(msg))
  }

  return res
  // --- 修改核心区域 END ---
},
error => {
  NProgress.done()
  console.error('🚫 网络错误:', error)

  // 处理取消请求的情况（不弹窗）
  if (axios.isCancel(error)) {
    // 可以在这里打印一个静默的日志，或者不处理
    return Promise.reject(error)
  }

  let msg = error.message || '网络异常'
  // 处理常见的 HTTP 状态码
  if (error.response) {
    switch (error.response.status) {
      case 401: msg = '未授权，请重新登录'; break
      case 403: msg = '拒绝访问'; break
      case 404: msg = '请求地址不存在'; break
      case 500: msg = '服务器内部错误'; break
      case 502: msg = '网关错误'; break
      default: msg = `连接错误${error.response.status}`
    }
  } else if (error.code === 'ECONNABORTED') {
    msg = '请求超时'
  }

  Message.error(msg)
  return Promise.reject(error)
}
)

export default request