<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var admin_announce_editRow = undefined;
	$(function(){
		$("#admin_announce_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Announce_getAnnounce',
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
				title : '标题',
				width : 100,
				align:'left',
				editor:{
					type:'validatebox',
					options:{
						required:true
					}
				}
			},{
				field : 'content',
				title : '内容',
				width : 180,
				align:'left',
				editor:{
					type:'validatebox',
					options:{
						required:true
					}
				}
			},{
				field : 'name',
				title : '附件名称',
				width : 60,
				align:'left'
			},{
				field : 'url',
				title : '附件地址',
				width : 60,
				align:'left',
				hidden:true
				
			},{
				field : 'userName',
				title : '发布人',
				width : 36,
				align:'left',
				sortable:true
			},{
				field : 'addTime',
				title : '发布时间',
				width : 36,
				align:'left',
				sortable:true
			}]],
			
			//CRUD开始
			toolbar:'#admin_announce_toolbar',
			onAfterEdit:function(rowIndex,rowData,changes){
					//获取的都是修改 后的一行的数据
					var inserted = $('#admin_course_datagrid').datagrid('getChanges','inserted');
					var url = '';
					if(inserted.length < 1 && updated.length < 1){
						$('#admin_announce_datagrid').datagrid('rejectChanges');
						$('#admin_announce_datagrid').datagrid('unselectAll');
						admin_announce_editRow = undefined;
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
									$('#admin_announce_datagrid').datagrid('load');
									$.messager.show({
										title:'提示',
										msg:'恭喜你,添加成功!'
									});
								}else{
									$('#admin_announce_datagrid').datagrid('rejectChanges');
									$.messager.show({
										title:'提示',
										msg:'对不起!添加失败!'
									});
								}
								$('#admin_announce_datagrid').datagrid('unselectAll');
								admin_announce_editRow = undefined;
							}
						});
					}
			}			
		});
	});
	
	//删除公告
	function admin_announce_remove(){
		var rows = $('#admin_announce_datagrid').datagrid('getSelections');
		var url = [];
		var ids = [];
		if(rows.length == 0){
			$.messager.show({
				title:'提示',
				msg:'请选择要删除的行!'
			});
		}else{
			for(var i = 0;i < rows.length;i++){
				alert(rows[i].url);
				if(null != rows[i].url){
					url.push(rows[i].url);
				}
				ids.push(rows[i].id);
			}
			$.messager.confirm('请确认','你确定要删除选择的数据吗?',function(data){
				if(data){
					$.ajax({
						url:'${pageContext.request.contextPath}/admin/Announce_deleteAnnounce',
						type:'post',
						data:{
							url:url.join(','),
							ids:ids.join(',')
						},
						dataType:'json',
						success:function(d){
							if(d){
								$('#admin_announce_datagrid').datagrid('load');
								$.messager.show({
									title:'提示',
									msg:'恭喜你,删除成功!'
								});
							}else{
								$('#admin_announce_datagrid').datagrid('rejectChanges');
								$.messager.show({
									title:'提示',
									msg:'对不起,删除失败!'
								});
							}
							$('#admin_announce_datagrid').datagrid('unselectAll');
							admin_announce_editRow = undefined;
						}
					});
				}else{
					$('#admin_announce_datagrid').datagrid('unselectAll');
					admin_announce_editRow = undefined;
				}
			});
		}
	}
	
	function admin_announce_add(){
		var url = '${pageContext.request.contextPath}/admin/addAnnounce.jsp';
		$("<div/>").dialog({
		    title: '添加公告',  
		    width: 760,  
		    height: 500,  
		    closed: false,  
		    cache: false,  
		    content: '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:100%;"></iframe>',
		    modal: true,
		    onClose:function(){
		    	$(this).dialog('destroy');
		    }
		});
	}
	
	function admin_announce_rollBack(){
		$('#admin_announce_datagrid').datagrid('rejectChanges');
		$('#admin_announce_datagrid').datagrid('unselectAll');
		admin_announce_editRow = undefined;
	}
	
	//保存后结束编辑
	function admin_announce_save(){
		$('#admin_announce_datagrid').datagrid('endEdit',admin_announce_editRow);
	}
	
	//查询功能
	function admin_announce_search(value,name){
		alert("开发中...");
	}
</script>

<table id="admin_announce_datagrid"></table>


<div id="admin_announce_toolbar" style="height:28px;border-bottom:1px solid #F3F3F3">
	<div style="float:left">
		<a onclick="admin_announce_add()" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加公告</a>
	    <a onclick="admin_announce_remove()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除公告</a>
	    <a onclick="admin_announce_save()" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">保存</a>
	    <a onclick="admin_announce_rollBack()" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">取消选中</a>
	</div>   
	<div style="float:left;margin-left:12px;margin-top:3px">
		<input class="easyui-searchbox" style="width:300px"  data-options="searcher:admin_announce_search,prompt:'请输入搜索信息',menu:'#admin_announce_search'"></input>  
		<div id="admin_announce_search" style="width:120px">  
		    <div data-options="name:'pubTime',iconCls:'icon-ok'">添加时间</div>  
		    <div data-options="name:'title',iconCls:'icon-ok'">公告名</div>  
		</div>  
	</div>
</div>
