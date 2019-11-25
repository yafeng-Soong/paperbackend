package com.yafeng.paperbackend.bean.vo.user;

import lombok.Data;

import java.math.BigDecimal;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.bean.vo.user
 * describe: 返回给前端的用户实体类
 * @author : songyafeng
 * creat_time: 2019/10/19 15:30
 **/
@Data
public class UserResponseVo {
    private String username;
    private String email;
    private String avatar;
    private BigDecimal cash;
    private Integer sex;
    private String signature;
    private String role;
}
