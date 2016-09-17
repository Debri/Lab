<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var admin_studentInfo_editRow = undefined;
	$(function(){
		$("#admin_studentInfo_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/User_getUserByType?type=student',
			fitColumns:true,
			fit:true,
			border:false,
			pagination:true,
			idField:'id',
			sortName:'grade',
			sortOrder:'desc',
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
				title : '学号',
				width : 100,
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
				title : '学生姓名',
				width : 100,
				align:'left',
				sortable:true,
				editor:{
					type:'validatebox',
					options:{
						required:true
					}
				}
			},{
				field : 'grade',
				title : '年级',
				width : 80,
				align:'left',
				sortable:true,
				editor:{
					type:'validatebox'
				}
			},{
				field : 'academy',
				title : '学院',
				width : 120,
				align:'left',
				sortable:true,
				 editor:{
					type:'validatebox'
				} 
			},{
				field : 'discipline',
				title : '专业',
				width : 80,
				align:'left',
				sortable:true,
				 editor:{
						type:'validatebox'
					} 
			},{
				field : 'cls',
				title : '班级',
				width : 80,
				align:'left',
				sortable:true,
				 editor:{
						type:'validatebox'
					} 
			},{
				field : 'phone',
				title : '电话',
				width : 80,
				align:'left',
				sortable:true,
				 editor:{
						type:'validatebox'
					} 
			},{
				field : 'type',
				title : '类型',
				width : 120,
				hidden:true,
				align:'center'
			},{
				field : 'sex',
				title : '性别',
				width : 40,
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
				width : 60,
				align:'left',
				sortable:true,
				 editor:{
						type:'validatebox',
						options:{
							required:true
						}
					} 
			},{
				field : 'securityQuestion',
				title : '密保问题',
				width : 40,
				align:'center'
			},{
				field : 'answer',
				title : '密保答案',
				width : 60,
				align:'center'
			}]],
			
			//CRUD开始
			toolbar:'#admin_studentInfo_toolbar',
			//双击修改信息
			onDblClickRow:function(rowIndex,rowData){
				//$('#admin_studentInfo_datagrid').datagrid('removeEditor','userId');
				if(admin_studentInfo_editRow != undefined){
					$('#admin_studentInfo_datagrid').datagrid('endEdit',admin_studentInfo_editRow);
					admin_studentInfo_editRow = undefined;
				}
				if(admin_studentInfo_editRow == undefined){
					$('#admin_studentInfo_datagrid').datagrid('beginEdit',rowIndex);
					admin_studentInfo_editRow = rowIndex;
				}
			},
			onAfterEdit:function(rowIndex,rowData,changes){
					//获取的都是修改 后的一行的数据
					var inserted = $('#admin_studentInfo_datagrid').datagrid('getChanges','inserted');
					var updated = $('#admin_studentInfo_datagrid').datagrid('getChanges','updated');
					var url = '';
					if(inserted.length < 1 && updated.length < 1){
						$('#admin_studentInfo_datagrid').datagrid('rejectChanges');
						$('#admin_studentInfo_datagrid').datagrid('unselectAll');
						admin_studentInfo_editRow = undefined;
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
								if(data > 0){
									$('#admin_studentInfo_datagrid').datagrid('load');
									$.messager.show({
										title:'提示',
										msg:'恭喜你,添加成功!'
									});
								}else{
									$('#admin_studentInfo_datagrid').datagrid('rejectChanges');
									$.messager.show({
										title:'提示',
										msg:'对不起，该用户已经存在！'
									});
								}
								$('#admin_studentInfo_datagrid').datagrid('unselectAll');
								admin_studentInfo_editRow = undefined;
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
									$('#admin_studentInfo_datagrid').datagrid('acceptChanges');
									$.messager.show({
										title:'提示',
										msg:'恭喜你,修改成功!'
									});
									
								}else{
									$('#admin_studentInfo_datagrid').datagrid('rejectChanges');
									$.messager.show({
										title:'提示',
										msg:'对不起,修改失败!'
									});
								}
								$('#admin_studentInfo_datagrid').datagrid('unselectAll');
								admin_studentInfo_editRow = undefined;
							}
						});
					}
			}			
		});
	});
	
	
	//删除学生
	function admin_studentInfo_remove(){
		var rows = $('#admin_studentInfo_datagrid').datagrid('getSelections');
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
						type:'post',
						data:{
							ids:ids.join(','),
							type:'student'
						},
						dataType:'json',
						success:function(d){
							if(d){
								$('#admin_studentInfo_datagrid').datagrid('load');
								$.messager.show({
									title:'提示',
									msg:'恭喜你,删除成功!'
								});
							}else{
								$('#admin_studentInfo_datagrid').datagrid('rejectChanges');
								$.messager.show({
									title:'提示',
									msg:'对不起,删除失败!'
								});
							}
							$('#admin_studentInfo_datagrid').datagrid('unselectAll');
							admin_studentInfo_editRow = undefined;
						}
					});
				}else{
					$('#admin_studentInfo_datagrid').datagrid('unselectAll');
					admin_studentInfo_editRow = undefined;
				}
			});
		}
	}
	
	//添加学生
	function admin_studentInfo_add(){
		if (admin_studentInfo_editRow != undefined) {
			$.messager.show({
				title:'提示',
				msg:'对不起,只能同时添加一行数据!'
			});
		}
		if (admin_studentInfo_editRow == undefined) {
			$('#admin_studentInfo_datagrid').datagrid('insertRow', {
				index : 0,
				row : {
					userId:'',
					userName : '',
					sex:'',
					academy:'',
					grade:'',
					discipline:'',
					cls:'',
					phone:'',
					type:'student',
					password:'123'
				}
			});
			$('#admin_studentInfo_datagrid').datagrid('beginEdit', 0);
			admin_studentInfo_editRow = 0;
		}
	}
	//修改学生
	function admin_studentInfo_edit(){
		if (admin_studentInfo_editRow != undefined) {
			$.messager.show({
				title:'提示',
				msg:'对不起,只能同时编辑一行数据!'
			});
			return;
		}
		if(admin_studentInfo_editRow == undefined){
			var rowData = $('#admin_studentInfo_datagrid').datagrid('getSelected');
			var rowIndex = $('#admin_studentInfo_datagrid').datagrid('getRowIndex',rowData);
			if(rowData == null){
				$.messager.show({
					title:'提示',
					msg:'请选择要修改的数据!'
				});
			}else{
				$('#admin_studentInfo_datagrid').datagrid('beginEdit',rowIndex);
				admin_studentInfo_editRow = rowIndex;
			}
		}
	}
	//取消选中
	function admin_studentInfo_rollBack(){
		$('#admin_studentInfo_datagrid').datagrid('rejectChanges');
		$('#admin_studentInfo_datagrid').datagrid('unselectAll');
		admin_studentInfo_editRow = undefined;
	}
	
	//保存后结束编辑
	function admin_studentInfo_save(){
		$('#admin_studentInfo_datagrid').datagrid('endEdit',admin_studentInfo_editRow);
	}
	
	//查询功能
	function admin_studentInfo_search(value,name){
		//alert(name+":"+value);
		if(name == 'userName'){
			userName = value;
			userId = '';
			grade='';
		}else if(name == 'userId'){
			userName = '';
			userId = value;
			grade='';
		}else if(name == 'grade'){
			userName = '';
			userId = '';
			grade = value;
		}
		//alert(userName+":"+userId);
		$('#admin_studentInfo_datagrid').datagrid('load',{
			userName:userName,
			userId:userId,
			grade:grade
		});
	}
	
	//批量导入学生信息
	function admin_studentInfo_import(){
		var url = '${pageContext.request.contextPath}/admin/addAllUser.jsp';
		$("<div/>").dialog({
		    title: '批量导入学生',  
		    width: 480,  
		    height: 240,  
		    closed: false,  
		    cache: false,  
		    content: '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:100%;"></iframe>',
		    modal: true  
		});
	}
</script>

<table id="admin_studentInfo_datagrid"></table>


<div id="admin_studentInfo_toolbar" style="height:28px;border-bottom:1px solid #F3F3F3">
	<div style="float:left">
		<a onclick="admin_studentInfo_add();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加学生</a>
	    <a onclick="admin_studentInfo_remove();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除学生</a>
	    <a onclick="admin_studentInfo_edit();" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改学生</a>
	    <a onclick="admin_studentInfo_save();" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">保存</a>
	    <a onclick="admin_studentInfo_rollBack();" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">取消选中&nbsp;&nbsp;|</a>
	    <a onclick="admin_studentInfo_import();" class="easyui-linkbutton" data-options="plain:true">批量导入学生</a>
	</div>   
	<div style="float:left;margin-left:12px;margin-top:3px">
		<input class="easyui-searchbox" style="width:300px"  data-options="searcher:admin_studentInfo_search,prompt:'请输入搜索信息',menu:'#admin_studentInfo_search'"></input>  
		<div id="admin_studentInfo_search" style="width:120px">  
		    <div data-options="name:'userName',iconCls:'icon-ok'">姓名</div>  
		    <div data-options="name:'userId',iconCls:'icon-ok'">学号</div>  
		    <div data-options="name:'grade',iconCls:'icon-ok'">年级</div>
		</div>  
	</div>
</div>

