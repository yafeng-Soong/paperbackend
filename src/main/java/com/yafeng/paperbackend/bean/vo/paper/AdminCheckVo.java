package com.yafeng.paperbackend.bean.vo.paper;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.StringUtils;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 管理员审核信息
 * @date 2019/10/25 19:56
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdminCheckVo {

    /** 论文主键 */
    private Integer paperId;

    /** 评语 */
    private String note;

    /** 退回或者是通过 */
    private Integer type;

    public boolean validate(){
        return paperId != null
                && type != null
                && StringUtils.isNotEmpty(note);
    }

}
