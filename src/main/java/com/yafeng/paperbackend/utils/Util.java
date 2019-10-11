package com.yafeng.paperbackend.utils;

import java.util.UUID;

/**
 * @author KONG
 * @version 1.0
 * @since 2019/10/11
 * 工具类
 */
public class Util {
    public static String uuid (){
        UUID uuid = UUID.randomUUID();
        long l = System.currentTimeMillis();
        String l1 = uuid + String.valueOf(l);
        return l1;
    }
    public static String cuo() {
        long l = System.currentTimeMillis();
        return String.valueOf(l);
    }
    public static String deleesyh(String zifu){
        zifu  = zifu.replaceAll("\"","").replaceAll("\"","");
        return zifu;
    }
}
