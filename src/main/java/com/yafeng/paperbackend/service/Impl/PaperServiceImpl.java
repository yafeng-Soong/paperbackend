package com.yafeng.paperbackend.service.Impl;

import com.yafeng.paperbackend.bean.entity.Paper;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.bean.vo.admin.AdminCheckVo;
import com.yafeng.paperbackend.bean.vo.paper.PaperBuildVo;
import com.yafeng.paperbackend.bean.vo.paper.PaperCancelVo;
import com.yafeng.paperbackend.bean.vo.paper.PaperUpdateVo;
import com.yafeng.paperbackend.enums.CheckStatus;
import com.yafeng.paperbackend.enums.OperateType;
import com.yafeng.paperbackend.enums.PayStatus;
import com.yafeng.paperbackend.exception.PaperException;
import com.yafeng.paperbackend.mapper.PaperMapper;
import com.yafeng.paperbackend.service.EmailService;
import com.yafeng.paperbackend.service.IPaperService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 论文审核功能服务实现
 * @date 2019/10/21 15:34
 */
@Slf4j
@Service
public class PaperServiceImpl implements IPaperService {

    @Autowired
    private PaperMapper paperMapper;
    @Autowired
    private EmailService emailService;

    /**
     * buildPaper
     * @description 用户新提交论文审核
     * 1.首先校验请求参数非空，若有空抛出异常
     * 2.然后在数据库中查找是否该用户是否有同名论文 若有抛出异常
     * 3.将新建数据插入数据库
     * @param vo {@link PaperBuildVo}
     * @return {@link Paper}
     * @author liugaoyang
     * @date 2019/10/21 16:14
     * @version 1.0.0
     */
    @Override
    public void buildPaper(PaperBuildVo vo) throws PaperException {
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        if (!vo.validate()){
            throw new PaperException("Please ensure that the paper information is completed!");
        }
        // 用户在新提交一篇论文时要检验  该用户是否之前发表了重名论文 若是抛出异常
        if (paperMapper.selectByPublisherEmailAndName(currentUser.getEmail(), vo.getName()) != null){
            throw new PaperException("You have already submit the same name paper!");
        }
        // 若没有找到重名论文 则向数据库中插入论文
        Paper p = requestToPaper(vo);
        paperMapper.insert(p);
        log.info("用户：{}提交了论文：{}", currentUser.getEmail(), p.getName());
        return;
    }


    /**
     * modifyPaper
     * @description 用户更新论文
     * 1.校验入参
     * 2.检验论文状态是否允许修改
     * 3.若修改了名称，则需检查该用户 修改后的名称是否有重名的 若有抛出异常
     * 4.组装实体类更新paper
     * @param vo 更新vo
     * @return {@link Void}
     * @author liugaoyang
     * @date 2019/10/23 18:24
     * @version 1.0.0
     */
    @Override
    public void updatePaper(PaperUpdateVo vo) throws PaperException {
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        if (!vo.validate()){
            throw new PaperException("Please ensure that the paper information is completed!");
        }
        // 查询数据库中原来的mapper信息 看论文的状态是否允许修改  vo中的主键id来自用户的提交论文列表 所以查找为空的概率几乎为0
        Paper oldPaper = paperMapper.selectByPrimaryKey(vo.getId());
        if (oldPaper == null){
            log.error("数据库异常，无法找到paper id:{}对应的实体类", vo.getId());
            // 可以连接短信SDK通知运维人员
            throw new PaperException("网络连接超时");
        }
        // 判断查询出来的论文是否属于当前用户
        if (!oldPaper.getPublisherEmail().equals(currentUser.getEmail())){
            throw new PaperException("权限不足,无法修改");
        }
        if (CheckStatus.PASSED.getCode() <= CheckStatus.of(oldPaper.getCheckStatus()).getCode()){
            // 已通过状态的论文不允许修改(只有处于0-待审核、1-待修改状态的论文才可更新)
            throw new PaperException("The passed paper doesn't allow to modify");
        }
        // 若修改了论文名称 则需要判定修改后的名称是否重名
        if (StringUtils.isNotEmpty(vo.getName()) && !oldPaper.getName().equals(vo.getName())){
            if (paperMapper.selectByPublisherEmailAndName(currentUser.getEmail(), vo.getName()) != null){
                throw new PaperException("You have already submit the same name paper!");
            }
        }
        // 组装实体类 用户修改了论文之后 论文需变为待审核状态
        Paper paper = new Paper(oldPaper.getId(),
                vo.getName(),
                vo.getAuthor(),
                oldPaper.getPublisherEmail(),
                vo.getKeyword(),
                vo.getSummary(),
                vo.getFilePath(),
                oldPaper.getPayStatus(),
                // 改为待审核状态
                CheckStatus.TO_REVIEW.getCode(),
                oldPaper.getCreateTime(),
                new Date());
        // 有选择的更新操作
        paperMapper.updateByPrimaryKeySelective(paper);
        log.info("用户：{}更新了论文信息：{}", currentUser.getEmail(), paper);
    }

    /**
     * getAllPapers
     * @description 查询用户的论文列表
     * @return {@link Paper}s
     * @author liugaoyang
     * @date 2019/10/23 19:09
     * @version 1.0.0
     */
    @Override
    public List<Paper> getAllPapers() {
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        log.info("用户：{}查询了论文列表", currentUser.getEmail());
        return paperMapper.selectAllByPublisherEmail(currentUser.getEmail());
    }

    /**
     * getAllPapersByCheckStatus
     * @description 根据论文检查状态查找论文
     * @param pay 支付状态
     * @param check 论文检查状态
     * @return {@link Paper}
     * @author liugaoyang
     * @date 2019/10/23 19:31
     * @version 1.0.0
     */
    @Override
    public List<Paper> getAllPapersByPayAndCheck(Integer pay, Integer check) {
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        log.info("{}查询了支付状态为：{} 审核状态为：{} 的论文信息",
                currentUser.getEmail(),
                PayStatus.of(pay).getDescription(),
                CheckStatus.of(check).getDescription());
        return paperMapper.selectAllByPublisherEmailAndStatus(currentUser.getEmail(), pay, check);
    }

    /**
     * getAllPapersByCheckStatus
     * @description 根据审核状态查询论文列表
     * @param check 审核状态
     * @return {@link Paper}
     * @author liugaoyang
     * @date 2019/10/25 19:17
     * @version 1.0.0
     */
    @Override
    public List<Paper> getAllPapersByCheckStatus(Integer check) {
        log.info("管理员用户查询了审核状态为：{}", CheckStatus.of(check).getDescription());
        return paperMapper.selectAllByCheckStatus(check);
    }

    /**
     * findByEmailAndName
     * @description 根据用户邮箱和论文名称查找论文
     * @param email 用户邮箱
     * @param name 论文名称
     * @return {@link Paper}
     * @author liugaoyang
     * @date 2019/10/23 22:08
     * @version 1.0.0
     */
    @Override
    public Paper findByEmailAndName(String email, String name) {
        return paperMapper.selectByPublisherEmailAndName(email, name);
    }

    /**
     * reviewPaper
     * @description 管理员审核论文
     * @return {@link Paper}
     * @author liugaoyang
     * @date 2019/10/25 20:04
     * @version 1.0.0
     */
    @Override
    public void reviewPaper(AdminCheckVo vo) throws PaperException {
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        if (!vo.validate()){
            throw new PaperException("Please ensure that the paper information is completed!");
        }
        // 查询更新之前的状态
        Paper oldPaper = paperMapper.selectByPrimaryKey(vo.getPaperId());
        // 现在此论文是待审核状态
        Integer checkStatus = 0;
        OperateType operateType = OperateType.of(vo.getType());
        if(CheckStatus.of(oldPaper.getCheckStatus()).equals(CheckStatus.TO_REVIEW)) {
            // 只有待审核发表状态才能被操作
            // 退回操作 则论文变回待修改
            if (operateType.equals(OperateType.RETURNED)) {
                checkStatus = CheckStatus.TO_MODIFY.getCode();
            }
            //通过审核 则论文变为通过状态
            else if (operateType.equals(OperateType.PASSED)) {
                checkStatus = CheckStatus.PASSED.getCode();
            } else {
                // 否则抛出异常 因为管理员只会审核待审核的论文 结果只有退户修改或者通过
                throw new PaperException("错误的操作，处于待审核状态的论文只能被退回或通过");
            }
        }else if(CheckStatus.of(oldPaper.getCheckStatus()).equals(CheckStatus.PAYED)){
            // 待发表状态只能进行发表操作
            if (operateType.equals(OperateType.PUBLISH))
                checkStatus = CheckStatus.PUBLISHED.getCode();
            else throw new PaperException("操作错误，处于待发表状态的论文只能进行发表操作！");
        }else{
            log.error("当前论文状态不允许您进行操作:{}", OperateType.of(vo.getType()).getDescription());
            throw new PaperException("当前论文状态不允许您进行操作！");
        }
        log.info("管理员：{} 对论文：{} 执行了：{} 操作 评语为:{}",
                currentUser.getEmail(),
                vo.getPaperId(),
                OperateType.of(vo.getType()).getDescription(), vo.getNote());

        Paper paper = Paper.builder()
                .id(vo.getPaperId())
                .checkStatus(checkStatus)
                .updateTime(new Date())
                .build();
        // 只需更新论文状态和修改时间即可
        paperMapper.updateByPrimaryKeySelective(paper);
        // 发送邮件通知投稿者
        emailService.sendSimpleEmail(oldPaper.getPublisherEmail(), oldPaper.getName(), operateType.getDescription());
    }


    /**
     * cancelPaper
     * @description 用户提交的退回论文操作（不考虑删除文件，应用程序一般不删除数据）
     * @param vo vo对象
     * @return {@link Void}
     * @author liugaoyang
     * @date 2019/11/4 21:11
     * @version 1.0.0
     */
    @Override
    public void cancelPaper(PaperCancelVo vo) throws PaperException {
        if (!vo.validate()){
            throw new PaperException("Please ensure that the paper information is completed!");
        }
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        // 查询更新之前的状态
        Paper oldPaper = paperMapper.selectByPrimaryKey(vo.getPaperId());
        if (oldPaper == null){
            log.error("数据库异常，无法找到paper id:{}对应的实体类", vo.getPaperId());
            // 可以连接短信SDK通知运维人员
            throw new PaperException("网络连接超时");
        }
        // 判断查询出来的论文是否属于当前用户
        if (!oldPaper.getPublisherEmail().equals(currentUser.getEmail())){
            throw new PaperException("权限不足,无法修改");
        }
        // 只有待审核状态才能被操作
        if(!CheckStatus.of(oldPaper.getCheckStatus()).equals(CheckStatus.TO_REVIEW)){
            log.error("当前论文状态不允许进行撤销论文操作");
            throw new PaperException("当前论文状态不允许您进行操作！");
        }
        log.info("用户：{} 对论文：{} 执行了撤回操作,备注为:{}",
                currentUser.getEmail(),
                vo.getPaperId(),
                vo.getNote());
        Paper paper = Paper.builder()
                .id(vo.getPaperId())
                .checkStatus(CheckStatus.CANCELED.getCode())
                .updateTime(new Date())
                .build();
        // 只需更新论文状态和修改时间即可
        paperMapper.updateByPrimaryKeySelective(paper);
    }

    @Override
    public void pay(Integer paperId) throws PaperException{
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        // 查询更新之前的状态
        Paper oldPaper = paperMapper.selectByPrimaryKey(paperId);
        if (oldPaper == null){
            log.error("数据库异常，无法找到paper id:{}对应的实体类", paperId);
            // 可以连接短信SDK通知运维人员
            throw new PaperException("网络连接超时");
        }
        // 判断查询出来的论文是否属于当前用户
        if (!oldPaper.getPublisherEmail().equals(currentUser.getEmail())){
            throw new PaperException("权限不足,无法支付");
        }
        if (oldPaper.getCheckStatus() != CheckStatus.PASSED.getCode()){
            log.error("论文【" + paperId + "】当前状态不允许支付");
            throw new PaperException("当前论文状态不允许支付");
        }
        Paper paper = new Paper();
        paper.setId(paperId);
        paper.setCheckStatus(CheckStatus.PAYED.getCode());
        paperMapper.updateByPrimaryKeySelective(paper);
        log.info("用户：{}支付了论文：{}", currentUser.getEmail(), oldPaper);
        return;
    }


    private Paper requestToPaper(PaperBuildVo vo){
        User currentUser = (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
        return new Paper(vo.getName(),
                vo.getAuthor(),
                currentUser.getEmail(),
                vo.getKeyword(),
                vo.getSummary(),
                vo.getFilePath(),
                PayStatus.UNPAID,
                CheckStatus.TO_REVIEW,
                new Date());
    }
}
