<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var admin_registerInfo_editRow = undefined;
	$(function(){
		$("#admin_registerInfo_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/admin/Register_getRegister',
			fitColumns:true,
			fit:true,
			border:false,
			pagination:true,
			idField:'id',
			sortName:'userName',
			sortOrder:'desc',
			pageList:[20,30],
			showHeader:true,
			checkOnSelect:true,
			selectOnCheck:true,
			columns : [[{
				field : 'id',
				width : 60,
				checkbox:true
			},{
				field : 'userId',
				title : '学号',
				width : 120,
				align:'left'
			},{
				field : 'userName',
				title : '学生姓名',
				width : 120,
				align:'left'
			},{
				field : 'grade',
				title : '年级',
				width : 120,
				align:'left'
			},{
				field : 'academy',
				title : '学院',
				width : 120,
				align:'left'
			},{
				field : 'discipline',
				title : '专业',
				width : 120,
				align:'left'
			},{
				field : 'cls',
				title : '班级',
				width : 120,
				align:'left'
			},{
				field : 'sex',
				title : '性别',
				width : 60,
				align:'left'
			},{
				field : 'phone',
				width : 60,
				title : '电话',
				align:'left'
			},{
				field : 'teacherName',
				width : 60,
				title : '教师姓名',
				align:'left'
			},{
				field : 'state',
				width : 60,
				hidden:true
			},{
				field : 'grant',
				title : '授权状态',
				width : 120,
				align:'left',
				formatter:function(value,row,index){
					if(row.state=='yes'){
						return '<span style="cursor:pointer;color:red;">已被授权</span>';
					}else{
						return '<span style="cursor:pointer;color:#8080C0;" onclick="admin_registerInfo_grantRegister(\''+row.userId+'\');">未被授权</span>';
					}
				}
			}]],
			toolbar:'#admin_registerInfo_toolbar'
		});
	});
	
	//管理员授权操作
	function admin_registerInfo_grantRegister(userId){
		$.messager.confirm('请确认','你确定要让该用户登录该系统吗?',function(data){
			if(data){
				$.ajax({
					url:'${pageContext.request.contextPath}/admin/Register_grantRegister',
					type:'post',
					data:{
						userId:userId
					},
					dataType:'json',
					success:function(d){
						if(d){
							$.messager.show({
								title:'提示',
								msg:'恭喜你，授权被成功！'
							});
						}else{
							$.messager.show({
								title:'提示',
								msg:'该授权失败，请与管理员联系！'
							});
						}
					}
				});
			}else{
				$.messager.show({
					title:'提示',
					msg:'该授权被取消了！'
				});
			}
		});
	}
	
	/*
		批量授权
	*/
	function admin_registerInfo_grantAllRegister(){
		var rows = $('#admin_registerInfo_datagrid').datagrid('getSelections');
		var userId = []; 
		if(rows.length == 0 ){
			$.messager.show({
				title:'提示',
				msg:'请选择要授权的用户!'
			});
		}else{
			for(var i = 0;i < rows.length;i++){
				userId.push(rows[i].userId);
			}
			$.messager.confirm('请确认','你确定要让该用户登录该系统吗?',function(data){
				if(data){
					$.ajax({
						url:'${pageContext.request.contextPath}/admin/Register_grantRegister',
						type:'post',
						data:{
							userId:userId.join(',')
						},
						dataType:'json',
						success:function(d){
							if(d){
								$.messager.show({
									title:'提示',
									msg:'恭喜你，授权成功！'
								});
							}else{
								$.messager.show({
									title:'提示',
									msg:'该授权失败！'
								});
							}
						}
					});
				}else{
					$.messager.show({
						title:'提示',
						msg:'该授权被取消了！'
					});
				}
			});
		}
	}
	/*
		删除注册用户
	*/
	function admin_registerInfo_delete(){
		var rows = $('#admin_registerInfo_datagrid').datagrid('getSelections');
		var userId = []; 
		if(rows.length == 0 ){
			$.messager.show({
				title:'提示',
				msg:'请选择要删除的注册用户!'
			});
		}else{
			for(var i = 0;i < rows.length;i++){
				userId.push(rows[i].userId);
			}
			$.messager.confirm('请确认','你确定要删除吗?',function(data){
				if(data){
					$.ajax({
						url:'${pageContext.request.contextPath}/admin/Register_deleteRegister',
						type:'post',
						data:{
							userId:userId.join(',')
						},
						dataType:'json',
						success:function(d){
							if(d){
								$.messager.show({
									title:'提示',
									msg:'恭喜你，删除成功！'
								});
							}else{
								$.messager.show({
									title:'提示',
									msg:'删除失败！'
								});
							}
						}
					});
				}else{
					$.messager.show({
						title:'提示',
						msg:'取消删除！'
					});
				}
			});
		}
	}
	
	//取消选中
	function admin_registerInfo_rollBack(){
		$('#admin_registerInfo_datagrid').datagrid('rejectChanges');
		$('#admin_registerInfo_datagrid').datagrid('unselectAll');
		admin_registerInfo_editRow = undefined;
	}
</script>

<table id="admin_registerInfo_datagrid"></table>

<div id="admin_registerInfo_toolbar" style="margin-top:2px;height:24px;">
	<div style="float:left">
		<a onclick="admin_registerInfo_grantAllRegister()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">批量授权</a>
		<a onclick="admin_registerInfo_delete()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除用户</a>
	    <a onclick="admin_registerInfo_rollBack()" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">取消选中</a>
	</div> 
</div>
