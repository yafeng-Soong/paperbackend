package com.yafeng.paperbackend.controller;

import com.yafeng.paperbackend.base.BaseController;
import com.yafeng.paperbackend.bean.entity.ResponseEntity;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.enums.ResponseEnums;
import com.yafeng.paperbackend.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

    @ApiOperation("用户注册接口")
    @PostMapping("/signUp")
    public ResponseEntity signUp(@RequestBody User user){
        ResponseEntity response = new ResponseEntity();
        try{
            userService.insert(user);
            response.setData("注册成功，快去邮箱激活吧！");
        }catch (Exception e){
            response.setCode(ResponseEnums.ERROR.getCode());
            response.setMsg(ResponseEnums.ERROR.getMsg());
            response.setData("注册失败");
            LOGGER.error("注册失败：" + e.getMessage());
        }finally {
            return response;
        }
    }
}
