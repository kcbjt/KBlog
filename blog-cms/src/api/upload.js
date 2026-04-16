import axios from '@/util/request'

export function upload(file) { // 参数直接传 file 对象，或者确保传入的是 FormData
    // 1. 创建 FormData 对象
    const formData = new FormData();
    // 2. 将文件添加进去，'file' 是键名，必须和后端 @RequestParam("file") 一致
    formData.append('file', file);

    return axios({
        url: '/blog-api/upload/image',
        method: 'POST',
        data: formData,
        // 3. 显式设置 Content-Type (虽然浏览器通常会自动设置，但显式设置更稳妥)
        headers: {
            'Content-Type': 'multipart/form-data'
        }
    })
}