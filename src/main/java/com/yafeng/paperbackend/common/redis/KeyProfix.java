package com.yafeng.paperbackend.common.redis;

/**
 *
 * @description redis 键值对前缀
 * @author liugaoyang
 * @date 2019/10/7 20:53
 * @version 1.0.0
 */
public interface KeyProfix {
    /**
     * getExpireSecond
     * @description 返回键值对得存活时间
     * @return int
     * @author liugaoyang
     * @date 2019/7/7 19:12
     * @version 1.0.0
     */
    int expireSeconds();

    /**
     * getPrefix
     * @description 得到键值得前缀
     * @return java.lang.String
     * @author liugaoyang
     * @date 2019/7/7 18:43
     * @version 1.0.0
     */
    String prefix();
}
