package com.kcbjt.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.security.SignatureException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Collection;
import java.util.Date;

/**
 * @Description: JWT工具类 (适配 jjwt 0.11.x+)
 * @Author: kcbjt
 * @Date: 2026-04-15
 */
@Component
public class JwtUtils {
	private static long expireTime;
	private static String secretKeyString;
	// 新版本推荐使用 SecretKey 对象
	private static SecretKey secretKey;

	@Value("${token.secretKey}")
	public void setSecretKey(String secretKey) {
		JwtUtils.secretKeyString = secretKey;
		// 初始化时将字符串转换为 SecretKey
		// 注意：HS512 算法要求密钥长度足够，这里直接使用字符串字节作为密钥
		JwtUtils.secretKey = Keys.hmacShaKeyFor(secretKey.getBytes(StandardCharsets.UTF_8));
	}

	@Value("${token.expireTime}")
	public void setExpireTime(long expireTime) {
		JwtUtils.expireTime = expireTime;
	}

	/**
	 * 判断token是否存在
	 */
	public static boolean judgeTokenIsExist(String token) {
		return token != null && !"".equals(token) && !"null".equals(token);
	}

	/**
	 * 生成token
	 */
	public static String generateToken(String subject) {
		Date now = new Date();
		Date expiryDate = new Date(now.getTime() + expireTime);

		return Jwts.builder()
				.setSubject(subject)
				.setIssuedAt(now) // 建议设置签发时间
				.setExpiration(expiryDate)
				// 新版本签名方式：signWith(Key, Algorithm)
				.signWith(secretKey, SignatureAlgorithm.HS512)
				.compact();
	}

	/**
	 * 生成带角色权限的token
	 */
	public static String generateToken(String subject, Collection<? extends GrantedAuthority> authorities) {
		StringBuilder sb = new StringBuilder();
		for (GrantedAuthority authority : authorities) {
			sb.append(authority.getAuthority()).append(",");
		}

		Date now = new Date();
		Date expiryDate = new Date(now.getTime() + expireTime);

		return Jwts.builder()
				.setSubject(subject)
				.claim("authorities", sb.toString()) // 建议存为 String 而非 StringBuilder
				.setIssuedAt(now)
				.setExpiration(expiryDate)
				.signWith(secretKey, SignatureAlgorithm.HS512)
				.compact();
	}

	/**
	 * 生成自定义过期时间token
	 */
	public static String generateToken(String subject, long expireTime) {
		Date now = new Date();
		Date expiryDate = new Date(now.getTime() + expireTime);

		return Jwts.builder()
				.setSubject(subject)
				.setIssuedAt(now)
				.setExpiration(expiryDate)
				.signWith(secretKey, SignatureAlgorithm.HS512)
				.compact();
	}

	/**
	 * 获取tokenBody同时校验token是否有效
	 */
	public static Claims getTokenBody(String token) {
		try {
			// 新版本解析方式：parserBuilder().setSigningKey().build().parseClaimsJws()
			return Jwts.parser()
					.setSigningKey(secretKey)
					.build()
					.parseClaimsJws(token.replace("Bearer ", "")) // 注意这里增加了空格，通常 Bearer 后有空格
					.getBody();
		} catch (ExpiredJwtException e) {
			throw new RuntimeException("Token 已过期", e);
		} catch (UnsupportedJwtException e) {
			throw new RuntimeException("不支持的 Token", e);
		} catch (MalformedJwtException e) {
			throw new RuntimeException("Token 格式错误", e);
		} catch (SignatureException e) {
			throw new RuntimeException("签名验证失败", e);
		} catch (Exception e) {
			throw new RuntimeException("Token 解析失败", e);
		}
	}
}