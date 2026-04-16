package com.kcbjt.exception;

/**
 * @Description: 非法请求异常
 * @Author: kcbjt
 * @Date: 2026-04-15
 */

public class BadRequestException extends RuntimeException {
	public BadRequestException() {
	}

	public BadRequestException(String message) {
		super(message);
	}

	public BadRequestException(String message, Throwable cause) {
		super(message, cause);
	}
}
