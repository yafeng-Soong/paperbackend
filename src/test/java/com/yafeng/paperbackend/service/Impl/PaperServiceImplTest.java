package com.yafeng.paperbackend.service.Impl;


import com.alibaba.fastjson.JSON;
import com.yafeng.paperbackend.bean.vo.paper.PaperRequestVo;
import com.yafeng.paperbackend.exception.PaperException;
import com.yafeng.paperbackend.service.IPaperService;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description
 * @date 2019/10/21 17:24
 */
@Slf4j
@SpringBootTest
@RunWith(SpringRunner.class)
public class PaperServiceImplTest {

    @Autowired
    private IPaperService paperService;

    @Test
    public void contextLoad(){

    }

    @Test
    public void testBuild() throws PaperException {
        PaperRequestVo vo = new PaperRequestVo("serviceTest001",
                "734190426@qq.com",
                "测试service",
                "这是一片摘要",
                "/home/kafka_2.1.2/");
        log.info("PAPER:{}", JSON.toJSONString(paperService.buildPaper(vo)));
    }

}