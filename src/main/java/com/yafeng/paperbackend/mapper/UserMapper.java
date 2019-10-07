package com.yafeng.paperbackend.mapper;

import com.yafeng.paperbackend.base.BaseMapper;
import com.yafeng.paperbackend.bean.entity.User;
import org.apache.ibatis.annotations.Mapper;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.mapper
 * describe: 用户类Mapper接口
 * @author : songyafeng
 * creat_time: 2019/10/6 21:23
 **/
@Mapper
public interface UserMapper extends BaseMapper<User>{
    User selectByEmail(String email);
}
