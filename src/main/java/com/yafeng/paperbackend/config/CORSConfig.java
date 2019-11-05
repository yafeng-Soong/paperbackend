package com.yafeng.paperbackend.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.config
 * describe: 解决跨域的配置文件
 * @author : songyafeng
 * creat_time: 2019/10/6 17:05
 **/
@Configuration
public class CORSConfig {
    @Bean
    public WebMvcConfigurer CORSConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**")
                        .allowedOrigins("*")
                        .allowedMethods("*")
                        .allowedHeaders("*")
                        //设置是否允许跨域传cookie
                        .allowCredentials(true)
                        //设置缓存时间，减少重复响应
                        .maxAge(3600);
            }
            /**
             * 配置静态资源路径，主要用于返回图片、文件
             * @param registry
             */
            @Override
            public void addResourceHandlers(ResourceHandlerRegistry registry) {
                registry.addResourceHandler("/imgs/**").addResourceLocations("file:/usr/web/imgs/");
                registry.addResourceHandler("/files/**").addResourceLocations("file:/usr/web/uploadFile/");
            }
        };
    }
}
