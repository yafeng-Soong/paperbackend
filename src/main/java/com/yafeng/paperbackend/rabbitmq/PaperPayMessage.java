package com.yafeng.paperbackend.rabbitmq;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 支付消息
 * @date 2019/11/21 21:35
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PaperPayMessage {

    private String orderNum;

    private Date updateTime;

    private String platformNumber;

    private String note;
}
