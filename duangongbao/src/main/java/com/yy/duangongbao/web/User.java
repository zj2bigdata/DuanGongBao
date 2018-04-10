package com.yy.duangongbao.web;

import com.yy.duangongbao.service.impl.PersonServiceImpl;
import com.yy.duangongbao.utils.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class User {
    @Autowired
    public PersonServiceImpl personServiceImpl;

    //将审核状态转换为中文显示
    private List<Map<String, String>> checkState(List<Map<String, String>> mapList) {
        List<Map<String, String>> checkedList = new ArrayList<>();

        for (Map<String, String> map : mapList) {
            if (map.get("person_flag").equals("1")) {
                map.put("person_flag", "待审核");
            } else if (map.get("person_flag").equals("2")) {
                map.put("person_flag", "审核通过");
            }

            checkedList.add(map);
        }
        return checkedList;
    }

    //显示所有用户
    @RequestMapping("/showAllUser.do")
    @ResponseBody
    public void showAllUser(HttpServletResponse response) throws IOException {
        List<Map<String, String>> mapList = personServiceImpl.queryAllUser();
        List<Map<String, String>> checkedList = checkState(mapList);
        String json = JsonUtils.objectToJson(checkedList);


        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.println(json);
        writer.flush();
        writer.close();
    }

    //通过角色显示
    @RequestMapping("/showUserByRole.do")
    @ResponseBody
    public void showWorker(String role, HttpServletResponse response) throws IOException {
        List<Map<String, String>> mapList = personServiceImpl.querySingleByRole(role);
        List<Map<String, String>> checkedList = checkState(mapList);
        String json = JsonUtils.objectToJson(checkedList);


        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.println(json);
        writer.flush();
        writer.close();
    }

    //通过审核状态显示
    @RequestMapping("/check.do")
    @ResponseBody
    public void check(String state, HttpServletResponse response) throws IOException {
        List<Map<String, String>> mapList = personServiceImpl.querySingleByState(state);
        List<Map<String, String>> checkedList = checkState(mapList);
        String json = JsonUtils.objectToJson(checkedList);


        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.println(json);
        writer.flush();
        writer.close();
    }

    //审核
    @RequestMapping("/updCheck.do")
    @ResponseBody
    public boolean updateCheck(String account) {
        return personServiceImpl.updateCheck(account);
    }

    //模糊查询
    @RequestMapping("/vagueQuery.do")
    @ResponseBody
    public void vagueQuery(String name, HttpServletResponse response) throws IOException {
        List<Map<String, String>> mapList = personServiceImpl.queryUserByVagueName(name);
        List<Map<String, String>> checkedList = checkState(mapList);
        String json = JsonUtils.objectToJson(checkedList);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.println(json);
        writer.flush();
        writer.close();
    }


}







