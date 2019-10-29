package com.yafeng.paperbackend.bean.vo.operation;

import com.yafeng.paperbackend.bean.vo.PageQueryVo;
import io.swagger.annotations.ApiModel;
import lombok.*;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 操作记录查询实体类
 * @date 2019/10/28 0:05
 */
@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ApiModel("论文操作记录查询请求分页对象")
public class OperationQueryVo extends PageQueryVo {
    /** 论文主键 */
    private Integer paperId;
}
