package com.yafeng.paperbackend.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Objects;
import java.util.stream.Stream;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 操作类型枚举类
 * @date 2019/10/20 20:39
 */
@Getter
@AllArgsConstructor
public enum OperateType {

    // 待补充与完善
    // 对论文的操作 分为用户操作 与审核人员操作
    // 用户可以 提交、修改、撤销（用户只能撤销未审核的论文）
    // 审核人员可以 退稿、通过
    SUBMIT("提交", 0),
    MODIFY("修改", 1),
    PAY("支付", 2),
    RETURNED("退回",3),
    PASSED("通过", 4),
    CANCEL("撤销", 5);

    private String description;

    private Integer code;


    public static OperateType of(Integer code){
        Objects.requireNonNull(code);
        return Stream.of(values())
                .filter(e->e.getCode().equals(code))
                .findAny()
                .orElseThrow(()-> new IllegalArgumentException(code + "not exists in OperateType"));
    }
}
