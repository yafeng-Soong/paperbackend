package com.yafeng.paperbackend.utils;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.utils
 * describe: 由开发人员自主完善
 *
 * @author : songyafeng
 * creat_time: 2019/10/14 11:07
 **/
public class RegexpConstant {
    /**
     * 邮箱正则表达式
     */
    public static final String REG_EMAIL = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
    /**
     * 密码正则表达式 6-16位字母数字组合；
     */
    public static final String REG_PASSWORD="^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";

}
