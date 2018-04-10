<%@ page pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		
		<link rel="stylesheet" href="js/jquery-easyui-1.5.4/themes/default/easyui.css">
		<link rel="stylesheet" href="js/jquery-easyui-1.5.4/themes/icon.css">
		<script src="js/jquery-easyui-1.5.4/jquery.min.js"></script>
		<script src="js/jquery-easyui-1.5.4/jquery.easyui.min.js"></script>
		<script src="js/jquery-easyui-1.5.4/locale/easyui-lang-zh_CN.js"></script>
		
		<script src="js/foreman.js"></script>		
		
	</head>
  
	<body>
		<div id="tt" class="easyui-tabs" style="width:1050px;height:450px;">   
		    <div title="邀请工人" style="padding:20px;display:none;">	           
		        <table id="dg0"></table>
		    </div>  
		    <div title="我的工人" style="padding:20px;display:none;">   
		        <table id="dg1"></table>
		    </div>   
		    <div title="可接订单" style="padding:20px;display:none;">   
		        <table id="dg2"></table>
		    </div> 
		    <div title="我的订单" style="padding:20px;display:none;">   
		        <table id="dg3"></table>
		    </div> 
		</div>
		
		
	</body>
</html>