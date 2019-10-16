package com.yafeng.paperbackend.bean.vo;

import com.yafeng.paperbackend.utils.RegexpUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.bean.vo
 * describe: 注册和登录时使用的VO
 * @author : songyafeng
 * creat_time: 2019/10/14 11:00
 **/
@Data
@ApiModel
public class RegisterAndLoginVo {
    @ApiModelProperty(value = "注册和登录邮箱", required = true)
    @NotNull(message = "邮箱字段不能为空")
    @Pattern(regexp = RegexpUtil.REG_EMAIL, message = "请输入正确格式的邮箱")
    private String email;
    @ApiModelProperty(value = "注册和登录密码", required = true)
    @NotNull(message = "密码字段不能为空")
    @Pattern(regexp = RegexpUtil.REG_PASSWORD, message = "请输入6~10位的数字和字母组合的密码")
    private String password;
}
