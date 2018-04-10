<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>权限出错</title>
  </head>
  
  <body background="<%=basePath %>/images/error_power.png"
	style=" background-repeat:no-repeat; background-size:100% 100%; background-attachment: fixed;">
  </body>
</html>
