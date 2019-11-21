package com.yafeng.paperbackend.service.Impl;

import com.lly835.bestpay.enums.BestPayPlatformEnum;
import com.lly835.bestpay.enums.BestPayTypeEnum;
import com.lly835.bestpay.model.PayRequest;
import com.lly835.bestpay.model.PayResponse;
import com.lly835.bestpay.service.BestPayService;
import com.yafeng.paperbackend.bean.entity.Paper;
import com.yafeng.paperbackend.bean.entity.PayInfo;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.enums.CheckStatus;
import com.yafeng.paperbackend.rabbitmq.PaperOperateMessage;
import com.yafeng.paperbackend.enums.OperateType;
import com.yafeng.paperbackend.mapper.PaperMapper;
import com.yafeng.paperbackend.mapper.PayInfoMapper;
import com.yafeng.paperbackend.rabbitmq.PaperMQSender;
import com.yafeng.paperbackend.rabbitmq.PaperPayMessage;
import com.yafeng.paperbackend.rabbitmq.PaperStatusMessage;
import com.yafeng.paperbackend.service.IPayService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 支付接口实现类 暂时只开放支付宝网页支付
 * @date 2019/11/21 1:18
 */
@Service
@Slf4j
public class PayServiceImpl implements IPayService {

    @Autowired
    private PaperMQSender sender;

    @Autowired
    private BestPayService bestPayService;

    @Autowired
    private PayInfoMapper payInfoMapper;

    // 论文付款 需生成一个订单编号提交给微信支付
    // 订单编号的生成规则 支付类型（支付宝为：A001、微信为W001共5位）+用户ID(用户ID在本系统中不会超过5位)+六位时间随机排序 + 8位随机数字
    @Override
    public PayResponse create(Integer paperId, BigDecimal amount, BestPayTypeEnum bestPayTypeEnum) {
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        // 判断支付类型
        if (bestPayTypeEnum != BestPayTypeEnum.WXPAY_NATIVE && bestPayTypeEnum != BestPayTypeEnum.ALIPAY_PC){
            throw new RuntimeException("暂不支持的支付类型");
        }
        // 需要校验论文的状态 需待付款才可支付
        // todo
        // 构建支付记录到数据库中  后续异步收到回调后才会去完善
        String orderId = buildOrderNum(paperId, bestPayTypeEnum);
        payInfoMapper.insertSelective(PayInfo.builder()
                .payPlatform(1)
                .payAmount(amount)
                .orderNo(orderId)
                .paperId(paperId)
                .userId(currentUser.getId())
                .platformStatus("toCheck")
                .createTime(new Date())
                .updateTime(new Date())
                .build());
        // 构建支付请求
        PayRequest request = new PayRequest();
        request.setOrderName("7959386-测试支付");
        // 设置支付类型
        request.setPayTypeEnum(bestPayTypeEnum);
        request.setOrderId(orderId);
        request.setOrderAmount(amount.doubleValue());

        PayResponse response = bestPayService.pay(request);
        log.info("response:{}", response);
        // 发送消息 异步生成支付的操作记录
        sender.sendPaperOperateMSG(
                PaperOperateMessage.builder()
                        // 反查数据库生成的论文
                        .paperId(paperId)
                        .note("用户付款")
                        .operateId(currentUser.getId())
                        .operateType(OperateType.PAY.getCode())
                        .build());
        return response;
    }

    @Override
    public String asyncNotify(String notifyData) {
        // 1.使用第三方包 bestpay 做签名校验
        PayResponse payResponse = bestPayService.asyncNotify(notifyData);
        // 2.查询数据库(根据异步返回的商户订单号) 检验实际支付的金额与收到的金额是否相同
        String orderId = payResponse.getOrderId();
        PayInfo payInfo = payInfoMapper.selectByOrderNo(orderId);
        if (payInfo == null || payInfo.getPlatformStatus() == "success"){
            throw new RuntimeException("网络波动引起的异常，数据库已写入！");
        }
        if (payInfo.getPayAmount().doubleValue() != payResponse.getOrderAmount()){
            throw new RuntimeException("支付金额不匹配");
        }

        // 3.发送消息 异步修改论文的状态为已支付
        sender.sendPaperStatusMSG(PaperStatusMessage.builder()
                .paperId(payInfo.getPaperId())
                .note("已收到款项")
                .build());

        // 4.发送消息生成论文支付操作记录操作
        sender.sendPaperPayMSG(PaperPayMessage.builder()
                .orderNum(orderId)
                .platformNumber(payResponse.getOutTradeNo())
                .updateTime(new Date())
                .note("回写订单操作")
                .build());

        // 5.通知微信已经收到了通知信息
        log.info("Response: {}", payResponse);
        // 判断支付平台 根据内容返回具体的响应
        if (payResponse.getPayPlatformEnum() == BestPayPlatformEnum.WX){
            return "<xml>\n" +
                    "  <return_code><![CDATA[SUCCESS]]></return_code>\n" +
                    "  <return_msg><![CDATA[OK]]></return_msg>\n" +
                    "</xml>";
        }else if (payResponse.getPayPlatformEnum() == BestPayPlatformEnum.ALIPAY){
            return "success";
        }
        else{
            throw new RuntimeException("错误的支付平台");
        }
    }


    /**
     * buildOrderNum
     * @description 构建订单编号
     * @param paperId 论文ID
     * @param bestPayTypeEnum 支付类型
     * @return {@link }
     * @author liugaoyang
     * @date 2019/11/21 17:18
     * @version 1.0.0
     */
    private String buildOrderNum(Integer paperId, BestPayTypeEnum bestPayTypeEnum){
        StringBuffer orderNum = new StringBuffer("");
        // 首先拼接支付类型
        if (bestPayTypeEnum == BestPayTypeEnum.WXPAY_NATIVE){
            orderNum.append("W001");
        }else {
            orderNum.append("A001");
        }
        orderNum.append(paperId).append(buildOrderNumSuffix14(new SimpleDateFormat("yyMMdd").format(new Date())));
        return orderNum.toString();
    }

    /**
     * buildOrderNumSuffix14
     * @description 根据时间生成后14位的订单号
     * @param date 当前时间
     * @return {@link String}
     * @author liugaoyang
     * @date 2019/11/21 17:10
     * @version 1.0.0
     */
    private String buildOrderNumSuffix14(String date){
        char[] bases = new char[]{'1','2','3', '4', '5', '6', '7', '8', '9'};
        // 将时间转换为字符并存储在容器之中
        List<Character> characters = date.chars()
                .mapToObj(e ->(char) e).collect(Collectors.toList());
        // 对数字进行洗牌排序
        Collections.shuffle(characters);
        // 将容器中的字符组合成字符串
        String mid6 = characters.stream()
                .map(Object::toString).collect(Collectors.joining());
        // 随机选择8个字符组装起来
        String suffix8 = RandomStringUtils.random(8, bases);
        return mid6 + suffix8;
    }
}
