package com.yafeng.paperbackend.common.redis;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
public abstract class BaseProfix implements KeyProfix {

    // 设置存活期为一天
    private static final Integer EXPIRETIME = 3600 * 24;

    // 键值对期待的存活期间
    private Integer expireSeconds;

    // 给键值对加上特定的前缀 防止错误覆盖
    private String prefix;

    public BaseProfix(String prefix){
        this(EXPIRETIME, prefix);
    }

    public BaseProfix(){
        this.expireSeconds = 0;
        this.prefix = "base";
    }

    public int expireSeconds(){
        return expireSeconds;
    }

    public String prefix(){
        String className = this.getClass().getSimpleName();
        return className + ":" + prefix;
    }
}
