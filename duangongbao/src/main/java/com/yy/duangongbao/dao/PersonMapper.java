package com.yy.duangongbao.dao;

import java.util.List;
import java.util.Map;

public interface PersonMapper {

    //登录注册页面MAPPER
    Map<String,String> selectSinglePersonByAccount(String personAccount);//查询单个用户
    
    String selectSinglePower(String personId);//查询用户权限
    //工人页面MAPPER
    List<Map<String,String>> selectSingleWorkerOrderByPid(String personId);//工人订单查询
    List<Map<String, Object>> selectForemans();//工人查询多个工头
    int updateMyForeman(String fid,String mid);//工人退出或加入工头

    List<Map<String, String>> queryAllUser();//查看所有用户

    List<Map<String, String>> querySingleByRole(String role);//通过角色查看用户

    List<Map<String, String>> querySingleByState(String state);//通过审核状态查看用户

    Map<String, String> selectSinglePersonByName(String personName);//通过用户名查看用户

    boolean pwdChanged(String name, String pwd);//修改密码

    int insertSinglePerson(Map<String, String> person);//插入单个用户
    
    List<Map<String, Object>> queryAllWorker(String person_foremanId);//查询所有未加入公会的工人
    
    List<Map<String, Object>> queryWorkerByForemanid(String person_foremanId);//查询工头的下属工人
    
    boolean invite(Map<String,String> map);//工头邀请工人
    
    boolean deleteWorkerByForeman(String person_Id);//工头删除下属工人
    
    List<Map<String, Object>> queryAllOrder(Map<String, Object> map);//查询工头可接订单
    
    boolean addPersonOrder(Map<String, Object> map);//工头接单,工人接单
    
    String queryOrderCountByForemanid(String foremanId);//工头已接订单总数   
    List<Map<String, Object>> queryOrderByForemanid(Map<String, Object> map);//工头已接订单
    
    List<Map<String, Object>> queryWorkerPersonOrder(String person_foremanId);//工头查询没有分配任务的下属工人
    boolean addPersonOrderWorker(Map<String,String> map);//工头送工
	//List<Map<String,Object>> selectPerson(Map<String,String> map);//动态查询单个用户
    
    List<Map<String,String>>  showProject();
	
	List<Map<String,String>>  showOrders();

    List<Map<String, String>> queryUserByVagueName(String name);//通过用户名模糊搜索查看用户

    int isChecked(String account);//审核

	
}
