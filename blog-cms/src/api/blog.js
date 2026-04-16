import axios from '@/util/request'

export function getDataByQuery(queryInfo) {
	return axios({
		url: '/blog-api/admin/blogs',
		method: 'GET',
		params: {
			...queryInfo
		}
	})
}

export function deleteBlogById(id) {
	return axios({
		url: '/blog-api/admin/blog',
		method: 'DELETE',
		params: {
			id
		}
	})
}

export function getCategoryAndTag() {
	return axios({
		url: '/blog-api/admin/categoryAndTag',
		method: 'GET'
	})
}

export function saveBlog(blog) {
	return axios({
		url: '/blog-api/admin/blog',
		method: 'POST',
		data: {
			...blog
		}
	})
}

export function updateTop(id, top) {
	return axios({
		url: '/blog-api/admin/blog/top',
		method: 'PUT',
		params: {
			id,
			top
		}
	})
}

export function updateRecommend(id, recommend) {
	return axios({
		url: '/blog-api/admin/blog/recommend',
		method: 'PUT',
		params: {
			id,
			recommend
		}
	})
}

export function updateVisibility(id, form) {
	return axios({
		url: `blog/${id}/visibility`,
		method: 'PUT',
		data: {
			...form
		}
	})
}

export function getBlogById(id) {
	return axios({
		url: '/blog-api/admin/blog',
		method: 'GET',
		params: {
			id
		}
	})
}

export function updateBlog(blog) {
	return axios({
		url: '/blog-api/admin/blog',
		method: 'PUT',
		data: {
			...blog
		}
	})
}