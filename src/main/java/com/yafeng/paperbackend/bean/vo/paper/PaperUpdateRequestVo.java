package com.yafeng.paperbackend.bean.vo.paper;

import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.StringUtils;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 论文更新vo
 * @date 2019/10/23 17:26
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ApiModel("用户申请更新论文对象")
public class PaperUpdateRequestVo {

    /** 更新的论文主键 */
    private Integer id;

    /** 论文名称 */
    private String name;

    /** 论文关键字 */
    private String keyword;

    /** 论文概要*/
    private String summary;

    /** 论文文件在服务器上的全路径*/
    private String filePath;

    /** 备注消息*/
    private String note;

    /**
     * validate
     * @description 校验论文修改提交的参数
     * 主键id一定不能为空 其他参数至少修改一项 修改备注也不能为空
     * @return {@link Boolean}
     * @author liugaoyang
     * @date 2019/10/23 17:30
     * @version 1.0.0
     */
    public boolean validate(){
        return (id != null) &&(StringUtils.isNotEmpty(name)
        || StringUtils.isNotEmpty(keyword)
        || StringUtils.isNotEmpty(summary)
        || StringUtils.isNotEmpty(filePath)) && (StringUtils.isNotEmpty(note));
    }
}
