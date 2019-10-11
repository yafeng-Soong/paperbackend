package com.yafeng.paperbackend.util;

import sun.misc.BASE64Encoder;

import java.security.MessageDigest;

/**
 * @author KONG
 * @version 1.0
 * @since 2019/10/11
 */
public class Md5 {
    public static String EncoderByMd5(String pwd, String salt){
        try {
            pwd = pwd+salt;
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            String newstr = base64en.encode(md5.digest(pwd.getBytes("utf-8")));
            return newstr;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
