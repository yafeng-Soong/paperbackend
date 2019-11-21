package com.yafeng.paperbackend.config;

import com.yafeng.paperbackend.config.filter.ShiroRoleFilter;
import com.yafeng.paperbackend.config.filter.ShiroUserFilter;
import com.yafeng.paperbackend.realm.UserRealm;
import com.yafeng.paperbackend.utils.PasswordHelper;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.Filter;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.config
 * describe: 由开发人员自主完善
 *
 * @author : songyafeng
 * creat_time: 2019/10/6 20:05
 **/
@Configuration
public class ShiroConfig {

    /**
     * 生成凭证匹配器，即加密方式和加密次数
     * @return 返回给realm设置
     */
    @Bean
    public HashedCredentialsMatcher hashedCredentialsMatcher(){
        HashedCredentialsMatcher hashedCredentialsMatcher = new HashedCredentialsMatcher();
        //使用PasswordHelper中的加密方式，md5算法加密2次
        hashedCredentialsMatcher.setHashAlgorithmName(PasswordHelper.ALGORITHM_NAME);
        hashedCredentialsMatcher.setHashIterations(PasswordHelper.HASH_ITERATION);
        return hashedCredentialsMatcher;
    }

    /**
     * 生成realm，并设置凭证匹配器
     * 这个方法必须有，这样realm才是以bean的形式注入了
     * 因为securityManager.setRealm(realm)的参数必须是注入的，不能用new生成（以后深究）
     * @return
     */
    @Bean
    public UserRealm userRealm(){
        UserRealm userRealm = new UserRealm();
        userRealm.setCredentialsMatcher(hashedCredentialsMatcher());
        return userRealm;
    }

    /**
     * 安全管理器
     * 注：使用shiro-spring-boot-starter 1.4时，返回类型是SecurityManager会报错，直接引用shiro-spring则不报错
     * 将userRealm注入其中
     * @return
     */
    @Bean
    public DefaultWebSecurityManager securityManager() {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setRealm(userRealm());
        //securityManager.setSessionManager(sessionManager());//设置session管理器，session存到redis可共享
        return securityManager;
    }

    /**
     * 设置过滤规则，常用的过滤规则有anon、user、authc、logout、role[角色]等
     * anon表示url可以匿名访问
     * authc表示url必须认证通过才能访问，即通过Realm中的doGetAuthorizationInfo、doGetAuthenticationInfo方法后的用户
     * user表示url“记住我”或者认证通过后可以访问
     * 配置logout的url，等待方法执行完后会跳到setLoginUrl设置的url
     * role[角色]表示授予了role中角色的用户才能访问
     * 这里只用到了anon和authc
     * 和自己使用WebMvcConfigurer设置拦截器完成的功能一样，不过覆盖得更全面
     * @param securityManager
     * @return
     */
    @Bean
    public ShiroFilterFactoryBean shiroFilter(SecurityManager securityManager) {
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        shiroFilterFactoryBean.setSecurityManager(securityManager);
        /** 一下三个方法针对前后端不分离开发时用，直接返回对应路径的页面
         * 未登录时返回的页面(MVC直接返回登录页面，静态资源下的login.index)
        * 或路径(使用Boot时在controller中配置一个路径为login的方法，SpringBoot重定向时会出现跨域错误)
        shiroFilterFactoryBean.setLoginUrl("/login");
        shiroFilterFactoryBean.setSuccessUrl("/");//校验成功跳转地址
        shiroFilterFactoryBean.setUnauthorizedUrl("/unauth");//无授权时跳转地址
        */
        //设置过滤器，主要解决跨域中的option请求
        Map<String, Filter> filter = new HashMap<>();
        filter.put("roles", new ShiroRoleFilter());
        filter.put("authc", new ShiroUserFilter());
        shiroFilterFactoryBean.setFilters(filter);

        //注意此处使用的是LinkedHashMap，是有顺序的，shiro会按从上到下的顺序匹配验证，匹配了就不再继续验证
        //所以上面的url要苛刻，宽松的url要放在下面，尤其是"/**"要放到最下面，如果放前面的话其后的验证规则就没作用了。
        Map<String, String> filterChainDefinitionMap = new LinkedHashMap<>();
        //静态资源不需要认证
        filterChainDefinitionMap.put("/static/**", "anon");
        filterChainDefinitionMap.put("/imgs/**", "anon");
        filterChainDefinitionMap.put("/files/**", "anon");
        //filterChainDefinitionMap.put("/login", "anon");
        //filterChainDefinitionMap.put("/logout", "logout");
        filterChainDefinitionMap.put("/login", "anon");//登录不需要认证，但退出登录要认证防止未认证用户把已登录用户退出
        filterChainDefinitionMap.put("/captcha.jpg", "anon");

        // 付款异步回调直接shiro放行
        filterChainDefinitionMap.put("/pay/notify", "anon");

        filterChainDefinitionMap.put("/favicon.ico", "anon");
        filterChainDefinitionMap.put("/user/signUp", "anon");
        filterChainDefinitionMap.put("/user/activate", "anon");
        filterChainDefinitionMap.put("/user/resetPassword", "anon");
        filterChainDefinitionMap.put("/user/resetPage", "anon");
        //swagger相关路径，太多了感觉是个坑
        filterChainDefinitionMap.put("/swagger-ui.html", "anon");
        filterChainDefinitionMap.put("/swagger-resources/**", "anon");
        filterChainDefinitionMap.put("/v2/api-docs/**", "anon");
        filterChainDefinitionMap.put("/webjars/springfox-swagger-ui/**", "anon");
        filterChainDefinitionMap.put("/configuration/security", "anon");
        filterChainDefinitionMap.put("/configuration/ui", "anon");
        //下面是需要角色权限的路径，暂时设置一个测试用的，具体是否要引进角色管理后面再说
        filterChainDefinitionMap.put("/user/selectPageList", "authc,roles[admin]");

        filterChainDefinitionMap.put("/**", "authc");

        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
        return shiroFilterFactoryBean;
    }
}
