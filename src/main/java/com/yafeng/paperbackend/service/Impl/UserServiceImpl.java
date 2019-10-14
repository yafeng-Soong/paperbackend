package com.yafeng.paperbackend.service.Impl;

import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.mapper.UserMapper;
import com.yafeng.paperbackend.service.UserService;
import com.yafeng.paperbackend.utils.PasswordHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.service.Impl
 * describe: 由开发人员自主完善
 *
 * @author : songyafeng
 * creat_time: 2019/10/6 21:22
 **/
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;
    @Override
    public User selectByEmail(String email) {
        return userMapper.selectByEmail(email);
    }

    @Override
    public int countAll() {
        return userMapper.countAll();
    }

    @Override
    public List<User> selectAll() {
        return userMapper.selectAll();
    }

    @Override
    public int insert(User entity) {
        //先对user的密码进行哈希散列
        PasswordHelper helper = new PasswordHelper();
        helper.encryptPassword(entity);
        //返回id
        userMapper.insert(entity);
        return entity.getId();
    }

    @Override
    public int update(User entity) {
        return userMapper.update(entity);
    }

    @Override
    public List<User> selectList(User query) {
        return userMapper.selectList(query);
    }

    @Override
    public int delete(User query) {
        return userMapper.delete(query);
    }

    /**
     * 更新头像路径
     * @param user
     * @return
     */
    @Override
    public int updateAvatar(User user){
        User update = new User();
        update.setAvatar(user.getAvatar());
        update.setEmail(user.getEmail());
        return userMapper.update(update);
    }
}
