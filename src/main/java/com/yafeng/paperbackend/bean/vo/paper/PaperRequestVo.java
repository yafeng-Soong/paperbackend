package com.yafeng.paperbackend.bean.vo.paper;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.StringUtils;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 用户提交论文审核的请求
 * @date 2019/10/21 15:07
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PaperRequestVo {

    /**一个用户提交的论文不存在重名的情况 不同的用户可以提交相同名字的论文*/

    /** 论文名称 */
    private String name;

    /** 论文关键字 */
    private String keyword;

    /** 论文概要 */
    private String summary;

    /** 论文文件在服务器上的全路径*/
    private String filePath;

    public boolean validate(){
        return StringUtils.isNotEmpty(name)
                && StringUtils.isNotEmpty(keyword)
                && StringUtils.isNotEmpty(summary)
                && StringUtils.isNotEmpty(filePath);
    }
}
