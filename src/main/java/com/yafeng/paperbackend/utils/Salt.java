package com.yafeng.paperbackend.utils;

import java.util.Random;

/**
 * @author KONG
 * @version 1.0
 * @since 2019/10/11
 */
public class Salt {
    /**
     * 生成16位数的随机salt值
     * @return
     */
    public static String randomSalt() {
        Random r = new Random();
        StringBuilder sb = new StringBuilder(16);
        sb.append(r.nextInt(99999999)).append(r.nextInt(99999999));
        int len = sb.length();
        if (len < 16) {
            for (int i = 0; i < 16 - len; i++) {
                sb.append("0");
            }
        }
        String salt = sb.toString();
        return salt;
    }
}
