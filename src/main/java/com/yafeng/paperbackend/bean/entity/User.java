package com.yafeng.paperbackend.bean.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

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
    private String username;
    private String password;
    private String salt;
    private String email;
    private int state;
    private String avatar;
    private BigDecimal cash;
    private String role;
}
