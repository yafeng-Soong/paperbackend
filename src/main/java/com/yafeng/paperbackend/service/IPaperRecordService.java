package com.yafeng.paperbackend.service;

import com.yafeng.paperbackend.bean.entity.Operation;
import com.yafeng.paperbackend.exception.PaperException;

import java.util.List;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 对操作记录的相关查询操作
 * @date 2019/10/24 9:59
 */
public interface IPaperRecordService {

    /** 查询某篇论文的操作记录（限制查询用户？） */
    List<Operation> findAllByPaperId(Integer paperId) throws PaperException;
}
