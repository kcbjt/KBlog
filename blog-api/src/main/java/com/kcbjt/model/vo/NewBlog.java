package com.kcbjt.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @Description: 最新推荐博客
 * @Author: kcbjt
 * @Date: 2026-04-15
 */
@NoArgsConstructor
@Getter
@Setter
@ToString
public class NewBlog {
	private Long id;
	private String title;
	private String password;
	private Boolean privacy;
}
