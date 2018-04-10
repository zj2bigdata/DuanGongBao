package com.yy.duangongbao.service;

import java.util.List;
import java.util.Map;

public interface PersonService {
	//登录注册页面服务接口
	Map<String,String> selectSinglePersonByAccount(String personAccount);
	boolean insertSinglePerson(Map<String,String> person);
	String selectSinglePower(String personId);
	//工人页面服务接口
	List<Map<String,String>> selectSingleWorkerOrderByPid(String personId);
	List<Map<String, Object>> selectForemans();
	int updateMyForeman(String fid,String mid);
	//工头页面服务接口
	List<Map<String, Object>> queryAllWorker(String person_foremanId);//查询所有未加入公会的工人
	boolean invite(Map<String,String> map);//工头邀请工人加入队伍
	List<Map<String, Object>> queryWorkerByForemanid(String person_foremanId);//查询工头的下属工人
	boolean deleteWorkerByForeman(String person_Id);//工头删除下属工人
	List<Map<String, Object>> queryAllOrder(Map<String, Object> map);//查询工头可接订单
	boolean addPersonOrder(Map<String,Object> map);//工头接单，工人接单
	String queryOrderCountByForemanid(String foremanId);//工头已接订单总数   
	List<Map<String, Object>> queryOrderByForemanid(Map<String, Object> map);//工头已接订单
	List<Map<String, Object>> queryWorkerPersonOrder(String person_foremanId);//查询工头未分配任务的下属工人
	boolean addPersonOrderWorker(Map<String,String> map);//工头送工
	
	List<Map<String,String>>  showProject();	
	List<Map<String,String>>  showOrders();
	

}
