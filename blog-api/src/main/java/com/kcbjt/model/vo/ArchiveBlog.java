package com.kcbjt.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @Description: 归档页面博客简要信息
 * @Author: kcbjt
 * @Date: 2026-04-15
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
public class ArchiveBlog {
	private Long id;
	private String title;
	private String day;
	private String password;
	private Boolean privacy;
}
