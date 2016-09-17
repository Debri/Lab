<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>实验室后台</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="${pageContext.request.contextPath}/javaScript/jQueryEasyUI/themes/icon.css"	type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/javaScript/jQueryEasyUI/themes/metro/easyui.css" type="text/css"></link>
<script type="text/javascript"	src="${pageContext.request.contextPath}/javaScript/jquery-1.8.0.min.js"></script>
<SCRIPT type="text/javascript" src="${pageContext.request.contextPath}/javaScript/jQueryEasyUI/jquery.easyui.min.js"></SCRIPT>
<script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/jQueryEasyUI/datagrid-detailview.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/jQueryEasyUI/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	function mainLogin(){
		//ajax提交方式,并采用表单验证(表单验证一般在注册时才用)
		if($('#main-loginForm').form('validate')){
			$.ajax({
			url:'',
			data:{
				//获取input中对应名字的值
				userId:$('#main-loginForm input[name=userId]').val(),
				password:$('#main-loginForm input[name=password]').val()
			},
			dataType:'json',
			success:function(obj,textStatus,jqXHR){
				//登陆成功后的操作，如	关闭dialog messager提示
				//json数据	
				if(obj.success){
					$('#main-loginDialog').dialog('close');
				}
				$.messager.show({
					title:'提示',
					msg:obj.msg,
					timeout:500,
					showType:'slide'
				});
			} 
		});
		}
	}
</script>
</head>

<body class="easyui-layout">
	   
	 <div data-options="region:'north',split:false,border:false" style="height:60px;border-bottom:0px">
    	<jsp:include page="top.jsp"></jsp:include>
    </div>  
    <div data-options="region:'south',split:false,border:false" style="height:36px">
    	<jsp:include page="bottom.jsp"></jsp:include>
    </div>  
    
    <div data-options="region:'west',title:'管理导航',split:false" style="width:200px;border-right:0px">
   		<jsp:include page="left.jsp"></jsp:include>
    </div> 
    <div data-options="region:'center'">
		  	<jsp:include page="center.jsp"></jsp:include>
    </div>
    
</body>
</html>
