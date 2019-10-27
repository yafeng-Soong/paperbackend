package com.yafeng.paperbackend.service.Impl;


import com.yafeng.paperbackend.bean.vo.paper.PaperUpdateRequestVo;
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
//        PaperRequestVo vo = new PaperRequestVo("serviceTest001",
//                "测试service",
//                "这是一片摘要",
//                "/home/kafka_2.1.2/");
//        log.info("PAPER:{}", JSON.toJSONString(paperService.buildPaper(vo)));
    }

    @Test
    public void testModify() throws PaperException{
        PaperUpdateRequestVo vo = PaperUpdateRequestVo.builder()
                .id(10)
                .filePath("https://zbsy.oss-cn-hongkong.aliyuncs.com/Netty/Netty%20%E5%85%A5%E9%97%A8%E4%B8%8E%E5%AE%9E%E6%88%98%EF%BC%9A%E4%BB%BF%E5%86%99%E5%BE%AE%E4%BF%A1%20IM%20%E5%8D%B3%E6%97%B6%E9%80%9A%E8%AE%AF%E7%B3%BB%E7%BB%9F/netty(html%E6%A0%BC%E5%BC%8F).rar")
                .name("netty压缩包地址")
                .build();
        paperService.modifyPaper(vo);
    }

}