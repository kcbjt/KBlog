package com.kcbjt.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import com.kcbjt.service.LoginLogService;
import com.kcbjt.service.impl.UserServiceImpl;

import java.util.Arrays;
import java.util.List;

/**
 * @Description: Spring Security配置类 (适配 Spring Security 6.x)
 * @Author: kcbjt
 * @Date: 2026-04-15
 */
@Configuration
@EnableWebSecurity // 确保开启 Web 安全配置
public class SecurityConfig {

	// 注入依赖
	private final UserServiceImpl userService;
	private final LoginLogService loginLogService;
	private final MyAuthenticationEntryPoint myAuthenticationEntryPoint;

	// 推荐使用构造器注入，避免循环依赖警告
	public SecurityConfig(UserServiceImpl userService,
						  LoginLogService loginLogService,
						  MyAuthenticationEntryPoint myAuthenticationEntryPoint) {
		this.userService = userService;
		this.loginLogService = loginLogService;
		this.myAuthenticationEntryPoint = myAuthenticationEntryPoint;
	}

	/**
	 * 密码编码器 Bean
	 */
	@Bean
	public BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}

	/**
	 * 核心安全配置：替代 configure(HttpSecurity http)
	 */
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http
				// 禁用 csrf 防御 (Lambda 写法)
				.csrf(csrf -> csrf.disable())
				// 开启跨域支持
				.cors(cors -> cors.configurationSource(corsConfigurationSource()))
				// 基于Token，不创建会话
				.sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
				// 授权请求配置
				.authorizeHttpRequests(auth -> auth
						// 放行获取网页标题后缀的请求
						.requestMatchers("/admin/webTitleSuffix").permitAll()
						// 任何 /admin 开头的路径下的请求都需要经过JWT验证
						.requestMatchers(HttpMethod.GET, "/admin/**").hasAnyRole("admin", "visitor")
						.requestMatchers("/admin/**").hasRole("admin")
						// 其它路径全部放行
						.anyRequest().permitAll()
				)
				// 未登录时，返回json，在前端执行重定向
				.exceptionHandling(ex -> ex.authenticationEntryPoint(myAuthenticationEntryPoint));

		// 注意：在 Spring Security 6.x 中，addFilterBefore 通常建议在 http.build() 之前调用，
		// 或者通过 SecurityCustomizer 处理。但为了保持逻辑简单，这里直接操作 http 对象。
		// 如果你的 JwtLoginFilter 需要 AuthenticationManager，请看下面的 authenticationManager() Bean 定义。
		http.addFilterBefore(new JwtLoginFilter("/admin/login", authenticationManager(), loginLogService), UsernamePasswordAuthenticationFilter.class);
		http.addFilterBefore(new JwtFilter(), UsernamePasswordAuthenticationFilter.class);

		return http.build();
	}

	/**
	 * 定义 CORS 配置源 (Spring Security 6 必须显式定义这个 Bean)
	 */
	@Bean
	public CorsConfigurationSource corsConfigurationSource() {
		CorsConfiguration configuration = new CorsConfiguration();
		// 允许携带凭证
		configuration.setAllowCredentials(true);
		// 允许的源，生产环境建议指定具体域名，不要用 "*"
		configuration.setAllowedOriginPatterns(List.of("*"));
		// 允许的方法
		configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
		// 允许的请求头
		configuration.setAllowedHeaders(Arrays.asList("*"));

		UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
		source.registerCorsConfiguration("/**", configuration);
		return source;
	}

	/**
	 * 认证管理器 Bean：替代 configure(AuthenticationManagerBuilder auth)
	 * 这是为了解决 JwtLoginFilter 中需要的 authenticationManager() 问题
	 */
	@Bean
	public AuthenticationManager authenticationManager() {
		// 使用 DaoAuthenticationProvider 替代旧的 auth.userDetailsService(userService)
		DaoAuthenticationProvider provider = new DaoAuthenticationProvider(userService);
		provider.setPasswordEncoder(bCryptPasswordEncoder());
		return new ProviderManager(provider);
	}
}