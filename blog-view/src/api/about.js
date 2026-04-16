import axios from '@/plugins/axios'

export function getAbout() {
	return axios({
		url: '/blog-api/about',
		method: 'GET'
	})
}