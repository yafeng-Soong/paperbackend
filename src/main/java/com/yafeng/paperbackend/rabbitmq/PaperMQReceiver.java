package com.yafeng.paperbackend.rabbitmq;

import com.alibaba.fastjson.JSON;
import com.yafeng.paperbackend.bean.entity.Operation;
import com.yafeng.paperbackend.bean.vo.PaperRbmqMessage;
import com.yafeng.paperbackend.config.RabbitMQConfig;
import com.yafeng.paperbackend.enums.OperateType;
import com.yafeng.paperbackend.mapper.OperationMapper;
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
    private OperationMapper operationMapper;

    @RabbitListener(queues = RabbitMQConfig.PAPER_QUEUE)
    public void receivePaperOperateMSG(String message){
        log.info("消费者接收到消息：{}", message);
        // 将消息内容转换为实体类
        PaperRbmqMessage paperRbmqMessage = JSON.parseObject(message, PaperRbmqMessage.class);
        OperateType operateType = OperateType.of(paperRbmqMessage.getOperateType());
        processByType(paperRbmqMessage, operateType);
    }

        /**
     * processByType
     * @description 根据消息内容进行数据库持久化操作
     * 提交类型的操作备注为默认的
     * @param message {@link PaperRbmqMessage}
     * @param operateType {@link OperateType}
     * @return {@link }
     * @author liugaoyang
     * @date 2019/10/23 20:56
     * @version 1.0.0
     * todo 完成其他接口后再重构代码
     */
    private void processByType(PaperRbmqMessage message, OperateType operateType) {
        Operation operation = new Operation(message.getOperateId(),
                message.getPaperId(),
                message.getNote(),
                message.getOperateType(),
                new Date());
        //数据库插入记录
        operationMapper.insert(operation);
        log.info("成功将操作写入数据库：{}", message);

//        switch (operateType){
//            case SUBMIT:
//                Operation operation = new Operation(message.getOperateId(),
//                        message.getPaperId(),
//                        message.getNote(),
//                        message.getOperateType(),
//                        new Date());
//                //数据库插入记录
//                operationMapper.insert(operation);
//                break;
//            case MODIFY:
//                Operation operation1 = new Operation(message.getOperateId(),
//                        message.getPaperId(),
//                        message.getNote(),
//                        message.getOperateType(),
//                        new Date());
//                operationMapper.insert(operation1);
//                break;
//            case RETURNED:
//                break;
//            case PASSED:
//                break;
//            case PAY:
//                break;
//        }
    }

}
