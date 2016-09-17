<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var admin_teacherInfo_editRow = undefined;
	$(function(){
		$("#admin_teacherInfo_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/User_getUserByType?type=teacher',
			fitColumns:true,
			fit:true,
			border:false,
			pagination:true,
			sortName:'grade',
			sortOrder:'desc',
			idField:'id',
			pageList:[20,50],
			showHeader:true,
			checkOnSelect:true,
			selectOnCheck:true,
			frozenColumns:[[{
				field : 'id',
				width : 60,
				align:'left',
				checkbox:true
			},{
				field : 'userId',
				title : '教师编号',
				width : 120,
				align:'left',
				 editor:{
					type:'validatebox',
					options:{
						required:true
					}
				}
			}]],
			columns : [[{
				field : 'userName',
				title : '教师姓名',
				width : 120,
				align:'left',
				editor:{
					type:'validatebox',
					options:{
						required:true
					}
				}
			},{
				field : 'grade',
				title : '年级',
				width : 120,
				align:'left',
				hidden:true,
				editor:{
					type:'validatebox'
				}
			},{
				field : 'academy',
				title : '学院',
				width : 120,
				align:'left',
				 editor:{
					type:'validatebox'
				} 
			},{
				field : 'discipline',
				title : '专业',
				width : 120,
				align:'left',
				hidden:true,
				 editor:{
						type:'validatebox'
					} 
			},{
				field : 'cls',
				title : '班级',
				width : 120,
				align:'left',
				hidden:true,
				 editor:{
						type:'validatebox'
					} 
			},{
				field : 'phone',
				title : '电话',
				width : 120,
				align:'left',
				 editor:{
					type:'validatebox'
				} 
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
				align:'left',
				sortable:true,
				 editor:{
						type:'validatebox'
					} 
			},{
				field : 'password',
				title : '登陆密码',
				width : 120,
				align:'left',
				sortable:true,
				 editor:{
						type:'validatebox',
						options:{
							required:true
						}
					} 
			}]],
			
			//CRUD开始
			toolbar:'#admin_teacherInfo_toolbar',
			//双击修改信息
			onDblClickRow:function(rowIndex,rowData){
				//$('#admin_studentInfo_datagrid').datagrid('removeEditor','userId');
				if(admin_teacherInfo_editRow != undefined){
					$('#admin_teacherInfo_datagrid').datagrid('endEdit',admin_teacherInfo_editRow);
					admin_teacherInfo_editRow = undefined;
				}
				if(admin_teacherInfo_editRow == undefined){
					$('#admin_teacherInfo_datagrid').datagrid('beginEdit',rowIndex);
					admin_teacherInfo_editRow = rowIndex;
				}
			},
			onAfterEdit:function(rowIndex,rowData,changes){
					//获取的都是修改 后的一行的数据
					var inserted = $('#admin_teacherInfo_datagrid').datagrid('getChanges','inserted');
					var updated = $('#admin_teacherInfo_datagrid').datagrid('getChanges','updated');
					var url = '';
					if(inserted.length < 1 && updated.length < 1){
						$('#admin_teacherInfo_datagrid').datagrid('rejectChanges');
						$('#admin_teacherInfo_datagrid').datagrid('unselectAll');
						admin_teacherInfo_editRow = undefined;
						return;
					}
					//增加
					if(inserted.length > 0){
						url = '${pageContext.request.contextPath}/admin/User_addUser';
						$.ajax({
							url:url,
							type:'post',
							data:rowData,
							dataType:'json',
							success:function(data){
								if(data){
									$('#admin_teacherInfo_datagrid').datagrid('load');
									$.messager.show({
										title:'提示',
										msg:'恭喜你,添加成功!'
									});
								}else{
									$('#admin_teacherInfo_datagrid').datagrid('rejectChanges');
									$.messager.show({
										title:'提示',
										msg:'对不起!添加失败!'
									});
								}
								$('#admin_teacherInfo_datagrid').datagrid('unselectAll');
								admin_teacherInfo_editRow = undefined;
							}
						});
					}
					//修改
					if(updated.length > 0){
						url = '${pageContext.request.contextPath}/admin/User_updateUser';
						$.ajax({
							url:url,
							type:'post',
							data:rowData,
							dataType:'json',
							success:function(data){
								if(data){
									$('#admin_teacherInfo_datagrid').datagrid('acceptChanges');
									$.messager.show({
										title:'提示',
										msg:'恭喜你,修改成功!'
									});
									
								}else{
									$('#admin_teacherInfo_datagrid').datagrid('rejectChanges');
									$.messager.show({
										title:'提示',
										msg:'对不起,修改失败!'
									});
								}
								$('#admin_teacherInfo_datagrid').datagrid('unselectAll');
								admin_teacherInfo_editRow = undefined;
							}
						});
					}
			}			
		});
	});
	
	
	//删除教师
	function admin_teacherInfo_remove(){
		var rows = $('#admin_teacherInfo_datagrid').datagrid('getSelections');
		var ids = [];
		if(rows.length == 0){
			$.messager.show({
				title:'提示',
				msg:'请选择要删除的行!'
			});
		}else{
			for(var i = 0;i < rows.length;i++){
				ids.push(rows[i].userId);
			}
			$.messager.confirm('请确认','你确定要删除选择的数据吗?',function(data){
				if(data){
					$.ajax({
						url:'${pageContext.request.contextPath}/admin/User_deleteUser',
						data:{
							ids:ids.join(','),
							type:'teacher'
						},
						dataType:'json',
						success:function(d){
							if(d){
								$('#admin_teacherInfo_datagrid').datagrid('load');
								$.messager.show({
									title:'提示',
									msg:'恭喜你,删除成功!'
								});
							}else{
								$('#admin_teacherInfo_datagrid').datagrid('rejectChanges');
								$.messager.show({
									title:'提示',
									msg:'对不起,删除失败!'
								});
							}
							$('#admin_teacherInfo_datagrid').datagrid('unselectAll');
							admin_teacherInfo_editRow = undefined;
						}
					});
				}else{
					$('#admin_teacherInfo_datagrid').datagrid('unselectAll');
					admin_teacherInfo_editRow = undefined;
				}
			});
		}
	}
	
	//添加教师
	function admin_teacherInfo_add(){
		if (admin_teacherInfo_editRow != undefined) {
			$.messager.show({
				title:'提示',
				msg:'对不起,只能同时添加一行数据!'
			});
		}
		if (admin_teacherInfo_editRow == undefined) {
			$('#admin_teacherInfo_datagrid').datagrid('insertRow', {
				index : 0,
				row : {
					userId:'',
					userName : '',
					sex:'',
					academy:'',
					phone:'',
					type:'teacher',
					password:'123'
				}
			});
			$('#admin_teacherInfo_datagrid').datagrid('beginEdit', 0);
			admin_teacherInfo_editRow = 0;
		}
	}
	//修改教师
	function admin_teacherInfo_edit(){
		if (admin_teacherInfo_editRow != undefined) {
			$.messager.show({
				title:'提示',
				msg:'对不起,只能同时编辑一行数据!'
			});
			return;
		}
		if(admin_teacherInfo_editRow == undefined){
			var rowData = $('#admin_teacherInfo_datagrid').datagrid('getSelected');
			var rowIndex = $('#admin_teacherInfo_datagrid').datagrid('getRowIndex',rowData);
			if(rowData == null){
				$.messager.show({
					title:'提示',
					msg:'对不起,请选择要修改的数据!'
				});
			}else{
				$('#admin_teacherInfo_datagrid').datagrid('beginEdit',rowIndex);
				admin_teacherInfo_editRow = rowIndex;
			}
		}
	}
	//取消选中
	function admin_teacherInfo_rollBack(){
		$('#admin_teacherInfo_datagrid').datagrid('rejectChanges');
		$('#admin_teacherInfo_datagrid').datagrid('unselectAll');
		admin_teacherInfo_editRow = undefined;
	}
	//保存后结束编辑
	function admin_teacherInfo_save(){
		$('#admin_teacherInfo_datagrid').datagrid('endEdit',admin_teacherInfo_editRow);
		$('#admin_teacherInfo_datagrid').datagrid('unselectAll');
		admin_teacherInfo_editRow = undefined;
	}
	
	//查询功能
	function admin_teacherInfo_search(value,name){
		$('#admin_teacherInfo_datagrid').datagrid('load',{
			userName:value
		});
	}
	
</script>

<table id="admin_teacherInfo_datagrid"></table>


<div id="admin_teacherInfo_toolbar" style="height:28px;border-bottom:1px solid #F3F3F3">
	<div style="float:left">
		<a onclick="admin_teacherInfo_add();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加教师</a>
	    <a onclick="admin_teacherInfo_remove();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除教师</a>
	    <a onclick="admin_teacherInfo_edit();" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改教师</a>
	    <a onclick="admin_teacherInfo_save();" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">保存</a>
 		<a onclick="admin_teacherInfo_rollBack();" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">取消选中&nbsp;&nbsp;|</a>
	</div>   
	<div style="float:left;margin-left:12px;margin-top:3px">
		<input class="easyui-searchbox" style="width:300px"  data-options="searcher:admin_teacherInfo_search,prompt:'请输入搜索信息',menu:'#admin_teacherInfo_search'"></input>  
		<div id="admin_teacherInfo_search" style="width:120px">  
		    <div data-options="name:'userName',iconCls:'icon-ok'">姓名</div>  
		</div>  
	</div>
</div>
