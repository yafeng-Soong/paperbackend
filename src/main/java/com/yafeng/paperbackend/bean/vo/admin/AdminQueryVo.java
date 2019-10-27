package com.yafeng.paperbackend.bean.vo.admin;

import com.yafeng.paperbackend.bean.vo.PageQueryVo;
import io.swagger.annotations.ApiModel;
import lombok.*;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 管理员查询论文请求实体类
 * @date 2019/10/27 23:31
 */
@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ApiModel("管理员查询论文(审核状态)请求分页对象")
public class AdminQueryVo extends PageQueryVo {

    // 论文的审核状态
    private Integer checkStatus;

}
