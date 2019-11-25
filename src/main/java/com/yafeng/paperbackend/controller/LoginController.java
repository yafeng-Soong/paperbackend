package com.yafeng.paperbackend.controller;

import com.yafeng.paperbackend.base.BaseController;
import com.yafeng.paperbackend.bean.entity.ResponseEntity;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.bean.vo.RegisterAndLoginVo;
import com.yafeng.paperbackend.bean.vo.user.UserResponseVo;
import com.yafeng.paperbackend.enums.ResponseEnums;
import com.yafeng.paperbackend.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import springfox.documentation.annotations.ApiIgnore;

import javax.validation.Valid;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.controller
 * describe: 由开发人员自主完善
 *
 * @author : songyafeng
 * creat_time: 2019/10/7 0:17
 **/
@Api(tags = "登录相关功能的接口")
@RestController
public class LoginController extends BaseController {

    private final static Logger LOGGER = LoggerFactory.getLogger(LoginController.class);
    @Autowired
    UserService userService;

    @PostMapping("/login")
    @ApiOperation("用户登录")
    public ResponseEntity login(@RequestBody @Valid RegisterAndLoginVo user, BindingResult bindingResult){
        ResponseEntity response = new ResponseEntity();
        if (validateParams(response, bindingResult)) {
            return response;
        }
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(user.getEmail(), user.getPassword());
        try {
            subject.login(token);
            User currentUser = userService.selectByEmail(user.getEmail());
            subject.getSession().setAttribute("currentUser", currentUser);
            //设置session过期时间为3天
            subject.getSession().setTimeout(259200000);
            UserResponseVo responseVo = new UserResponseVo();
            BeanUtils.copyProperties(currentUser, responseVo);
            response.setData(responseVo);
            //subject.getSession().setTimeout(10000);
            //if (subject.isAuthenticated())
                //return response;
        } catch (UnknownAccountException e) {
            LOGGER.warn("不存在该用户：" + user.getEmail());
            response.setCode(ResponseEnums.LOGIN_UNKNOWN.getCode());
            response.setMsg(ResponseEnums.LOGIN_UNKNOWN.getMsg());
        } catch (DisabledAccountException e) {
            LOGGER.warn(user.getEmail() + "暂未激活");
            response.setCode(ResponseEnums.LOGIN_DISABLE.getCode());
            response.setMsg(ResponseEnums.LOGIN_DISABLE.getMsg());
        }catch (IncorrectCredentialsException e) {
            LOGGER.warn(user.getEmail() + "密码错误");
            response.setCode(ResponseEnums.LOGIN_ERROR.getCode());
            response.setMsg(ResponseEnums.LOGIN_ERROR.getMsg());
        } catch (Exception e) {
            LOGGER.error("登录时发生未知错误~");
            response.setCode(ResponseEnums.INNER_ERROR.getCode());
            response.setMsg(ResponseEnums.INNER_ERROR.getMsg());
        } finally {
            return response;
        }
    }

    @ApiOperation("返回当前用户信息")
    @GetMapping("/getCurrentUser")
    public ResponseEntity currentUser(){
        ResponseEntity response = new ResponseEntity();
        User currentUser = getCurrentUser();
        UserResponseVo responseVo = new UserResponseVo();
        BeanUtils.copyProperties(currentUser, responseVo);
        response.setData(responseVo);
        return response;
    }

    @ApiIgnore
    @GetMapping("/sayHello")
    public String sayHello(){
        //只是一个测试接口
        String username = (String) SecurityUtils.getSubject().getPrincipal();
        return "(✿✪‿✪｡)ﾉｺﾝﾁｬ♡，" + username + "当你看到这条消息表示你已经登陆了哦!";
    }

    /**
     * 退出登录，实质上是去掉session
     * @return
     */
    @ApiOperation("退出登录接口")
    @GetMapping("/logout")
    public String logout(){
        Subject subject = SecurityUtils.getSubject();
        subject.getSession().removeAttribute("currentUser");
        subject.logout();
        return "您已经退出登录！";
    }
}
