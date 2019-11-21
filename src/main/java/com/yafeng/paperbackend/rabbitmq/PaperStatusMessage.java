package com.yafeng.paperbackend.rabbitmq;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 修改论文状态消息
 * @date 2019/11/21 20:50
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PaperStatusMessage {

    private Integer paperId;

    private String note;
}
