<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var userId = '${sessionScope.user.userId }';
	$(function(){
	/* 	$("input[name='password']").blur(function(){
			var oPassword = document.getElementById("easyui-validatebox").value;
			var strExp=new RegExp("^[0-9A-Za-z]{3,12}$");
			if(!strExp.test(oPassword)){
				alert("密码只能为3到12位数字或英文字母!");
				return false;
			}
		}); */
		$.ajax({
			url:'${pageContext.request.contextPath}/User_getUserByUserId',
			type:'post',
			data:{
				userId:userId
			},
			dataType:'json',
			success:function(obj){
				$("input[name='userId']").attr('value',obj.userId);
				$("input[name='userName']").attr('value',obj.userName);
				$("input[name='academy']").attr('value',obj.academy);
				$("input[name='grade']").attr('value',obj.grade);
				$("input[name='discipline']").attr('value',obj.discipline);
				$("input[name='cls']").attr('value',obj.cls);
				$("input[name='sex']").attr('value',obj.sex);
				$("input[name='type']").attr('value',obj.type);
				$("input[name='phone']").attr('value',obj.phone);
				$("input[name='password']").attr('value',obj.password);
			}
		});	
	});
	
	
	//new changePassword
	$(function(){
		$('#changePassword').click(function(){
			$('.passwordProtect').css('display','block');
			return false;
		});
		$('.protectClose').click(function(){
			$('.passwordProtect').css('display','none');
		});
		var password = $('#newPassword');
		var reInput = $('#reNewPassword');
		var oldPassword = $('#oldPassword');
		var strExp=new RegExp("^[0-9A-Za-z]{3,12}$");
		password.blur(function(){
			if(!strExp.test(password.val())){
				alert("密码只能为3到12位数字或英文字母!");
				password.val('');
				return false;
			}
		});
		reInput.blur(function(){
			if($(this).val() != password.val()){
				alert("请输入相同的新密码!");
				$(this).val('');
			}
		});
		$('#protectAnswer').blur(function(){
			if($(this).val() == ''){
				alert("答案不能为空！");
			}
		});
		//提交按钮
		$('#passwordSubmit').click(function(){
			var oldPasswordValue = oldPassword.val();
			var questionIndex = $('#questionChoose').val();
			var newPassword = password.val();
			var userId = $("input[name='userId']").val();
			var protectAnswer = $("#protectAnswer").val();
	
			var data = {
			    "userId":userId,
				"password":oldPasswordValue,
				"newPassword":newPassword,
				"securityQuestion":questionIndex,
				"answer":protectAnswer
			};
			//提交时对表单进行判断
			if(!strExp.test($('#newPassword').val())){
				alert("新密码只能为3到12位数字或英文字母!");
				password.val('');
				return false;
			};
			if(reInput.val() != password.val()){
				alert("请输入相同的新密码!");
				reInput.val('');
				return false;
			};
			if($('#protectAnswer').val() == ''){
				alert("答案不能为空！");
				return false;
			};
			
			$.ajax({
				url: '${pageContext.request.contextPath}/student/User_modifyPasswordAndSecurity',
				type: 'POST',
				dataType: 'json',
				data: data,
				success:function(d){
					if (!d) {
						alert("旧密码输入错误！");
						//清空输入的密码
						oldPassword.val("");
						password.val("");
						reInput.val("");
						console.log(data);
					}else{
						alert("修改成功！");
						window.location.href='${pageContext.request.contextPath}/index.jsp';
					}
				}
			});
		});
	});
</script>

<style>
	#tb1{
		 border-collapse:collapse;
		 border:1px solid #DCDCDC;
		 font-weight:bold;
		 font-size:12px;
	}
	#tb1 td{
		border:1px solid #DCDCDC;
	}
</style>
<div style="margin:1px;">
	<form method="post" id="student_myInfo_form">
		<table id="tb1">
			<tr>
				<td>学号<td>
				<td><input name="userId" value="" type="text" readonly/><td>
				<td>姓名<td>
				<td><input name="userName" value="" type="text" readonly/><td>
			</tr>
			<tr>
				<td>年级<td>
				<td><input name="grade" value="" type="text" readonly/><td>
				<td>学院<td>
				<td><input name="academy" value="" type="text" readonly/><td>
			</tr>
			<tr>
				<td>专业<td>
				<td><input name="discipline" value="" type="text" readonly/><td>
				<td>班级<td>
				<td><input name="cls" value="" type="text" readonly/><td>
			</tr>
			<tr>
				<td>性别<td>
				<td><input name="sex" value="" type="text" readonly/><td>
				<td>类型<td>
				<td><input name="type" value="" type="text" readonly/><td>
			</tr>
			<tr>
				<td>电话<td>
				<td><input class="easyui-validatebox" type="text" name="phone" value=""/><td>
				<td>密码<td>
				<td><a class="easyui-validatebox" id="changePassword" type="submit">修改密码</a><td>
				<!-- <td><input class="easyui-validatebox" id="easyui-validatebox" type="text" name="password" value=""/><td> -->
			</tr>
			<tr>
			</tr>
		</table>
	</form>
	<div class="passwordProtect">
		<div class="protectTop">
			<span>修改密码</span>
			<div class="protectClose"></div>
		</div>
		<div class="protectContent"> 
			<span>请选择密保问题：</span>
			<select name="questionChoose" id="questionChoose">
				<option value="Q1">您就读的高中叫什么名字？</option>
				<option value="Q2">您的母亲叫什么名字？</option>
				<option value="Q3">您就读的小学叫什么名字？</option>
			</select>
			<span>请输入密保问题： </span><input type="text" id="protectAnswer" name="protectAnswer" /><br/>
			<span>输入你的旧密码： </span><input type="password" id="oldPassword" name="oldPassword" /><br/>
			<span>输入你的新密码： </span><input type="password" id="newPassword" name="newPassword" /><br/>
			<span>再次输入新密码： </span><input type="password" id="reNewPassword" name="reNewPassword" /><br/>
		</div>
		<button id="passwordSubmit">提交</button>
	</div>
</div>