package com.yafeng.paperbackend.bean.vo;

import com.yafeng.paperbackend.utils.RegexpConstant;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.bean.vo
 * describe: 由开发人员自主完善
 *
 * @author : songyafeng
 * creat_time: 2019/10/14 11:00
 **/
@Data
@ApiModel
public class LoginVo {
    /**
     * 登录邮箱
     */
    @ApiModelProperty(value = "登录邮箱", required = true)
    @NotNull(message = "邮箱字段不能为空")
    @Pattern(regexp = RegexpConstant.REG_EMAIL, message = "请输入正确格式的邮箱")
    private String email;
    @ApiModelProperty(value = "登录密码", required = true)
    @NotNull(message = "密码字段不能为空")
    @Pattern(regexp = RegexpConstant.REG_PASSWORD, message = "请输入6~10位的数字和字母组合的密码")
    private String password;
}
