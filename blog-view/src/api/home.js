import axios from '@/plugins/axios'

export function getBlogList(pageNum) {
	return axios({
		url: '/blog-api/blogs',
		method: 'GET',
		params: {
			pageNum
		}
	})
}