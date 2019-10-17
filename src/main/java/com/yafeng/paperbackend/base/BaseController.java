package com.yafeng.paperbackend.base;

import com.yafeng.paperbackend.bean.entity.ResponseEntity;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.enums.ResponseEnums;
import org.apache.shiro.SecurityUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;

import java.util.ArrayList;
import java.util.List;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.base
 * describe: 将参数校验方法提到controller的父级
 * @author : songyafeng
 * creat_time: 2019/10/14 16:30
 **/
public abstract class BaseController {
    /**
     * 校验参数
     * @param response 返回实体类
     * @param bindingResult
     * @return
     */
    public boolean validateParams(ResponseEntity response, BindingResult bindingResult){
        if (bindingResult.hasErrors()){
            response.setCode(ResponseEnums.VALID_ERROR.getCode());
            response.setMsg(ResponseEnums.VALID_ERROR.getMsg());
            List<String> data = new ArrayList<>();
            for (ObjectError error : bindingResult.getAllErrors()){
                data.add(((FieldError)error).getField() + "字段，" + error.getDefaultMessage());
            }
            response.setData(data);
            return true;
        }
        return false;
    }

    /**
     * 返回当前登录用户信息
     * @return
     */
    protected User getCurrentUser(){
        return (User) SecurityUtils.getSubject().getSession().getAttribute("currentUser");
    }
}
