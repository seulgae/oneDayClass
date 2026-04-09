package com.example.onedayclass.common.config;

import com.example.onedayclass.common.interceptor.LoginMemberInterceptor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Paths;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    private final LoginMemberInterceptor loginMemberInterceptor;

    @Value("${app.upload.dir:uploads}")
    private String uploadDir;

    public WebConfig(LoginMemberInterceptor loginMemberInterceptor) {
        this.loginMemberInterceptor = loginMemberInterceptor;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String uploadLocation = Paths.get(uploadDir).toAbsolutePath().normalize().toUri().toString();
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations(uploadLocation);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginMemberInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns("/css/**", "/uploads/**", "/h2-console/**");
    }
}
