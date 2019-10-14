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
    User selectByEmail(String email);
    int updateAvatar(User user);
}
