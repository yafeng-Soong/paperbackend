package com.yafeng.paperbackend.controller;

import com.yafeng.paperbackend.bean.entity.ResponseEntity;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.bean.vo.PaperRbmqMessage;
import com.yafeng.paperbackend.bean.vo.paper.AdminCheckVo;
import com.yafeng.paperbackend.enums.OperateType;
import com.yafeng.paperbackend.exception.PaperException;
import com.yafeng.paperbackend.rabbitmq.PaperMQSender;
import com.yafeng.paperbackend.service.IPaperService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
     * @param checkStatus
     * @return {@link ResponseEntity}
     * @author liugaoyang
     * @date 2019/10/25 18:56
     * @version 1.0.0
     */
    @ApiOperation("管理员用户查询论文列表")
    @GetMapping(value = "/list")
    public ResponseEntity getAllPapersByCheckStatus(@RequestParam(value = "checkStatus") Integer checkStatus){
        ResponseEntity responseEntity = new ResponseEntity();
        try {
            // 校验权限身份
            validate();
            responseEntity.setData(paperService.getAllPapersByCheckStatus(checkStatus));
        } catch (PaperException e) {
            log.error("ERROR OCCUR: {}", e.getMessage());
            responseEntity.setErrorResponse();
            responseEntity.setData(e.getMessage());
            return responseEntity;
        }
        return responseEntity;
    }

    @ApiOperation("管理员审核")
    @PostMapping(value = "/check")
    public ResponseEntity check(@RequestBody AdminCheckVo adminCheckVo){
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
