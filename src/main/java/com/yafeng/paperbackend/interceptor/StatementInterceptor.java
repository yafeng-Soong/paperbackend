package com.yafeng.paperbackend.interceptor;

import com.google.common.base.Stopwatch;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.ParameterMode;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.reflection.DefaultReflectorFactory;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.SystemMetaObject;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.type.TypeHandlerRegistry;

import java.lang.reflect.Field;
import java.lang.reflect.Proxy;
import java.sql.Connection;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

@Intercepts({
        @Signature(
                type = StatementHandler.class,
                method = "prepare",
                args = {Connection.class, Integer.class}
        )
})
@Slf4j
public class StatementInterceptor implements Interceptor {
    @Override
    public Object intercept(Invocation invocation) throws Throwable {

        Stopwatch stopwatch = Stopwatch.createStarted();

        if (invocation.getTarget() instanceof StatementHandler) {

            //获取Statement 对象
            Connection conn = (Connection) invocation.getArgs()[0];
            StatementHandler handler = (StatementHandler) invocation.getTarget();
            Statement stmt = handler.prepare(conn, 30);
            handler.parameterize(stmt);

            //获取真实对象
            MetaObject metaObject = SystemMetaObject.forObject(stmt);

            while (metaObject.hasGetter("h")) {
                Object obj = metaObject.getValue("h");
                // 将对象包装成MetaObject对象后就成了真实对象，然后就可以通过反射技术可以操作真实对象的所有属性
                metaObject = SystemMetaObject.forObject(obj);
            }

            //通过反射获取 Statement 对象上的FinalSql

            Field hField = metaObject.getClass().getDeclaredField("originalObject");
            hField.setAccessible(true);
            Object hObj = hField.get(metaObject);

            Field statementField = hObj.getClass().getDeclaredField("statement");
            statementField.setAccessible(true);
            Object statementObj = statementField.get(hObj);

            Field stmtField = statementObj.getClass().getSuperclass().getSuperclass().getDeclaredField("delegate");
            stmtField.setAccessible(true);
            Object stmtObj = stmtField.get(statementObj);

//            Field statementArrivedField = stmtObj.getClass().getDeclaredField("statement");
//            statementArrivedField.setAccessible(true);
//            Object statementArrivedFieldObj = statementArrivedField.get(stmtObj);


//            String finalSql = statementArrivedFieldObj.toString();
            String finalSql = stmtObj.toString();


            //去掉不要的字符串
            finalSql = finalSql.substring(finalSql.lastIndexOf(":") + 1, finalSql.length());
            finalSql = finalSql.replaceAll("\\s+", " ");

            log.info("最终sql： \n " + finalSql);

        }

        //做了下性能测试 平均耗时为 1，2毫秒，非常低，不错！
        log.info("抓取最终sql 耗时：" + stopwatch);
        return invocation.proceed();


//        Statement statement;
//        //获取方法参数
//        Object firstArg = invocation.getArgs()[0];
//        if (Proxy.isProxyClass(firstArg.getClass())) {
//            statement = (Statement) SystemMetaObject.forObject(firstArg).getValue("h.statement");
//        } else {
//            statement = (Statement) firstArg;
//        }
//        MetaObject stmtMetaObj = SystemMetaObject.forObject(statement);
//        //获取Statement对象（sql语法已经构建完毕）
//        statement = (Statement) stmtMetaObj.getValue("stmt.statement");
//        //获取sql语句
//        String sql = statement.toString();
//
//        //将原始sql中的空白字符（\s包括换行符，制表符，空格符）替换为" "
//        // originalSql = originalSql.replaceAll("[\\s]+", " ");

    }

    @Override
    public Object plugin(Object o) {
        return o instanceof StatementHandler ? Plugin.wrap(o, this) : o;
    }

    @Override
    public void setProperties(Properties properties) {

    }

//    public static <T> T realTarget(Object target) {
//        if (Proxy.isProxyClass(target.getClass())) {
//            MetaObject metaObject = SystemMetaObject.forObject(target);
//            return realTarget(metaObject.getValue("h.target"));
//        } else {
//            return (T) target;
//        }
//    }



}
