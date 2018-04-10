package com.yy.duangongbao.dao;

import java.util.List;
import java.util.Map;

public interface POMapper {

    List<Map<String, String>> queryAllProjects();

    List<Map<String, String>> poVagueQuery(String name);

    int updateFlag(String name, String flag);
}
