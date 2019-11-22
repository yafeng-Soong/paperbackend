package com.yafeng.paperbackend.service.Impl;

import com.yafeng.paperbackend.bean.entity.Operation;
import com.yafeng.paperbackend.bean.entity.Paper;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.exception.PaperException;
import com.yafeng.paperbackend.mapper.OperationMapper;
import com.yafeng.paperbackend.mapper.PaperMapper;
import com.yafeng.paperbackend.service.IPaperRecordService;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 记录操作查询功能实现
 * @date 2019/10/24 9:59
 */
@Service
@Slf4j
public class PaperRecordServiceImpl implements IPaperRecordService {

    @Autowired
    private OperationMapper operationMapper;

    @Autowired
    private PaperMapper paperMapper;

    /**
     * findAllByPaperId
     * @description 查询此篇论文的所有操作记录
     * 管理员可以查询所有论文
     * 普通用户只能查询自己的论文记录
     * @param paperId 论文ID
     * @return {@link Operation}s
     * @author liugaoyang
     * @date 2019/10/24 10:03
     * @version 1.0.0
     */
    @Override
    public List<Operation> findAllByPaperId(Integer paperId) throws PaperException {
        // 获取查询用户的权限信息
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        boolean searchAllPermission = false;

        if (currentUser.getRole().equals("admin")){
            searchAllPermission = true;
        }
        if (!searchAllPermission){
            // 先查出来数据 解决pageHelper只对第一条sql分页的问题
            List<Operation> result =  operationMapper.selectByPaperId(paperId);
            // 普通用户只能查询自己论文的提交记录
            // 如果为空则说明有其他用户通过伪造请求的方式查询论文提交记录 直接抛出异常
            Paper paper = paperMapper.selectAllByPublisherEmail(currentUser.getEmail()).stream()
                    .filter(e -> e.getId().equals(paperId))
                    .findAny()
                    .orElseThrow(() -> new PaperException("权限不足"));
            if (paper != null){
                // 查询论文操作记录
                return result;
            }
        }
        // 管理员用户查找所有的论文提交记录
        return operationMapper.selectByPaperId(paperId);
    }
}
