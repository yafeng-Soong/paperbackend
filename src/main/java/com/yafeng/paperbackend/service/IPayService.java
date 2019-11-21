package com.yafeng.paperbackend.service;

import com.lly835.bestpay.enums.BestPayTypeEnum;
import com.lly835.bestpay.model.PayResponse;

import java.math.BigDecimal;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 支付接口
 * @date 2019/11/21 1:16
 */
public interface IPayService {

    /**
     * create
     * @description 发起支付
     * @param paperId 论文ID
     * @param amount 支付金额
     * @return {@link }
     * @author liugaoyang
     * @date 2019/11/21 1:17
     * @version 1.0.0
     */
    PayResponse create(Integer paperId, BigDecimal amount, BestPayTypeEnum bestPayTypeEnum);

    String asyncNotify(String notifyData);
}
