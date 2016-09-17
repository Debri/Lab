<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--上机任务 页面--%>
<script type="text/javascript">
	var admin_studentCourse_editRow = undefined;
	$(function(){
		$("#admin_studentCourse_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Course_getCourseByType?type=student',
			fitColumns:true,
			fit:true,
			pagination:true,
			idField:'id',
			border:false,
			sortName:'addTime',
			sortOrder:'desc',
			pageList:[20,50],
			showHeader:true,
			columns : [[{
				field : 'id',
				width:60,
				checkbox:true,
				align:'left'
			},{
				field : 'courseName',
				title : '实验课程',
				width : 120,
				align:'left'
			},
			{
				field : 'courseNumber',
				title : '课程编号',
				width : 60,
				align:'left'
			},{
				field : 'term',
				title : '学期',
				width : 80,
				align:'left'
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
				field : 'addTime',
				title : '发布时间',
				width : 120,
				align:'left',
				sortable:true
			}]],
			toolbar:'#admin_studentCourse_toolbar',
			view: detailview,
            detailFormatter:function(index,row){
                return '<div style="padding:2px;"><table id="admin_studentCourse-' + index + '"></table></div>';
            },
            onExpandRow: function(index,row){
                $('#admin_studentCourse-'+index).datagrid({
                    url:'${pageContext.request.contextPath}/Work_getWorkByStudentCourseId?studentCourseId='+row.id,
                    fitColumns:true,
                    singleSelect:true,
                    loadMsg:'',
                    height:'auto',
                    columns : [[{
        				field : 'id',
        				hidden:true,
        				align:'center'
        			},{
        				field : 'workName',
        				title : '作业名称',
        				width : 120,
        				align:'left'
        			},{
        				field : 'addTime',
        				title : '上传时间',
        				width : 120,
        				align:'left',
        				sortable:true
        			},{
        				field : 'url',
        				width : 120,
        				align:'left',
        				hidden:true
        			}]],
                    onResize:function(){
                        $('#admin_studentCourse_datagrid').datagrid('fixDetailRowHeight',index);
                    },
                    onLoadSuccess:function(){
                        setTimeout(function(){
                            $('#admin_studentCourse_datagrid').datagrid('fixDetailRowHeight',index);
                        },0);
                    },
                });
                $('#admin_studentCourse_datagrid').datagrid('fixDetailRowHeight',index);
            }
		});
	});
	
	
	//取消选中
	function admin_studentCourse_rollBack(){
		$('#admin_studentCourse_datagrid').datagrid('rejectChanges');
		$('#admin_studentCourse_datagrid').datagrid('unselectAll');
		admin_studentCourse_editRow = undefined;
	}
	
	//查询功能
	function admin_studentCourse_search(value,name){
		if(name == 'userName'){
			userName = value;
			userId = '';
		}else if(name == 'userId'){
			userName = '';
			userId = value;
		}
		$('#admin_studentCourse_datagrid').datagrid('load',{
			userName:userName,
			userId:userId
		});
	}
	/*
	删除学生课程
	*/
	function admin_studentCourse_delete(){
		var rows = $('#admin_studentCourse_datagrid').datagrid('getSelections');
		if(rows.length == 0){
			$.messager.show({
				title:'提示',
				msg:'请选择要删除的行!'
			});
		}else{
			var id = [];
			for(var i = 0;i < rows.length;i++){
				id.push(rows[i].id);
			}
			$.messager.confirm('请确认','删除会连学生作业一起删除，确定吗?',function(data){
				if(data){
					$.ajax({
						url:'${pageContext.request.contextPath}/admin/Course_deleteStudentCourse',
						type:'post',
						data:{
							ids:id.join(',')
						},
						dataType:'json',
						success:function(d){
							if(d){
								$('#admin_studentCourse_datagrid').datagrid('load');
								$.messager.show({
									title:'提示',
									msg:'恭喜你,删除成功!'
								});
							}else{
								$('#admin_studentCourse_datagrid').datagrid('rejectChanges');
								$.messager.show({
									title:'提示',
									msg:'对不起,删除失败!'
								});
							}
							$('#admin_studentCourse_datagrid').datagrid('unselectAll');
							admin_studentCourse_editRow = undefined;
						}
					});
				}else{
					$('#admin_studentCourse_datagrid').datagrid('unselectAll');
					admin_studentCourse_editRow = undefined;
				}
			});
		}
	}
</script>
<table id="admin_studentCourse_datagrid"></table>

<div id="admin_studentCourse_toolbar" style="height:28px;">
	<div style="float:left">
		<a onclick="admin_studentCourse_delete()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除课程</a>
	    <a onclick="admin_studentCourse_rollBack()" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">取消选中</a>
	</div>   
	<div style="float:left;margin-left:12px;margin-top:3px">
		<input class="easyui-searchbox" style="width:300px"  data-options="searcher:admin_studentCourse_search,prompt:'请输入搜索信息',menu:'#admin_studentCourse_search'"></input>  
		<div id="admin_studentCourse_search" style="width:120px">  
		    <div data-options="name:'userName',iconCls:'icon-ok'">姓名</div> 
		    <div data-options="name:'userId',iconCls:'icon-ok'">学号</div> 
		</div>  
	</div>
</div>