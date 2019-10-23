package com.yafeng.paperbackend.service;

import org.apache.kafka.clients.consumer.ConsumerRecord;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description kafka消息队列服务
 * @date 2019/10/23 20:37
 */
public interface IKafkaService {

    void consumePaperKafkaMessage(ConsumerRecord<?, ?> record);
}
