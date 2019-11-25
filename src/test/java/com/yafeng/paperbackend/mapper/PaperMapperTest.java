package com.yafeng.paperbackend.mapper;

import com.alibaba.fastjson.JSON;
import com.yafeng.paperbackend.bean.entity.Paper;
import com.yafeng.paperbackend.enums.CheckStatus;
import com.yafeng.paperbackend.enums.PayStatus;
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
 * @date 2019/10/21 15:11
 */
@Slf4j
@SpringBootTest
@RunWith(SpringRunner.class)
public class PaperMapperTest {

    @Autowired
    private PaperMapper paperMapper;

    @Test
    public void contextLoad(){

    }

    @Test
    public void testBuild(){
        Paper paper = new Paper("mapper测试001", "袁杰彬", "734190426@qq.com", "综合课题设计III", "这是个简短的摘要", "/root/lgy/xx", PayStatus.UNPAID, CheckStatus.TO_REVIEW, new Date());
        paperMapper.insertSelective(paper);
    }

    @Test
    public void testModified(){
        Paper paper = paperMapper.selectByPrimaryKey(10);
        paper.setSummary("我修改了摘要");
        paperMapper.updateByPrimaryKey(paper);
    }

    @Test
    public void testSelect(){
        log.info("{}", JSON.toJSONString(paperMapper.selectAllByPublisherEmail("734190426@qq.com")));
        log.info("{}", paperMapper.selectAllByPublisherEmailAndStatus("734190426@qq.com", 1, 0));
        log.info("{}", paperMapper.selectByPublisherEmailAndName("734190426@qq.com", "mapper测试001"));
    }

}