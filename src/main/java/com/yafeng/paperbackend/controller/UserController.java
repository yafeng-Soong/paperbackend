package com.yafeng.paperbackend.controller;

import com.yafeng.paperbackend.base.BaseController;
import com.yafeng.paperbackend.bean.entity.ResponseEntity;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.config.Redis.UserKeyProfix;
import com.yafeng.paperbackend.enums.ResponseEnums;
import com.yafeng.paperbackend.service.EmailService;
import com.yafeng.paperbackend.service.RedisService;
import com.yafeng.paperbackend.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.mail.SendFailedException;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.controller
 * describe: 由开发人员自主完善
 *
 * @author : songyafeng
 * creat_time: 2019/10/7 17:16
 **/
@Api(tags = "用户管理相关接口")
@RestController
@RequestMapping("/user")
public class UserController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);

    @Autowired
    UserService userService;
    @Autowired
    EmailService emailService;
    @Autowired
    RedisService redisService;

    @ApiOperation("用户注册接口")
    @PostMapping("/signUp")
    @Transactional(rollbackFor = Exception.class)//事物回滚
    public ResponseEntity signUp(@RequestBody User user){
        ResponseEntity response = new ResponseEntity();
        try{
            userService.insert(user);
            String subject = "尊敬的" + user.getUsername() + "!请激活您的账号";
            emailService.sendTemplateMail(user.getEmail(), "activateAccount", subject);
            response.setData("注册成功，快去邮箱激活吧！");
        }catch (DuplicateKeyException e){
            response.setCode(ResponseEnums.ERROR.getCode());
            response.setMsg(ResponseEnums.ERROR.getMsg());
            response.setData("注册失败," + user.getEmail() + "邮箱已被注册");
            LOGGER.error("邮箱被注册：" + e.getMessage());
        }catch (SendFailedException e){
            response.setCode(ResponseEnums.ERROR.getCode());
            response.setMsg(ResponseEnums.ERROR.getMsg());
            response.setData("注册失败,无效邮箱");
        }catch (Exception e){
            response.setCode(ResponseEnums.INNER_ERROR.getCode());
            response.setMsg(ResponseEnums.INNER_ERROR.getMsg());
        }finally {
            return response;
        }
    }

    @GetMapping("/activate")
    public ResponseEntity activate(@RequestParam("email") String email, @RequestParam("token") String token){
        ResponseEntity response = new ResponseEntity();
        String storedEmail = redisService.get(UserKeyProfix.TOKEN, token, String.class);
        if (storedEmail == null || !storedEmail.equals(email)){
            response.setCode(ResponseEnums.ERROR.getCode());
            response.setMsg(ResponseEnums.ERROR.getMsg());
            response.setData("激活链接已过期");
        }else if (userService.activateUser(email) == 0){
            response.setCode(ResponseEnums.ERROR.getCode());
            response.setMsg(ResponseEnums.ERROR.getMsg());
            response.setData("激活失败");
        }else{
            redisService.delete(UserKeyProfix.TOKEN, token);
            response.setData("激活成功");
        }
        return response;
    }
}
