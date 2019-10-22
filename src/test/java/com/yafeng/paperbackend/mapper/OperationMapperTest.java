package com.yafeng.paperbackend.mapper;

import com.yafeng.paperbackend.bean.entity.Operation;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.enums.OperateType;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.Date;


/**
 * @author liugaoyang
 * @version 1.0.0
 * @description
 * @date 2019/10/21 16:17
 */
@Slf4j
@SpringBootTest
@RunWith(SpringRunner.class)
public class OperationMapperTest {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private OperationMapper operationMapper;

    @Test
    public void contextLoad(){

    }

    @Test
    public void testBuild(){
        User user = userMapper.selectByEmail("734190426@qq.com");
        Operation operation = new Operation(
                user.getId(),
                10,
                "2016220204某某某综合课题设计论文提交",
                OperateType.SUBMIT,
                new Date()
        );
        operationMapper.insertSelective(operation);
    }

    @Test
    public void testSelect(){
      log.info("{}", operationMapper.selectByUserId(3));
    }

}