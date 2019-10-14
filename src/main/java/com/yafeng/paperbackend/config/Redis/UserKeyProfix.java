package com.yafeng.paperbackend.config.Redis;

import com.yafeng.paperbackend.base.BaseProfix;
import lombok.Data;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description redis中用户前缀
 * @date 2019/10/14 20:11
 */
@Data
public class UserKeyProfix extends BaseProfix {

    private UserKeyProfix(String prefix){
        super(prefix);
    }
    private UserKeyProfix(int expiretime, String prefix){
        super(expiretime, prefix);
    }

    public static UserKeyProfix Id = new UserKeyProfix("ID");
    public static UserKeyProfix Name = new UserKeyProfix("Name");
    public static UserKeyProfix TOKEN = new UserKeyProfix("Token");
    // 访问次数  用来记录某个接口1分钟内的访问次数
    public static UserKeyProfix COUNT = new UserKeyProfix(60,"COUNT");
    // 用于构建通用的访问次数限制
    public static UserKeyProfix count(Integer expireTime){
        return new UserKeyProfix(expireTime, "COMMONCOUNT");
    }

}
