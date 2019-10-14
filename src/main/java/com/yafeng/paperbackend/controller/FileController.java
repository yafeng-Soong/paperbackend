package com.yafeng.paperbackend.controller;

import com.yafeng.paperbackend.base.BaseController;
import com.yafeng.paperbackend.bean.entity.ResponseEntity;
import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.enums.ResponseEnums;
import com.yafeng.paperbackend.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.controller
 * describe: 控制文件的上传
 * @author : songyafeng
 * creat_time: 2019/10/14 0:03
 **/
@RestController
@RequestMapping("/upload")
public class FileController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(FileController.class);
    //限制图片格式
    private List<String> imgTypes = Arrays.asList("image/jpeg","image/gif","image/png","image/bmp");
    //限制文件格式为doc和pdf
    private List<String> fileTypes = Arrays.asList("application/msword", "application/pdf");

    private static final String ROOT_PATH = "/usr/web";
    private static final String HEADER_PATH = ROOT_PATH + "/imgs/header/";
    private static final String DEFAULT_HEADER = ROOT_PATH + "/imgs/header/default.jpg";

    @Autowired
    UserService userService;

    @PostMapping("/header")
    public ResponseEntity uploadHeader(@RequestParam("img") MultipartFile img){
        ResponseEntity response = new ResponseEntity();
        String fileType = img.getContentType();
        //检查是否是图片
        if (!imgTypes.contains(fileType)){
            response.setCode(ResponseEnums.FILE_TYPE_ERROR.getCode());
            response.setMsg(ResponseEnums.FILE_TYPE_ERROR.getMsg());
            return response;
        }
        Subject subject = SecurityUtils.getSubject();
        User currentUser = (User) subject.getSession().getAttribute("currentUser");
        //删除旧头像
        String oldPath = ROOT_PATH + currentUser.getAvatar();
        File oldImg = new File(oldPath);
        if (!oldPath.equals(DEFAULT_HEADER) && oldImg.exists())
            oldImg.delete();
        //重命名图片为邮箱加后缀
        String[] nameArray = img.getOriginalFilename().split("\\.");
        String imgType = nameArray[nameArray.length - 1];
        String newName = currentUser.getEmail() + "." + imgType;
        try {
            img.transferTo(new File(HEADER_PATH + newName));
            //更新用户信息
            currentUser.setAvatar("/imgs/header/" + newName);
            subject.getSession().setAttribute("currentUser", currentUser);
            userService.updateAvatar(currentUser);
        }catch (IOException e){
            e.printStackTrace();
            LOGGER.error("文件上传错误：" + e.getMessage());
            response.setCode(ResponseEnums.FILE_UPLOAD_ERROR.getCode());
            response.setMsg(ResponseEnums.FILE_UPLOAD_ERROR.getMsg());
        }catch (Exception e){
            e.printStackTrace();
            response.setCode(ResponseEnums.INNER_ERROR.getCode());
            response.setMsg(ResponseEnums.INNER_ERROR.getMsg());
        }finally {
            return  response;
        }
    }

}
