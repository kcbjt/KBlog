import axios from '@/util/request'

export function getData(queryInfo) {
	return axios({
		url: '/blog-api/admin/categories',
		method: 'GET',
		params: {
			...queryInfo
		}
	})
}

export function addCategory(form) {
	return axios({
		url: '/blog-api/admin/category',
		method: 'POST',
		data: {
			...form
		}
	})
}

export function editCategory(form) {
	return axios({
		url: '/blog-api/admin/category',
		method: 'PUT',
		data: {
			...form
		}
	})
}

export function deleteCategoryById(id) {
	return axios({
		url: '/blog-api/admin/category',
		method: 'DELETE',
		params: {
			id
		}
	})
}