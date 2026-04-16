import axios from '@/util/request'

export function getLoginLogList(queryInfo) {
	return axios({
		url: '/blog-api/admin/loginLogs',
		method: 'GET',
		params: {
			...queryInfo
		}
	})
}

export function deleteLoginLogById(id) {
	return axios({
		url: '/blog-api/admin/loginLog',
		method: 'DELETE',
		params: {
			id
		}
	})
}