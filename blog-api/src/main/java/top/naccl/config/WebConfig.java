package top.naccl.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.config.annotation.*;
import top.naccl.config.properties.UploadProperties;
import top.naccl.interceptor.AccessLimitInterceptor;

/**
 * @Description: 配置CORS跨域支持、拦截器
 * @Author: kcbjt
 * @Date: 2026-04-15
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {
	@Autowired
	AccessLimitInterceptor accessLimitInterceptor;
	@Autowired
	UploadProperties uploadProperties;

	/**
	 * 跨域请求
	 *
	 * @param registry
	 */
	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**")
				.allowedOrigins("*")
				.allowedHeaders("*")
				.allowedMethods("GET", "POST", "PUT", "DELETE", "HEAD", "OPTIONS")
				.maxAge(3600);
	}

	/**
	 * 请求拦截器
	 *
	 * @param registry
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(accessLimitInterceptor);
	}

	/**
	 * 本地静态资源路径映射
	 *
	 * @param registry
	 */
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler(uploadProperties.getAccessPath()).addResourceLocations(uploadProperties.getResourcesLocations());
	}

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		// 1. 【可选】设置默认首页
		// 访问根路径 "/" 时，默认跳转到前台首页
		// 如果你想让根路径显示后台，改为 forward:/cms/index.html
		registry.addViewController("/").setViewName("forward:/view/index.html");

		// 2. 配置前台路由 (/view/**)
		// 匹配 /view/ 开头的任意路径（排除带后缀的文件，如 .js, .css）
		// 这样 Vue Router 的 History 模式刷新页面时，会重新加载 index.html
		registry.addViewController("/view/{path:[^\\.]+}")
				.setViewName("forward:/view/index.html");

		// 3. 配置后台路由 (/cms/**)
		// 匹配 /cms/ 开头的任意路径
		registry.addViewController("/cms/{path:[^\\.]+}")
				.setViewName("forward:/cms/index.html");

		// 4. 【可选】提高优先级
		// 确保这些视图映射优先于其他可能存在的静态资源映射
		registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
	}
}
