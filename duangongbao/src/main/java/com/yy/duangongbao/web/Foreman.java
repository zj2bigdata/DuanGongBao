package com.yy.duangongbao.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yy.duangongbao.service.PersonService;
import com.yy.duangongbao.service.impl.PersonServiceImpl;
import com.yy.duangongbao.utils.CommonsUtils;


@Controller
@RequestMapping(value="/project")
public class Foreman {

	@Autowired
	private PersonServiceImpl presonService;
	
	//所有未加入公会的工人
	@RequestMapping(value="/foreman.do")
	@ResponseBody
	public List<Map<String, Object>> queryAll(HttpServletRequest req,int page,int rows){
		Map<String,String> person=(Map<String,String>)req.getSession().getAttribute("person");
		System.out.println("所有未加入公会的工人"+person.get("person_id"));
		String foremanId = person.get("person_id");
		return presonService.queryAllWorker(foremanId);			
	}
	//我的工人
	@RequestMapping(value="/foremanworker.do")
	@ResponseBody
	public List<Map<String, Object>> queryWorker(HttpServletRequest req){
		Map<String,String> person=(Map<String,String>)req.getSession().getAttribute("person");
		System.out.println("我的工人"+person.get("person_id"));
		String foremanId = person.get("person_id");
		return presonService.queryWorkerByForemanid(foremanId);
			
	}
	//邀请工人
	@RequestMapping(value="/invite.do")
	@ResponseBody
	public boolean invite(HttpServletRequest req,String person_id){
		//System.out.println("获取的id"+person_id);
		Map<String,String> map = new HashMap<String, String>();
		String person_foremanId = "dbd73139-f5b5-44bc-a450-3af999d391ec";
		map.put("id", CommonsUtils.getUUID());
		map.put("person_id", person_id);
		map.put("person_foremanId", person_foremanId);
		boolean flag = presonService.invite(map);
		System.out.println(flag);
		return flag;		
	}
	//工头删除下属工人
	@RequestMapping(value="/delete.do")
	@ResponseBody
	public boolean deleteWorkerByForeman(String person_id){
		System.out.println("获取的id"+person_id);			
		boolean flag = presonService.deleteWorkerByForeman(person_id);
		System.out.println(flag);
		return flag;		
	}
	//工头的可接订单
	@RequestMapping(value="/allorder.do")
	@ResponseBody
	public List<Map<String, Object>> queryAllOrder(HttpServletRequest req,int page,int rows){
		Map<String,Object> map = new HashMap<String, Object>();
		Map<String,String> person=(Map<String,String>)req.getSession().getAttribute("person");
		System.out.println("工头"+person.get("person_id"));
		String foremanId = person.get("person_id");
		map.put("foremanId", foremanId);
		map.put("start",page*rows-rows);
		map.put("rows",rows);
		System.out.println();
		return presonService.queryAllOrder(map);
	}
	//工头接单
	@RequestMapping(value="/addPersonOrder.do")
	@ResponseBody
	public boolean addPersonOrder(HttpServletRequest req,String order_id){
		Map<String,Object> map = new HashMap<String, Object>();
		Map<String,String> person=(Map<String,String>)req.getSession().getAttribute("person");
		System.out.println("工头"+person.get("person_id"));
		String person_id = person.get("person_id");
		map.put("id",CommonsUtils.getUUID());
		map.put("person_id", person.get("person_id"));
		map.put("order_id",order_id);
		boolean flag = presonService.addPersonOrder(map);		
		System.out.println(flag);
		return flag;		
	}
	//工头的已接订单
	@RequestMapping(value="/myPersonOrder.do")
	@ResponseBody
	public List<Map<String, Object>> queryMyOrder(HttpServletRequest req,int page,int rows){
		Map<String,Object> map = new HashMap<String, Object>();
		Map<String,String> person=(Map<String,String>)req.getSession().getAttribute("person");
		System.out.println("工头"+person.get("person_id"));		
		String foremanId = person.get("person_id");
		String count = presonService.queryOrderCountByForemanid(foremanId);
		map.put("foremanId", foremanId);
		map.put("start",page*rows-rows);
		map.put("rows",rows);
		System.out.println();
		return presonService.queryOrderByForemanid(map);
	}
	//我的工人
	@RequestMapping(value="/selectPersonOrderWorker.do")
	@ResponseBody
	public List<Map<String, Object>> queryWorkerPersonOrder(HttpServletRequest req){
		Map<String,String> person=(Map<String,String>)req.getSession().getAttribute("person");
		System.out.println("我的工人"+person.get("person_id"));
		String foremanId = person.get("person_id");
		return presonService.queryWorkerPersonOrder(foremanId);
			
	}
	//工头送工
	@RequestMapping(value="/addPersonOrderWorker.do")
	@ResponseBody
	public boolean addPersonOrderWorker(HttpServletRequest req,String person_id,String order_id){
		System.out.println("获取的id"+person_id);
		System.out.println("获取的order_id"+order_id);
		Map<String,String> map = new HashMap<String, String>();
		map.put("id", CommonsUtils.getUUID());
		map.put("person_id", person_id);
		map.put("order_id", order_id);
		boolean flag = presonService.addPersonOrderWorker(map);
		System.out.println(flag);
		return flag;		
	}
}
