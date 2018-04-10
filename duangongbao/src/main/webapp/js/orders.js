$(function()
{
	initDataGrid();
});

function initDataGrid()
{
	var columns = [[{field : "projectid", title : "项目编号"},
					{field : "ordername", title : "订单名称"},
					{field : "starttime", title : "开始时间"},
					{field : "endtime", title : "结束时间"}]];					
	$("#showorders").datagrid({
		singleSelect : true,
		pagination : true,
		url : "/showorders.do",
		columns : columns,
	});
}