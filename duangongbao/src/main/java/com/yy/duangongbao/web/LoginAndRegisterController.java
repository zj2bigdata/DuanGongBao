package com.yy.duangongbao.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.yy.duangongbao.service.PersonService;
import com.yy.duangongbao.utils.CommonsUtils;
import com.yy.duangongbao.utils.MD5Utils;


@Controller
public class LoginAndRegisterController {

	@Resource
	private PersonService personService;
	
	//登录
	@RequestMapping("/login.do")
	@ResponseBody
	public boolean login(String person_Account,String isCheck,String person_pwd,HttpServletRequest req,HttpServletResponse response){
		Subject subject = SecurityUtils.getSubject();
		//System.out.println(personService.selectSinglePersonByAccount(person_Account));
		UsernamePasswordToken token = new UsernamePasswordToken(person_Account,MD5Utils.md5(person_pwd)) ;
		try {
		        subject.login(token);
		        response.setCharacterEncoding("UTF-8");
                response.setContentType("text/html;charset=UTF-8");
                //使用request对象的getSession()获取session，如果session不存在则创建一个
                 HttpSession session = req.getSession();
                 //将数据存储到session中
                 if("true".equals(isCheck)) {
                 	session.setAttribute("isCheck", isCheck);
                 }
                 //将数据存储到session中
                 session.setAttribute("person",personService.selectSinglePersonByAccount(person_Account));
		        return true ;
		    }catch (Exception e){
		        //这里将异常打印关闭是因为如果登录失败的话会自动抛异常
		        //e.printStackTrace();
		        return false ;
		    }
		
	}
	//注册
	@RequestMapping("/register.do")
	@ResponseBody
	public boolean register(String register){
		 Map<String,Object> person = JSON.parseObject(register); 
		 String person_name=(String) person.get("person_name");
		 Map<String,String> newPerson=new HashMap<String, String>();
		 newPerson.put("person_id", CommonsUtils.getUUID());
		 newPerson.put("person_name", person_name);
		 newPerson.put("person_account", (String) person.get("person_account"));
		 newPerson.put("person_pwd",MD5Utils.md5((String) person.get("person_pwd")));
		 newPerson.put("person_address", (String) person.get("person_address"));
		 newPerson.put("person_type", (String) person.get("type"));
		 newPerson.put("person_flag", "1");
		 newPerson.put("person_foremanId",null);
		 if(personService.selectSinglePersonByAccount((String) person.get("person_account"))==null){
			 //可以注册... 
			 boolean femail=personService.insertSinglePerson(newPerson);
			 if(femail){
				 String message="<a style='color:pink;' href=''>"+person_name+"注册了短工宝,请注意审核!</a>";
				 try {
					//MailUtils.sendMail("13647157266@163.com", message);
				} catch (Exception e) {
					e.printStackTrace();
				}
			 }
			 return femail;
		 }else{
			 return false;
		 }
	}
	
	//跳转
	@RequestMapping("/toPage.do")
	public void toPage(HttpServletRequest req,HttpServletResponse resp){
		Map<String,String> person=(Map<String,String>)req.getSession().getAttribute("person");
		String url=personService.selectSinglePower(person.get("person_type"));
		//System.out.println(url);
		try {
			resp.sendRedirect(url);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
