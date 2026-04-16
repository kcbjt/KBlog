package com.kcbjt.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.kcbjt.entity.OperationLog;
import com.kcbjt.exception.PersistenceException;
import com.kcbjt.mapper.OperationLogMapper;
import com.kcbjt.model.dto.UserAgentDTO;
import com.kcbjt.service.OperationLogService;
import com.kcbjt.util.IpAddressUtils;
import com.kcbjt.util.UserAgentUtils;

import java.util.List;

/**
 * @Description: 操作日志业务层实现
 * @Author: kcbjt
 * @Date: 2026-04-15
 */
@Service
public class OperationLogServiceImpl implements OperationLogService {
	@Autowired
	OperationLogMapper operationLogMapper;
	@Autowired
	UserAgentUtils userAgentUtils;

	@Override
	public List<OperationLog> getOperationLogListByDate(String startDate, String endDate) {
		return operationLogMapper.getOperationLogListByDate(startDate, endDate);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void saveOperationLog(OperationLog log) {
		String ipSource = IpAddressUtils.getCityInfo(log.getIp());
		UserAgentDTO userAgentDTO = userAgentUtils.parseOsAndBrowser(log.getUserAgent());
		log.setIpSource(ipSource);
		log.setOs(userAgentDTO.getOs());
		log.setBrowser(userAgentDTO.getBrowser());
		if (operationLogMapper.saveOperationLog(log) != 1) {
			throw new PersistenceException("日志添加失败");
		}
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void deleteOperationLogById(Long id) {
		if (operationLogMapper.deleteOperationLogById(id) != 1) {
			throw new PersistenceException("删除日志失败");
		}
	}
}
