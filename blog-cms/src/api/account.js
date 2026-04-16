import axios from '@/util/request'

export function changeAccount(account) {
	return axios({
		url: '/blog-api/admin/account',
		method: 'POST',
		data: {
			...account
		}
	})
}
