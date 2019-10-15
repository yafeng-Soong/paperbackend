package com.yafeng.paperbackend.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.utils
 * describe: 正则匹配工具
 * @author : songyafeng
 * creat_time: 2019/10/14 11:07
 **/
public class RegexpUtil {
    /**
     * 邮箱正则表达式
     */
    public static final String REG_EMAIL = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
    /**
     * 密码正则表达式 6-16位字母数字组合；
     */
    public static final String REG_PASSWORD="^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";

    public static boolean genericMatcher(String regexExpre,String testStr){
        Pattern pattern=Pattern.compile(regexExpre);
        Matcher matcher = pattern.matcher(testStr);
        return matcher.matches();
    }

    /**
     * 校验邮箱
     * @param email
     * @return
     */
    public static boolean emailMatcher(String email){
        Pattern pattern=Pattern.compile(REG_EMAIL);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    /**
     * 校验密码
     * @param password
     * @return
     */
    public static boolean passwordMatcher(String password){
        Pattern pattern=Pattern.compile(REG_PASSWORD);
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
    }

}
