package com.yafeng.paperbackend.bean.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.naming.Name;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.bean.vo
 * describe: 基础分页对象
 * @author : songyafeng
 * creat_time: 2019/10/17 15:25
 **/
@Data
@ApiModel("基础分页对象")
public class PageQueryVo {
    @ApiModelProperty(name = "pageNum", value = "当前页数，从1开始")
    @Min(value = 1)
    @NotNull(message = "当前页数不能为空")
    private Integer pageNum;
    @ApiModelProperty(name = "pageSize", value = "分页大小")
    @Min(value = 1)
    @NotNull(message = "分页大小不能为空")
    private Integer pageSize;
}
