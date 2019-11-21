package com.yafeng.paperbackend.rabbitmq;

import com.alibaba.fastjson.JSON;
import com.yafeng.paperbackend.config.RabbitMQConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 消息发送者（生产者）
 * @date 2019/10/24 9:15
 */
@Service
@Slf4j
public class PaperMQSender {
    @Autowired
    private RabbitTemplate rabbitTemplate;

    public void sendPaperOperateMSG(PaperOperateMessage paperOperateMessage){
        String msg = JSON.toJSONString(paperOperateMessage);
        log.info("用户执行操作，向消费者发送操作消息：{}", msg);
        rabbitTemplate.convertAndSend(RabbitMQConfig.PAPER_QUEUE_OP, msg);
    }

    public void sendPaperStatusMSG(PaperStatusMessage paperStatusMessage){
        String msg = JSON.toJSONString(paperStatusMessage);
        log.info("用户成功付款！修改论文的状态");
        rabbitTemplate.convertAndSend(RabbitMQConfig.PAPER_QUEUE_STATUS, msg);
    }

    public void sendPaperPayMSG(PaperPayMessage paperPayMessage){
        String msg = JSON.toJSONString(paperPayMessage);
        log.info("用户成功付款！修改论文的状态");
        rabbitTemplate.convertAndSend(RabbitMQConfig.PAPER_QUEUE_PAY, msg);
    }


}
