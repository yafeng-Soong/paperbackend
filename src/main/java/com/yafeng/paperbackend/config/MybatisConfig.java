package com.yafeng.paperbackend.config;


import com.github.pagehelper.autoconfigure.PageHelperAutoConfiguration;
import com.yafeng.paperbackend.interceptor.ExecutorInterceptor;
import com.yafeng.paperbackend.interceptor.FinalInterceptor;
import com.yafeng.paperbackend.interceptor.ResultInterceptor;
import com.yafeng.paperbackend.interceptor.StatementInterceptor;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;
import java.util.List;

@Configuration
@AutoConfigureAfter({PageHelperAutoConfiguration.class})
public class MybatisConfig {

//    @Autowired
//    private List<SqlSessionFactory> sqlSessionFactoryList;
    /**
     * 注册拦截器
     * @return
     */
//    @Bean
//    public ExecutorInterceptor executorInterceptor(){
//        ExecutorInterceptor interceptor = new ExecutorInterceptor();
//        // Properties properties = new Properties();
//        // 可以调用properties.setProperty方法来给拦截器设置一些自定义参数
//        // interceptor.setProperties(properties);
//        return interceptor;
//    }

//    @Bean
//    public StatementInterceptor statementInterceptor(){
//        return new StatementInterceptor();
//    }
    @Bean
    public FinalInterceptor finalInterceptor() {
        return  new FinalInterceptor();
    }

    @Bean
    public ResultInterceptor resultInterceptor() {
        return new ResultInterceptor();
    }

//    @PostConstruct
//    public void addMyInterceptor() {
//        ExecutorInterceptor interceptor = new ExecutorInterceptor();
//        for (SqlSessionFactory sqlSessionFactory : sqlSessionFactoryList) {
//            sqlSessionFactory.getConfiguration().addInterceptor(interceptor);
//        }
//    }
}
