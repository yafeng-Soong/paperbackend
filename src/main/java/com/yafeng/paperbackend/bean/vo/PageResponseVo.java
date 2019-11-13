package com.yafeng.paperbackend.bean.vo;

import com.github.pagehelper.Page;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.bean.vo
 * describe: 分页对象返回实体类
 * @author : songyafeng
 * creat_time: 2019/10/17 16:14
 **/
@Data
@ApiModel
public class PageResponseVo<T> {
    @ApiModelProperty(value = "当前页数")
    private Integer pageNum;
    @ApiModelProperty(value = "分页大小")
    private Integer pageSize;
    @ApiModelProperty(value = "数据总条数")
    private long total;
    @ApiModelProperty(value = "总页数，约等于total/pageSize")
    private Integer pages;
    @ApiModelProperty(value = "实际数据")
    private List<T> data;

    public PageResponseVo(List<T> data, Page page){
        this.data = data;
        pageNum = page.getPageNum();
        pageSize = page.getPageSize();
        total = page.getTotal();
        pages = page.getPages();
    }
}
