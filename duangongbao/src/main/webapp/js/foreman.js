$(function(){
	initDataGrid();	
});

function initDataGrid(){
	showAllWorker();
	$('#tt').tabs({ 
	    border:true,    
	    onSelect:function(title,index){
	    	if(index == 0){showAllWorker()}	 
	    	else if(index == 1){showMyWorker()}
	    	else if(index == 2){showAllOrder()}
	    	else if(index == 3){showMyOrder()}
	    }    
	}); 
}	
function showAllWorker(){
	$('#dg0').datagrid({    
	    url:'project/foreman.do',    
	    columns:[[    
	        {field:'person_name',title:'姓名',width:100},    
	        {field:'person_account',title:'电话',width:100},    
	        {field:'person_address',title:'地址',width:210,align:'center'},
	        {field:'operate1',title:'操作',align:'center',width:$(this).width()*0.1,  
	            //formatter:function(value, row, index){  
	            //    var str = '<a href="foreman.jsp" name="opera" class="easyui-linkbutton" ></a>'; 
	              //  alert(value);
	              //  return str; 
	        	formatter:function rowformater(value, row, index) {  
	            return '<input type="button" value="邀请" iconCls:"icon-add" onclick="inviteWorker(' + index + ')"/>';        
	         
	        }},
	    ]],
		singleSelect:true,
		pagination:true,	    		
	});  
}
function showMyWorker(){
	$('#dg1').datagrid({    
	    url:'project/foremanworker.do',    
	    columns:[[    
	        {field:'person_name',title:'姓名',width:100},    
	        {field:'person_account',title:'电话',width:100},    
	        {field:'person_address',title:'地址',width:210,align:'center'},
	        {field:'operate1',title:'操作',align:'center',width:$(this).width()*0.2,  
	            formatter:function rowformater(value, row, index) {  
	            return '<input type="button" value="查看信息" iconCls:"icon-cancel"/>'+            
	            '<input type="button" value="踢出队伍" iconCls:"icon-cancel" onclick="myWorker(' + index + ')"/>';
	        }},
	    ]],
		singleSelect:true,
		pagination:true,	    		
	});	  
}
function showAllOrder(){
	$('#dg2').datagrid({    
	    url:'project/allorder.do',    
	    columns:[[    
	        {field:'ordername',title:'订单名称',width:100,align:'center'},    
	        {field:'starttime',title:'开始时间',width:150,align:'center'},    
	        {field:'endtime',title:'结束时间',width:150,align:'center'},	
	        {field:'realnum',title:'已有工人',width:100,align:'center'},
	        {field:'personnumber',title:'总用工量',width:100,align:'center'},	        
	        {field:'operate',title:'操作',align:'center',width:$(this).width()*0.1,  
	            formatter:function rowformater(value, row, index) {  
	            return '<input type="button" value="我要接单" iconCls:"icon-cancel" onclick="addOrder(' + index + ')"/>';            
	         
	        }},
	    ]],
		singleSelect:true,
		pagination:true,//分页控件	
		pageSize:3,
		pageList:[3,5],
	});  
}
function showMyOrder(){
	$('#dg3').datagrid({    
	    url:'project/myPersonOrder.do',    
	    columns:[[    
			{field:'ordername',title:'订单名称',width:100,align:'center'},    
			{field:'starttime',title:'开始时间',width:150,align:'center'},    
			{field:'endtime',title:'结束时间',width:150,align:'center'},
			{field:'realnum',title:'已有工人',width:100,align:'center'},
			{field:'personnumber',title:'总用工量',width:100,align:'center'},
	        {field:'operate1',title:'操作',align:'center',width:$(this).width()*0.2,  
	            formatter:function rowformater(value, row, index) {  
	            return '<input type="button" value="查看详情" iconCls:"icon-cancel"/>'+	            
	            '<input id="cc" name="dept" onclick="myOrder(' + index + ')" value="我要送工" />';            
	         
	        }},	       
	    ]],
		singleSelect:true,
		pagination:true,	    		
	});  
}
//发送邀请
function inviteWorker(index) {  
    $('#dg0').datagrid('selectRow', index);  
    var row = $('#dg0').datagrid('getSelected');
    $.ajax({
    	url : "project/invite.do",
		type : "post",
		data : "person_id=" + row.person_id,
		success : function(data) // 执行成功后的回调函数，参数(自定义)为返回的数据
		{
			var obj = $.parseJSON(data);
			alert("邀请成功");
//			$("#shopId").val(obj.shopId);
			$("#dg0").datagrid("reload");
		}
    });
} 
//删除工人
function myWorker(index) {  
    $('#dg1').datagrid('selectRow', index);  
    var row = $('#dg1').datagrid('getSelected');
    $.ajax({
    	url : "project/delete.do",
		type : "post",
		data : "person_id=" + row.person_id,
		success : function(data) // 执行成功后的回调函数，参数(自定义)为返回的数据
		{
			var obj = $.parseJSON(data);
			alert("删除成功");
			$("#dg1").datagrid("reload");
		}
    });
} 
//我要接单
function addOrder(index){
	$("#dg2").datagrid("selectRow",index);
	var row = $("#dg2").datagrid("getSelected");
	$.ajax({
    	url : "project/addPersonOrder.do",
		type : "post",
		data : "order_id=" + row.id,
		success : function(data) // 执行成功后的回调函数，参数(自定义)为返回的数据
		{
			var obj = $.parseJSON(data);
			alert("接单成功，请尽快完成送工");
//			$("#shopId").val(obj.shopId);
			$("#dg2").datagrid("reload");
		}
    });
}
//我要送工
function myOrder(index){
	 $('#dg3').datagrid('selectRow', index);  
	 var row = $('#dg3').datagrid('getSelected');
	 $('#cc').combogrid({    
		    panelWidth:450,    
		    value:'选择工人', 		     
		    idField:'code',    
		    textField:'name',    
		    url:"project/selectPersonOrderWorker.do",
		    columns:[[    
	            {field:'person_name',title:'姓名',width:100},    
	  	        {field:'person_account',title:'电话',width:100},    
	  	        {field:'person_address',title:'地址',width:150,align:'center'},
	  	        {field:'operate1',title:'操作',align:'center',width:$(this).width()*0.1, 
		        	formatter:function rowformater(value, row, index) {  
		            return '<input type="button" value="发送任务" iconCls:"icon-add" onclick="addPersonOrderWorker(' + index + ')"/>';        
		         
		        }},
		    ]]    
		});    
}
function addPersonOrderWorker(index){
	$('#dg3').datagrid('selectRow', index);  
	 var row1 = $('#dg3').datagrid('getSelected');
	 console.log(index);
	 console.log(row1.order_id);
	 var row2 = $('#cc').combogrid('grid').datagrid('selectRow', index);  
	 //var row2 = $('#cc').datagrid('getSelected');
	 console.log(row2);
	 console.log(row2.person_name);
	 $.ajax({
	    	url : "project/addPersonOrderWorker.do",
			type : "post",
			data : "person_id=" + row2.person_id + "&order_id=" + row1.order_id,
			success : function(data) // 执行成功后的回调函数，参数(自定义)为返回的数据
			{
				var obj = $.parseJSON(data);
				alert("送工成功");
//				$("#shopId").val(obj.shopId);
				$("#dg3").datagrid("reload");
			}
	    });
	
}