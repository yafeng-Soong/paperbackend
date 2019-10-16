package com.yafeng.paperbackend.bean.vo.user;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.bean.vo
 * describe: 用户更新VO
 * @author : songyafeng
 * creat_time: 2019/10/16 10:58
 **/
@Data
@ApiModel
public class UserUpdateVo {
    @ApiModelProperty(value = "修改后的用户名")
    private String username;
    @ApiModelProperty(value = "修改后的简介")
    private String signature;
    @ApiModelProperty(value = "修改后的性别")
    private boolean sex;

    public boolean getSex(){
        return sex;
    }
}
