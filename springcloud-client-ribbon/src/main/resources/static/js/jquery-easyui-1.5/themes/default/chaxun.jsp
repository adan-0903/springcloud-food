<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<!-- css -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/js/jquery-easyui-1.5/themes/black/easyui.css"></link>
<link rel="stylesheet" href="<%=request.getContextPath() %>/js/jquery-easyui-1.5/themes/icon.css"></link>
<!--  js -->
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-easyui-1.5/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
<body>
	<!-- 新增框 -->
	<div id="dd" class="easyui-dialog" style="width:300px;height:300px"
		data-options="title:'My Dialog',buttons:'#bb',modal:true,closed:true,">
		 	<form id="addFrom">
	         		<table>
	         			<tr>
	         				<td>停车场</td>
	         				<td>
	         					<input name="parkid" class="easyui-combobox"    
   									 data-options="valueField:'park_typeid',textField:'parkname',url:'<%=request.getContextPath() %>/park/xiala.do'" />
	         				</td>
	         			</tr>
	         			<tr>
	         				<td>车位名称</td>
	         				<td>
	         					<input type="hidden" name="lotid">
	         					<input name="lotname" class="easyui-textbox">
	         				</td>
	         			</tr>
	         			<tr>
	         				<td>价格</td>
	         				<td>
	         					<input name="lotprice" class="easyui-textbox">
	         				</td>
	         			</tr>
	         		</table>
	         </form>
		</div>
		<div id="bb">
		<a href="javascript:addinsert()" class="easyui-linkbutton">保存</a>
	</div>
	<!-- 条查 -->
	停车场: <input id="xiala" class="easyui-combobox"    
   			 data-options="valueField:'park_typeid',textField:'parkname',url:'<%=request.getContextPath() %>/park/xiala.do'" />
   	用户名/车牌号:<input id="nameorpai" class="easyui-textbox">
   	车位价格 : <input id="kaishi" class="easyui-textbox"> ----- <input id="jieshu" class="easyui-textbox">
   	<a  href="javascript:tc()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a> 
   	<a  href="javascript:getadd()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加车位</a>
   	<a  href="javascript:deleteAllUser()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">批量删除</a>
   	<!-- 查询 -->
	<table id="dg"></table>
</body>
<script type="text/javascript">
 // 查询 
$('#dg').datagrid({    
    url:'<%=request.getContextPath()%>/park/getquary.do',    
    columns:[[    
        {field:'checkbox',checkbox:true},    
        {field:'lotid',title:'序号',width:100},    
        {field:'lotname',title:'车位名称',width:100},    
        {field:'nickname',title:'用户名',width:100},    
        {field:'carnumber',title:'车牌号',width:100},    
        {field:'lotprice',title:'价格',width:100,formatter:function(value,rows,index){
        	return value+"万元";
        }},    
        {field:'lotstatus',title:'状态',width:100,formatter:function(value,rows,index){
        	if (value == 2) {
				return "已售出";
			}
        	if (value == 1) {
				return "闲置";
			}
        }},    
        {field:'dasgasg',title:'操作',width:100,formatter:function(value,rows,index){
        	if (rows.lotstatus == 2) {
				return "已售出"+'<input type="button" value="删除" onclick="deleteUser('+rows.lotid+')">';
			}
        	if (rows.lotstatus == 1) {
				return '<input type="button" value="购买" onclick="goumai('+rows.lotid+')">'+'<input type="button" value="删除" onclick="deleteUser('+rows.lotid+')">';
			}
        }},    
    ]],
    fitColumns:true,
    pagination:true,
    pageList:[2,4,6,8,10],
    pageSize:10,
});
// 条查  
 function tc(){
	 $('#dg').datagrid('load', {    
		 	parkid:$("#xiala").combobox("getValue"),    
		 	nickname:$("#nameorpai").textbox("getValue"),    
		 	kaishi:$("#kaishi").textbox("getValue"),    
		 	jieshu:$("#jieshu").textbox("getValue"),    
		});
}
//开启 新增 框 
 function getadd(){
	 $('#addFrom').form('clear');
	 $('#dd').dialog({    
		    title:'新增',    
		    closed: false,    
		});
}
//关闭 新增 框 
 function getguan(){
	 $('#dd').dialog({    
		    title:'新增',    
		    closed:true,    
		});
}
// 新增 保存
function addinsert(){
	$('#addFrom').form('submit', {    
	    url:"<%=request.getContextPath()%>/park/addinsert.do",    
	    success:function(data){ 
	    	alert(data);
	    	if (data == "新增成功") {
	    		getguan();
		    	tc();
			}
	    }    
	}); 
}
// 修改 回显 
function goumai(id){
	$('#dd').dialog({
	    title:'购买',
	    closed: false,    
	});
	$('#addFrom').form('load','<%=request.getContextPath()%>/park/gethuixian.do?id='+id);
}
//批量删除
function deleteAllUser(){
	var arr = $("#dg").datagrid("getChecked");
	var str="";
	for (var i = 0; i < arr.length; i++) {
			str += ","+arr[i].lotid;
	}
	var ids = str.substr(1);
	$.ajax({
		url:"<%=request.getContextPath()%>/park/deleteUser.do",
		type:"get",
		data:{ids:ids},
		success:function(){
			alert("删除成功！");
			tc();
		}
	})
}
//单删除 
function deleteUser(id){
	$.messager.confirm('确认','您确认想要删除记录吗？',function(r){    
		if (r){    
			$.ajax({
				url:"<%=request.getContextPath()%>/park/deleteUser.do",
				type:"get",
				data:{ids:id},
				success:function(){
					alert("删除成功！");
					tc();
				}
			})
       
		}    
	}); 
}
</script>
</html>