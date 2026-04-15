package top.naccl.exception;

/**
 * @Description: 持久化异常
 * @Author: kcbjt
 * @Date: 2026-04-15
 */

public class PersistenceException extends RuntimeException {
	public PersistenceException() {
	}

	public PersistenceException(String message) {
		super(message);
	}

	public PersistenceException(String message, Throwable cause) {
		super(message, cause);
	}
}
