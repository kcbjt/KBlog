import axios from '@/plugins/axios'

export function getData() {
	return axios({
		url: '/blog-api/friends',
		method: 'GET'
	})
}

export function addViewsByNickname(nickname) {
	return axios({
		url: '/blog-api/friend',
		method: 'POST',
		params: {
			nickname
		}
	})
}