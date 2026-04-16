package com.kcbjt.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.kcbjt.entity.VisitRecord;
import com.kcbjt.mapper.VisitRecordMapper;
import com.kcbjt.service.VisitRecordService;

/**
 * @Description: 访问记录业务层实现
 * @Author: kcbjt
 * @Date: 2026-04-15
 */
@Service
public class VisitRecordServiceImpl implements VisitRecordService {
	@Autowired
	VisitRecordMapper visitRecordMapper;

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void saveVisitRecord(VisitRecord visitRecord) {
		visitRecordMapper.saveVisitRecord(visitRecord);
	}
}
