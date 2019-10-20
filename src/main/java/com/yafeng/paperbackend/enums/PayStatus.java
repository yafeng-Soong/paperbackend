package com.yafeng.paperbackend.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Objects;
import java.util.stream.Stream;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 支付状态
 * @date 2019/10/20 21:26
 */
@Getter
@AllArgsConstructor
public enum PayStatus {

    UNPAID("未支付", 0),
    PAID("已支付", 1);

    private String description;

    private Integer code;

    public static PayStatus of(Integer code){
        Objects.requireNonNull(code);
        return Stream.of(values())
                .filter(e->e.getCode().equals(code))
                .findAny()
                .orElseThrow(()->new IllegalArgumentException(code + "not exist in PayStatus"));
    }
}
