package com.yafeng.paperbackend.common.redis;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;



@RunWith(SpringRunner.class)
@SpringBootTest
public class RedisServiceTest {
    @Autowired
    private RedisService redisService;

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
        BaseProfix profix = new BaseProfix() {
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

}