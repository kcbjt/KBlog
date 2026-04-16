import axios from '@/util/request'

export function getVisitorList(queryInfo) {
	return axios({
		url: '/blog-api/admin/visitors',
		method: 'GET',
		params: {
			...queryInfo
		}
	})
}

export function deleteVisitor(id, uuid) {
	return axios({
		url: '/blog-api/admin/visitor',
		method: 'DELETE',
		params: {
			id,
			uuid
		}
	})
}