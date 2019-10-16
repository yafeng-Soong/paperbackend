package com.yafeng.paperbackend.controller;

import com.yafeng.paperbackend.base.BaseController;
import com.yafeng.paperbackend.bean.entity.ResponseEntity;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.bean.vo.RegisterAndLoginVo;
import com.yafeng.paperbackend.bean.vo.user.UserUpdateVo;
import com.yafeng.paperbackend.config.Redis.UserKeyProfix;
import com.yafeng.paperbackend.enums.ResponseEnums;
import com.yafeng.paperbackend.service.EmailService;
import com.yafeng.paperbackend.service.RedisService;
import com.yafeng.paperbackend.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.mail.SendFailedException;
import javax.validation.Valid;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.controller
 * describe: 用户控制类
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
    public ResponseEntity signUp(@RequestBody @Valid RegisterAndLoginVo registerVo, BindingResult bindingResult){
        ResponseEntity response = new ResponseEntity();
        if (validateParams(response, bindingResult))
            return response;
        try{
            User user = new User();
            user.setEmail(registerVo.getEmail());
            user.setPassword(registerVo.getPassword());
            userService.insert(user);
            String subject = "尊敬的" + user.getUsername() + "!请激活您的账号";
            emailService.sendTemplateMail(user.getEmail(), "activateAccount", subject);
            response.setData("注册成功，快去邮箱激活吧！");
        }catch (DuplicateKeyException e){
            response.setErrorResponse();
            response.setData("注册失败," + registerVo.getEmail() + "邮箱已被注册");
            LOGGER.error("邮箱被注册：" + e.getMessage());
        }catch (SendFailedException e){
            response.setErrorResponse();
            response.setData("注册失败,无效邮箱");
        }catch (Exception e){
            e.printStackTrace();
            response.setCode(ResponseEnums.INNER_ERROR.getCode());
            response.setMsg(ResponseEnums.INNER_ERROR.getMsg());
        }finally {
            return response;
        }
    }

    @ApiOperation("更新用户信息")
    @PostMapping("/updateUser")
    public  ResponseEntity updateUser(@RequestBody UserUpdateVo updateVo){
        ResponseEntity response = new ResponseEntity();
        User user = new User();
        user.setUsername(updateVo.getUsername());
        user.setSignature(updateVo.getSignature());
        user.setSex(updateVo.getSex());
        Subject subject = SecurityUtils.getSubject();
        User currentUser = (User) subject.getSession().getAttribute("currentUser");
        user.setEmail(currentUser.getEmail());
        if (userService.update(user) == 0){
            response.setErrorResponse();
            response.setData("更新失败");
        }
        return response;
    }

    @ApiOperation("激活账号接口，从邮箱转进来的")
    @GetMapping("/activate")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "email", value = "待激活的邮箱号", required = true),
            @ApiImplicitParam(name = "token", value = "redis中保存的token，用于验证", required = true)
    })
    public ResponseEntity activate(@RequestParam("email") String email, @RequestParam("token") String token){
        ResponseEntity response = new ResponseEntity();
        String storedEmail = redisService.get(UserKeyProfix.TOKEN, token, String.class);
        if (storedEmail == null || !storedEmail.equals(email)){
            response.setErrorResponse();
            response.setData("激活链接已过期");
        }else if (userService.activateUser(email) == 0){
            response.setErrorResponse();
            response.setData("激活失败");
        }else{
            //激活后删掉redis中的链接
            redisService.delete(UserKeyProfix.TOKEN, token);
            response.setData("激活成功");
        }
        return response;
    }

    @ApiOperation("发送重置密码邮件")
    @GetMapping("/resetPassword")
    @ApiImplicitParam(name = "email", value = "要重置密码的邮箱号", required = true)
    public ResponseEntity sendResetEmail(@RequestParam("email") String email){
        ResponseEntity response = new ResponseEntity();
        User user = userService.selectByEmail(email);
        if (user == null){
            response.setErrorResponse();
            response.setData("不存在该邮箱：" + email);
        }else if (user.getState() == 0) {
            response.setErrorResponse();
            response.setData(email + "暂未激活");
        }else{
            try {
                emailService.sendTemplateMail(email, "resetEmail", "重置密码");
                response.setData("请及时前往邮箱重置密码");
            }catch (SendFailedException e){
                response.setErrorResponse();
                response.setData("发送邮件失败");
            }
        }
        return response;
    }


    @ApiOperation("返回重置密码页面")
    @GetMapping("/resetPage")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "email", value = "待激活的邮箱号", required = true),
            @ApiImplicitParam(name = "token", value = "redis中保存的token，用于验证", required = true)
    })
    public ModelAndView resetPage(@RequestParam("email") String email, @RequestParam("token") String token){
        ModelAndView view = new ModelAndView();
        view.setViewName("resetPassword");
        view.addObject("email", email);
        view.addObject("token", token);
        return view;
    }

    @ApiOperation("重置密码接口")
    @PostMapping("/resetPassword")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "email", value = "邮箱", required = true),
            @ApiImplicitParam(name = "password", value = "重置后的密码", required = true),
            @ApiImplicitParam(name = "token", value = "redis中保存的token", required = true)
    })
    public ResponseEntity resetPassword(@RequestParam("email") String email,
                                        @RequestParam("password") String password,
                                        @RequestParam("token") String token){
        ResponseEntity response = new ResponseEntity();
        String storedEmail = redisService.get(UserKeyProfix.TOKEN, token, String.class);
        if (storedEmail == null || !storedEmail.equals(email)){
            response.setErrorResponse();
            response.setData("重置密码链接已过期");
        }else {
            int flag = userService.resetPassword(email, password);
            if (flag == -1){
                response.setErrorResponse();
                response.setData("新密码格式错误");
            }else if (flag == 0){
                response.setErrorResponse();
                response.setData("重置密码失败");
            }else {
                redisService.delete(UserKeyProfix.TOKEN, token);
                response.setData("重置密码成功");
            }
        }
        return response;
    }
}
