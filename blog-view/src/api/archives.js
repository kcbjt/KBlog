import axios from '@/plugins/axios'

export function getArchives() {
	return axios({
		url: '/blog-api/archives',
		method: 'GET'
	})
}