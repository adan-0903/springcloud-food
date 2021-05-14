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
	<form id="addFrom">
	         		<table>
	         			<tr>
	         				<td>转账人</td>
	         				<td>
	         					<input name="zhuanZhangUser" class="easyui-textbox">
	         				</td>
	         			</tr>
	         			<tr>
	         				<td>转账账号</td>
	         				<td>
	         					<input name="code" class="easyui-textbox">
	         				</td>
	         			</tr>
	         			<tr>
	         				<td>转账金额</td>
	         				<td>
	         					<input name="money" class="easyui-textbox">
	         				</td>
	         			</tr>
	         			<tr>
	         				<td>收账人</td>
	         				<td>
	         					<input name="shoukuanUser" class="easyui-textbox">
	         				</td>
	         			</tr>
	         			<tr>
	         			<tr>
				<td>购买数量</td>
				<td>
					<input id='setPrice' class="easyui-numberbox"  name="getprice">
				</td>
			  </tr>
			  <tr>
				<td>作曲</td>
				<td>
					<input class="easyui-textbox" name="musicname">
				</td>
			  </tr>
			  <tr>
				<td>价格</td>
				<td>
					<input id='tprice' class="easyui-textbox"  name="tprice">
				</td>
			  </tr>
			  <tr>
				<td>实付价格</td>
				<td>
					<input class="easyui-textbox" name="ppprice">
				</td>
			  </tr>
	         				<td>收账卡号</td>
	         				<td>
	         					<input name="skCode" class="easyui-textbox">
	         					<input id="dong" class="easyui-combobox"   
    data-options="valueField:'tid',textField:'typename',url:'<%=request.getContextPath() %>/music/dongtai.do'" /> 
    <input id="cc" class="easyui-combobox"  
    data-options="valueField:'id',textField:'text',url:'get_data.php'" /> 
	         				</td>
	         			</tr>
	         			<tr>
	         				<td>请输入密码</td>
	         				<td>
	         					<input name="sjadb" class="easyui-textbox">
	         				</td>
	         			</tr>
	         			<tr>
	         				<td>请确认密码</td>
	         				<td>
	         					<input name="asdasda" class="easyui-textbox">
	         					<input name="userer" type="text" value="${user.user_name }">
	         				</td>
	         			</tr>
	         		</table>
	         </form>
	         <a href="javascript:addinsert()" class="easyui-linkbutton">保存</a>
</body>
<script type="text/javascript">
	//新增 保存
	function addinsert(){
		$('#addFrom').form('submit', {    
		    url:"<%=request.getContextPath()%>/bank/addinsert.do",  
		    type:"post",
		    success:function(data){ 
		    	alert(data);
		    }    
		}); 
	}
	$("#setPrice").numberbox({
		onChange:function(newValue,oldValue){
			$('#setPrice').numberbox('setValue', newValue);
			console.log($("#setPrice").numberbox('getValue'))
			$("#tprice").textbox({
				value:newValue*30
			})
		}
	})
	$("#dong").combobox({
		onSelect:function(record){
			/* console.log(record)
			document.write(record)
			alert(record) */
			if(record.tid == 1){
				$("#newtypeBox").show();
			}else{
				$("#newtypeBox").hide();
			}				
		}
	})
</script>
</html>