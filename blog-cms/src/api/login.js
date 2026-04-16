import axios from '@/util/request'

export function login(loginForm) {
	return axios({
		url: '/blog-api/admin/login',
		method: 'POST',
		data: {
			...loginForm
		}
	})
}
