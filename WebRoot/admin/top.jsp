<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<script type="text/javascript">
	var userId = '${sessionScope.user.userId}';
	
	//登录超时就退出
	$(function(){
		if(userId == ""){
			window.location.href='${pageContext.request.contextPath}/index.jsp';
		}
	});
	
	function admin_adminIndex_logout(){
		
		$.messager.confirm('确定','你确定要退出系统吗?',function(r){
			if(r){
				$.ajax({
					url:'${pageContext.request.contextPath}/User_logout',
					type:'post',
					dataType:'json',
					data:{
						userId:userId
					},
					success:function(obj){
						if(obj){
							window.location.href='${pageContext.request.contextPath}/index.jsp';
						}else{
							$.messager.show({
								title:'温馨提示',
								msg:'你已经不是登陆状态了,谢谢!'
							});
							window.location.href='${pageContext.request.contextPath}/index.jsp';
						}
					}
				});
			}
		});
	}
	
	//查看个人信息
	function admin_myInfo(){
		$('<div/>').dialog({
			title: '我的信息',  
		    width: 430,  
		    height: 180,  
		    href: '${pageContext.request.contextPath}/admin/myInfo.jsp',  
		    modal: true,
		    buttons:[{
		    	text:'保存',
		    	handler:function(){
		    		$.messager.confirm('请确认','你确定要修改吗?',function(data){
		    			if(data){
		    				$.ajax({
				    			url:'${pageContext.request.contextPath}/admin/User_updateUser',
				    			type:'post',
				    			data:$("#admin_myInfo_form").serializeArray(),
				    			dataType:'json',
				    			success:function(obj){
				    				if(obj){
				    					$.messager.show({
				    						title:'提示',
				    						msg:'恭喜你,修改成功!'
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
	    						msg:'修改已被取消!'
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

<div style="float:right;height:22px;width:240px;margin-top:36px;">
	<span style="color: rgb(0, 136, 204);cursor:pointer" onclick="admin_myInfo();">${sessionScope.user.userName }</span>&nbsp;您好&nbsp;|身份&nbsp;-&nbsp;${sessionScope.user.type}&nbsp;&nbsp;<a style="cursor:pointer;color: rgb(0, 136, 204);" onclick="admin_adminIndex_logout();">退出</a>
</div>