package com.yafeng.paperbackend.constant;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 常量
 * @date 2019/10/23 20:47
 */
public class Constant {
    /** 定义消息队列topic 代表对论文的操作 */
    public static final String TOPIC = "zs3_paper_system_op";

    /** 用户提交文件的存储路径*/
    public static final String UPLOAD_PATH = System.getProperty("user.dir") +
            System.getProperty("file.separator") + "uploadFile" + System.getProperty("file.separator");



}
