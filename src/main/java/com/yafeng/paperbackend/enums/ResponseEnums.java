package com.yafeng.paperbackend.enums;

import lombok.Getter;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.enums
 * describe: 由开发人员自主完善
 *
 * @author : songyafeng
 * creat_time: 2019/10/6 23:11
 **/
public enum ResponseEnums {
    SUCCESS(200, "操作成功"),
    LOGIN_SUCCESS(201, "登录成功"),
    LOGIN_UNKNOWN(202, "用户不存在"),
    LOGIN_ERROR(203, "账号或密码错误"),
    LOGIN_CHECK_ERROR(204, "输入的旧密码不匹配"),
    ERROR(400, "操作失败"),
    UNAUTHORIZED(401, "您还未登录"),
    NOT_FOUND(404, "资源不存在"),
    INNER_ERROR(500, "系统发生异常"),
    PARAMETER_ERROR(601, "文章上传失败");

    @Getter
    private Integer code;
    @Getter
    private String msg;


    ResponseEnums(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }
}
