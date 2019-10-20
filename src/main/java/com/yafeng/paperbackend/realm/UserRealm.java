package com.yafeng.paperbackend.realm;

import com.yafeng.paperbackend.bean.entity.User;
import com.yafeng.paperbackend.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * project_name: paperbackend
 * package: com.yafeng.paperbackend.realm
 * describe: 由开发人员自主完善
 *
 * @author : songyafeng
 * creat_time: 2019/10/6 20:07
 **/
public class UserRealm extends AuthorizingRealm {
    private static final Logger LOGGER = LoggerFactory.getLogger(UserRealm.class);
    @Autowired
    private UserService userService;

    /**
     * 授予权限，暂时没有什么权限好授予
     *
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        String email = (String) principalCollection.getPrimaryPrincipal();
        User user = userService.selectByEmail(email);
        info.addRole(user.getRole());
        return info;
    }

    /**
     * 角色认证
     *
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //Http请求时会进入这里
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        User user = userService.selectByEmail(token.getUsername());
        if (user == null)
            throw new UnknownAccountException();
        if (user.getState() == 0)
            throw new DisabledAccountException();
        return new SimpleAuthenticationInfo(
                user.getEmail(),
                user.getPassword(),
                ByteSource.Util.bytes(user.getSalt()),
                getName());
    }
}
