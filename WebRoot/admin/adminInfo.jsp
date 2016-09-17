<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var admin_adminInfo_editRow = undefined;
	$(function(){
		$("#admin_adminInfo_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/User_getUserByType?type=admin',
			fitColumns:true,
			fit:true,
			border:false,
			pagination:true,
			sortName:'grade',
			sortOrder:'desc',
			idField:'id',
			pageList:[20,50,100],
			showHeader:true,
			checkOnSelect:true,
			selectOnCheck:true,
			frozenColumns:[[{
				field : 'id',
				width : 60,
				align:'center',
				checkbox:true
			},{
				field : 'userId',
				title : '教师编号',
				width : 120,
				align:'left'
			}]],
			columns : [[{
				field : 'userName',
				title : '教师姓名',
				width : 120,
				align:'left',
				sortable:true,
				editor:{
					type:'validatebox',
					options:{
						required:true
					}
				}
			},{
				field : 'academy',
				title : '学院',
				width : 120,
				align:'left',
				sortable:true,
				 editor:{
					type:'validatebox',
					options:{
						required:true
					}
				} 
			},{
				field : 'type',
				title : '类型',
				width : 120,
				align:'center',
				hidden:true
			},{
				field : 'sex',
				title : '性别',
				width : 120,
				align:'left',
				sortable:true,
				 editor:{
						type:'validatebox',
						options:{
							required:true
						}
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
			toolbar : [ {
				text : '添加管理员',
				iconCls : 'icon-add',
				handler : function() {
					admin_adminInfo_add();
				}
			}, '-',{
				text : '修改管理员',
				iconCls : 'icon-edit',
				handler : function() {
					admin_adminInfo_edit();
				}
			}, '-',{
				text : '保存',
				iconCls : 'icon-save',
				handler : function() {
					admin_adminInfo_save();
				}
			}, '-',{
				text : '取消选中',
				iconCls : 'icon-redo',
				handler : function() {
					admin_adminInfo_rollBack();
				}
			}],
			onAfterEdit:function(rowIndex,rowData,changes){
					//获取的都是修改 后的一行的数据
					var inserted = $('#admin_adminInfo_datagrid').datagrid('getChanges','inserted');
					var url = '';
					if(inserted.length < 1 && updated.length < 1){
						$('#admin_adminInfo_datagrid').datagrid('rejectChanges');
						$('#admin_adminInfo_datagrid').datagrid('unselectAll');
						admin_adminInfo_editRow = undefined;
						return;
					}
					//增加
					if(inserted.length > 0){
						//url = '${pageContext.request.contextPath}/admin/teacher/CourseInsert_insertCourse_teacherCourse';
						$.ajax({
							url:url,
							type:'post',
							data:{
								courseName:inserted[0].courseName,
								pubName:inserted[0].pubName,
								term:inserted[0].term,
								pubTime:inserted[0].pubTime
							},
							dataType:'json',
							success:function(data){
								if(data){
									$('#admin_adminInfo_datagrid').datagrid('load');
									$.messager.show({
										title:'提示',
										msg:'恭喜你,添加成功!'
									});
								}else{
									$('#admin_adminInfo_datagrid').datagrid('rejectChanges');
									$.messager.show({
										title:'提示',
										msg:'对不起!添加失败!'
									});
								}
								$('#admin_adminInfo_datagrid').datagrid('unselectAll');
								admin_adminInfo_editRow = undefined;
							}
						});
					}
			}			
		});
	});
	
	//添加学生
	function admin_adminInfo_add(){
		if (admin_adminInfo_editRow != undefined) {
			$.messager.show({
				title:'提示',
				msg:'对不起,只能同时添加一行数据!'
			});
		}
		if (admin_adminInfo_editRow == undefined) {
			$('#admin_adminInfo_datagrid').datagrid('insertRow', {
				index : 0,
				row : {
					id:'',
					courseName : '请输入课程名',
					term:'请输入课程学期'
				}
			});
			$('#admin_adminInfo_datagrid').datagrid('beginEdit', 0);
			admin_adminInfo_editRow = 0;
		}
	}
	//修改管理员 
	function admin_adminInfo_edit(){
		alert("开发中...");
	}
	//取消选中
	function admin_adminInfo_rollBack(){
		$('#admin_adminInfo_datagrid').datagrid('rejectChanges');
		$('#admin_adminInfo_datagrid').datagrid('unselectAll');
		admin_adminInfo_editRow = undefined;
	}
	
	//保存后结束编辑
	function admin_adminInfo_save(){
		$('#admin_adminInfo_datagrid').datagrid('endEdit',admin_adminInfo_editRow);
	}
	
	//查询功能
	function admin_adminInfo_search(value,name){
		alert(value+":"+name);
	}
</script>

<table id="admin_adminInfo_datagrid"></table>
