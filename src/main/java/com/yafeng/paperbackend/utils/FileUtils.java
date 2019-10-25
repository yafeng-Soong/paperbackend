package com.yafeng.paperbackend.utils;

import lombok.extern.slf4j.Slf4j;

import java.io.File;

/**
 * FileUtils
 *
 * @author liugaoyang
 * @version 1.0
 * @description
 * @date 2019/6/17 15:31
 **/
@Slf4j
public class FileUtils {
    /**
     * NameUtils
     * @description 构造函数
     * @author liugaoyang
     * @date 2019/5/29 11:18
     * @version 1.0.0
     */
    private FileUtils() {

    }

    /**
     * isFileExists
     * @description 判断临时文件是否存在 若存在则删除
     * @param filePath 文件路径
     * @return void
     * @author liugaoyang
     * @date 2019/5/29 16:35
     * @version 1.0.0
     */
    public static void isFileExists(String filePath){
        File file = new File(filePath);
        if (file.exists()) {
            if (file.delete()) {
                log.info("删除" + filePath + "成功!");
            } else {
                log.info("删除" + filePath + "失败!");
            }
        }
    }

    /**运行
     * getCorrectFilePath
     * @description 在指定路径生成正确文件
     * @param filename 文件名称
     * @return void
     * @author liugaoyang
     * @date 2019/6/13 11:06
     * @version 1.0.0
     */
    public static String getFilePath(String filename){
        String filePath = System.getProperty("user.dir") +
                System.getProperty("file.separator") + filename;
        log.info("生成的临时文件路径:" + filePath);
        return filePath;
    }
}
