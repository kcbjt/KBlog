import axios from '@/util/request'

export function getExceptionLogList(queryInfo) {
	return axios({
		url: '/blog-api/admin/exceptionLogs',
		method: 'GET',
		params: {
			...queryInfo
		}
	})
}

export function deleteExceptionLogById(id) {
	return axios({
		url: '/blog-api/admin/exceptionLog',
		method: 'DELETE',
		params: {
			id
		}
	})
}