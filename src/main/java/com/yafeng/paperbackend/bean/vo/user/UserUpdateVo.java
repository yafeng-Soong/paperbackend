package com.yafeng.paperbackend.bean.vo.user;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.bean.vo
 * describe: 用户更新VO
 * @author : songyafeng
 * creat_time: 2019/10/16 10:58
 **/
@Data
@ApiModel
@JsonIgnoreProperties(ignoreUnknown = true)
public class UserUpdateVo {
    @ApiModelProperty(value = "修改后的用户名")
    private String username;
    @ApiModelProperty(value = "修改后的简介")
    private String signature;
    @ApiModelProperty(value = "修改后的性别")
    private Integer sex;
    @ApiModelProperty(value = "账户余额")
    private BigDecimal cash;

    public Integer getSex(){
        return sex;
    }
}
