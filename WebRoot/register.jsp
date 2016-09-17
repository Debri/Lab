<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function(){
		$.ajax({
			url:'${pageContext.request.contextPath}/User_getUserByType',
			type:'post',
			data:{
				type:'teacher',
				page:0,
				rows:200,
				sort:'userName',
				order:'asc'
			},
			dataType:'json',
			success:function(obj){
				var i = 0;
				for(;i< obj.total;i++){
					$("#select_teacher_id").append("<option value="+obj.rows[i].userId+">"+obj.rows[i].userName+"</option>");
				}
			}
		});
		$("#it").focus();
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
	<form method="post" id="user-registerForm">
		<table id="tb1">
			<tr>
				<td>学号<td>
				<td><input style="border-color:#FF00FF;" id="userId"  name="userId" value=""  type="text" /><td>
				<td>姓名<td>
				<td><input style="border-color:#FF00FF;" id="userName" name="userName" value=""  type="text" /><td>
			</tr>
			<tr>
				<td>年级<td>
				<td><input id="grade" name="grade"  type="text" value="" style="border-color:#FF00FF;"/><td>
				<td>学院<td>
				<td><input id="academy" name="academy" type="text" value="" style="border-color:#FF00FF;"/><td>
			</tr>
			<tr>
				<td>专业<td>
				<td><input id="discipline" name="discipline"  type="text" value="" style="border-color:#FF00FF;"/><td>
				<td>班级<td>
				<td><input id="cls" name="cls"  type="text" value="" style="border-color:#FF00FF;"/><td>
			</tr>
			<tr>
				<td>性别<td>
				<td><select name="sex" style="width:154px;"><option value="男">男</option><option value="女">女</option></select><td>
				<td>教师<td>
				<td><select id="select_teacher_id" name="teacherId" style="width:154px;"><option value="">请选择实验教师</option></select><td>
			</tr>
			<tr>
				<td>电话<td>
				<td><input type="text" id="phone" name="phone" value="" style="border-color:#FF00FF;"/><td>
				<td>密码<td>
				<td><input style="border-color:#FF00FF;" value=""  type="text" id="password" name="password" /><td>
				<input type="hidden" name="type" value="student"/>
			</tr>
		</table>
	</form>
	提示：信息必须真实,完整,否则无效！
</div>
