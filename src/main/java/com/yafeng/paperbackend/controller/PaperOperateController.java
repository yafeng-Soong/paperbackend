package com.yafeng.paperbackend.controller;

import com.yafeng.paperbackend.bean.entity.Operation;
import com.yafeng.paperbackend.bean.entity.ResponseEntity;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.bean.vo.PaperRbmqMessage;
import com.yafeng.paperbackend.bean.vo.paper.PaperRequestVo;
import com.yafeng.paperbackend.bean.vo.paper.PaperUpdateVo;
import com.yafeng.paperbackend.constant.Constant;
import com.yafeng.paperbackend.enums.OperateType;
import com.yafeng.paperbackend.exception.PaperException;
import com.yafeng.paperbackend.rabbitmq.PaperMQSender;
import com.yafeng.paperbackend.service.IPaperRecordService;
import com.yafeng.paperbackend.service.IPaperService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 论文相关操作
 * @date 2019/10/23 15:48
 */
@Api(tags = "论文操作相关接口")
@RestController
@Slf4j
@RequestMapping(value = "/paper")
public class PaperOperateController {

    @Autowired
    private IPaperRecordService paperRecordService;

    @Autowired
    private IPaperService paperService;

    @Autowired
    private PaperMQSender mqsender;

    /**
     * submit
     * @description 用户提交论文
     * @param vo 用户提交的论文审核的请求
     * @return {@link ResponseEntity}
     * @author liugaoyang
     * @date 2019/10/23 15:52
     * @version 1.0.0
     */
    @ApiOperation("论文提交接口")
    @PostMapping(value = "/submit")
    public ResponseEntity submit(@RequestBody PaperRequestVo vo){
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        ResponseEntity responseEntity = new ResponseEntity();
        try {
            paperService.buildPaper(vo);
            responseEntity.setData("提交成功，专家将在48小时内审核您的论文！");
        } catch (PaperException e) {
            log.error("ERROR OCCUR: {}", e.getMessage());
            responseEntity.setErrorResponse();
            responseEntity.setData(e.getMessage());
            return responseEntity;
        }
//         生成操作记录（论文提交记录） 写入到操作数据库中  可以使用消息队列异步来写
        mqsender.sendPaperOperateMSG(
                PaperRbmqMessage.builder()
                        // 反查数据库生成的论文
                        .paperId(paperService.findByEmailAndName(currentUser.getEmail(), vo.getName()).getId())
                        .note(vo.getNote())
                        .operateId(currentUser.getId())
                        .operateType(OperateType.SUBMIT.getCode())
                .build()
        );
        // TODO 在用户付费之后 可以调用消息队列异步生成消息记录 通知相关人员去审核论文
        return responseEntity;
    }

    /**
     * reSubmit
     * @description 论文修改  注意只能修改状态为待审核的待修改的论文
     * @param vo 用户提交的修改论文审核的请求
     * @return {@link ResponseEntity}
     * @author liugaoyang
     * @date 2019/10/23 17:16
     * @version 1.0.0
     * todo 增加逻辑处理
     */
    @ApiOperation("修改后论文修改接口")
    @PutMapping(value = "/reSubmit")
    public ResponseEntity reSubmit(@RequestBody PaperUpdateVo vo){
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        ResponseEntity responseEntity = new ResponseEntity();
        try {
            paperService.modifyPaper(vo);
            responseEntity.setData("修改成功！");
        } catch (PaperException e) {
            log.error("ERROR OCCUR: {}", e.getMessage());
            responseEntity.setErrorResponse();
            responseEntity.setData(e.getMessage());
            return responseEntity;
        }
        // 生成操作记录（论文修改记录） 写入到操作数据库中  可以使用消息队列异步来写
        mqsender.sendPaperOperateMSG(
                PaperRbmqMessage.builder()
                        .paperId(vo.getId())
                        .note(vo.getNote())
                        .operateId(currentUser.getId())
                        .operateType(OperateType.MODIFY.getCode())
                        .build()
        );
        // TODO 检查论文状态 可以调用消息队列异步生成消息记录 通知相关人员更新了提交
        return responseEntity;
    }

    @ApiOperation("文件上传（返回文件的绝对路径）")
    @PostMapping("/fileUpload")
    public ResponseEntity fileUpload(@RequestParam(value = "file") MultipartFile file){
        ResponseEntity responseEntity = new ResponseEntity();
        String path = null;
        try {
            path = uploadFile(file);
            responseEntity.setData(path);
        } catch (PaperException e) {
            log.error("ERROR OCCUR: {}", e.getMessage());
            responseEntity.setErrorResponse();
            responseEntity.setData(e.getMessage());
            return responseEntity;
        }
        return responseEntity;
    }


    /**
     * findAllPapers
     * @description 用户的论文列表 （点击详情可以查看该论文的提交记录）
     * 显示的是论文的最新状态 包含论文基本信息（论文名称、关键字、摘要、文件可供下载、审核状态、支付状态）
     * @return {@link com.yafeng.paperbackend.bean.entity.Paper}
     * @author liugaoyang
     * @date 2019/10/23 19:06
     * @version 1.0.0
     * todo 增加分页参数
     */
    @ApiOperation("论文列表信息")
    @GetMapping(value = "/all")
    public ResponseEntity findAllPapers(){
        ResponseEntity responseEntity = new ResponseEntity();
        responseEntity.setData(paperService.getAllPapers());
        return responseEntity;
    }

    /**
     * findAllPapersByStatus
     * @description 根据论文的状态组合查找论文列表
     * @return {@link com.yafeng.paperbackend.bean.entity.Paper}
     * @author liugaoyang
     * @date 2019/10/23 19:24
     * @version 1.0.0
     */
    @ApiOperation("查询论文列表信息根据状态")
    @GetMapping(value = "/all/status")
    public ResponseEntity findAllPapersByStatus(@RequestParam(value = "pay", defaultValue = "1") Integer payStatus,
                                                @RequestParam(value = "check", defaultValue = "0") Integer checkStatus){
        ResponseEntity responseEntity = new ResponseEntity();
        responseEntity.setData(paperService.getAllPapersByPayAndCheck(payStatus, checkStatus));
        return responseEntity;
    }


    /**
     * getOperationDetail
     * @description  查询某篇论文的提交修改记录 (包括审核者的退回操作)
     * @param paperId 论文唯一主键
     * @return {@link Operation}s
     * @author liugaoyang
     * @date 2019/10/23 20:00
     * @version 1.0.0
     */
    @ApiOperation("论文操作记录查询")
    @GetMapping("/operation/detail")
    public ResponseEntity getOperationDetail(@RequestParam(value = "paperId", required = true) Integer paperId){

        ResponseEntity responseEntity = new ResponseEntity();
        List<Operation> result = null;
        try {
            result = paperRecordService.findAllByPaperId(paperId);
            responseEntity.setData(result);
        } catch (PaperException e) {
            log.error("ERROR OCCUR: {}", e.getMessage());
            responseEntity.setErrorResponse();
            responseEntity.setData(e.getMessage());
            return responseEntity;
        }
        return responseEntity;
    }


    /**
     * uploadFile
     * @description 文件上传功能
     * @param file 前端传来的文件流
     * @return {@link String} 文件的存储路径
     * @author liugaoyang
     * @date 2019/10/25 10:50
     * @version 1.0.0
     */
    private String uploadFile(MultipartFile file) throws PaperException {
        if (file == null || file.isEmpty()){
            throw new PaperException("文件上传出错，请检查上传的文件！");
        }
        // 判断当前项目路径下是否包含上传文件的路径 不包含则创建
        File fileDir = new File(Constant.UPLOAD_PATH);
        File newFile = null;
        if (!fileDir.isDirectory()){
            fileDir.mkdirs();
        }
        try {
            String[] array = file.getOriginalFilename().split("\\.");
            String prefixName = array[0];
            String suffix = array[1];
            // 上传到服务器上文件的名称 为/当前项目路径/upoladFile/原文件名+当前时间+文件后缀
            newFile = new File(Constant.UPLOAD_PATH + prefixName + System.currentTimeMillis() + "." + suffix);
            file.transferTo(newFile);
        } catch (IOException e) {
            log.error("文件上传异常");
            e.printStackTrace();
            throw new PaperException(e.getMessage());
        }
        // 返回文件存储的绝对路径
        return newFile.getAbsolutePath();
    }

}
