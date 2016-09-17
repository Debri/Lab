<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var userId = '${sessionScope.user.userId }';
	$(function(){
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
	<form method="post" id="teacher_myInfo_form">
		<table id="tb1">
			<tr>
				<td>编号<td>
				<td><input name="userId" value="" type="text" readonly/><td>
				<td>姓名<td>
				<td><input name="userName" value="" type="text" readonly/><td>
			</tr>
			<tr>
				<td>学院<td>
				<td><input name="academy" value="" type="text" readonly/><td>
				<td>性别<td>
				<td><input name="sex" value="" type="text" readonly/><td>
				
			</tr>
			<tr>
				<td>电话<td>
				<td><input class="easyui-validatebox" type="text" name="phone" value=""/><td>
				<td>密码<td>
				<td><input class="easyui-validatebox" type="text" name="password" value=""/><td>
			</tr>
		</table>
		<input name="type" value="" type="hidden" />
		<input name="discipline" value="" type="hidden"/>
		<input name="cls" value="" type="hidden" />
		<input name="grade" value="" type="hidden" />
	</form>
</div>