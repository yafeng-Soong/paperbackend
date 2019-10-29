package com.yafeng.paperbackend.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yafeng.paperbackend.bean.entity.Paper;
import com.yafeng.paperbackend.bean.entity.ResponseEntity;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.bean.vo.PageResponseVo;
import com.yafeng.paperbackend.bean.vo.PaperRbmqMessage;
import com.yafeng.paperbackend.bean.vo.admin.AdminCheckRequestVo;
import com.yafeng.paperbackend.bean.vo.admin.AdminQueryVo;
import com.yafeng.paperbackend.exception.PaperException;
import com.yafeng.paperbackend.rabbitmq.PaperMQSender;
import com.yafeng.paperbackend.service.IPaperService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 管理员相关操作接口
 * @date 2019/10/25 18:52
 */
@Api(tags = "管理员操作相关接口")
@Slf4j
@RestController
@RequestMapping(value = "/admin")
public class AdminController {

    @Autowired
    private IPaperService paperService;

    @Autowired
    private PaperMQSender mqsender;

    /**
     *
     * @description  管理员用户查询审核状态为xx的论文列表
     * @param vo 带有分页参数的查询请求
     * @return {@link ResponseEntity} 经过分页的论文数据
     * @author liugaoyang
     * @date 2019/10/25 18:56
     * @version 1.0.0
     */
    @ApiOperation("管理员用户查询论文列表")
    @PostMapping(value = "/list")
    public ResponseEntity getAllPapersByCheckStatus(@RequestBody AdminQueryVo vo){
        ResponseEntity responseEntity = new ResponseEntity();
        try {
            // 校验权限身份
            validate();
            Page<Paper> page = PageHelper.startPage(vo.getPageNum(), vo.getPageSize());
            List<Paper> paperList = paperService.getAllPapersByCheckStatus(vo.getCheckStatus());
            responseEntity.setData(new PageResponseVo<>(paperList, page));
        } catch (PaperException e) {
            log.error("ERROR OCCUR: {}", e.getMessage());
            responseEntity.setErrorResponse();
            responseEntity.setData(e.getMessage());
            return responseEntity;
        }
        return responseEntity;
    }

    /**
     * check
     * @description 管理员审核用户提交的待审核状态的论文
     * @param adminCheckVo 请求实体
     * @return {@link ResponseEntity}
     * @author liugaoyang
     * @date 2019/10/28 0:45
     * @version 1.0.0
     */
    @ApiOperation("管理员审核操作")
    @PostMapping(value = "/check")
    public ResponseEntity check(@RequestBody AdminCheckRequestVo adminCheckVo){
        ResponseEntity responseEntity = new ResponseEntity();
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        try {
            // 校验身份
            validate();
            paperService.modifyPaperCheckStatus(adminCheckVo);
            responseEntity.setData("操作成功！");
        } catch (PaperException e) {
            log.error("ERROR OCCUR: {}", e.getMessage());
            responseEntity.setErrorResponse();
            responseEntity.setData(e.getMessage());
            return responseEntity;
        }
        // 通知消息队列执行操作记录
        mqsender.sendPaperOperateMSG(
                PaperRbmqMessage.builder()
                        // 反查数据库生成的论文
                        .paperId(adminCheckVo.getPaperId())
                        .note(adminCheckVo.getNote())
                        .operateId(currentUser.getId())
                        .operateType(adminCheckVo.getType())
                        .build()
        );
        return responseEntity;
    }

    /**
     * validate
     * @description 校验登陆者身份
     * @author liugaoyang
     * @date 2019/10/25 19:00
     * @version 1.0.0
     */
    private void validate() throws PaperException {
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        if (!currentUser.getRole().equals("admin")){
            throw new PaperException("很抱歉，您的权限不足！");
        }
        return;
    }
}
