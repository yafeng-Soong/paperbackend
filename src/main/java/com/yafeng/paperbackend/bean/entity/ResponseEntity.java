package com.yafeng.paperbackend.bean.entity;

import com.yafeng.paperbackend.enums.ResponseEnums;
import lombok.Data;

import java.io.Serializable;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.bean.vo
 * describe: 返回数据实体类，记录code、data
 * @author : songyafeng
 * creat_time: 2019/10/6 20:25
 **/
@Data
public class ResponseEntity<T> implements Serializable {
    private Integer code = ResponseEnums.SUCCESS.getCode();
    private String msg = ResponseEnums.SUCCESS.getMsg();
    private T data;

    public ResponseEntity(){
        super();
    }

    public ResponseEntity(T data){
        super();
        this.data = data;
    }

    public  ResponseEntity(Integer code, String msg){
        super();
        this.code = code;
        this.msg = msg;
    }

    public ResponseEntity(Exception e){
        super();
        this.code = ResponseEnums.ERROR.getCode();
        this.msg = e.getMessage();
    }
}
