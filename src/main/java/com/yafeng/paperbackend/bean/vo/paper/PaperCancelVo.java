package com.yafeng.paperbackend.bean.vo.paper;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.StringUtils;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 撤销论文审核请求
 * @date 2019/11/4 20:15
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PaperCancelVo {

    /** 论文主键 */
    private Integer paperId;

    /**  撤销提交备注*/
    private String note;

    public boolean validate(){
        return paperId != null
                && StringUtils.isNotEmpty(note);
    }
}
