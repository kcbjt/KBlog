import axios from '@/util/request'

export function getCommentListByQuery(queryInfo) {
	return axios({
		url: '/blog-api/admin/comments',
		method: 'GET',
		params: {
			...queryInfo
		}
	})
}

export function getBlogList() {
	return axios({
		url: '/blog-api/admin/blogIdAndTitle',
		method: 'GET'
	})
}

export function updatePublished(id, published) {
	return axios({
		url: '/blog-api/admin/comment/published',
		method: 'PUT',
		params: {
			id,
			published
		}
	})
}

export function updateNotice(id, notice) {
	return axios({
		url: '/blog-api/admin/comment/notice',
		method: 'PUT',
		params: {
			id,
			notice
		}
	})
}

export function deleteCommentById(id) {
	return axios({
		url: '/blog-api/admin/comment',
		method: 'DELETE',
		params: {
			id
		}
	})
}

export function editComment(form) {
	return axios({
		url: '/blog-api/admin/comment',
		method: 'PUT',
		data: {
			...form
		}
	})
}