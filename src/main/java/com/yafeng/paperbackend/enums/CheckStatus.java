package com.yafeng.paperbackend.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Objects;
import java.util.stream.Stream;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 论文审核状态
 * @date 2019/10/20 21:27
 */
@Getter
@AllArgsConstructor
public enum CheckStatus {

    // 用户第一次提交的论文为待审核、 若审核通过则变为已通过状态、若未通过则变为待修改状态 需要用户修改后再次提交
    PENDINGREVIEW("待审核", 0),
    TOBEMODIFIED("待修改",1),
    PASSED("已通过",2);

    private String description;

    private Integer code;

    public static CheckStatus of(Integer code){
        Objects.requireNonNull(code);
        return Stream.of(values())
                .filter(e->e.getCode().equals(code))
                .findAny()
                .orElseThrow(()-> new IllegalArgumentException(code + "not exists in PayStatus"));
    }
}
