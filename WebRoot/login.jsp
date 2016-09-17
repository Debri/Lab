<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var Q;
	var userId;
	$(function(){
		$("#it").focus();
		//回车提交表单
		document.getElementById("user-loginForm").onkeydown=function(ev)
			{
				var oEvent=ev||event;
				if(oEvent.keyCode==13)
				{
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
			};
	});
	function user_reset(){
		$("#login").dialog({
			title: '重置密码',  
		    width: 240,  
		    height: 176,  
		    href: '${pageContext.request.contextPath}/forgetPassword.jsp',  
		    modal: true,
		    buttons:[{
		    	text:'提交'
		    }]
		});
	}
	$("#forgetPassword").click(function(){
		 userId = document.getElementById("it").value;
		var data = {
			"userId": userId
		};
		console.log(data);
		var reg = new RegExp("^[0-9A-Za-z]{1,16}$");
			if(!reg.test(userId)){
				alert("请先输入学号!");
				return false;
			}else{
				$.ajax({
					type:"POST",
					url:'${pageContext.request.contextPath}/User_getSecurity',
					data: data,
					dataType: "json",
					success: function(obj){
						Q = obj.securityQuestion;
						if(Q != undefined){
							user_reset();
						}else{
							alert("你未设置密保问题,或学号错误，请联系管理员重置密码！");
						}
					},
				});
				
			}
	});
</script>
<form id="user-loginForm" method="post">

	<table>
	
  		<tr>
  			<td style="font-weight:bold;font-size:13px;">学号</td>
  			<td><input id="it" type="text" name="userId"/></td>
  		</tr>
  		<tr>
  			<td style="font-weight:bold;font-size:13px;">密码</td>
  			<td><input type="password"  name="password"/></td>
  		</tr>
  		<tr>
  			<td style="font-weight:bold;font-size:13px;">身份</td>
  			<td>
  				<select name="type">
  					<option value="student" selected>学&nbsp;&nbsp;生</option>
       				<option value="teacher">教&nbsp;&nbsp;师</option>
       				<option value="admin">管理员</option>
  				</select>
  			</td>
  		</tr>
  		
  	</table>
  	<a  id="forgetPassword" style="margin: 15px 0 0 5px; color: blue; cursor:pointer;">忘记密码</a>
</form>

