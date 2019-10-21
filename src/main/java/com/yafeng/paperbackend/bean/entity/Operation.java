package com.yafeng.paperbackend.bean.entity;

import com.yafeng.paperbackend.enums.OperateType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import javax.persistence.*;

/**
 *
 * @description 论文操作记录实体类
 * @author liugaoyang
 * @date 2019/10/21 14:54
 * @version 1.0.0
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "operation")
public class Operation {
    @Id
    @GeneratedValue(generator = "JDBC")
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
     * 操作类型，1—管理员通过，2—管理员退回，3—投稿者撤销
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
     * Operation
     * @description 自定义构造函数
     * @param operatorId 对论文操作用户
     * @param paperId 论文主键
     * @param note 操作记录备注
     * @param operateType 操作类型
     * @return {@link Operation}
     * @author liugaoyang
     * @date 2019/10/21 15:04
     * @version 1.0.0
     */
    public Operation(Integer operatorId, Integer paperId, String note, OperateType operateType,Date createTime){
        this.note = note;
        this.operatorId = operatorId;
        this.paperId = paperId;
        this.type = operateType.getCode();
        this.createTime = createTime;
    }

}