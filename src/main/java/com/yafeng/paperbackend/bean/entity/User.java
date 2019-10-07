package com.yafeng.paperbackend.bean.entity;

import lombok.Data;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.bean.entity
 * describe: 用户类
 * @author : songyafeng
 * creat_time: 2019/10/6 20:08
 **/
@Data
public class User {
    private Integer id;
    private String username;
    private String password;
    private String salt;
    private String email;
}
