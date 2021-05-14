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
<body>
<!-- 导入excel弹框 -->
	<div id="daorutankuang" class="easyui-dialog" data-options="title:'导入信息',closed:true,modal:true">
		<form id="daoruform" method="post" enctype="multipart/form-data">
			<!-- 我们需要向后台传一个excel文件，name为filename -->
		  	<input class="easyui-filebox" name="filename" data-options="buttonText:'选择文件'" style="width:300px">
		</form>
	  	<a onclick="javascript:daoru()" class="easyui-linkbutton">提交</a>
	</div>
		转账人<input class="easyui-textbox"  id="zhuanZhangUser">
		收款人<input class="easyui-textbox" id="shoukuanUser">
		开始价格<input class="easyui-textbox" id="startprice">
		-<input class="easyui-textbox" id="endprice">
		转账日期<input  id="stime"  type= "text" class= "easyui-datebox" required ="required"> </input> -<input  id="etime"  type= "text" class= "easyui-datebox" required ="required"> </input> 
		<a class="easyui-linkbutton" data-options="iconCls:'icon-search'"  onclick="javascript:tc()">搜索</a> 
		<a class="easyui-linkbutton" href="javascript:importData()">导入</a> 
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'"   
        onclick="javascript:daobook()">导出</a> 
        <a  class="easyui-linkbutton" data-options="iconCls:'icon-no'"   
        onclick="javascript:delAll()">批删</a>
	<table id="dg"></table>
</body>
<script type="text/javascript">
function delAll(){
	var aa=$('#dg').datagrid("getChecked");
	var arr=[];
	for (var i = 0; i < aa.length; i++) {
		arr+=arr==""?aa[i].id:","+aa[i].id
	}
	alert(arr)
	$.ajax({
		url:"<%=request.getContextPath()%>/bank/delAll.do",
		data:{id:arr},
		type:"post",
		success:function(){
			tc();
		}
	})
}
	//查询 
	$('#dg').datagrid({    
	    url:'<%=request.getContextPath()%>/bank/getMongodbQuery.do',    
	    columns:[[    
	        {field:'checkbox',checkbox:true},    
	        {field:'id',title:'编号',width:100},    
	        {field:'zhuanZhangUser',title:'转账人',width:100},    
	        {field:'money',title:'转账金额',width:100},    
	        {field:'code',title:'转账卡号',width:100},    
	        {field:'shoukuanUser',title:'收款人',width:100}, 
	        {field:'skCode',title:'收款卡号',width:100}, 
	        {field:'createDate',title:'转账日期',width:100}
	    ]],
	    fitColumns:true,
	    pagination:true,
	    pageList:[2,4,6,8,10],
	    pageSize:10,
	});
	// 条查  
	 function tc(){
		 $('#dg').datagrid('load', {    
				zhuanZhangUser:$("#zhuanZhangUser").textbox("getValue"),    
			 	shoukuanUser:$("#shoukuanUser").textbox("getValue"),    
			 	startprice:$("#startprice").textbox("getValue"),    
			 	endprice:$("#endprice").textbox("getValue"),    
			 	stime:$("#stime").datebox("getValue"),    
			 	etime:$("#etime").datebox("getValue"),    
			});
	}
	//开启弹框，以便选择文件
		function importData(){//打开导入弹框：上传excel
			$("#daorutankuang").dialog("open");
		}
		//导入：上传+导入
		function daoru(){
			$("#daoruform").form("submit",{		//修改一下请求父路径（gongsi）
				url:"<%=request.getContextPath()%>/bank/importData.do",
				success:function(){
					$.messager.alert("提示","导入成功！","info");
					$("#daorutankuang").dialog("close");//关闭弹框
					$('#myTable').datagrid("load");//刷新表格
				}
			});
		}
		daobook=function(){
			location.href="<%=request.getContextPath()%>/bank/daobook.do"
		}
</script>
</html>