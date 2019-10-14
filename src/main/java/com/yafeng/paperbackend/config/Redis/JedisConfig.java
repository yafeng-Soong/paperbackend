package com.yafeng.paperbackend.config.Redis;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description
 * @date 2019/10/14 19:41
 */

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

/**
 *
 * @description Jedis配置
 * @author liugaoyang
 * @date 2019/10/7 20:48
 * @version 1.0.0
 */
@Configuration
@Data
@ConfigurationProperties(prefix = "spring.redis")
public class JedisConfig {
    private Integer database;

    private String host;

    private Integer port;

    private String password;

    private Integer timeout;

    @Bean
    public JedisPool JedisPoolFactory(){
        JedisPoolConfig config = new JedisPoolConfig();
        config.setMaxIdle(8);
        config.setMinIdle(0);
        config.setMaxWaitMillis(-1);
        config.setMaxTotal(200);
        return new JedisPool(config, host, port, timeout, password, database, null);
    }
}
