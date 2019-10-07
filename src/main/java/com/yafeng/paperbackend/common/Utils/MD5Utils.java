package com.yafeng.paperbackend.common.Utils;

import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @description MD5加密工具类
 * @author liugaoyang
 * @date 2019/10/7 20:56
 * @version 1.0.0
 */
public class MD5Utils {

    // 服务端固定的盐值
    private static final String salt = "asd23ejsc@12";

    private MD5Utils(){
        throw new IllegalStateException("Utility class");
    }


    /**
     * MD5encode
     * @description 利用固定盐值对密码进行加密
     * @param password
     * @return java.lang.String
     * @author liugaoyang
     * @date 2019/7/11 23:47
     * @version 1.0.0
     */
    public static String MD5encode(String password){
        return DigestUtils.md5Hex(password + salt);
    }

    /**
     * MD5encode
     * @description 对用户填写的密码进行随机盐值  二次加密
     * @param password
     * @param salt
     * @return java.lang.String
     * @author liugaoyang
     * @date 2019/7/11 23:46
     * @version 1.0.0
     */
    public static String MD5encode(String password, String salt){
        return DigestUtils.md5Hex(password + salt);
    }

    /**
     * MD5encodeDB
     * @description 将用户填写的密码加密成数据库存储的形式（两次加密 第一次加密以固定的盐值进行加密，第二次加密是将第一次加密的结果 加上随机的盐值加密存储导数据库中，随机产生的盐值也存储在数据库中）
     * @param password
     * @param salt
     * @return java.lang.String
     * @author liugaoyang
     * @date 2019/7/11 23:43
     * @version 1.0.0
     */
    public static String MD5encodeDB(String password, String salt){
        return MD5encode(MD5encode(password), salt);
    }

}
