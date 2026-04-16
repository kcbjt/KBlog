import axios from '@/util/request'

export function getSiteSettingData() {
	return axios({
		url: '/blog-api/admin/siteSettings',
		method: 'GET'
	})
}

export function update(settings, deleteIds) {
	return axios({
		url: '/blog-api/admin/siteSettings',
		method: 'POST',
		data: {
			settings,
			deleteIds
		}
	})
}

export function getWebTitleSuffix() {
	return axios({
		url: '/blog-api/admin/webTitleSuffix',
		method: 'GET'
	})
}