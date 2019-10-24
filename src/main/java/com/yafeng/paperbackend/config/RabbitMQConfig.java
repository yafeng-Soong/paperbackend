package com.yafeng.paperbackend.config;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description RabbitMq消息队列配置
 * @date 2019/10/24 9:04
 */

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;

/**
 * RabbitMQConfig
 *
 * @author liugaoyang
 * @version 1.0
 * @description RabbitMq配置
 * @date 2019/7/4 13:46
 **/
@Configuration
@ConfigurationProperties(prefix = "spring.rabbitmq")
@Data
@Slf4j
public class RabbitMQConfig {

    // 队列
    public static final String PAPER_QUEUE = "PAPER_OP";

    private String host;

    private Integer port;

    private String username;

    private String password;

    @Bean
    public ConnectionFactory RbmqConnectionFactory(){
        CachingConnectionFactory connectionFactory = new CachingConnectionFactory(host, port);
        connectionFactory.setUsername(username);
        connectionFactory.setPassword(password);
        return connectionFactory;
    }

    // spring 中的bean默认是单例 也就是说这个bean只能创建一个实例 （如果这个bean是单例模式的话，则获取bean时都会取唯一的实例）
    // 如果需要每次获取这个bean都是一个新的实例 需要加上这个注解  @Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
    @Bean
    @Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
    public RabbitTemplate rabbitTemplate(){
        RabbitTemplate template = new RabbitTemplate(RbmqConnectionFactory());
        return template;
    }



    // 直接交换机模式：新建论文操作使用的队列
    @Bean
    public Queue PAPERQueue(){
        return new Queue(PAPER_QUEUE, true);
    }
}
