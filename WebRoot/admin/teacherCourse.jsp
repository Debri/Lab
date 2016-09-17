<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--上机任务 页面--%>
<script type="text/javascript">
var admin_teacherCourse_editRow = undefined;
	$(function(){
		$("#admin_teacherCourse_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Course_getCourseByType?type=teacher',
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
				checkbox:true
			},{
				field : 'courseName',
				title : '实验课程',
				width : 120,
				align:'left'
			},{
				field : 'courseNumber',
				title : '课程编号',
				width : 60,
				align:'left'
			},{
				field : 'courseId',
				title : '课程id',
				width : 120,
				align:'left',
				hidden:true
			},{
				field : 'userId',
				title : '用户id',
				width : 120,
				align:'left',
				hidden:true
			},{
				field : 'term',
				title : '学期',
				width : 80,
				align:'left'
			},{
				field : 'userName',
				title : '课程教师',
				width : 120,
				align:'left'
			},{
				field : 'addTime',
				title : '发布时间',
				width : 120,
				align:'left',
				sortable:true
			}]],
			toolbar:'#admin_teacherCourse_toolbar',
			view: detailview,
            detailFormatter:function(index,row){
                return '<div style="padding:2px;"><table id="admin_teacherCourse-' + index + '"></table></div>';
            },
            onExpandRow: function(index,row){
                $('#admin_teacherCourse-'+index).datagrid({
                    url:'${pageContext.request.contextPath}/Task_getTaskByTeacherCourseId?teacherCourseId='+row.id,
                    fitColumns:true,
                    singleSelect:true,
                    loadMsg:'',
                    height:'auto',
                    columns : [[{
        				field : 'id',
        				hidden:true,
        				align:'center'
        			},{
        				field : 'teacherCourseId',
        				hidden:true,
        				align:'center'
        			},{
        				field : 'num',
        				title : '第几次实验',
        				width : 120,
        				align:'left',
                		formatter:function(value,row,index){
    						return '<span>第'+value+'次实验任务</span>';
            			}
        			},{
        				field:'workDir',
        				width:60,
        				align:'left',
        				hidden:true
        			},{
        				field:'url',
        				width:60,
        				align:'left',
        				hidden:true
        			},{
        				field : 'taskName',
        				title : '实验指导书',
        				width : 120,
        				align:'left'
        			},{
        				field : 'addTime',
        				title : '发布时间',
        				width : 120,
        				align:'left',
        				sortable:true
        			}]],
                    onResize:function(){
                        $('#admin_teacherCourse_datagrid').datagrid('fixDetailRowHeight',index);
                    },
                    onLoadSuccess:function(){
                        setTimeout(function(){
                            $('#admin_teacherCourse_datagrid').datagrid('fixDetailRowHeight',index);
                        },0);
                    }
                });
                $('#admin_teacherCourse_datagrid').datagrid('fixDetailRowHeight',index);
            }
		});
	});
	
	
	/*
	删除教师课程
	*/
	function admin_teacherCourse_delete(){
		var rows = $('#admin_teacherCourse_datagrid').datagrid('getSelections');
		if(rows.length == 0){
			$.messager.show({
				title:'提示',
				msg:'请选择要删除的行!'
			});
		}else{
			var id = [];
			var courseId = [];
			var userId = [];
			for(var i = 0;i < rows.length;i++){
				id.push(rows[i].id);
				userId.push(rows[i].userId);
				courseId.push(rows[i].courseId);
			}
			$.messager.confirm('请确认','删除会连学生作业一起删除，确定吗?',function(data){
				if(data){
					$.ajax({
						url:'${pageContext.request.contextPath}/admin/Course_deleteTeacherCourse',
						type:'post',
						data:{
							ids:id.join(','),
							courseIds:courseId.join(','),
							userId:userId.join(',')
						},
						dataType:'json',
						success:function(d){
							if(d){
								$('#admin_teacherCourse_datagrid').datagrid('load');
								$.messager.show({
									title:'提示',
									msg:'恭喜你,删除成功!'
								});
							}else{
								$('#admin_teacherCourse_datagrid').datagrid('rejectChanges');
								$.messager.show({
									title:'提示',
									msg:'对不起,删除失败!'
								});
							}
							$('#admin_teacherCourse_datagrid').datagrid('unselectAll');
							admin_teacherCourse_editRow = undefined;
						}
					});
				}else{
					$('#admin_teacherCourse_datagrid').datagrid('unselectAll');
					admin_teacherCourse_editRow = undefined;
				}
			});
		}
	}
	
	//取消选中
	function admin_teacherCourse_rollBack(){
		$('#admin_teacherCourse_datagrid').datagrid('rejectChanges');
		$('#admin_teacherCourse_datagrid').datagrid('unselectAll');
		admin_teacherCourse_editRow = undefined;
	}
	
	//查询功能
	function admin_teacherCourse_search(value,name){
	alert(name+":"+value);
		if(name == 'userName'){
			userName = value;
			userId = '';
		}else if(name == 'userId'){
			userName = '';
			userId = value;
		}
		$('#admin_teacherCourse_datagrid').datagrid('load',{
			userName:userName,
			userId:userId
		});
	}
</script>
<table id="admin_teacherCourse_datagrid"></table>

<div id="admin_teacherCourse_toolbar" style="height:28px;">
	<div style="float:left">
		<a onclick="admin_teacherCourse_delete()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除课程</a>
	    <a onclick="admin_teacherCourse_rollBack()" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">取消选中</a>
	</div>   
	<div style="float:left;margin-left:12px;margin-top:3px">
		<input class="easyui-searchbox" style="width:300px"  data-options="searcher:admin_teacherCourse_search,prompt:'请输入搜索信息',menu:'#admin_teacherCourse_search'"></input>  
		<div id="admin_teacherCourse_search" style="width:120px">  
		    <div data-options="name:'userName',iconCls:'icon-ok'">姓名</div> 
		    <div data-options="name:'userId',iconCls:'icon-ok'">教师编号</div> 
		</div>  
	</div>
</div>