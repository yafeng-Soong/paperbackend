package com.yafeng.paperbackend.utils;

import com.yafeng.paperbackend.bean.entity.User;
import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.utils
 * describe: 用户注册时的密码加密工具
 * @author : songyafeng
 * creat_time: 2019/10/7 12:23
 **/
public class PasswordHelper {
    //随机字符串生成器，用于生成盐值
    private RandomNumberGenerator numberGenerator = new SecureRandomNumberGenerator();

    //哈希散列算法——md5
    public static final String ALGORITHM_NAME = "md5";

    //散列次数2
    public static final int HASH_ITERATION = 2;

    /**
     *  加密用户
     * @param user 用户，用户名(name)、密码(pwd)、盐\加密因子(salt)
     */
    public void encryptPassword(User user){
        if (user.getPassword() == null || "".equals(user.getPassword()))
            return;
        //生成加密因子，保存盐。
        user.setSalt(numberGenerator.nextBytes().toHex());
        //加密密码 SimpleHash（算法名，密码，盐的byte，次数）.toHex()
        String newPassword = new SimpleHash(ALGORITHM_NAME ,user.getPassword(), ByteSource.Util.bytes(user.getSalt()),HASH_ITERATION).toHex();
        //更新密码
        user.setPassword(newPassword );
    }
}
