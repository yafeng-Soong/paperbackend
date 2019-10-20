package com.yafeng.paperbackend.config.filter;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.config.filter
 * describe: 角色过滤器
 * @author : songyafeng
 * creat_time: 2019/10/20 17:45
 **/
public class ShiroRoleFilter extends AuthorizationFilter {
    private static final Logger LOGGER = LoggerFactory.getLogger(ShiroRoleFilter.class);
    @Override
    protected boolean isAccessAllowed(ServletRequest servletRequest, ServletResponse servletResponse, Object o) throws Exception {
        String method = WebUtils.toHttp(servletRequest).getMethod();
        if (method.equals("OPTIONS")) {
            LOGGER.info("来自" + servletRequest.getRemoteAddr() + ":" + servletRequest.getRemotePort() + "的需要授权角色的OPTIONS请求被放行");
            return true;
        }
        Subject subject = getSubject(servletRequest,servletResponse);
        String[] roles = (String[]) o;
        if(roles == null || roles.length ==0){
            return true;
        }
        for(String role:roles){
            if(subject.hasRole(role)){
                return true;
            }
        }
        return false;
    }
}
