<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>民力短工宝欢迎您!</title>
	<!-- Meta-Tags -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
	<!-- //Meta-Tags -->
	<link rel="stylesheet" href="<%=basePath%>css/style.css" type="text/css" media="all">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>js/jquery-easyui-1.5.4/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>js/jquery-easyui-1.5.4/themes/icon.css">
	<script type="text/javascript" src="<%=basePath%>js/jquery-easyui-1.5.4/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery-easyui-1.5.4/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/jquery-easyui-1.5.4/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=PtgfiFuWmG958LEgAAXZnY9Amp0oxl3G"></script>
	<script type="text/javascript">
		$(function(){
			$.extend($.fn.validatebox.defaults.rules, {    
			    phoneNum: { 							//验证手机号   
			        validator: function(value, param){ 
			         return /^1[3-8]+\d{9}$/.test(value);
			        },    
			        message: '请输入正确的手机号码。'   
			    },
			    userPassword: {								//验证密码
	                validator: function (value) {
	                     return /^[a-zA-Z][a-zA-Z0-9_]{6,15}$/i.test(value);
	                 },
	                 message: '密码不合法（字母开头，允许6-16位，允许字母数字下划线）'
             	},
             	nameTest:{// 验证姓名，可以是中文或英文
             	      validator : function(value) {
             	    	var pattern = /[\u4e00-\u9fa5]/;
             	    	return  pattern.test(value);
             	      },
             	      message : '请输入您的中文名!'
             	 },
	    	});
			
			//判断是否勾选记住账号
	    	var isCheck=<%= 
	    		(String) session.getAttribute("isCheck") == null ? true:false
	    	%>;
	    	if(!isCheck){
	    		$("input[name='userName']").val( ${sessionScope.person.person_account} );
	    		$("input[type='checkbox']").attr("checked", true);
	    	}
	    	
		})
		// 登录提交表单
			function submitForm()
			{
				$("#frm").form("submit", {
					url : "#",
					onSubmit : function()
					{
						var flag=true;
						$.ajax({
							async:false,
							url:"<%=basePath%>login.do",
							type:"POST",
							data:"person_Account="+$("input[name='userName']").val()+"&isCheck="+$("input[type='checkbox']").is(':checked')+"&person_pwd="+$("input[name='password']").val(),
							success:function(data){
								flag=data;
							}
						});
						
						if(flag){
							return true;
						}else{
							$.messager.alert('警告','账号或者密码错误!');
							return false;
						}
					},
					success : function()
					{
						$.messager.confirm('登录提示', '登陆成功!', function(r){
							if (r){
							    location.href="<%=basePath%>toPage.do";
							}
						});	
					}
				});
			}
			
			// 注册提交表单
			function submitForm2()
			{
				$("#frm2").form("submit", {
					url : "#",
					onSubmit : function()
					{
						var flag=true;
						
						var person={};
						person.person_name=$("input[name='name']").val();
						person.person_account=$("input[name='phone']").val();
						person.person_pwd=$("input[name='password2']").val();
						person.person_address=$("input[name='address']").val();
						if(/^[a-zA-Z][a-zA-Z0-9_]{6,15}$/i.test(person.person_pwd)){
							
						}else{
							alert("密码格式不对 !");
							return false;
						}
						person.type=$('#job option:selected').val();
						var json_person=JSON.stringify(person);
						$.ajax({
							async:false,
							url:"<%=basePath%>register.do",
							data:"register="+json_person,
							type:"POST",
							success:function(data){
								flag=data;
							}
						});
						if(flag){
							return true;
						}else{
							$.messager.alert('警告','该用户手机已经被注册!');
							return false;
						}
					},
					success : function()
					{
						$.messager.confirm('恭喜', '注册成功,欢迎加入短工宝!', function(r){
							if (r){
							    location.reload();
							}
						});
					}
				});
			}
			// 百度地图API功能
			function mapApi(){

			    var map = new BMap.Map("allmap");
			    var point = new BMap.Point(108.95,34.27);
			    map.centerAndZoom(point,12);
			    var geolocation = new BMap.Geolocation();
			    geolocation.getCurrentPosition(function(r){console.log(r.point)
			        if(this.getStatus() == BMAP_STATUS_SUCCESS){
			            var mk = new BMap.Marker(r.point);
			            map.addOverlay(mk);//标出所在地
			            map.panTo(r.point);//地图中心移动
			            var point = new BMap.Point(r.point.lng,r.point.lat);//用所定位的经纬度查找所在地省市街道等信息
			            var gc = new BMap.Geocoder();
			            gc.getLocation(point, function(rs){
			               var addComp = rs.addressComponents; console.log(rs.address);//地址信息
			               alert("您的当前地址为:"+rs.address);//弹出所在地址
							$("input[name='address']").val(rs.address);
			            });
			        }else {
			            alert('failed'+this.getStatus());
			        }        
			    },{enableHighAccuracy: true})
			
			}
			
	</script>
  </head>
  
<body>
	<h1>民力短工宝欢迎您!</h1>
	 <div id="allmap" style="width: 100%;height: 500px;display: none;"></div>
	<div class="container w3layouts agileits">

		<div class="login w3layouts agileits">
			<h2>登 录</h2>
			<form method="post" id="frm">
				<input type="text" name="userName" placeholder="手机号" class="easyui-validatebox" data-options="required:true,validType:'phoneNum'"/>
				<input type="password" name="password" placeholder="密码" class="easyui-validatebox" data-options="showEye:false,required:true,validType:'userPassword'">
			</form>
			<ul class="tick w3layouts agileits">
				<li>
					<input type="checkbox" id="brand1" value="">
					<label for="brand1"><span></span>记住账号</label>
				</li>
			</ul>
			<div class="send-button w3layouts agileits">
					<input type="submit" value="登 录" onclick="submitForm()">
			</div>
			<a href="#">忘记密码?</a>
			<div class="social-icons w3layouts agileits">
				<p>- 欢迎加入! -</p>
				<ul>
					<li class="qq"><a href="#">
					<span class="icons w3layouts agileits"></span>
					<span class="text w3layouts agileits">工人</span></a></li>
					<li class="weixin w3ls"><a href="#">
					<span class="icons w3layouts"></span>
					<span class="text w3layouts agileits">工头</span></a></li>
					<li class="weibo aits"><a href="#">
					<span class="icons agileits"></span>
					<span class="text w3layouts agileits">农户</span></a></li>
					<div class="clear"></div>
				</ul>
			</div>
			<div class="clear"></div>
		</div>
		

		<div class="register w3layouts agileits">
			<h2>注 册</h2>
			<form method="post" id="frm2">
				<input type="text" name="name" placeholder="姓名" class="easyui-validatebox" data-options="required:true,validType:'nameTest'"/>
				<input type="password" name="password2" placeholder="密码" class="easyui-validatebox" data-options="showEye:false,required:true,validType:'userPassword'"/>
				<input type="text" name="phone" placeholder="电话" class="easyui-validatebox" data-options="showEye:false,required:true,validType:'phoneNum'"/>
				<input type="text" name="address" placeholder="地址">
				<select id="job" class="jobs">
					<option value="工人">工人</option>
					<option value="农户">农户</option>
					<option value="工头">工头</option>
				</select>
			</form>
			<div class="send-button w3layouts agileits">
					<input type="submit" value="获取当前位置" onclick="mapApi()">
					<input type="submit" value="免费注册" onclick="submitForm2()">
			</div>
			<div class="clear"></div>
		</div>

		<div class="clear"></div>

	</div>

	<div class="footer w3layouts agileits">
		<p>Copyright &copy;We are the public servants of the people!</p>
	</div>
	<div style="text-align:center;">
		<p>热心提醒：<a href="#" target="_blank">短工宝欢迎你!</a></p>
	</div>

</body>
</html>
