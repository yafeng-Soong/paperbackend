package com.yafeng.paperbackend.config.Redis;

import com.yafeng.paperbackend.base.BasePrefix;
import com.yafeng.paperbackend.service.RedisService;
import com.yafeng.paperbackend.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description redis相关功能测试类
 * @date 2019/10/14 19:59
 */
@RunWith(SpringRunner.class)
@SpringBootTest
@Slf4j
public class RedisServiceTest {

    @Autowired
    private RedisService redisService;

    @Autowired
    private UserService userService;
    /**
     * testConnectionRedis
     * @description  测试redis工具类的正确性
     * @return void
     * @author liugaoyang
     * @date 2019/10/7 21:22
     * @version 1.0.0
     */
    @Test
    public void testConnectionRedis(){
        BasePrefix profix = new BasePrefix() {
            @Override
            public int expireSeconds() {
                return 0;
            }

            @Override
            public String prefix() {
                return "Connection";
            }
        };
        redisService.set(profix,"test", "test");
    }

    @Test
    public void testSetAndGet(){
        String token = "60e949eb7b294c118ac2d7a3a94ac27d";
        String storedEmail = redisService.get(UserKeyPrefix.TOKEN, token, String.class);
        log.info("{}", storedEmail);

        //        User user = userService.selectByEmail("397655952@qq.com");
//        redisService.set(UserKeyPrefix.Name, user.getSalt(), user);
//        log.info("测试get和set方法{}", redisService.get(UserKeyPrefix.Name, user.getSalt(), User.class));

    }

}