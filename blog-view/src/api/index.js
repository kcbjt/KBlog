import axios from '@/plugins/axios'

export function getHitokoto() {
	return axios({
		url: '/blog-api/https://v1.hitokoto.cn/?c=a',
		method: 'GET'
	})
}

export function getSite() {
	return axios({
		url: '/blog-api/site',
		method: 'GET'
	})
}