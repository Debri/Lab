<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var teacher_studentInfo_editRow = undefined;
	$(function(){
		$("#teacher_studentInfo_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/User_getUserByType?type=student',
			fitColumns:true,
			fit:true,
			border:false,
			pagination:true,
			idField:'id',
			sortName:'grade',
			sortOrder:'desc',
			pageList:[12],
			showHeader:true,
			singleSelect:true,
			frozenColumns:[[{
				field : 'id',
				width : 60,
				hidden:true,
				align:'center'
			},{
				field : 'userId',
				title : '学号',
				width : 150,
				align:'left'
			}]],
			columns : [[{
				field : 'userName',
				title : '学生姓名',
				width : 120,
				align:'left'
			},{
				field : 'type',
				title : '类型',
				width : 120,
				hidden:true,
				align:'left'
			},{
				field : 'sex',
				title : '性别',
				width : 120,
				align:'left'
			},/* {
				field : 'password',
				title : '登陆密码',
				width : 120,
				align:'left',
				 editor:{
						type:'validatebox',
						options:{
							required:true
						}
					} 
			} */ 
			{
				field : 'password',
				title : '登陆密码',
				width : 120,
				align:'left',
				formatter:function(value,row,index){
						return '<span style="cursor:pointer;color:#8080C0;"onclick="teacher_studentInfo_resetPassword(\''+row.userId+'\');">重置密码</span>';
					},
			}]],
			//CRUD开始
			toolbar:'#teacher_studentInfo_toolbar',
	
		});
	});
	//重置学生密码
	function teacher_studentInfo_resetPassword(userId){
				$.messager.confirm('请确认','重置该学生的密码，你确定吗?',function(data){
					if(data){
					//alert(userId);
						$.ajax({
							url:'${pageContext.request.contextPath}/teacher/User_resetStudentPassword',
							type:'post',
							data:{
								'userId':userId
							},
							dataType:'json',
							success:function(d){
								if(d){
									$('#teacher_studentInfo_resetPassword').datagrid('load');
									$.messager.show({
										title:'提示',
										msg:'重置成功!'
									});
								}else{
									$.messager.show({
										title:'提示',
										msg:'对不起,重置失败!'
									});
								}
							}
						});
					}else{
						$.messager.show({
							title:'提示',
							msg:'已取消重置操作!'
						});
					}
					//$('#teacher_studentInfo_datagrid').datagrid('unselectAll');
				}); 
			}
	//修改学生
	function teacher_studentInfo_edit(){
		if (teacher_studentInfo_editRow != undefined) {
			$.messager.show({
				title:'提示',
				msg:'对不起,只能同时编辑一行数据!'
			});
			return;
		}
		if(teacher_studentInfo_editRow == undefined){
			var rowData = $('#teacher_studentInfo_datagrid').datagrid('getSelected');
			var rowIndex = $('#teacher_studentInfo_datagrid').datagrid('getRowIndex',rowData);
			if(rowData == null){
				$.messager.show({
					title:'提示',
					msg:'对不起,请选择要修改的数据!'
				});
			}else{
				$('#teacher_studentInfo_datagrid').datagrid('beginEdit',rowIndex);
				teacher_studentInfo_editRow = rowIndex;
			}
		}
	}
	//取消选中
	function teacher_studentInfo_rollBack(){
		$('#teacher_studentInfo_datagrid').datagrid('rejectChanges');
		$('#teacher_studentInfo_datagrid').datagrid('unselectAll');
		teacher_studentInfo_editRow = undefined;
	}
	
	//保存后结束编辑
	function teacher_studentInfo_save(){
		$('#teacher_studentInfo_datagrid').datagrid('endEdit',teacher_studentInfo_editRow);
	}
	
	//查找功能
	function teacher_studentInfo_search(value,name){
		var userId;
		var userName;
		if(name == 'userId'){
			userId = value;
			userName = '';
		}else{
			userName = value;
			userId = '';
		}
		$('#teacher_studentInfo_datagrid').datagrid('load',{
			userId:userId,
			userName:userName
		});
	}
	
	//教师授权给注册的学生
	function teacher_studentInfo_grant(){
		$('<div/>').dialog({
			title:'注册用户',
			width: 730,  
		    height: 415, 
		    href: '${pageContext.request.contextPath}/teacher/registerInfo.jsp',  
		    modal: true,
		    onClose:function(){
		    	$(this).html('');
		    	$(this).dialog('destroy');
		    }
		});
	}
	
</script>

<table id="teacher_studentInfo_datagrid"></table>

<div id="teacher_studentInfo_toolbar"
	style="height:28px;border-bottom:1px solid #F3F3F3">
	<div style="float:left">
		<a onclick="teacher_studentInfo_edit();" class="easyui-linkbutton"
			data-options="iconCls:'icon-edit',plain:true">修改学生</a> <a
			onclick="teacher_studentInfo_save();" class="easyui-linkbutton"
			data-options="iconCls:'icon-save',plain:true">保存</a> <a
			onclick="teacher_studentInfo_rollBack();" class="easyui-linkbutton"
			data-options="iconCls:'icon-redo',plain:true">取消选中</a> <a
			onclick="teacher_studentInfo_grant();" class="easyui-linkbutton"
			data-options="plain:true">学生认证</a>
	</div>
	<div style="float:left;margin-left:12px;margin-top:3px">
		<input class="easyui-searchbox" style="width:200px"
			data-options="searcher:teacher_studentInfo_search,prompt:'请输入搜索信息',menu:'#teacher_studentInfo_search'"></input>
		<div id="teacher_studentInfo_search" style="width:120px">
			<div data-options="name:'userId',iconCls:'icon-ok'">学号</div>
			<div data-options="name:'userName',iconCls:'icon-ok'">姓名</div>
		</div>
	</div>
</div>
</div>
