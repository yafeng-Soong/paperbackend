package com.yafeng.paperbackend.bean.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "pay_info")
public class PayInfo {
    @Id
    @GeneratedValue(generator = "JDBC")
    private Integer id;


    @Column(name = "paper_id")
    private Integer paperId;

    /**
     * 用户id
     */
    @Column(name = "user_id")
    private Integer userId;

    /**
     * 订单号
     */
    @Column(name = "order_no")
    private String orderNo;

    /**
     * 支付平台:1-支付宝,2-微信
     */
    @Column(name = "pay_platform")
    private Integer payPlatform;

    /**
     * 支付宝支付流水号
     */
    @Column(name = "platform_number")
    private String platformNumber;

    /**
     * 支付宝支付状态
     */
    @Column(name = "platform_status")
    private String platformStatus;

    /**
     * 支付金额
     */
    @Column(name = "pay_amount")
    private BigDecimal payAmount;

    /**
     * 创建时间
     */
    @Column(name = "create_time")
    private Date createTime;

    /**
     * 更新时间
     */
    @Column(name = "update_time")
    private Date updateTime;

}



