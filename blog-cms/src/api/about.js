import axios from '@/util/request'

export function getAbout() {
	return axios({
		url: '/blog-api/admin/about',
		method: 'GET'
	})
}

export function updateAbout(form) {
	return axios({
		url: '/blog-api/admin/about',
		method: 'PUT',
		data: {
			...form
		}
	})
}