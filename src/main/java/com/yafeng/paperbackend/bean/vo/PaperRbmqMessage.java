package com.yafeng.paperbackend.bean.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description rbmq 消息对象
 * @date 2019/10/23 20:43
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PaperRbmqMessage {

    /** 论文操作类型 */
    private Integer operateType;

    /** 操作者ID*/
    private Integer operateId;

    /** 被操作的论文主键*/
    private Integer paperId;

    /** 操作备注信息 */
    private String note;

}
