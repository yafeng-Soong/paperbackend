package com.yafeng.paperbackend.bean.vo.user;

import com.yafeng.paperbackend.bean.vo.PageQueryVo;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.bean.vo.user
 * describe: 用户类分页查询Vo
 * @author : songyafeng
 * creat_time: 2019/10/17 15:59
 **/
@EqualsAndHashCode(callSuper = true)
@Data
@ApiModel("用户类分页查询Vo")
public class UserQueryVo extends PageQueryVo {
    @ApiModelProperty(value = "用户注册邮箱")
    private String email;
    @ApiModelProperty(value = "用户名")
    private String username;
    @ApiModelProperty(value = "性别")
    private Integer sex;
}
