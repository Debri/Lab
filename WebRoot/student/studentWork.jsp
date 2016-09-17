<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var userId = '${sessionScope.user.userId }';
	var taskId = <%=request.getParameter("taskId")%>;
	$(function(){
		$("#student_studentWork_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/student/Work_getWorkByTaskId?userId='+userId+
					'&taskId='+taskId,
			fitColumns:true,
			fit:true,
			border:false,
			pagination:true,
			idField:'id',
			sortName:'addTime',
			sortOrder:'desc',
			pageList:[3,5,10],
			showHeader:true,
			singleSelected:true,
			columns : [[{
				field : 'id',
				width : 60,
				hidden:true,
				align:'center'
			},{
				field : 'workName',
				title : '作业名称',
				width : 240,
				align:'left'
			},{
				field : 'addTime',
				title : '上传时间',
				width : 120,
				align:'left'
			},{
				field : 'url',
				width : 120,
				align:'center',
				hidden:true
			},{
				field : 'studentWorkCl',
				title : '作业操作',
				width : 180,
				align:'left',
				formatter:function(value,row,index){
					return '<span style="cursor:pointer;color:#8080C0;" onclick="student_studentWork_downloadWork(\''+row.url+'\',\''+row.workName+'\');">下载</span>'+
					'<span style="cursor:pointer;color:#B22222;margin-left:24px;" onclick="student_studentWork_deleteWork(\''+row.id+'\',\''+row.url+'\');">删除</span>';
				}
			}]]
		});
	});
	//学生下载作业
	function student_studentWork_downloadWork(url,workName){
		$.messager.confirm('请确认','你确定要下载选择的资料吗?',function(data){
			if(data){
				//ajax实现文件下载
				var form = $("<form>");  //==>jQuery创建隐藏表单,实现ajax下载
				form.attr('style','display:none');  
				form.attr('target','');  
				form.attr('method','post');  
				form.attr('action','${pageContext.request.contextPath}/download/Download_downloadFile');  
				$('body').append(form);  
				form.append("<input type='hidden' name='url' value='"+url+"'>");
				form.append("<input type='hidden' name='fileName' value='"+workName+"'>");
				form.submit();  
				form.remove();
			}
		});
	}
	
	//删除功能
	function student_studentWork_deleteWork(id,url){
		$.messager.confirm('请确认','你确定要删除该实验课程吗?',function(data){
			if(data){
				$.ajax({
					url:'${pageContext.request.contextPath}/student/Work_deleteWorkByWorkId',
					data:{
						id:id,
						url:url
					},
					dataType:'json',
					type:'post',
					success:function(d){
						if(d){
							$('#student_studentWork_datagrid').datagrid('load');
							$.messager.show({
								title:'提示',
								msg:'恭喜你,删除成功!'
							});
						}else{
							$.messager.show({
								title:'提示',
								msg:'对不起,删除失败!'
							});
						}
					}
				});
			}else{
				$.messager.show({
					title:'提示',
					msg:'删除已被取消!!'
				});
			}
			$('#student_studentWork_datagrid').datagrid('unselectAll');
		});
	}
</script>
	
<table id="student_studentWork_datagrid"></table>
