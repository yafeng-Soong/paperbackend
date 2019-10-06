package com.yafeng.paperbackend.mapper;

import com.yafeng.paperbackend.bean.entity.Book;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.dao
 * describe: 由开发人员自主完善
 *
 * @author : songyafeng
 * creat_time: 2019/10/6 12:49
 **/
@Mapper
public interface BookMapper {
    List<Book> selectAll();
    Book selectOne();
}
