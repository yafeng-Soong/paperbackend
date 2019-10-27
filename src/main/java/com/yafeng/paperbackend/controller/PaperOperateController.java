package com.yafeng.paperbackend.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yafeng.paperbackend.bean.entity.Operation;
import com.yafeng.paperbackend.bean.entity.Paper;
import com.yafeng.paperbackend.bean.entity.ResponseEntity;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.bean.vo.PageQueryVo;
import com.yafeng.paperbackend.bean.vo.PageResponseVo;
import com.yafeng.paperbackend.bean.vo.PaperRbmqMessage;
import com.yafeng.paperbackend.bean.vo.operation.OperationQueryVo;
import com.yafeng.paperbackend.bean.vo.paper.PaperQueryVo;
import com.yafeng.paperbackend.bean.vo.paper.PaperRequestVo;
import com.yafeng.paperbackend.bean.vo.paper.PaperUpdateRequestVo;
import com.yafeng.paperbackend.enums.OperateType;
import com.yafeng.paperbackend.exception.PaperException;
import com.yafeng.paperbackend.rabbitmq.PaperMQSender;
import com.yafeng.paperbackend.service.IFileService;
import com.yafeng.paperbackend.service.IPaperRecordService;
import com.yafeng.paperbackend.service.IPaperService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
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
    private IFileService fileService;

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
    public ResponseEntity reSubmit(@RequestBody PaperUpdateRequestVo vo){
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

    /**
     * fileUpload
     * @description 文件上传接口
     * @param file 客户端提交来的文件
     * @return {@link ResponseEntity}
     * @author liugaoyang
     * @date 2019/10/26 13:02
     * @version 1.0.0
     */
    @ApiOperation("文件上传（返回文件的绝对路径）")
    @PostMapping("/fileUpload")
    public ResponseEntity fileUpload(@RequestParam(value = "file") MultipartFile file){
        ResponseEntity responseEntity = new ResponseEntity();
        String path = null;
        try {
            path = fileService.uploadFile(file);
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
     * downloadFile
     * @description 文件下载接口
     * @param paperId 论文主键 根据主键查找文件的存储位置
     * @param response http response 利用http协议来传输文件
     * @return {@link Void}
     * @author liugaoyang
     * @date 2019/10/26 13:00
     * @version 1.0.0
     */
    @ApiOperation("文件下载")
    @GetMapping(value = "/download")
    public void downloadFile(@RequestParam("paperId") Integer paperId, HttpServletResponse response){
        fileService.downloadFile(paperId, response);
        return;
    }


    /**
     * findAllPapers
     * @description 用户的论文列表 （点击详情可以查看该论文的提交记录）
     * 显示的是论文的最新状态 包含论文基本信息（论文名称、关键字、摘要、文件可供下载、审核状态、支付状态）
     * @return {@link com.yafeng.paperbackend.bean.entity.Paper}
     * @author liugaoyang
     * @date 2019/10/23 19:06
     * @version 1.0.0
     */
    @ApiOperation("论文列表信息")
    @PostMapping(value = "/all")
    public ResponseEntity findAllPapers(@RequestBody PageQueryVo pageQueryVo){
        ResponseEntity responseEntity = new ResponseEntity();
        Page<Paper> page = PageHelper.startPage(pageQueryVo.getPageNum(), pageQueryVo.getPageSize());
        // 根据用户email去查询该用户所有的论文
        List<Paper> paperList = paperService.getAllPapers();
        responseEntity.setData(new PageResponseVo<>(paperList, page));
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
    @PostMapping(value = "/all/status")
    public ResponseEntity findAllPapersByStatus(@RequestBody PaperQueryVo vo){

        ResponseEntity responseEntity = new ResponseEntity();
        Page<Paper> page = PageHelper.startPage(vo.getPageNum(), vo.getPageSize());
        List<Paper> paperList = paperService.getAllPapersByPayAndCheck(vo.getPayStatus(), vo.getCheckStatus());
        responseEntity.setData(new PageResponseVo<>(paperList, page));
        return responseEntity;
    }


    /**
     * getOperationDetail
     * @description  查询某篇论文的提交修改记录 (包括审核者的退回操作)
     * @param vo 论文唯一主键
     * @return {@link Operation}s
     * @author liugaoyang
     * @date 2019/10/23 20:00
     * @version 1.0.0
     * TODO 改为分页参数之后 后端未做参数的校验 需要前端进行校验
     */
    @ApiOperation("论文操作记录查询")
    @PostMapping(value = "/operation/detail")
    public ResponseEntity getOperationDetail(@RequestBody OperationQueryVo vo){
        ResponseEntity responseEntity = new ResponseEntity();
        List<Operation> result = null;
        try {
            Page<Operation> page = PageHelper.startPage(vo.getPageNum(), vo.getPageSize());
            result = paperRecordService.findAllByPaperId(vo.getPaperId());
            responseEntity.setData(new PageResponseVo<>(result, page));
        } catch (PaperException e) {
            log.error("ERROR OCCUR: {}", e.getMessage());
            responseEntity.setErrorResponse();
            responseEntity.setData(e.getMessage());
            return responseEntity;
        }
        return responseEntity;
    }

}
