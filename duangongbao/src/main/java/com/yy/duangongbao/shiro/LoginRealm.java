package com.yy.duangongbao.shiro;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.yy.duangongbao.service.PersonService;

public class LoginRealm extends AuthorizingRealm{

	@Resource
    private PersonService personService;

    /**
     * 用于的权限的认证。
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String personAccount = principalCollection.getPrimaryPrincipal().toString() ;
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        Map<String,String> map=personService.selectSinglePersonByAccount(personAccount);
        //权限角色名和审核状态
        Set<String> set1 = new HashSet<String>();
        set1.add(map.get("person_type"));
        set1.add(map.get("person_flag"));
        //System.out.println(set1);
        //权限角色可访问页面
        Set<String> set2 = new HashSet<String>();
        String url=personService.selectSinglePower(map.get("person_type"));
        set2.add(url);
        Set<String> roleName = set1;
        Set<String> permissions = set2;
        info.setRoles(roleName);
        info.setStringPermissions(permissions);
        return info;
    }

    /**
     * 首先执行这个登录验证
     * @param token
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token)
            throws AuthenticationException {
        //获取用户账号
        String personAccount = token.getPrincipal().toString();
        System.out.println(personAccount+"--"+personService.selectSinglePersonByAccount(personAccount));
        Map<String, String> person = personService.selectSinglePersonByAccount(personAccount);
        if (person != null){
            //将查询到的用户账号和密码存放到 authenticationInfo用于后面的权限判断。第三个参数传入realName。
            AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(person.get("person_account"),person.get("person_pwd"),
                    "a") ;
            return authenticationInfo ;
        }else{
            return  null ;
        }
    }

}
