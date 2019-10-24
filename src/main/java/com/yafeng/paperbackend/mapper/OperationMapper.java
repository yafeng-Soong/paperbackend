package com.yafeng.paperbackend.mapper;

import com.yafeng.paperbackend.bean.entity.Operation;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 *
 * @description 通用mapper创建的基本mapper文件 包含了所需的单表操作
 * @author liugaoyang
 * @date 2019/10/21 14:55
 * @version 1.0.0
 */

public interface OperationMapper extends Mapper<Operation> {

    /**
     * selectByUserId
     * @description 用户查询自己的所有论文提交记录
     * @param {@link Integer} 用户id
     * @return {@link Operation}s
     * @author liugaoyang
     * @date 2019/10/21 16:26
     * @version 1.0.0
     */
    List<Operation> selectByUserId(Integer userId);

    List<Operation> selectByPaperId(Integer paperId);

}