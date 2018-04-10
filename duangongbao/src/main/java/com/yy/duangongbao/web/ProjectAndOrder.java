package com.yy.duangongbao.web;

import com.yy.duangongbao.service.impl.POServiceImpl;
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
public class ProjectAndOrder {
    @Autowired
    private POServiceImpl poService;


    //将状态转换为中文显示
    private List<Map<String, String>> checkState(List<Map<String, String>> mapList) {
        List<Map<String, String>> checkedList = new ArrayList<>();

        for (Map<String, String> map : mapList) {
            switch (map.get("flag")) {
                case "1":
                    map.put("flag", "未开始");
                    break;
                case "2":
                    map.put("flag", "进行中");
                    break;
                case "3":
                    map.put("flag", "已结束");
                    break;
                case "4":
                    map.put("flag", "已删除");
                    break;
            }

            checkedList.add(map);
        }
        return checkedList;
    }

    //显示所有项目及分类显示
    @RequestMapping("/showAllprojects.do")
    @ResponseBody
    public void showAllprojects(String sort, HttpServletResponse response) throws IOException {
        List<Map<String, String>> mapList = poService.queryAllProjects();
        List<Map<String, String>> checkdList = checkState(mapList);

        List<Map<String, String>> notStart = new ArrayList<>();
        List<Map<String, String>> onGoing = new ArrayList<>();
        List<Map<String, String>> finished = new ArrayList<>();
        List<Map<String, String>> deleted = new ArrayList<>();

        for (Map<String, String> map : checkdList) {
            switch (map.get("flag")) {
                case "未开始":
                    notStart.add(map);
                    break;
                case "进行中":
                    onGoing.add(map);
                    break;
                case "已结束":
                    finished.add(map);
                    break;
                case "已删除":
                    deleted.add(map);
                    break;
            }
        }
        String json = null;
        switch (sort) {
            case "all":
                json = JsonUtils.objectToJson(checkdList);
                break;
            case "notStart":
                json = JsonUtils.objectToJson(notStart);
                break;
            case "onGoing":
                json = JsonUtils.objectToJson(onGoing);
                break;
            case "finished":
                json = JsonUtils.objectToJson(finished);
                break;
            case "deleted":
                json = JsonUtils.objectToJson(deleted);
                break;
        }


        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.println(json);
        writer.flush();
        writer.close();
    }

    //模糊查询
    @RequestMapping("/poVagueQuery.do")
    @ResponseBody
    public void vagueQuery(String name, HttpServletResponse response) throws IOException {
        List<Map<String, String>> mapList = poService.poVagueQuery(name);
        List<Map<String, String>> checkedList = checkState(mapList);
        String json = JsonUtils.objectToJson(checkedList);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter writer = response.getWriter();
        writer.println(json);
        writer.flush();
        writer.close();
    }

    @RequestMapping("updateFlag.do")
    @ResponseBody
    public boolean updateFlag(String name, String flag) {

        return poService.updateFlag(name, flag);
    }
}
