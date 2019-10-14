package com.yafeng.paperbackend.controller;

import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.mapper.UserMapper;
import com.yafeng.paperbackend.service.UserService;
import com.yafeng.paperbackend.utils.PasswordHelper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;

import static org.junit.Assert.*;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.controller
 * describe: 由开发人员自主完善
 *
 * @author : songyafeng
 * creat_time: 2019/10/7 16:34
 **/
@RunWith(SpringRunner.class)
@SpringBootTest
public class LoginControllerTest {

    private static final Logger LOGGER = LoggerFactory.getLogger(LoginControllerTest.class);
//    @Resource
//    private RedisTemplate<String, Object> redisTemplate;
    @Autowired
    UserService userService;

    @Test
    public void insertUser(){
        User user = new User();
        user.setEmail("397655952@qq.com");
        user.setUsername("峰酱");
        user.setPassword("gta123456");
        LOGGER.info("user's new password:" + user.getPassword());
        LOGGER.info("" + userService.insert(user));
        LOGGER.info("" + user.getId());
    }

    @Test
    public void updateUser(){
        User user = new User();
        user.setEmail("397655952@qq.com");
        user.setUsername("阿峰");
        insertUser();
        userService.update(user);
    }

    @Test
    public void deleteUser(){
        User user = new User();
        user.setEmail("397655952@qq.com");
        userService.delete(user);
    }

//    @Test
//    public void redisTest(){
//        redisTemplate.opsForValue().set("test", 1);
//        int test = (int) redisTemplate.opsForValue().get("test");
//        System.out.println(test);
//    }

}