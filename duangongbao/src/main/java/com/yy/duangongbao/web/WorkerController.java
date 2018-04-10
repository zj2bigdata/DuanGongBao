package com.yy.duangongbao.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yy.duangongbao.service.PersonService;

@Controller
public class WorkerController {
	@Resource
	private PersonService personService;
	//工人页面跳转
	@RequestMapping("/workerIndex.do")
	public String selectSingleWorkerOrderByPid(HttpServletRequest req,Model model){
		Map<String,String> person=(Map<String,String>)req.getSession().getAttribute("person");
		List<Map<String, String>> orders = personService.selectSingleWorkerOrderByPid(person.get("person_id"));
		List<Map<String, Object>> foremans = personService.selectForemans();
		for(int i=0;i<foremans.size();i++) {
			if(foremans.get(i).get("person_id").equals(person.get("person_foremanId"))) {
				model.addAttribute("myforeman", foremans.get(i));
				foremans.remove(i);
			}
		}
		model.addAttribute("foremans",foremans);
		model.addAttribute("worker", person);
		model.addAttribute("orders", orders);
		return "workerIndex";
		
	}
	//工人退出和加入
	@RequestMapping("/workerQuiet.do")
	@ResponseBody
	public String workerQuiet(String foremanId,String myId){
		if("-1".equals(foremanId)) {
			foremanId=null;
		}
		return personService.updateMyForeman(foremanId, myId)!=1?"yes":"no";
	}
}