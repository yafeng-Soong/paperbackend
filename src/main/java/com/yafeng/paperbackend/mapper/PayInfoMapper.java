package com.yafeng.paperbackend.mapper;

import com.yafeng.paperbackend.bean.entity.PayInfo;
import tk.mybatis.mapper.common.Mapper;

public interface PayInfoMapper extends Mapper<PayInfo> {
    // 先在数据库中建立一个索引
    PayInfo selectByOrderNo(String orderId);
}