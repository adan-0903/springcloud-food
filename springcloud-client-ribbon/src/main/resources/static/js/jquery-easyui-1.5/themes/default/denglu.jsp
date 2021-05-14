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
	<div class="easyui-dialog" style="width:300px;height:200px"
		data-options="title:'用     户       登         录',buttons:'#bb',modal:true">
		 	<form id="loginForm">
		 			<table>
				 		<tr>
				 			<td>用户名</td>
				 			<td>
				 				<input name="username" class="easyui-textbox" data-options="iconCls:'icon-search'"> 
				 			</td>
				 		</tr>
				 		<tr>
				 			<td>密码</td>
				 			<td>
				 				<input name="password" class="easyui-passwordbox" prompt="Password" iconWidth="28"> 
				 			</td>
				 		</tr>
				 		<tr>
				 			<td>验证码</td>
				 			<td>
				 				<input name="useryan" class="easyui-textbox" >
				 				<img id="yanzheng1" onclick="yanzheng()"  src="<%=request.getContextPath() %>/park/yanzheng.do">
				 			</td>
				 		</tr>
				 	</table>
		 	</form>
		</div>
		<div id="bb">
		<a href="javascript:login()" class="easyui-linkbutton">登录</a>
	</div>
</body>
<script type="text/javascript">
function login(){
	$('#loginForm').form('submit', {    
	    url:"<%=request.getContextPath()%>/park/login.do",    
	    success:function(data){ 
	    	alert(data);
	        if (data == "登录成功") {
				location.href="<%=request.getContextPath()%>/show.jsp";
			}   
	    }    
	}); 
}
	function yanzheng(){
		$("#yanzheng1").prop("src","<%=request.getContextPath() %>/park/yanzheng.do?"+new Date().getTime())
	}
</script>
</html>