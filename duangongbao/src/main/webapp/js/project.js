$(function()
{
	initDataGrid();
});

function initDataGrid()
{
	var columns = [[{field : "id", title : "编号"},
					{field : "project_name", title : "项目名称"},
					{field : "starttime", title : "开始时间"},
					{field : "endtime", title : "结束时间"},
					{field : "createtime", title : "创建时间"}]];					
	$("#showproject").datagrid({
		singleSelect : true,
		pagination : true,
		url : "/showproject.do",
		columns : columns,
		toolbar : [{
			iconCls : "icon-add",
			text : "发布订单",
			handler : initAddDialog
		}]
	});
}

function initAddDialog()
{
	$("<div id='dd' style='padding:10px'></div>").dialog({
		title : "发布订单",
		width : 250,
		height : 350,
		modal : true,
		collapsible: true,
		top:50,
		href : "addproject.jsp",
		buttons : [{
			iconCls : "icon-save",
			text : "发布",
			handler : addproject
		}],
		onClose : function()
		{
			$(this).dialog("destroy");
		}
	});
}

function addproject(){
	alert("发布成功");
	$("#dd").dialog("close");
	/**
	$("#frm").form("submit", {
	    url : "/addproject.do",
	    success : function(data)
	    {
	    	var obj = $.parseJSON(data);
	    	
	    	if(obj.result)
	    	{
	    		$.messager.alert("消息", "发布成功", "info", function()
		    	{
		    		$("#dd").dialog("close");
		    		$("#dg").datagrid("reload");
		    	});
	    	}
	    	else
			{
				$.messager.alert("消息", "发布失败", "info");
			}
	    }
	});
	*/
}
