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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/js/uploadify/uploadify.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/js/uploadify/jquery.uploadify.min.js"></script>
<body>
	姓名: <input id="b_user_id" class="easyui-textbox"  style="width:150px">
   	卡号:<input id="b_user_code" class="easyui-textbox">
   	日期:<input  id="kaishi"  type= "text" class= "easyui-datebox" >----<input  id="jieshu"  type= "text" class= "easyui-datebox">
   	<a  href="javascript:tc()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a> 
	<table id="dg"></table>
</body>
<script type="text/javascript">
	//查询 
	$('#dg').datagrid({    
	    url:'<%=request.getContextPath()%>/bank/getquary.do',    
	    columns:[[    
	        {field:'checkbox',checkbox:true},    
	        {field:'id',title:'编号',width:100},    
	        {field:'b_user_id',title:'用户名称',width:100},    
	        {field:'b_user_code',title:'用户卡号',width:100},    
	        {field:'b_user_password',title:'密码',width:100},    
	        {field:'b_type',title:'用户类型',width:100,formatter:function(value,rows,index){
	        	if (value == 2) {
					return "已售出";
				}
	        	if (value == 1) {
					return "闲置";
				}
	        }},   
	        {field:'create_date',title:'开户日期',width:100}, 
	        {field:'b_account_balance',title:'账户余额',width:100}, 
	        {field:'user_birthday',title:'用户生日',width:100}
	    ]],
	    fitColumns:true,
	    pagination:true,
	    pageList:[2,4,6,8,10],
	    pageSize:10,
	});
	// 条查  
	 function tc(){
		alert(111)
		 $('#dg').datagrid('load', {    
			 b_user_id:$("#b_user_id").textbox("getValue"),    
			 b_user_code:$("#b_user_code").textbox("getValue"),    
			 	kaishi:$("#kaishi").datebox("getValue"),    
			 	jieshu:$("#jieshu").datebox("getValue"),    
			});
	}
</script>
</html>