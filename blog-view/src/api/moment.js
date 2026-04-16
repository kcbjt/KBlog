import axios from '@/plugins/axios'

export function getMomentListByPageNum(token, pageNum) {
	return axios({
		url: '/blog-api/moments',
		method: 'GET',
		headers: {
			Authorization: token,
		},
		params: {
			pageNum
		}
	})
}

export function likeMoment(id) {
	return axios({
		url: `moment/like/${id}`,
		method: 'POST',
	})
}