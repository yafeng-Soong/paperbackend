package com.yafeng.paperbackend.service.Impl;

import com.yafeng.paperbackend.bean.entity.Paper;
import com.yafeng.paperbackend.constant.Constant;
import com.yafeng.paperbackend.exception.PaperException;
import com.yafeng.paperbackend.mapper.PaperMapper;
import com.yafeng.paperbackend.service.IFileService;
import com.yafeng.paperbackend.utils.FileUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 文件服务实现类
 * @date 2019/10/25 21:11
 */
@Service
@Slf4j
public class FileServiceImpl implements IFileService {

    @Autowired
    private PaperMapper paperMapper;

    @Override
    /**
     * uploadFile
     * @description 文件上传功能
     * @param file 前端传来的文件流
     * @return {@link String} 文件的存储路径
     * @author liugaoyang
     * @date 2019/10/25 10:50
     * @version 1.0.0
     */
    public String uploadFile(MultipartFile file) throws PaperException {
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

    /**
     * downloadFile
     * @description 基于断点续传下载文件
     * @param paperId 论文主键
     * @param response 相应流
     * @return {@link }
     * @author liugaoyang
     * @date 2019/10/25 21:31
     * @version 1.0.0
     */
    @Override
    public void downloadFile(Integer paperId, HttpServletResponse response) {
        Paper paper = paperMapper.selectByPrimaryKey(paperId);
        File file = new File(paper.getFilePath());
        String[] array = file.getName().split("\\.");
        String suffix = array[1];
        FileUtils.breakpointResume(file, file.getName(), FileUtils.getContentTypeByExtensionName(suffix), null, response);
    }


}
