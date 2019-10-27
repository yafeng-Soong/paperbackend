package com.yafeng.paperbackend.bean.vo.paper;

import com.yafeng.paperbackend.bean.vo.PageQueryVo;
import io.swagger.annotations.ApiModel;
import lombok.*;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 用户论文查询实体类
 * @date 2019/10/28 0:18
 */
@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ApiModel("论文查询分页（根据状态）对象")
public class PaperQueryVo extends PageQueryVo {

    private Integer payStatus;

    private Integer checkStatus;
}
