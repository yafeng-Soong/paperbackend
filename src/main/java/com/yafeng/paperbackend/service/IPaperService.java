package com.yafeng.paperbackend.service;

import com.yafeng.paperbackend.bean.entity.Paper;
import com.yafeng.paperbackend.bean.vo.admin.AdminCheckVo;
import com.yafeng.paperbackend.bean.vo.paper.PaperBuildVo;
import com.yafeng.paperbackend.bean.vo.paper.PaperCancelVo;
import com.yafeng.paperbackend.bean.vo.paper.PaperUpdateVo;
import com.yafeng.paperbackend.exception.PaperException;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 论文审核相关功能接口
 * @date 2019/10/21 15:33
 */
public interface IPaperService {

    /**  用户创建论文*/
    void buildPaper(PaperBuildVo vo) throws PaperException;

    /**  用户更新论文*/
    void updatePaper(PaperUpdateVo vo) throws PaperException;

    /**  用户查询论文列表*/
    List<Paper> getAllPapers();

    /**  根据支付状态和审核状态查询论文*/
    List<Paper> getAllPapersByPayAndCheck(Integer pay, Integer check);

    /**  管理员根据审核状态查找论文列表*/
    List<Paper> getAllPapersByCheckStatus(Integer check);

    /**  根据用户邮箱和论文名称查找论文*/
    Paper findByEmailAndName(String email, String name);

    /**  管理员审核论文*/
    void reviewPaper(AdminCheckVo vo) throws PaperException;

    /**  用户撤销论文*/
    void cancelPaper(PaperCancelVo vo) throws PaperException;

    /** 将论文状态改为已支付*/
    void pay(Integer paperId) throws PaperException;

}
