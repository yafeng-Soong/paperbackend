package com.yafeng.paperbackend.interceptor;


import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.executor.resultset.DefaultResultSetHandler;
import org.apache.ibatis.executor.resultset.ResultSetHandler;
import org.apache.ibatis.plugin.*;

import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

@Intercepts({
        @Signature(
                type = ResultSetHandler.class,
                method = "handleResultSets",
                args = {Statement.class}
        )
})
@Slf4j
public class ResultInterceptor implements Interceptor {
    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        Object result  = invocation.proceed();
//        if (result instanceof ArrayList) {
//            ArrayList resultList = (ArrayList) result;
//            for (int i = 0; i < resultList.size(); i++) {
//                Object oi = resultList.get(i);
//                Class c = oi.getClass();
//                Class[] types = {String.class};
//                Method method = c.getMethod("setAddress", types);
//                // 调用obj对象的 method 方法
//                method.invoke(oi, "china");
//            }
//        }
        log.info("查询结果类型---->" + result.getClass().getName());
        if (!(result instanceof List)){
            log.info("拦截非List的返回值");
            List newResult = new ArrayList<>();
            // Class c = result.getClass();
            newResult.add(result);
            return newResult;
        }
        return result;
    }

    @Override
    public Object plugin(Object o) {
        return o instanceof ResultSetHandler? Plugin.wrap(o, this): o;
    }

    @Override
    public void setProperties(Properties properties) {

    }
}
