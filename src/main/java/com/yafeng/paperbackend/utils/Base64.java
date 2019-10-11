package com.yafeng.paperbackend.utils;

import sun.misc.BASE64Encoder;

import java.io.UnsupportedEncodingException;

/**
 * @author KONG
 * @version 1.0
 * @since 2019/10/11
 * base64 加密
 */
public class Base64 {
    public static String getbase64(String str){
        byte[] b=null;
        String s=null;
        try {
            b = str.getBytes("utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        if(b!=null){
            s=new BASE64Encoder().encode(b);
        }
        return s;
    }
}
