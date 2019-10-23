package com.yafeng.paperbackend.service.Impl;

import com.alibaba.fastjson.JSON;
import com.yafeng.paperbackend.bean.entity.Operation;
import com.yafeng.paperbackend.bean.vo.PaperKafkaMessage;
import com.yafeng.paperbackend.constant.Constant;
import com.yafeng.paperbackend.enums.OperateType;
import com.yafeng.paperbackend.mapper.OperationMapper;
import com.yafeng.paperbackend.service.IKafkaService;
import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Optional;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description kafka功能实现类 主要异步将对paper的操作写入到数据库之中
 * @date 2019/10/23 20:38
 */
@Slf4j
@Service
public class KafkaServiceImpl implements IKafkaService {

    @Autowired
    private OperationMapper operationMapper;

    /**
     * consumePaperKafkaMessage
     * @description 消费生产者发送来的消息
     * @param record 生产者发送的消息
     * @return {@link Void}
     * @author liugaoyang
     * @date 2019/10/23 22:26
     * @version 1.0.0
     */
    @Override
    @KafkaListener(topics = {Constant.TOPIC}, groupId = "zs3-paper-1")
    public void consumePaperKafkaMessage(ConsumerRecord<?, ?> record) {
        // 里面存储的是Optional对象
        Optional<?> kafkaMsg = Optional.ofNullable(record.value());
        // 判断是否存在消息 msg对象里面的内容是
        if(kafkaMsg.isPresent()){
            Object msg = kafkaMsg.get();
            // 将kafka中的消息对象转换为实体类
            PaperKafkaMessage message = JSON.parseObject(msg.toString(), PaperKafkaMessage.class);
            log.info("receive kafka message: {}", message.toString());
            OperateType operateType = OperateType.of(message.getOperateType());
            processByType(message, operateType);
        }

    }


    /**
     * processByType
     * @description 根据消息内容进行数据库持久化操作
     * 提交类型的操作备注为默认的
     * @param message {@link PaperKafkaMessage}
     * @param operateType {@link OperateType}
     * @return {@link }
     * @author liugaoyang
     * @date 2019/10/23 20:56
     * @version 1.0.0
     * todo 完成其他接口后再重构代码
     */
    private void processByType(PaperKafkaMessage message, OperateType operateType) {
        Operation operation = new Operation(message.getOperateId(),
                message.getPaperId(),
                message.getNote(),
                message.getOperateType(),
                new Date());
        //数据库插入记录
        operationMapper.insert(operation);

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
