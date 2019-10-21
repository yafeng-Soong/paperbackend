package com.yafeng.paperbackend.bean.entity;

import com.yafeng.paperbackend.enums.CheckStatus;
import com.yafeng.paperbackend.enums.PayStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import javax.persistence.*;

/**
 *
 * @description 论文实体类
 * @author liugaoyang
 * @date 2019/10/21 14:54
 * @version 1.0.0
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "paper")
public class Paper {
    /**
     * 自增主键
     */
    @Id
    @GeneratedValue(generator = "JDBC")
    private Integer id;

    /**
     * 论文名称
     */
    private String name;

    /**
     * 提交论文的用户email
     */
    @Column(name = "publisher_email")
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
    @Column(name = "file_path")
    private String filePath;

    /**
     * 支付状态 0未支付 1已支付
     */
    @Column(name = "pay_status")
    private Integer payStatus;

    /**
     * 审核状态 0待审核 1待修改 2已通过
     */
    @Column(name = "check_status")
    private Integer checkStatus;

    /**
     * 创建时间
     */
    @Column(name = "create_time")
    private Date createTime;

    /**
     * 修改时间
     */
    @Column(name = "update_time")
    private Date updateTime;

    /**
     * Paper
     * @description 自定义构造函数
     * @param name 论文名称
     * @param publisherEmail 提交者邮箱
     * @param keyword 论文关键字
     * @param summary 论文概要
     * @param filePath 论文存储路径
     * @param payStatus 支付状态
     * @param checkStatus 论文审核状态
     * @return {@link Paper}
     * @author liugaoyang
     * @date 2019/10/21 14:58
     * @version 1.0.0
     */
    public Paper(String name, String publisherEmail, String keyword, String summary,
                 String filePath, PayStatus payStatus, CheckStatus checkStatus,
                 Date createTime){
        this.name = name;
        this.publisherEmail = publisherEmail;
        this.keyword = keyword;
        this.summary = summary;
        this.filePath = filePath;
        this.payStatus = payStatus.getCode();
        this.checkStatus = checkStatus.getCode();
        this.createTime = createTime;
        this.updateTime = new Date();

    }

}