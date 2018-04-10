package com.yy.duangongbao.service.impl;

import com.yy.duangongbao.dao.POMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class POServiceImpl {
    @Autowired
    private POMapper poMapper;

    public List<Map<String, String>> queryAllProjects() {
        return poMapper.queryAllProjects();
    }

    public List<Map<String, String>> poVagueQuery(String name) {
        return poMapper.poVagueQuery(name);
    }

    public boolean updateFlag(String name, String flag) {
        return poMapper.updateFlag(name, flag) != -1;
    }
    
    
}
