<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var admin_course_editRow = undefined;
	$(function(){
		$("#admin_course_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Course_getCourseByType?type=admin',
			fitColumns:true,
			fit:true,
			border:false,
			pagination:true,
			sortName:'addTime',
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
				field : 'courseName',
				title : '课程名',
				width : 240,
				align:'left',
				editor:{
					type:'validatebox',
					options:{
						required:true
					}
				}
			}]],
			columns : [[{
				field : 'courseNumber',
				title : '课程编号',
				width : 60,
				align:'left',
				editor:{
					type:'validatebox',
					options:{
						required:true
					}
				}
			},{
				field : 'term',
				title : '学期',
				width : 80,
				align:'left',
				sortable:true,
				editor:{
					type:'validatebox',
					options:{
						required:true
					}
				}
			},{
				field : 'userName',
				title : '发布人',
				width : 120,
				align:'left'
			},{
				field : 'addTime',
				title : '发布时间',
				width : 120,
				align:'left',
				sortable:true
			}]],
			
			//CRUD开始
			toolbar:'#admin_course_toolbar',
			onAfterEdit:function(rowIndex,rowData,changes){
					//获取的都是修改 后的一行的数据
					var inserted = $('#admin_course_datagrid').datagrid('getChanges','inserted');
					var url = '';
					if(inserted.length < 1 && updated.length < 1){
						$('#admin_course_datagrid').datagrid('rejectChanges');
						$('#admin_course_datagrid').datagrid('unselectAll');
						admin_course_editRow = undefined;
						return;
					}
					//增加
					if(inserted.length > 0){
						var userId = '${sessionScope.user.userId}';
						url = '${pageContext.request.contextPath}/admin/Course_addCourse?userId='+userId;
						$.ajax({
							url:url,
							type:'post',
							data:rowData,
							dataType:'json',
							success:function(data){
								if(data){
									$('#admin_course_datagrid').datagrid('load');
									$.messager.show({
										title:'提示',
										msg:'恭喜你,添加成功!'
									});
								}else{
									$('#admin_course_datagrid').datagrid('rejectChanges');
									$.messager.show({
										title:'提示',
										msg:'对不起!添加失败!'
									});
								}
								$('#admin_course_datagrid').datagrid('unselectAll');
								admin_course_editRow = undefined;
							}
						});
					}
			}			
		});
	});
	
	//删除课程
	function admin_course_remove(){
		var rows = $('#admin_course_datagrid').datagrid('getSelections');
		var ids = [];
		if(rows.length == 0){
			$.messager.show({
				title:'提示',
				msg:'请选择要删除的行!'
			});
		}else{
			for(var i = 0;i < rows.length;i++){
				ids.push(rows[i].id);
			}
			$.messager.confirm('请确认','你确定要删除选择的数据吗?',function(data){
				if(data){
					$.ajax({
						url:'${pageContext.request.contextPath}/admin/Course_deleteCourse',
						type:'post',
						data:{
							'ids':ids.join(',')
						},
						dataType:'json',
						success:function(d){
							if(d){
								$('#admin_course_datagrid').datagrid('load');
								$.messager.show({
									title:'提示',
									msg:'恭喜你,删除成功!'
								});
							}else{
								$('#admin_course_datagrid').datagrid('rejectChanges');
								$.messager.show({
									title:'提示',
									msg:'对不起,删除失败!'
								});
							}
							$('#admin_course_datagrid').datagrid('unselectAll');
							admin_course_editRow = undefined;
						}
					});
				}else{
					$('#admin_course_datagrid').datagrid('unselectAll');
					admin_course_editRow = undefined;
				}
			});
		}
	}
	
	function admin_course_add(){
		if (admin_course_editRow != undefined) {
			$.messager.show({
				title:'提示',
				msg:'对不起,只能同时添加一行数据!'
			});
		}
		if (admin_course_editRow == undefined) {
			$('#admin_course_datagrid').datagrid('insertRow', {
				index : 0,
				row : {
					id:'',
					courseName : '请输入课程名',
					term:'请输入课程学期'
				}
			});
			$('#admin_course_datagrid').datagrid('beginEdit', 0);
			admin_course_editRow = 0;
		}
	}
	
	function admin_course_rollBack(){
		$('#admin_course_datagrid').datagrid('rejectChanges');
		$('#admin_course_datagrid').datagrid('unselectAll');
		admin_course_editRow = undefined;
	}
	
	//保存后结束编辑
	function admin_course_save(){
		$('#admin_course_datagrid').datagrid('endEdit',admin_course_editRow);
	}
	
	//查询功能
	function admin_course_search(value,name){
			alert(name+":"+value);
		if(name == 'courseName'){
			courseName = value;
			term = '';
		}else if(name == 'term'){
			courseName = '';
			term = value;
		}
		$('#admin_course_datagrid').datagrid('load',{
			courseName:courseName,
			term:term
		});
	}
	
	//批量导入课程信息
	function admin_course_addAllCourse(){
		var url = '${pageContext.request.contextPath}/admin/addAllCourse.jsp';
		$("<div/>").dialog({
		    title: '批量导入课程',  
		    width: 480,  
		    height: 240,  
		    closed: false,  
		    cache: false,  
		    content: '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:100%;"></iframe>',
		    modal: true  
		});
	}
</script>

<table id="admin_course_datagrid"></table>


<div id="admin_course_toolbar"
	style="height:28px;border-bottom:1px solid #F3F3F3">
	<div style="float:left">
		<a onclick="admin_course_add();" class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true">添加课程</a> <a
			onclick="admin_course_remove();" class="easyui-linkbutton"
			data-options="iconCls:'icon-remove',plain:true">删除课程</a> <a
			onclick="admin_course_save();" class="easyui-linkbutton"
			data-options="iconCls:'icon-save',plain:true">保存</a> <a
			onclick="admin_course_rollBack();" class="easyui-linkbutton"
			data-options="iconCls:'icon-redo',plain:true">取消选中&nbsp;&nbsp;|</a> <a
			onclick="admin_course_addAllCourse();" class="easyui-linkbutton"
			data-options="plain:true">批量导入课程</a>
	</div>
	<div style="float:left;margin-left:12px;margin-top:3px">
		<input class="easyui-searchbox" style="width:300px"
			data-options="searcher:admin_course_search,prompt:'请输入搜索信息',menu:'#admin_course_search'"></input>
		<div id="admin_course_search" style="width:120px">
			<div data-options="name:'courseName',iconCls:'icon-ok'">课程名</div>
			<div data-options="name:'term',iconCls:'icon-ok'">学期</div>
		</div>
	</div>
</div>
