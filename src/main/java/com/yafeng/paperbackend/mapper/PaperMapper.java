package com.yafeng.paperbackend.mapper;

import com.yafeng.paperbackend.bean.entity.Paper;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 *
 * @description 通用mapper插件创建的基本mapper文件 包含了所需的单表操作
 * @author liugaoyang
 * @date 2019/10/21 14:55
 * @version 1.0.0
 */
public interface PaperMapper extends Mapper<Paper> {

    /**
     * selectByPublisherEmail
     * @description 查找用户提交的所有论文
     * @param email 提交用户的邮箱
     * @return {@link Paper}s
     * @author liugaoyang
     * @date 2019/10/21 15:30
     * @version 1.0.0
     */
    List<Paper> selectByPublisherEmail(String email);

    /**
     * selectByPublisherEmailAndStatus
     * @description 查询用户的某个状态的所有论文
     * @param
     * @return {@link Paper}s
     * @author liugaoyang
     * @date 2019/10/21 15:30
     * @version 1.0.0
     */
    List<Paper> selectByPublisherEmailAndStatus(@Param("email") String email, @Param("payStatus") Integer payStatus, @Param("checkStatus") Integer checkStatus);

    /**
     * selectByPublisherEmailAndName
     * @description 根据用户 和论文名称筛选论文
     * @param
     * @return {@link }
     * @author liugaoyang
     * @date 2019/10/23 16:32
     * @version 1.0.0
     */
    Paper selectByPublisherEmailAndName(@Param("email") String email, @Param("paperName") String paperName);
}