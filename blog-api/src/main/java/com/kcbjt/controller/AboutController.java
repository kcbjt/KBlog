package com.kcbjt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import com.kcbjt.annotation.VisitLogger;
import com.kcbjt.enums.VisitBehavior;
import com.kcbjt.model.vo.Result;
import com.kcbjt.service.AboutService;

/**
 * @Description: 关于我页面
 * @Author: kcbjt
 * @Date: 2026-04-15
 */
@RestController
public class AboutController {
	@Autowired
	AboutService aboutService;

	/**
	 * 获取关于我页面信息
	 *
	 * @return
	 */
	@VisitLogger(VisitBehavior.ABOUT)
	@GetMapping("/about")
	public Result about() {
		return Result.ok("获取成功", aboutService.getAboutInfo());
	}
}
