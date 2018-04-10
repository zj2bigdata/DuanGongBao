<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>项目展示</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="js/jquery-easyui-1.5.4/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="js/jquery-easyui-1.5.4/themes/icon.css">
	<script type="text/javascript" src="js/jquery-easyui-1.5.4/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.5.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/jquery-easyui-1.5.4/locale/easyui-lang-zh_CN.js"></script>
	<head>
		<script src="js/project.js">

		</script>
	</head>  
  <body>
  	<table id="showproject"></table><br/><br/>
   	<a href="famerIndex.jsp">退出</a>
   
  </body>
</html>
