package com.yafeng.paperbackend.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.config
 * describe: Swagger2的配置类，主要功能是扫描controller接口生成swagger主页
 * @author : songyafeng
 * creat_time: 2019/10/8 16:51
 **/
@Configuration
@EnableSwagger2
public class SwaggerConfig {
    @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .pathMapping("/")
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.yafeng.paperbackend.controller"))
                .paths(PathSelectors.any())
                .build().apiInfo(new ApiInfoBuilder()
                        .title("论文投稿系统Swagger2接口文档")
                        .description("前端开发人员在这里查看API接口信息")
                        .version("9.0")
                        .build());
    }
}
