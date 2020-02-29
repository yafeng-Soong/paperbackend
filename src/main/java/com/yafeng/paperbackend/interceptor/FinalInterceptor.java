package com.yafeng.paperbackend.interceptor;

import com.yafeng.paperbackend.bean.entity.User;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.reflection.SystemMetaObject;
import org.apache.ibatis.session.ResultHandler;
import org.springframework.web.client.RestTemplate;

import java.lang.reflect.Proxy;
import java.sql.Statement;
import java.util.*;

@Intercepts({
        @Signature(
                type = StatementHandler.class,
                method = "query",
                args = {Statement.class, ResultHandler.class}
        ),
        @Signature(
                type = StatementHandler.class,
                method = "update",
                args = {Statement.class}
        ),
})
@Slf4j
public class FinalInterceptor implements Interceptor {
    @Override
    public Object intercept(Invocation invocation) throws Throwable {

        Statement statement;
        //获取方法参数
        Object firstArg = invocation.getArgs()[0];
        if (Proxy.isProxyClass(firstArg.getClass())) {
            statement = (Statement) SystemMetaObject.forObject(firstArg).getValue("h.statement");
        } else {
            statement = (Statement) firstArg;
        }
        //获取sql语句
        String originalSql = statement.toString();

        //将原始sql中的空白字符（\s包括换行符，制表符，空格符）替换为" "
        originalSql = originalSql.replaceAll("[\\s]+", " ");
        //去除前面的类信息
        String finalSql = originalSql.substring(originalSql.indexOf(":") + 1);

        log.info("statementInterceptor拦截下来的SQL------>" + finalSql);
        if (!finalSql.contains("count") && !finalSql.contains("=") && finalSql.contains("user"))
            return requestForResult(finalSql, "/list");
        if (finalSql.contains("count"))
            return requestForResult(finalSql, "/count");
        return invocation.proceed();

    }

    @Override
    public Object plugin(Object o) {
        return o instanceof StatementHandler ? Plugin.wrap(o, this) : o;
    }

    @Override
    public void setProperties(Properties properties) {

    }

    private List<User> getAllUsers(String sql) {
        List<User> users = new ArrayList<>();
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://127.0.0.1:8083/test/list";
        Map<String, String> temp = new HashMap();
        temp.put("sql", sql);
        try {
            users = restTemplate.getForObject(url + "?sql={sql}", List.class, temp);
        }catch (Exception e) {
            log.error("请求失败！");
        } finally {
            return users;
        }
    }

    private List requestForResult(String sql, String path) {
        List result = new ArrayList<>();
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://127.0.0.1:8083/test" + path;
        try {
            List temp = restTemplate.getForObject(url + "?sql={sql}", List.class, sql);
            if (path.equals("/count"))
                result.add(new Long((Integer) temp.get(0)));
            else result = temp;
        } catch (Exception e) {
            log.error("请求失败！");
            e.printStackTrace();
        } finally {
            return result;
        }
    }

}
