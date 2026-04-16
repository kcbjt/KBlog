import axios from '@/util/request'

export function getVisitLogList(queryInfo) {
	return axios({
		url: '/blog-api/admin/visitLogs',
		method: 'GET',
		params: {
			...queryInfo
		}
	})
}

export function deleteVisitLogById(id) {
	return axios({
		url: '/blog-api/admin/visitLog',
		method: 'DELETE',
		params: {
			id
		}
	})
}