<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>用户管理</title>
    <link rel="stylesheet" type="text/css" href="js/jquery-easyui-1.5.4/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="js/jquery-easyui-1.5.4/themes/icon.css">
    <script type="text/javascript" src="js/jquery-easyui-1.5.4/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-easyui-1.5.4/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="js/jquery-easyui-1.5.4/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        $(function () {
            showAllUser();
        });

        //所有用户
        function showAllUser() {
            $('#dg').datagrid({
                url: 'showAllUser.do',
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

        //工人查询
        function queryWorker() {
            $('#dg').datagrid({
                url: 'showUserByRole.do?role=工人',
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

        //查看工头
        function queryForeman() {
            $('#dg').datagrid({
                url: 'showUserByRole.do?role=工头',
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

        //查看农户
        function queryFarmer() {
            $('#dg').datagrid({
                url: 'showUserByRole.do?role=农户',
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

        //待审核
        function unchecked() {
            $('#dg').datagrid({
                url: 'check.do?state=1',
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
                pagePosition: 'top',
                onDblClickCell: function (index, field, value) {
                    if (field === 'person_account') {
                        updateCheck(value);
                    }
                }
            });
        }

        //审核
        function updateCheck(account) {
            document.getElementById("main").innerHTML = "<h3 style=\"color: #00bbee\" align=\"center\">确定通过审核吗？</h3>";
            $('#main').dialog({
                title: '确认审核',
                width: 400,
                height: 200,
                closed: false,
                cache: false,
                buttons: [{
                    text: '确定',
                    handler: function () {
                        $.ajax({
                            url: 'updCheck.do?account=' + account,
                            success: function (flag) {
                                if (flag) {
                                    unchecked();
                                    $('#main').window('close');
                                }
                            }
                        })
                    }
                }, {
                    text: '待定',
                    handler: function () {
                        unchecked();
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
                url: 'vagueQuery.do?name=%25' + $('#vg').val() + '%25',
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
    </script>
</head>
<body class="easyui-layout">
<div data-options="region:'west',title:'查看分类',split:true" style="width:300px;height:auto;">
    <div id="aa" class="easyui-accordion" style="width:300px;height:200px;">
        <div title="角色分类" style="overflow:auto;padding:10px" data-options="selected:true">
            <p>
                <button onclick="queryWorker()">工人</button>
            </p>
            <p>
                <button onclick="queryForeman()">工头</button>
            </p>
            <p>
                <button onclick="queryFarmer()">农户</button>
            </p>
        </div>
        <div title="审核状态" style="padding:10px;">
            <p>
                <button onclick="unchecked()">待审核</button>
                （确定审核对象后请双击账户）
            </p>
            <p>
                <button onclick="checked()">已审核</button>
            </p>
        </div>
        <div title="模糊查询">
            <h3 style="color: #00bbee">请输入用户名字段：</h3>
            <input type="text" id="vg" onchange="vagueQuery()"/>
        </div>
    </div>
</div>
<div id="qw" data-options="region:'center',title:'用户'" style="padding:5px;background:#eee;">
    <a id="btn" href="#" onclick="showAllUser()" class="easyui-linkbutton"
       data-options="iconCls:'icon-search'">所有用户信息</a>

    <table id="dg"></table>
    <div id="main"></div>
</div>
