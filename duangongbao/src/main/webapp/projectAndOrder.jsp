<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>项目和订单管理</title>
    <link rel="stylesheet" type="text/css" href="js/jquery-easyui-1.5.4/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="js/jquery-easyui-1.5.4/themes/icon.css">
    <script type="text/javascript" src="js/jquery-easyui-1.5.4/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-easyui-1.5.4/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="js/jquery-easyui-1.5.4/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        $(function () {
            showAllProjects();

        });

        //所有项目
        function showAllProjects() {
            $('#dg').datagrid({
                url: 'showAllprojects.do?sort=all',
                width: 'auto',
                columns: [[
                    {field: 'project_name', title: '项目名称', width: 140, align: 'center'},
                    {field: 'starttime', title: '开始时间', width: 100, align: 'center'},
                    {field: 'endtime', title: '结束时间', width: 100, align: 'center'},
                    {field: 'trueendtime', title: '实际结束时间', width: 100, align: 'center'},
                    {field: 'person_name', title: '创建者', width: 80, align: 'center'},
                    {field: 'createtime', title: '创建时间', width: 100, align: 'center'},
                    {field: 'flag', title: '状态', width: 80, align: 'center'}
                ]],
                pagination: true,
                striped: true,
                singleSelect: true,
                rownumbers: true,
                pageSize: 20,
                pagePosition: 'top',

            });
        }

        //未开始
        function notStart() {
            $('#dg').datagrid({
                url: 'showAllprojects.do?sort=notStart',
                width: 'auto',
                columns: [[
                    {field: 'project_name', title: '项目名称', width: 140, align: 'center'},
                    {field: 'starttime', title: '开始时间', width: 100, align: 'center'},
                    {field: 'endtime', title: '结束时间', width: 100, align: 'center'},
                    {field: 'trueendtime', title: '实际结束时间', width: 100, align: 'center'},
                    {field: 'person_name', title: '创建者', width: 80, align: 'center'},
                    {field: 'createtime', title: '创建时间', width: 100, align: 'center'},
                    {field: 'flag', title: '状态', width: 80, align: 'center'}
                ]],
                pagination: true,
                striped: true,
                singleSelect: true,
                rownumbers: true,
                pageSize: 20,
                pagePosition: 'top'
            });
        }

        //进行中
        function onGoing() {
            $('#dg').datagrid({
                url: 'showAllprojects.do?sort=onGoing',
                width: 'auto',
                columns: [[
                    {field: 'project_name', title: '项目名称', width: 140, align: 'center'},
                    {field: 'starttime', title: '开始时间', width: 100, align: 'center'},
                    {field: 'endtime', title: '结束时间', width: 100, align: 'center'},
                    {field: 'trueendtime', title: '实际结束时间', width: 100, align: 'center'},
                    {field: 'person_name', title: '创建者', width: 80, align: 'center'},
                    {field: 'createtime', title: '创建时间', width: 100, align: 'center'},
                    {field: 'flag', title: '状态', width: 80, align: 'center'}
                ]],
                pagination: true,
                striped: true,
                singleSelect: true,
                rownumbers: true,
                pageSize: 20,
                pagePosition: 'top',
                onDblClickCell: function (index, field, value) {
                    if (field === 'project_name') {
                        closeProject(value);
                    }
                }
            });
        }

        //已结束
        function finished() {
            $('#dg').datagrid({
                url: 'showAllprojects.do?sort=finished',
                width: 'auto',
                columns: [[
                    {field: 'project_name', title: '项目名称', width: 140, align: 'center'},
                    {field: 'starttime', title: '开始时间', width: 100, align: 'center'},
                    {field: 'endtime', title: '结束时间', width: 100, align: 'center'},
                    {field: 'trueendtime', title: '实际结束时间', width: 100, align: 'center'},
                    {field: 'person_name', title: '创建者', width: 80, align: 'center'},
                    {field: 'createtime', title: '创建时间', width: 100, align: 'center'},
                    {field: 'flag', title: '状态', width: 80, align: 'center'}
                ]],
                pagination: true,
                striped: true,
                singleSelect: true,
                rownumbers: true,
                pageSize: 20,
                pagePosition: 'top',
                onDblClickCell: function (index, field, value) {
                    if (field === 'project_name') {
                        deleteProject(value);
                    }
                }
            });
        }

        //已删除
        function deleted() {
            $('#dg').datagrid({
                url: 'showAllprojects.do?sort=deleted',
                width: 'auto',
                columns: [[
                    {field: 'project_name', title: '项目名称', width: 140, align: 'center'},
                    {field: 'starttime', title: '开始时间', width: 100, align: 'center'},
                    {field: 'endtime', title: '结束时间', width: 100, align: 'center'},
                    {field: 'trueendtime', title: '实际结束时间', width: 100, align: 'center'},
                    {field: 'person_name', title: '创建者', width: 80, align: 'center'},
                    {field: 'createtime', title: '创建时间', width: 100, align: 'center'},
                    {field: 'flag', title: '状态', width: 80, align: 'center'}
                ]],
                pagination: true,
                striped: true,
                singleSelect: true,
                rownumbers: true,
                pageSize: 20,
                pagePosition: 'top'
            });
        }

        //强制结束
        function closeProject(name) {
            document.getElementById("main").innerHTML = "<h3 style=\"color: #00bbee\" align=\"center\">确定结束该项目吗？</h3>";
            $('#main').dialog({
                title: '强制结束项目',
                width: 400,
                height: 200,
                closed: false,
                cache: false,
                buttons: [{
                    text: '确定',
                    handler: function () {
                        $.ajax({
                            url: 'updateFlag.do?flag=3&name=' + name,
                            success: function (isupdated) {
                                if (isupdated) {
                                    onGoing();
                                    $('#main').window('close');
                                }
                            }
                        })
                    }
                }, {
                    text: '待定',
                    handler: function () {
                        onGoing();
                        $('#main').window('close');
                    }
                }]

            });
        }

        //删除
        function deleteProject(name) {
            document.getElementById("main").innerHTML = "<h3 style=\"color: #00bbee\" align=\"center\">确定删除该项目吗？</h3>";
            $('#main').dialog({
                title: '删除项目',
                width: 400,
                height: 200,
                closed: false,
                cache: false,
                buttons: [{
                    text: '确定',
                    handler: function () {
                        $.ajax({
                            url: 'updateFlag.do?flag=4&name=' + name,
                            success: function (isupdated) {
                                if (isupdated) {
                                    finished();
                                    $('#main').window('close');
                                }
                            }
                        })
                    }
                }, {
                    text: '待定',
                    handler: function () {
                        finished();
                        $('#main').window('close');
                    }
                }]

            });
        }
        //审核通过
        function checked() {
            $('#dg').datagrid({
                url: 'check.do?state=2',
                width: 'auto',
                columns: [[
                    {field: 'person_name', title: '姓名', width: 70, align: 'center'},
                    {field: 'person_account', title: '账户', width: 100, align: 'center'},
                    {field: 'person_address', title: '地址', width: 350, align: 'center'},
                    {field: 'person_type', title: '用户类型', width: 70, align: 'center'},
                    {field: 'person_flag', title: '审核状态', width: 80, align: 'center'}
                ]],
                pagination: true,
                striped: true,
                singleSelect: true,
                rownumbers: true,
                pageSize: 20,
                pagePosition: 'top'
            });
        }

        //模糊查询
        function vagueQuery() {

            $('#dg').datagrid({
                url: 'poVagueQuery.do?name=%25' + $('#vg').val() + '%25',
                width: 'auto',
                columns: [[
                    {field: 'project_name', title: '项目名称', width: 140, align: 'center'},
                    {field: 'starttime', title: '开始时间', width: 100, align: 'center'},
                    {field: 'endtime', title: '结束时间', width: 100, align: 'center'},
                    {field: 'trueendtime', title: '实际结束时间', width: 100, align: 'center'},
                    {field: 'person_name', title: '创建者', width: 80, align: 'center'},
                    {field: 'createtime', title: '创建时间', width: 100, align: 'center'},
                    {field: 'flag', title: '状态', width: 80, align: 'center'}
                ]],
                pagination: true,
                striped: true,
                singleSelect: true,
                rownumbers: true,
                pageSize: 20,
                pagePosition: 'top'
            });
        }
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'west',title:'查看分类',split:true" style="width:300px;height:auto;">
    <div id="aa" class="easyui-accordion" style="width:300px;height:200px;">
        <div title="项目分类" style="overflow:auto;padding:10px" data-options="selected:true">
            <p>
                <button onclick="notStart()">未开始</button>
                <button onclick="onGoing()">进行中</button>
            </p>
            <p>
                <button onclick="finished()">已结束</button>
                <button onclick="deleted()">已删除</button>
            </p>
            （关闭或删除项目请双击项目名）
        </div>
        <div title="模糊查询">
            <h3 style="color: #00bbee">请输入项目名字段：</h3>
            <input type="text" id="vg" onchange="vagueQuery()"/>
        </div>
    </div>
</div>
<div id="qw" data-options="region:'center',title:'项目'" style="padding:5px;background:#eee;">
    <a id="btn" href="#" onclick="showAllProjects()" class="easyui-linkbutton"
       data-options="iconCls:'icon-search'">所有项目</a>

    <table id="dg"></table>
    <div id="main"></div>
</div>
