package top.naccl.util.common;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import java.util.Set;

/**
 * @Description:
 * @Author: kcbjt
 * @Date: 2026-04-15
 */
public class ValidatorUtils {
	private static Validator validator;

	static {
		validator = Validation.buildDefaultValidatorFactory().getValidator();
	}

	/**
	 * 校验对象
	 *
	 * @param object 待校验对象
	 * @param groups 待校验的组
	 * @throws RuntimeException 校验不通过，则报BusinessException异常
	 */
	public static void validateEntity(Object object, Class<?>... groups) throws RuntimeException {
		Set<ConstraintViolation<Object>> constraintViolations = validator.validate(object, groups);
		if (!constraintViolations.isEmpty()) {
			ConstraintViolation<Object> constraint = constraintViolations.iterator().next();
			throw new RuntimeException(constraint.getMessage());
		}
	}
}
