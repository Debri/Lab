<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>实验室系统</title>
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
	var userId = '${sessionScope.user.userId}';
	//初始化form
	$(function(){
		//判断session
		if(userId == ""){
			window.location.href='${pageContext.request.contextPath}/index.jsp';
		}
		//
		$(".tabs").css({"font-size":"13px","font-family":"宋体","font-weight":"bold"});
		$(".tabs li").css("margin-left","10px");
		$(".tabs li：first").css("margin-left","48px");
		
		//实验室公告
		$("#student_announce_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Announce_getAnnounce',
			fitColumns:true,
			fit:true,
			border:true,
			pagination:true,
			idField:'id',
			sortName:'addTime',
			sortOrder:'desc',
			pageList:[15],
			showHeader:true,
			singleSelect:true,
			columns : [[{
				field : 'id',
				hidden:true,
				align:'center'
			},{
				field : 'title',
				title : '公告标题',
				width : 300,
				align:'left',
				formatter:function(value,row,index){
					return '<span style="cursor:pointer;color:#8080C0;" onclick="student_lookForAnnounce(\''+row.id+'\');">'+row.title+'</span>';
				}
			},{
				field : 'addTime',
				title : '发布时间',
				width : 80,
				align:'left',
				sortable:true
			},{
				field : 'userName',
				width : 80,
				hidden:true
			},{
				field : 'url',
				width : 80,
				hidden:true
			},{
				field : 'name',
				title : '附件名称',
				width : 80,
				hidden:true
			}]]
		});
	});
	
	//查看公告信息
	function student_lookForAnnounce(id){
		$('<div/>').dialog({
			title: '公告信息',  
		    width: 600,  
		    height: 480,  
		    href: '${pageContext.request.contextPath}/announceInfo.jsp?id='+id,  
		    modal: true,
		    onClose:function(){
		    	$(this).html('');
		    	$(this).dialog('destory');
		    }
		});
	}
	function student_studentIndex_logout(){
		//ajax提交方式,并采用表单验证(表单验证一般在注册时才用)
		var userId = '${sessionScope.user.userId}';
		$.messager.confirm('确定','你确定要退出系统吗?',function(r){
			if(r){
				$.ajax({
					url:'${pageContext.request.contextPath}/User_logout?userId='+userId,
					type:'post',
					dataType:'json',
					success:function(obj){
						//登陆成功后的操作，如	关闭dialog messager提示
						//json数据	
						if(obj){
							window.location.href='${pageContext.request.contextPath}/index.jsp';
						}else{
							$.messager.show({
								title:'温馨提示',
								msg:'你已经不是登陆状态了,谢谢!'
							});
						}
					}
				});
			}
		});
	}
	//添加tabs(成功)
	function addTabs(id,name,title,url) {
		var t1 = name + title;
		//加上自己的sessionid可查出自己的作业
		var url1 = '${pageContext.request.contextPath}/student/'+url+'.jsp'+'?id='+id;
 		var t = $('#student_studentCourse_tabs');
 		if (t.tabs('exists', t1)) {
 			t.tabs('select', t1);
 		} else {
			t.tabs('add',{
				title:t1,
				href:url1,
				closable : true
			});
		}
	}
	
	//查看个人信息
	function student_studentIndex_myInfo(){
		$('<div/>').dialog({
			title: '我的信息',  
		    width: 430,  
		    height: 232,  
		    href: '${pageContext.request.contextPath}/student/myInfo.jsp',  
		    modal: true,
		    buttons:[{
		    	text:'保存',
		    	handler:function(){
		    		$.messager.confirm('请确认','你确定要保存该修改吗?',function(data){
		    			if(data){
		    				$.ajax({
				    			url:'${pageContext.request.contextPath}/student/User_updateUser',
				    			type:'post',
				    			data:$("#student_myInfo_form").serializeArray(),
				    			dataType:'json',
				    			success:function(obj){
				    				if(obj){
				    					$.messager.show({
				    						title:'提示',
				    						msg:'恭喜你,保存成功!'
				    					});
				    				}else{
				    					$.messager.show({
				    						title:'提示',
				    						msg:'对不起,修改失败!'
				    					});
				    				}
				    			}
				    		});
		    			}else{
		    				$.messager.show({
	    						title:'提示',
	    						msg:'已被取消!'
	    					});
		    			}
		    		});
		    	}
		    }],
		    onClose:function(){
		    	$(this).html('');
		    	$(this).dialog('destory');
		    }
		});
	}
</script>
</head>
<body style="margin:0;padding:0;text-align:center;font-size:12px;background-color:#FFFFFF;">
	<div style="margin:0 auto;width:1024px;min-height:720px;">
		<%--logo部分，里面放logo和用户状态信息 --%>
		<div style="height:124px;width:1024px;background:url(${pageContext.request.contextPath}/images/h1.gif);">
			<div  style="float:right;height:22px;width:320px;margin-top:102px;">
				<span style="color: rgb(0, 136, 204);cursor:pointer" onclick="student_studentIndex_myInfo();">${sessionScope.user.userName }</span>&nbsp;您好&nbsp;|身份-${sessionScope.user.type}&nbsp;&nbsp;<a style="cursor:pointer;color:rgb(0, 136, 204)" onclick="student_studentIndex_logout();">退出</a>
				&nbsp;&nbsp;<a style="color:green; text-decoration: none;" href="../manual/html/student.html">使用手册</a>
			</div>
		</div>
		<%--panel部分,里面是一个个的tab或panel --%>
		<div class="easyui-panel">
			<div id="index-tabs" class="easyui-tabs" data-options="border:false" style="height:508px;padding:2px;">
	    		 <div title="实验室首页" style="padding:2px;">
	    		 	<%--实验室图片 --%>
					<div  class="easyui-panel" data-options="border:false">
						<div class="easyui-layout" style="height:468px;">
							<div data-options="region:'center',border:false" style="width:420px;">
								<jsp:include page="../img.jsp"></jsp:include>
							</div>
							<div data-options="region:'west',title:'实验室公告',border:false" style="padding:2px;width:460px;">
								<table id="student_announce_datagrid"></table>
							</div>
						</div>
					</div>
	    		 </div>
	    		 <div title="上机任务" data-options="href:'${pageContext.request.contextPath}/student/studentCourse.jsp'" style="padding:2px;"></div>
	    		 <div title="学习资料" data-options="href:'${pageContext.request.contextPath}/student/material.jsp'" style="padding:2px;"></div>
	    		 <div title="软件下载" data-options="href:'${pageContext.request.contextPath}/student/softWare.jsp' ,tools:[{
				        iconCls:'icon-mini-refresh',
				        handler:function(){
				           $('#student_softWare_datagrid').datagrid('load',{});
				           $('#student_softWare_datagrid').datagrid('unselectAll');
				        }
				    }]" style="padding:2px;">
				 </div>
    		</div>
		</div>
		<%--网站的footer --%>
		<div style="height:112px;border:1px #FFFFFF solid;background:url(${pageContext.request.contextPath}/images/foot.jpg)">
			<div style="height:18px;margin-top:64px;font-size:13px;text-align:left;font-weight:bold;">+&nbsp;相关链接</div>
			<div style="height:18px;margin:8px;font-size:12px;text-align:left;">
				<span><a href="http://172.22.4.16" target="_blank">极客网</a></span>
				<span style="margin-left:12px;"><a href="http://172.22.4.29:8000" target="_blank">技能认证</a></span>
				<span style="margin-left:12px;"><a href="http://172.22.4.29" target="_blank">开放上机</a></span><span style="margin-left:12px;"><a href="http://202.202.43.125" target="_blank">网址大全</a></span>		
			</div>
		</div>
		<div style="height:18px;"><span style="align:center;">版权所有&nbsp;&nbsp;极客网工作室</span></div>
	</div>
</body>
</html>
