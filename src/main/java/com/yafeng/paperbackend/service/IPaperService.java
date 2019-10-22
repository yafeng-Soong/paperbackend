package com.yafeng.paperbackend.service;

import com.yafeng.paperbackend.bean.entity.Paper;
import com.yafeng.paperbackend.bean.vo.paper.PaperRequestVo;
import com.yafeng.paperbackend.exception.PaperException;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 论文审核相关功能接口
 * @date 2019/10/21 15:33
 */
public interface IPaperService {

    Paper buildPaper(PaperRequestVo vo) throws PaperException;
}
