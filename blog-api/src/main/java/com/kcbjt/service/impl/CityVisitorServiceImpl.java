package com.kcbjt.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.kcbjt.entity.CityVisitor;
import com.kcbjt.mapper.CityVisitorMapper;
import com.kcbjt.service.CityVisitorService;

/**
 * @Description: 城市访客数量统计业务层实现
 * @Author: kcbjt
 * @Date: 2026-04-15
 */
@Service
public class CityVisitorServiceImpl implements CityVisitorService {
	@Autowired
	CityVisitorMapper cityVisitorMapper;

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void saveCityVisitor(CityVisitor cityVisitor) {
		cityVisitorMapper.saveCityVisitor(cityVisitor);
	}
}
