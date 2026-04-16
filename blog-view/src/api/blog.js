import axios from '@/plugins/axios'

export function getBlogById(token, id) {
	return axios({
		url: '/blog-api/blog',
		method: 'GET',
		headers: {
			Authorization: token,
		},
		params: {
			id
		}
	})
}

export function checkBlogPassword(blogPasswordForm) {
	return axios({
		url: '/blog-api/checkBlogPassword',
		method: 'POST',
		data: {
			...blogPasswordForm
		}
	})
}

export function getSearchBlogList(query) {
	return axios({
		url: '/blog-api/searchBlog',
		method: 'GET',
		params: {
			query
		}
	})
}