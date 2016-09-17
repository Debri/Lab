<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var admin_material_editRow = undefined;
	$(function(){
		$("#admin_material_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Material_getMaterial',
			fitColumns:true,
			fit:true,
			border:false,
			pagination:true,
			idField:'id',
			sortName:'addTime',
			sortOrder:'desc',
			pageList:[20,50,100],
			showHeader:true,
			checkOnSelect:true,
			selectOnCheck:true,
			columns : [[{
				field : 'id',
				width : 60,
				align:'center',
				checkbox:true
			},{
				field : 'title',
				title : '资料名称',
				width : 120,
				align:'left'
			},{
				field : 'size',
				title : '大小',
				width : 40,
				align:'left'
			},{
				field : 'url',
				title : '资料url',
				width : 120,
				align:'left',
				hidden:true
			},{
				field : 'userName',
				title : '上传人',
				width : 120,
				align:'left',
				sortable:true
			},{
				field : 'addTime',
				title : '上传时间',
				width : 120,
				align:'left',
				sortable:true
			}]],
			
			//CRUD开始
			toolbar:'#admin_material_toolbar',
			onAfterEdit:function(rowIndex,rowData,changes){
					//获取的都是修改 后的一行的数据
					var inserted = $('#admin_material_datagrid').datagrid('getChanges','inserted');
					var url = '';
					if(inserted.length < 1 && updated.length < 1){
						$('#admin_material_datagrid').datagrid('rejectChanges');
						$('#admin_material_datagrid').datagrid('unselectAll');
						admin_material_editRow = undefined;
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
									$('#admin_material_datagrid').datagrid('load');
									$.messager.show({
										title:'提示',
										msg:'恭喜你,添加成功!'
									});
								}else{
									$('#admin_material_datagrid').datagrid('rejectChanges');
									$.messager.show({
										title:'提示',
										msg:'对不起!添加失败!'
									});
								}
								$('#admin_material_datagrid').datagrid('unselectAll');
								admin_material_editRow = undefined;
							}
						});
					}
			}			
		});
	});
	
	
	
	//删除资料
	function admin_material_remove(){
		var rows = $('#admin_material_datagrid').datagrid('getSelections');
		var urls = [];
		var ids = [];
		if(rows.length == 0){
			$.messager.show({
				title:'提示',
				msg:'请选择要删除的行!'
			});
		}else{
			for(var i = 0;i < rows.length;i++){
				urls.push(rows[i].url);
			}
			for(var i = 0;i < rows.length;i++){
				ids.push(rows[i].id);
			}
			$.messager.confirm('请确认','你确定要删除选择的数据吗?',function(data){
				if(data){
					$.ajax({
						url:'${pageContext.request.contextPath}/admin/Material_deleteMaterial',
						type:'post',
						data:{
							url:urls.join(','),
							ids:ids.join(',')
						},
						dataType:'json',
						success:function(d){
							if(d){
								$('#admin_material_datagrid').datagrid('load');
								$.messager.show({
									title:'提示',
									msg:'恭喜你,删除成功!'
								});
							}else{
								$('#admin_material_datagrid').datagrid('rejectChanges');
								$.messager.show({
									title:'提示',
									msg:'对不起,删除失败!'
								});
							}
							$('#admin_material_datagrid').datagrid('unselectAll');
							admin_material_editRow = undefined;
						}
					});
				}else{
					$('#admin_material_datagrid').datagrid('unselectAll');
					admin_material_editRow = undefined;
				}
			});
		}
	}
	
	//取消选中
	function admin_material_rollBack(){
		$('#admin_material_datagrid').datagrid('rejectChanges');
		$('#admin_material_datagrid').datagrid('unselectAll');
		admin_materialType_editRow = undefined;
	}
	
	//保存后结束编辑
	function admin_material_save(){
		$('#admin_material_datagrid').datagrid('endEdit',admin_material_editRow);
	}
	
	//查询功能
	function admin_material_search(value,name){
		if(name == 'title'){
			title = value;
			mtName = '';
			userName = '';
		}
				
		if(name == 'userName'){
			title = '';
			mtName = '';
			userName = value;
		}
		$("#admin_material_datagrid").datagrid('load',{
			title:title,
			userName:userName
		});
	}
	
	//上传的dialog
	function admin_material_upload(){
		var url = '${pageContext.request.contextPath}/teacher/uploadMaterial.jsp';
		$("<div/>").dialog({
		    title: '上传资料',  
		    width: 480,  
		    height: 360,  
		    closed: false,  
		    cache: false,  
		    content: '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:100%;"></iframe>',
		    modal: true,
		    onClose:function(){
		    	$(this).dialog('destroy');
		    }
		});
	}
	
</script>
<table id="admin_material_datagrid"></table>
<div id="admin_material_toolbar" style="height:28px;border-bottom:1px solid #F3F3F3">
	<div style="float:left">
		 <a onclick="admin_material_upload()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">上传资料</a>
	    <a onclick="admin_material_remove()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除资料</a>
	    <a onclick="admin_material_rollBack()" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">取消选中</a>
	</div>   
	<div style="float:left;margin-left:12px;margin-top:3px">
		<input class="easyui-searchbox" style="width:300px"  data-options="searcher:admin_material_search,prompt:'请输入搜索信息',menu:'#admin_material_search'"></input>  
		<div id="admin_material_search" style="width:120px">  
		    <div data-options="name:'title',iconCls:'icon-ok'">资料名</div> 
		    <div data-options="name:'userName',iconCls:'icon-ok'">上传人</div>  
		</div>  
	</div>
</div>
