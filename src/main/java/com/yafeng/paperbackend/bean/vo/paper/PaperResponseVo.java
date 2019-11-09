package com.yafeng.paperbackend.bean.vo.paper;

import com.yafeng.paperbackend.bean.entity.Paper;
import lombok.Data;
import org.springframework.beans.BeanUtils;

import java.util.Date;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.bean.vo.paper
 * describe: 返回给前端的论文实体类
 * @author : songyafeng
 * creat_time: 2019/11/9 19:06
 **/
@Data
public class PaperResponseVo {
    /**
     * 自增主键
     */
    private Integer id;

    /**
     * 论文名称
     */
    private String name;

    /**
     * 提交论文的用户email
     */
    private String publisherEmail;

    /**
     * 论文关键字
     */
    private String keyword;

    /**
     * 论文概要
     */
    private String summary;

    /**
     * 文件存储路径
     */
    private String filePath;

    /**
     * 审核状态 0-待审核 1-待修改 2-已通过待付款 3-已付款 4-已撤回
     */
    private String checkStatus;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改时间
     */
    private Date updateTime;

    public  PaperResponseVo(Paper paper){
        BeanUtils.copyProperties(paper, this);
        String status = "待审核";
        switch (paper.getCheckStatus()){
            case 0: status = "待审核"; break;
            case 1: status = "待修改"; break;
            case 2: status = "已通过待付款"; break;
            case 3: status = "已付款"; break;
            case 4: status = "已撤回"; break;
            default: break;
        }
        this.setCheckStatus(status);
    }
}
