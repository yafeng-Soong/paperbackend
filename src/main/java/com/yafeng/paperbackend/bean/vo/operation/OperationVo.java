package com.yafeng.paperbackend.bean.vo.operation;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import java.util.Date;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 组装的操作信息 包含了操作者的用户名以及角色
 * @date 2019/11/27 13:04
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OperationVo {


    private Integer id;

    /**
     * 操作者id
     */
    @Column(name = "operator_id")
    private Integer operatorId;

    /**
     * 文章id
     */
    @Column(name = "paper_id")
    private Integer paperId;

    /**
     * 操作类型，0用户提交、1用户修改、2用户支付、3管理员退回，4管理员通过
     */
    private Integer type;

    /**
     * 操作完成时间
     */
    @Column(name = "create_time")
    private Date createTime;

    /**
     * 操作备注，如退回理由
     */
    private String note;

    /**
     * 操作用户名
     */
    private String username;

    /**
     * 操作用户角色
     */
    private String role;
}
