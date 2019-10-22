package com.yafeng.paperbackend.exception;

/**
 * @author liugaoyang
 * @version 1.0.0
 * @description 论文审核系统异常类
 * @date 2019/10/20 20:22
 */
public class PaperException extends Exception{
    public PaperException(String message){
        super(message);
    }
}
