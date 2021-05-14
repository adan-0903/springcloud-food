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
<body class="easyui-layout">   
    <div data-options="region:'north',title:'North Title',split:true" style="height:100px;">
    	用户:${user.username }      
    	余额:${user.balance }
    </div>   
    <div data-options="region:'west',title:'West',split:true" style="width:20%;">
    		<div  class="easyui-accordion" style="width:300px;height:200px;">   
			    <div title="练习" data-options="iconCls:'icon-save'" style="overflow:auto;padding:10px;">  
			    	 <ul id="tree"></ul>
			    </div>   
			</div> 
    </div>   
    <div data-options="region:'center',title:'center title'" style="padding:5px;background:#eee;">
    	<div id="tt" class="easyui-tabs" style="width:100%;height:100%;">   
		    <div title="首页" style="padding:20px;display:none;">   
		         	首页
		    </div>   
		</div>  
    </div>   
</body>
<script type="text/javascript">
$('#tree').tree({    
    url:'<%=request.getContextPath()%>/park/tree.do',   
    	onClick: function(node){
    		if (node.url != null) {
	    			var aa=$("#tt").tabs("exists",node.text)
	        		if(aa){
	        			$("#tt").tabs("select",node.text)
	        		}else{
	        		$('#tt').tabs('add',{    
	        		    title:node.text, /* //保持一致 */   
	        		    content:createpage(node.url),    
	        		    closable:true,    
	        		    tools:[{  
	        		        iconCls:'icon-mini-refresh',    
	        		        handler:function(){    
	        		        	var tab = $('#tt').tabs('getSelected');  // 获取选择的面板
	        		        	$('#tt').tabs('update', {
	        		        		tab: tab,
	        		        		options: {
	        		          		    content:createpage(node.url),   
	        		        		}
	        		        	});
	        		        }    
	        		    }]   
	        		}); 
        		}
			}
    	}		
    })

	function  createpage(url){
		return '<iframe frameborder="0" scrolling="auto" style="width:100%;height:100%"  src="<%=request.getContextPath() %>/path/'+url+'"></iframe>';
	}
</script>
</html>