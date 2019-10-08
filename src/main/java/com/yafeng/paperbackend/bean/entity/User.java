package com.yafeng.paperbackend.bean.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.bean.entity
 * describe: 用户类
 * @author : songyafeng
 * creat_time: 2019/10/6 20:08
 **/
@ApiModel
@Data
public class User {
    private Integer id;
    @ApiModelProperty(value = "用户名，注册时必填")
    private String username;
    @ApiModelProperty(value = "密码，注册必填")
    private String password;
    private String salt;
    @ApiModelProperty(value = "邮箱，注册时必填")
    private String email;
}
