<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>实验室系统主页</title>
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
	//初始化form
	$(function(){
		//兼容提示
		$.messager.show({
			title:'提示',
			msg:'亲,请不要使用 IE6 噢!'
		});
		
		$(".tabs").css({"font-size":"13px","font-family":"宋体","font-weight":"bold"});
		$(".tabs li").css("margin-left","10px");
		$(".tabs li：first").css("margin-left","48px");
		
		//实验室公告
		$("#announce_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Announce_getAnnounce',
			fitColumns:true,
			fit:true,
			border:true,
			pagination:true,
			idField:'id',
			sortName:'addTime',
			sortOrder:'desc',
			pageList:[16],
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
					return '<span style="cursor:pointer;color:#8080C0;" onclick="lookForAnnounce(\''+row.id+'\');">'+row.title+'</span>';
				}
			},{
				field : 'addTime',
				title : '发布时间',
				width : 80,
				align:'center',
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
	function lookForAnnounce(id){
		$('<div/>').dialog({
			title: '公告信息',  
		    width: 600,  
		    height: 480,  
		    href: '${pageContext.request.contextPath}/announceInfo.jsp?id='+id,  
		    modal: true,
		    onClose:function(){
		    	$(this).html('');
		    	$(this).dialog('destroy');
		    }
		});
	}
	//用户登录的dialog
	function user_login_dialog(){
		$("#login").dialog({
			title: '用户登录',  
		    width: 240,  
		    height: 176,  
		    href: '${pageContext.request.contextPath}/login.jsp',  
		    modal: true,
		    buttons:[{
		    	text:'登录',
		    	handler:function(){
					    $.ajax({
		    			url:'${pageContext.request.contextPath}/User_login',
		    			type:'post',
		    			data:$("#user-loginForm").serializeArray(),
		    			dataType:'json',
		    			success:function(obj){
	    					if(obj.type == '学生'){
	    						window.location.href='${pageContext.request.contextPath}/student/studentIndex.jsp';
	    					}else if(obj.type == '教师'){
	    						window.location.href='${pageContext.request.contextPath}/teacher/teacherIndex.jsp';
	    					}else if(obj.type == '管理员'){
	    						window.location.href='${pageContext.request.contextPath}/admin/adminIndex.jsp';
	    					}else{
		    					$.messager.show({
	    							title:'提示',
	    							msg:"用户名或密码错误，请重新输入！"
	    						});
		    				}
		    			}
		    		});
		    	}
		    }]
		});
	}
	
	//用户注册
	function User_register_dialog(){
   		$("#register").dialog({
   			title:'用户注册',
   			width: 430,  
   		    height: 246, 
   		    href: '${pageContext.request.contextPath}/register.jsp',  
   		    modal: true,
   		    buttons:[{
   		    	text:'提交',
   		    	handler:function(){
   		    		if( $("input[id='userId']").val() == "" ||
   		    			$("input[id='userName']").val() == "" ||
   		    			$("input[id='grade']").val() == "" ||
   		    			$("input[id='academy']").val() == "" ||
   		    			$("input[id='discipline']").val() == "" ||
   		    			$("input[id='cls']").val() == "" ||
   		    			$("input[id='phone']").val() == "" ||
   		    			$("input[id='password']").val() == "" ||
   		    		    $("#select_teacher_id").val() == ""){
   		    			alert("对不起！信息必须填完整！");
   		    		}else{
   		    			$.ajax({
    		    			url:'${pageContext.request.contextPath}/User_register',
    		    			type:'post',
    		    			data:$("#user-registerForm").serializeArray(),
    		    			dataType:'json',
    		    			success:function(obj){
    		    				if(obj){
    		    					$.messager.show({
    		    						title:'提示!',
    		    						msg:'恭喜你 ,注册成功！请等待相关教师的认证后才可登陆系统！'
    		    					});
    		    					$("#register").dialog('close');
    		    				}else{
    		    					$.messager.show({
    		    						title:'提示!',
    		    						msg:'该用户已存在！'
    		    					});
    		    				}
    		    			}
    		    		});
   		    		}
   		    	}
   		    }]
   		});
	}
	
	function DrawImage(ImgD,iwidth,iheight){
	    //参数(图片,允许的宽度,允许的高度)
	    var image=new Image();
	    image.src=ImgD.src;
	    if(image.width>0 && image.height>0){
	    flag=true;
	    if(image.width/image.height>= iwidth/iheight){
	        if(image.width>iwidth){  
		        ImgD.width=iwidth;
		        ImgD.height=(image.height*iwidth)/image.width;
	        }else{
		        ImgD.width=image.width;  
		        ImgD.height=image.height;
	        }
	        ImgD.alt=image.width+"×"+image.height;
	        }
	    else{
	        if(image.height>iheight){  
		        ImgD.height=iheight;
		        ImgD.width=(image.width*iheight)/image.height;        
	        }else{
		        ImgD.width=image.width;  
		        ImgD.height=image.height;
	        }
	        ImgD.alt=image.width+"×"+image.height;
	        }
	    }
	}
	
</script>
</head>
<body style="margin:0;padding:0;text-align:center;font-size:12px;background-color:#FFFFFF;">
	<div style="margin:0 auto;width:1024px;min-height:720px;overflow-y:scrooll;">
		<%--logo部分，里面放logo和用户状态信息 --%>
		<div style="height:124px;width:1024px;background:url(${pageContext.request.contextPath}/images/h1.gif);overflow:hidden;">
			<div style="float:right;height:22px;width:260px;margin-top:102px;">
				身份&nbsp;|&nbsp;游客&nbsp;&nbsp;<a style="cursor:pointer" onclick="user_login_dialog();">登陆</a>
				&nbsp;&nbsp;<a style="cursor:pointer" onclick="User_register_dialog();">注册</a>
				&nbsp;&nbsp;<a style="color:green; text-decoration: none;" href="manual/html/student.html">使用手册</a>
			</div>
		</div>
		
		<%--panel部分,里面是一个个的tab或panel --%>
		<div class="easyui-panel">
			<%--实验室首页 --%>
			<div id="index-tabs" class="easyui-tabs" data-options="border:false" style="height:512px;padding:2px;">
	    		 <div title="实验室首页" style="padding:2px;">
	    		 		<%--实验室图片 --%>
					<div  class="easyui-panel" data-options="border:false">
						<div class="easyui-layout" style="height:468px;">
							<div data-options="region:'center',border:false" style="width:420px;">
								<jsp:include page="img.jsp"></jsp:include>
							</div>
							<div data-options="region:'west',title:'实验室公告',border:false" style="padding:2px;width:460px;">
								<table id="announce_datagrid"></table>
							</div>
						</div>
					</div>
	    		 </div>
	    		 <div title="上机任务" data-options="href:'${pageContext.request.contextPath}/teacherCourse.jsp',tools:[{
				        iconCls:'icon-mini-refresh',
				        handler:function(){
				           $('#teacherCourse_datagrid').datagrid('load',{});
				           $('#teacherCourse_datagrid').datagrid('unselectAll');
				        }
				    }]" style="padding:2px;">
			    </div>
			    
    		 	<div title="学习资料" data-options="href:'${pageContext.request.contextPath}/material.jsp',tools:[{
				        iconCls:'icon-mini-refresh',
				        handler:function(){
				           $('#softWare_datagrid').datagrid('load',{});
				           $('#softWare_datagrid').datagrid('unselectAll');
				        }
				    }]" style="padding:2px;"></div>
    		 
    		 	<div title="软件下载" data-options="href:'${pageContext.request.contextPath}/softWare.jsp',tools:[{
				        iconCls:'icon-mini-refresh',
				        handler:function(){
				           $('#softWare_datagrid').datagrid('load',{});
				           $('#softWare_datagrid').datagrid('unselectAll');
				        }
				    }]" style="padding:2px;">
		     	</div>
    		</div>
		</div>
		
		<%--网站的footer --%>
		<div style="height:112px;border:1px #FFFFFF solid;background:url(${pageContext.request.contextPath}/images/foot.jpg)">
			<div style="height:18px;margin-top:60px;font-size:13px;text-align:left;font-weight:bold;">+&nbsp;相关链接</div>
			<div style="height:18px;margin:8px;font-size:12px;text-align:left;">
				<span><a href="http://172.22.4.16" target="_blank">极客网</a></span>
				<span style="margin-left:12px;"><a href="http://172.22.4.29:8000" target="_blank">技能认证</a></span>
				<span style="margin-left:12px;"><a href="http://172.22.4.29" target="_blank">开放上机</a></span>
				<span style="margin-left:12px;"><a href="http://202.202.43.125" target="_blank">网址大全</a></span>		
			</div>
		</div>
		<div style="height:18px;margin-top:6px"><span style="align:center;">版权所有&nbsp;&nbsp;极客网工作室</span></div>
		<div id="register" style="float:left;width:0;height:0;overflow:hidden;"></div>
		<div id="login" style="float:left;width:0;height:0;overflow:hidden;"></div>
	</div>
</body>
</html>
