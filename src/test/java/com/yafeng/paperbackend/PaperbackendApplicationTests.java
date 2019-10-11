package com.yafeng.paperbackend;

import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.mapper.UserMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class PaperbackendApplicationTests {
    @Autowired
    UserMapper userMapper;

    @Test
    public void contextLoads() {
        User query = new User();
        query.setEmail("233333@qq.com");
        List<User> users = userMapper.selectList(query);
        for (User user : users)
            System.out.println(user.toString());
    }

}
