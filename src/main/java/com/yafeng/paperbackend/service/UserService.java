package com.yafeng.paperbackend.service;

import com.yafeng.paperbackend.base.BaseService;
import com.yafeng.paperbackend.bean.entity.User;
import org.springframework.stereotype.Service;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.service
 * describe: 由开发人员自主完善
 *
 * @author : songyafeng
 * creat_time: 2019/10/6 20:13
 **/
public interface UserService extends BaseService<User> {
    /**
     * 通过邮箱查找
     * @param email
     * @return
     */
    User selectByEmail(String email);

    /**
     * 修改头像
     * @param user
     * @return
     */
    int updateAvatar(User user);

    /**
     * 激活账户
     * @param email
     * @return
     */
    int activateUser(String email);
}
