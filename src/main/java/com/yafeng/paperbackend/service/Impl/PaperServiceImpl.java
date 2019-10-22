package com.yafeng.paperbackend.service.Impl;

import com.yafeng.paperbackend.bean.entity.Paper;
import com.yafeng.paperbackend.bean.vo.paper.PaperRequestVo;
import com.yafeng.paperbackend.enums.CheckStatus;
import com.yafeng.paperbackend.enums.PayStatus;
import com.yafeng.paperbackend.exception.PaperException;
import com.yafeng.paperbackend.mapper.PaperMapper;
import com.yafeng.paperbackend.service.IPaperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 论文审核功能服务实现
 * @date 2019/10/21 15:34
 */
@Service
public class PaperServiceImpl implements IPaperService {

    @Autowired
    private PaperMapper paperMapper;

    /**
     * buildPaper
     * @description 用户提交论文审核
     * @param vo {@link PaperRequestVo}
     * @return {@link Paper}
     * @author liugaoyang
     * @date 2019/10/21 16:14
     * @version 1.0.0
     */
    @Override
    public Paper buildPaper(PaperRequestVo vo) throws PaperException {

        if (!vo.validate()){
            throw new PaperException("PaperRequestVo param error");
        }
        Paper p = requestToPaper(vo);
        paperMapper.insert(p);
        return p;
    }

    private Paper requestToPaper(PaperRequestVo vo){
        return new Paper(vo.getName(),
                vo.getPublisherEmail(),
                vo.getKeyword(),
                vo.getSummary(),
                vo.getFilePath(),
                PayStatus.UNPAID,
                CheckStatus.PENDINGREVIEW,
                new Date());
    }
}
