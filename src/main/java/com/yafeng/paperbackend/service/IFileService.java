package com.yafeng.paperbackend.service;

import com.yafeng.paperbackend.exception.PaperException;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 文件功能服务
 * @date 2019/10/25 21:11
 */
public interface IFileService {

    String uploadFile(MultipartFile file) throws PaperException;

    void downloadFile(Integer paperId, HttpServletResponse response);
}
