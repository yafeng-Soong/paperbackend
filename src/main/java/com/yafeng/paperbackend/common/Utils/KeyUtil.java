package com.yafeng.paperbackend.common.Utils;

import java.util.Random;
import java.util.UUID;

/**
 * KeyUtil
 * @description 用来生成唯一的主键
 * @param
 * @return
 * @author liugaoyang
 * @date 2019/3/17 21:58
 * @version 1.0.0
 */
public class KeyUtil {

    private KeyUtil(){
        throw new IllegalStateException("Utility class");
    }

    //以当前的毫秒数与随机数  同时因为是获取唯一id因此要防止多线程下时间相同
    public static synchronized String getUniqueKey(){
        Integer number = new Random().nextInt(900000) + 100000;
        return  System.currentTimeMillis() + String.valueOf(number) ;
    }

    //生成唯一的UUID
    public static synchronized String getUUID(){
        return UUID.randomUUID().toString().replace("-", "");
    }
}

