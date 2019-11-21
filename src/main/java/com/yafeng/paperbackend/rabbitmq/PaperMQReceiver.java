package com.yafeng.paperbackend.rabbitmq;

import com.alibaba.fastjson.JSON;
import com.yafeng.paperbackend.bean.entity.Operation;
import com.yafeng.paperbackend.bean.entity.Paper;
import com.yafeng.paperbackend.bean.entity.PayInfo;
import com.yafeng.paperbackend.config.RabbitMQConfig;
import com.yafeng.paperbackend.enums.CheckStatus;
import com.yafeng.paperbackend.enums.OperateType;
import com.yafeng.paperbackend.mapper.OperationMapper;
import com.yafeng.paperbackend.mapper.PaperMapper;
import com.yafeng.paperbackend.mapper.PayInfoMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 消息消费者
 * @date 2019/10/24 9:16
 */
@Service
@Slf4j
public class PaperMQReceiver {

    @Autowired
    private PayInfoMapper payInfoMapper;

    @Autowired
    private OperationMapper operationMapper;

    @Autowired
    private PaperMapper paperMapper;

    /**
     * receivePaperOperateMSG
     * @description 接收到消息的处理操作
     * @param message 执行操作后发来的相关操作的消息内容
     * @return {@link Void}
     * @author liugaoyang
     * @date 2019/10/24 9:54
     * @version 1.0.0
     */
    @RabbitListener(queues = RabbitMQConfig.PAPER_QUEUE_OP)
    public void receivePaperOperateMSG(String message){
        log.info("消费者接收到消息：{}", message);
        // 将消息内容转换为实体类
        PaperOperateMessage paperOperateMessage = JSON.parseObject(message, PaperOperateMessage.class);
        OperateType operateType = OperateType.of(paperOperateMessage.getOperateType());
        processByType(paperOperateMessage, operateType);
    }


    @RabbitListener(queues = RabbitMQConfig.PAPER_QUEUE_STATUS)
    public void receivePaperStatusMSG(String message){
        log.info("消费者接收到消息：{}", message);
        // 将消息内容转换为实体类
        PaperStatusMessage paperStatusMessage = JSON.parseObject(message, PaperStatusMessage.class);
        // 修改论文状态
        Paper paper = paperMapper.selectByPrimaryKey(paperStatusMessage.getPaperId());
        paper.setCheckStatus(CheckStatus.PAYED.getCode());
        paper.setUpdateTime(new Date());
        paperMapper.updateByPrimaryKeySelective(paper);
        log.info("成功将操作写入数据库：{}", message);
    }

    @RabbitListener(queues = RabbitMQConfig.PAPER_QUEUE_PAY)
    public void receivePaperPayMSG(String message){
        log.info("消费者接收到消息：{}", message);
        // 将消息内容转换为实体类
        PaperPayMessage paperPayMessage = JSON.parseObject(message, PaperPayMessage.class);
        PayInfo payInfo = payInfoMapper.selectByOrderNo(paperPayMessage.getOrderNum());
        payInfo.setUpdateTime(new Date());
        payInfo.setPlatformNumber(paperPayMessage.getPlatformNumber());
        payInfo.setPlatformStatus("success");
        payInfoMapper.updateByPrimaryKeySelective(payInfo);
        log.info("成功将操作写入数据库：{}", message);
    }

        /**
     * processByType
     * @description 根据消息内容进行数据库持久化操作
     * 提交类型的操作备注为默认的
     * @param message {@link PaperOperateMessage}
     * @param operateType {@link OperateType}
     * @return {@link }
     * @author liugaoyang
     * @date 2019/10/23 20:56
     * @version 1.0.0
     * todo 完成其他接口后再重构代码
     */
    private void processByType(PaperOperateMessage message, OperateType operateType) {
        Operation operation = new Operation(message.getOperateId(),
                message.getPaperId(),
                message.getNote(),
                message.getOperateType(),
                new Date());
        //数据库插入记录
        operationMapper.insert(operation);
        log.info("成功将操作写入数据库：{}", message);
    }

}
