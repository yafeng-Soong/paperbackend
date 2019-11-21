package com.yafeng.paperbackend.controller;

import com.lly835.bestpay.enums.BestPayTypeEnum;
import com.lly835.bestpay.model.PayResponse;
import com.yafeng.paperbackend.service.Impl.PayServiceImpl;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 支付Controller
 * @date 2019/11/21 16:15
 */
@Api(tags = "论文支付相关接口")
@Controller
@RequestMapping("/pay")
public class PayController {

    @Autowired
    private PayServiceImpl payService;

    /**
     * create
     * @description  用户点击付款   创建支付订单 返回订单的支付二维码
     * @author liugaoyang
     * @date 2019/11/21 9:34
     * @version 1.0.0
     */
    @ApiOperation("用户付款")
    @GetMapping("/create")
    public ModelAndView create(@RequestParam(name = "paperId") Integer paperId,
                               @RequestParam(name = "amount", defaultValue = "0.01") BigDecimal amount,
                               @RequestParam(name = "payType") BestPayTypeEnum bestPayTypeEnum){
        PayResponse response = payService.create(paperId, amount, bestPayTypeEnum);
        Map<String, String> map = new HashMap<>();
        // 支付方式不同 支付页面渲染的方式也不同
        if (bestPayTypeEnum == BestPayTypeEnum.WXPAY_NATIVE){
            map.put("codeUrl", response.getCodeUrl());
            return new ModelAndView("createforWX", map);
        }else if (bestPayTypeEnum == BestPayTypeEnum.ALIPAY_PC){
            map.put("body", response.getBody());
            return new ModelAndView("createforALI", map);
        }else{
            throw new RuntimeException("无效的支付方式");
        }
    }

    /**
     * asyncNotify
     * @description 接受微信异步回调信息 做相关校验  比如校验签名、支付金额是否正确
     * @param notifyData 微信支付端异步返回的数据
     * @return {@link Void}
     * @author liugaoyang
     * @date 2019/11/21 11:48
     * @version 1.0.0
     */
    @ApiOperation("支付结果异步回调")
    @PostMapping("/notify")
    @ResponseBody
    public String asyncNotify(@RequestBody String notifyData){
        // 接收微信的异步响应信息  校验支付 并返回结果
        return payService.asyncNotify(notifyData);
    }
}
