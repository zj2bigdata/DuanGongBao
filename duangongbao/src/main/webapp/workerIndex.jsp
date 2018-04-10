<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>短工宝工人页</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/workindex.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>js/jquery-easyui-1.5.4/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>js/jquery-easyui-1.5.4/themes/icon.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-easyui-1.5.4/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery-easyui-1.5.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery-easyui-1.5.4/locale/easyui-lang-zh_CN.js"></script>
	<script>
		$(function(){
			// 返回所有选项卡面板
			var tabs = $("#tt").tabs("tabs");
			$(tabs).each(function()
			{
				// 获取当前选项卡的标题
				var title = this.panel("options").title;
			});
			
		});
		// 选中选项卡事件
		function changeTitle(title, index){
			// 获取指定选项卡面板
			var tab = $("#tt").tabs("getTab", index);
			// 更新指定的选项卡面板
			$("#tt").tabs("update", {
				tab : tab, 
				options : {
					title:title
				}
			});
		}
		
	</script>
	<script type="text/javascript">
		$(function(){
			//工人退出
			$("#quiet").click(function(){
				var f="${empty orders }";
				console.log(f);
				if(f=='true'){
					$.ajax({
						async:false,
						url:"<%=basePath%>workerQuiet.do",
						data:"foremanId=-1&myId=${person.person_id }",
						type:"POST",
						success:function(data){
							console.log(data);
							if(data=='yes'){
								if(confirm("由于负责人变更 ,请重新登录!")){
									location.href="<%=basePath%>index.jsp";
								}
								
							}	
						}
					});
				}else{
					alert("抱歉您接单未完成 !请先完成接单!");
				}
					
			})
		})
		//工人加入
		function join(obj){
			var fm='${empty myforeman }';
			console.log(fm)
			if(fm=="true"){
				$.ajax({
					async:false,
					url:"<%=basePath%>workerQuiet.do",
					data:"foremanId="+$(obj).attr("id")+"&myId=${person.person_id }",
					type:"POST",
					success:function(data){
						if(confirm("由于负责人变更 ,请重新登录!")){
							location.href="<%=basePath%>index.jsp";
						}
					}
				});
			}else{
				alert("抱歉您有负责人!");
			}
			
			
		}
		
		 function show(){
	            var date = new Date(); //日期对象
	            var now = "";
	            now = date.getFullYear()+"年"; //读英文就行了
	            now = now + ( (date.getMonth()+1)< 10? ('0' + (date.getMonth()+1)):(date.getMonth()+1) ) +"月"; //取月的时候取的是当前月-1如果想取当前月+1就可以了
	            now = now + ( date.getDate()< 10 ? ('0' + date.getDate()):date.getDate() ) +"日";
	            now = now + '&nbsp;' + ( date.getHours()< 10 ? ('0' + date.getHours()):date.getHours() )+":";
	            now = now + ( date.getMinutes()< 10 ? ('0' + date.getMinutes()):date.getMinutes() )+":";
	            now = now + ( date.getSeconds()< 10 ? ('0' + date.getSeconds()):date.getSeconds() );
	            document.getElementById("nowDiv").innerHTML = now; //div的html是now这个字符串
	            setTimeout("show()",1000); //设置过1000毫秒就是1秒，调用show方法
	        }
	
	</script>
  </head>
  
  <body onload="show()">
  
    <div id="tt" class="easyui-tabs" style="margin:auto;" data-options="width:800,height:600,onSelect:changeTitle">
			<div title="个人信息" data-options="style:{padding:10}">
				<form id="payment">
				    <fieldset>
				        <legend>个人详细资料</legend>
				        <ol>
				            <li>
				                <label for="name">姓名：</label>
				                <input id="name" name="name" type="text" value="${person.person_name }" readonly="readonly"/>
				            </li>
				            <li>
				                <label for="email">电话：</label>
				                <input id="email" name="phone" type="text" value="${person.person_account }" readonly="readonly"/>
				            </li>
				            <li>
				                <label for="phone">地址：</label>
				                <input id="phone" name="address" type="text" value="${person.person_address }" readonly="readonly"/>
				            </li>
				        </ol>
		    		</fieldset>
      			</form>
			</div>
			<div title="个人接单" data-options="style:{padding:10}">
			<div style="float: right" id="nowDiv"></div>
				<!-- Table goes in the document BODY -->
				<table class="hovertable" style="margin: auto;">
					<tr>
						<th>订单编号</th>
						<th>工程编号</th>
						<th>订单名</th>
						<th>开始时间</th>
						<th>结束时间</th>
						<th>报名人数</th>
						<th>负责人编号</th>
					</tr>
					 <c:forEach items="${orders }" var="order">
					 	<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
							<td>${order.id }</td>
							<td>${order.projectid }</td>
							<td>${order.ordername }</td>
							<td>
								<fmt:formatDate value="${order.starttime }" pattern="yyyy-MM-dd"/>
							</td>
							<td>
								<fmt:formatDate value="${order.endtime }" pattern="yyyy-MM-dd"/>
							</td>
							<td>${order.personnumber }</td>
							<td>${order.createid }</td>
						</tr>
				    </c:forEach>	
				</table>
			</div>
			
			<div title="负责人" data-options="style:{padding:10}">
				<table class="hovertable" style="margin: auto;">
					<tr>
						<th>姓名</th>
						<th>电话</th>
						<th>职位</th>
						<th>我的状态</th>
					</tr>
					<tr>
						<c:if test="${not empty myforeman.person_name}">
						<td>${myforeman.person_name }</td>				
						<td>${myforeman.person_account }</td>
						<td>我的负责人</td>
						<th><button id="quiet">我要退出</button></th>
						<td style="display:none;">${myforeman.person_id }</td>
						</c:if>	

					</tr>
					 <c:forEach items="${foremans }" var="foreman">
					 	<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
							<td>${foreman.person_name }</td>
							<td>${foreman.person_account }</td>
							<td>其他负责人</td>
							<th><button id="${foreman.person_id }" onclick="join(this)">我要加入</button></th>
						</tr>
				    </c:forEach>	
				</table>
			</div>
	</div>
  </body>
</html>
