import axios from '@/plugins/axios'

export function getBlogListByCategoryName(categoryName, pageNum) {
	return axios({
		url: '/blog-api/category',
		method: 'GET',
		params: {
			categoryName,
			pageNum
		}
	})
}