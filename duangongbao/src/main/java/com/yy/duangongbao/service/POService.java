package com.yy.duangongbao.service;

import java.util.List;
import java.util.Map;

public interface POService {
	List<Map<String, String>> queryAllProjects();

    List<Map<String, String>> poVagueQuery(String name);

    boolean updateFlag(String name, String flag);
}
