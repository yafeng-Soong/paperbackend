package com.yafeng.paperbackend.bean.vo.operation;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.bean.vo.operation
 * describe: 支付实体类
 * @author : songyafeng
 * creat_time: 2019/11/22 15:22
 **/
@Data
@ApiModel("支付实体类")
public class PayVo {
    @NotNull
    @ApiModelProperty(value = "论文的id")
    private Integer paperId;
    @NotNull
    @ApiModelProperty(value = "支付金额")
    @Min(value = 1)
    @Max(value = 10000)
    private BigDecimal cash;
}
