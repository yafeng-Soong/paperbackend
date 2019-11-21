package com.yafeng.paperbackend.config.pay;

import com.lly835.bestpay.config.AliPayConfig;
import com.lly835.bestpay.config.WxPayConfig;
import com.lly835.bestpay.service.BestPayService;
import com.lly835.bestpay.service.impl.BestPayServiceImpl;
import com.yafeng.paperbackend.constant.PayConstant;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 返回bestPayService
 * @date 2019/11/21 11:32
 */
@Component
public class BestPayConfig {

    @Bean
    public BestPayService bestPayService(){
        WxPayConfig wxPayConfig = new WxPayConfig();
        // 参数按具体的支付类型配置  按需使用
        // 设置公众号ID
        wxPayConfig.setAppId(PayConstant.WX_APPID);
        // 设置商户号
        wxPayConfig.setMchId(PayConstant.WX_MCHID);
        // 设置商户密匙
        wxPayConfig.setMchKey(PayConstant.WX_MCHKEY);
        // 设置支付异步通知URL
        wxPayConfig.setNotifyUrl(PayConstant.WX_NOTIFY_URL_LOCAL);

        // 支付宝支付相关配置信息
        AliPayConfig aliPayConfig = new AliPayConfig();
        // 支付宝应用的应用ID
        aliPayConfig.setAppId(PayConstant.ALIPAY_APPID);
        // 支付宝应用公钥
        aliPayConfig.setAliPayPublicKey(PayConstant.ALIPAY_PUBLIC_KEY);
        // 支付宝商家私钥
        aliPayConfig.setPrivateKey(PayConstant.ALIPAY_PRIVATE_KEY);
        // 支付宝异步回调地址
        aliPayConfig.setNotifyUrl(PayConstant.ALIPAY_NOTIFY_URL_LOCAL);
        // 支付成功的跳转地址
        aliPayConfig.setReturnUrl(PayConstant.ALIPAY_RETURN_URL);

        BestPayServiceImpl bestPayService = new BestPayServiceImpl();
        bestPayService.setWxPayConfig(wxPayConfig);
        bestPayService.setAliPayConfig(aliPayConfig);
        return bestPayService;
    }
}
