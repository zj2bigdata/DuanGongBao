package com.yy.duangongbao.web;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yy.duangongbao.service.impl.PersonServiceImpl;
import com.yy.duangongbao.utils.JsonUtils;

@Controller
public class FammerController {
	
	@Autowired
	private PersonServiceImpl presonService;
	
	@RequestMapping("/showproject.do")
	@ResponseBody
	public String  showProject(){
		return JsonUtils.objectToJson(presonService.showProject());			
	}
	
	@RequestMapping("/showorders.do")
	@ResponseBody
	public String  showOrders(){
		return JsonUtils.objectToJson(presonService.showOrders());			
	}
	
}
