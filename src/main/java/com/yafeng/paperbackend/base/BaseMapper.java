package com.yafeng.paperbackend.base;

import java.util.List;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.base
 * describe: 基础Mapper接口
 * @author : songyafeng
 * creat_time: 2019/10/6 20:19
 **/
public interface BaseMapper<T> {
    /**
     * 查询总数
     * @return 总数
     */
    int countAll();

    /**
     * 获取全部结果
     * @return
     */
    List<T> selectAll();

    /**
     * 新增数据记录
     * @param entity 插入的实体类
     * @return 受影响的行数
     */
    int insert(T entity);

    /**
     * 修改记录
     * @param entity 包含更新条件和更新数据
     * @return
     */
    int update(T entity);

    /**
     * 按条件查询
     * @param query 包含查询条件
     * @return 符合条件的数据
     */
    List<T> selectList(T query);

    /**
     * 按条件删除
     * @param query 包含删除条件
     * @return 受影响的行数
     */
    int delete(T query);
}
