package com.yy.duangongbao.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yy.duangongbao.dao.PersonMapper;
import com.yy.duangongbao.service.PersonService;

@Service
public class PersonServiceImpl implements PersonService{
	
	/**
	 * 该页面不要自定义方法,必须是实现PersonService接口.
	 */

	@Autowired
	private PersonMapper personMapper;
	
	//根据人名查询单个person
	@Override
	public Map<String,String> selectSinglePersonByAccount(String personAccount){
		return personMapper.selectSinglePersonByAccount(personAccount);
	}
	//插入单个person
	@Override
	public boolean insertSinglePerson(Map<String,String> person){
		return personMapper.insertSinglePerson(person)!=-1? true :false;	
	}
	//查询个人权限
	@Override
	public String selectSinglePower(String personId) {
		
		return personMapper.selectSinglePower(personId);
	}
	
	//查询所有工头
	@Override
	public List<Map<String, Object>> selectForemans() {
		
		return personMapper.selectForemans();
	}
	//跟新工人工头
	@Override
	public int updateMyForeman(String fid, String mid) {
		
		return personMapper.updateMyForeman(fid, mid);
	}
	//查询工人订单
	@Override
	public List<Map<String, String>> selectSingleWorkerOrderByPid(String personId) {
		
		return personMapper.selectSingleWorkerOrderByPid(personId);
	}
	//查询工头可接订单
	@Override
	public List<Map<String, Object>> queryAllOrder(Map<String,Object> map){
		
		return personMapper.queryAllOrder(map);
	}
	//查询工头的下属工人
	@Override
	public  List<Map<String, Object>> queryWorkerByForemanid(String person_foremanId){
		return personMapper.queryWorkerByForemanid(person_foremanId);
	}
//	public String selectPerson(Map<String,String> map1){
//		map1.put("invite", "null");
//		List<Map<String,Object>> list = personMapper.selectPerson(map1);
//		return JsonUtils.objectToJson(list);
//	}
	//查询所有未加入公会的工人
	@Override
	public  List<Map<String, Object>> queryAllWorker(String person_foremanId){
		return personMapper.queryAllWorker(person_foremanId);
	}
	//工头邀请工人加入队伍
	@Override
	public boolean invite(Map<String,String> map){
		return personMapper.invite(map);
	}
	//工头删除下属工人
	@Override
	public boolean deleteWorkerByForeman(String person_Id){
		return personMapper.deleteWorkerByForeman(person_Id);
	}
	//工头接单
	@Override
	public boolean addPersonOrder(Map<String, Object> map){
		return personMapper.addPersonOrder(map);
	}
	//工头已接订单总数  
	@Override
	public String queryOrderCountByForemanid(String foremanId){
		return personMapper.queryOrderCountByForemanid(foremanId);
	} 
	//工头已接订单
	@Override
	public List<Map<String, Object>> queryOrderByForemanid(Map<String, Object> map){
		return personMapper.queryOrderByForemanid(map);
	}
	//查询工头未分配任务的下属工人
	@Override
	public  List<Map<String, Object>> queryWorkerPersonOrder(String person_foremanId){
		return personMapper.queryWorkerPersonOrder(person_foremanId);
	}
	//工头送工
	@Override
	public boolean addPersonOrderWorker(Map<String,String> map){
		return personMapper.addPersonOrderWorker(map);
	}
	
	public List<Map<String,String>>  showProject(){
		
		return personMapper.showProject();
	}
	@Override
	public List<Map<String, String>> showOrders() {
		
		return personMapper.showOrders();
	}
	
	 //根据人名查询单个person
    public Map<String, String> selectSinglePersonByName(String personName) {

        return personMapper.selectSinglePersonByName(personName);
    }

    public List<Map<String, String>> queryUserByVagueName(String name) {

        return personMapper.queryUserByVagueName(name);
    }
    
    public List<Map<String, String>> queryAllUser() {

        return personMapper.queryAllUser();
    }

    public List<Map<String, String>> querySingleByRole(String role) {

        return personMapper.querySingleByRole(role);
    }

    public List<Map<String, String>> querySingleByState(String state) {

        return personMapper.querySingleByState(state);
    }

    public boolean updateCheck(String account) {

        return personMapper.isChecked(account) != -1;
    }

    
 


}
