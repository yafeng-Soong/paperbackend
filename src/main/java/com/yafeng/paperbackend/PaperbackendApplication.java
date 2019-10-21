package com.yafeng.paperbackend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import tk.mybatis.spring.annotation.MapperScan;

@MapperScan("com.yafeng.paperbackend.mapper")
@SpringBootApplication
public class PaperbackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(PaperbackendApplication.class, args);
    }

}
