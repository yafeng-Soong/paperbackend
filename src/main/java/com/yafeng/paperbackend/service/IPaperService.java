package com.yafeng.paperbackend.service;

import com.yafeng.paperbackend.bean.entity.Paper;
import com.yafeng.paperbackend.bean.vo.paper.PaperRequestVo;
import com.yafeng.paperbackend.bean.vo.paper.PaperUpdateVo;
import com.yafeng.paperbackend.exception.PaperException;

import java.util.List;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 论文审核相关功能接口
 * @date 2019/10/21 15:33
 */
public interface IPaperService {

    void buildPaper(PaperRequestVo vo) throws PaperException;

    void modifyPaper(PaperUpdateVo vo) throws PaperException;

    List<Paper> getAllPapers();

    List<Paper> getAllPapersByPayAndCheck(Integer pay, Integer check);

    Paper findByEmailAndName(String email, String name);

}
