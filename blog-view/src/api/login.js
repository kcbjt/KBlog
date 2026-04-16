import axios from '@/plugins/axios'

export function login(loginForm) {
	return axios({
		url: '/blog-api/login',
		method: 'POST',
		data: {
			...loginForm
		}
	})
}
