import axios from '@/plugins/axios'

export function getBlogListByTagName(tagName, pageNum) {
	return axios({
		url: '/blog-api/tag',
		method: 'GET',
		params: {
			tagName,
			pageNum
		}
	})
}