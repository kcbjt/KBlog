import axios from '@/util/request'

export function getDashboard() {
	return axios({
		url: '/blog-api/admin/dashboard',
		method: 'GET'
	})
}