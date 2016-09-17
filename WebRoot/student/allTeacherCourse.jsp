<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--上机任务 页面--%>
<script type="text/javascript">
	$(function(){
		$("#student_allTeacherCourse_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Course_getCourseByType?type=teacher',
			fitColumns:true,
			fit:true,
			pagination:true,
			idField:'id',
			sortName:'addTime',
			sortOrder:'desc',
			pageList:[14,20,50],
			showHeader:true,
			singleSelect:true,
			columns : [[{
				field : 'id',
				width:60,
				hidden:true,
				align:'center'
			},{
				field : 'courseName',
				title : '实验课程',
				width : 240,
				align:'left'
			},{
				field : 'courseNumber',
				title : '课程编号',
				width : 80,
				align:'left'
			},{
				field : 'term',
				title : '学期',
				width : 80,
				align:'left',
				formatter:function(value,row,index){
					return '<span>第'+value+'个学期</span>';
				}
			},{
				field : 'userName',
				title : '课程教师',
				width : 80,
				align:'left'
			},{
				field : 'addTime',
				title : '发布时间',
				width : 80,
				align:'left',
				sortable:true
			},{
				field : 'status',
				title : '实验处理',
				width : 100,
				align:'left',
				formatter:function(value,row,index){
					return '<span style="cursor:pointer;color:#8080C0;" onclick="student_allTeacherCourse_addCourse(\''+row.id+'\');">添加课程</span>';
				}
			}]],
			
			toolbar:'#student_allTeacherCourse_toolbar',
			
			view: detailview,
            detailFormatter:function(index,row){
                return '<div style="padding:2px;"><table id="student_allTeacherCourse-' + index + '"></table></div>';
            },
            onExpandRow: function(index,row){
                $('#student_allTeacherCourse-'+index).datagrid({
                    url:'${pageContext.request.contextPath}/Task_getTaskByTeacherCourseId?teacherCourseId='+row.id,
                    fitColumns:true,
                    singleSelect:true,
                    loadMsg:'',
                    height:'auto',
                    columns : [[{
        				field : 'taskId',
        				hidden:true,
        				align:'center'
        			},{
        				field : 'courseId',
        				hidden:true,
        				align:'center'
        			},{
        				field : 'taskName',
        				title : '实验任务',
        				width : 180,
        				align:'left'
        			},{
        				field : 'fileNameF',
        				title : '附件名称',
        				width : 160,
        				align:'left'
        			},{
        				field : 'addTime',
        				title : '发布时间',
        				width : 120,
        				align:'left',
        				sortable:true
        			}]],
        			
                    onResize:function(){
                        $('#student_allTeacherCourse_datagrid').datagrid('fixDetailRowHeight',index);
                    },
                    onLoadSuccess:function(){
                        setTimeout(function(){
                            $('#student_allTeacherCourse_datagrid').datagrid('fixDetailRowHeight',index);
                        },0);
                    }
                });
                $('#student_allTeacherCourse_datagrid').datagrid('fixDetailRowHeight',index);
            }
		});
	});
	
	//学生添加实验任务课程
	function student_allTeacherCourse_addCourse(teachereCourseId){
		var userId = '${sessionScope.user.userId }';
		$.messager.confirm('请确认','你确定要添加该实验课程吗?',function(data){
			if(data){
				$.ajax({
					url:'${pageContext.request.contextPath}/student/Course_addCourse',
					type:'post',
					data:{
						teacherCourseId:teachereCourseId,
						userId:userId
					},
					dataType:'json',
					success:function(d){
						if(d){
								$.messager.show({
								title:'温馨提示',
								msg:'恭喜你,添加成功!'
							});
							$('#student_studentCourse_datagrid').datagrid('load');
						}else{
							$.messager.show({
								title:'温馨提示',
								msg:'对不起，该实验课程已添加!'
							});
						}
					}
				});
			}else{
				$.messager.show({
					title:'温馨提示',
					msg:'添加已取消!'
				});
			}
			$('#student_allTeacherCourse_datagrid').datagrid('unselectAll');
		});
	}
	
	//查询
	function student_allTeacherCourse_search(value,name){
		if(name == 'userName'){
			userName = value;
			courseName = '';
		}else{
			userName = '';
			courseName = value;
		}
		
		$('#student_allTeacherCourse_datagrid').datagrid('load',{
			userName:userName,
			courseName:courseName
		});
	}
</script>
<table id="student_allTeacherCourse_datagrid"></table>

<div id="student_allTeacherCourse_toolbar">
	<input id="student_allTeacherCourse_input"  class="easyui-searchbox" style="width:300px"  data-options="searcher:student_allTeacherCourse_search,prompt:'请输入搜索信息',menu:'#student_allTeacherCourse_search'"></input>  
	<div id="student_allTeacherCourse_search" style="width:120px">  
	    <div data-options="name:'userName',iconCls:'icon-ok'">教师姓名</div>  
	    <div data-options="name:'courseName',iconCls:'icon-ok'">课程名</div>  
	</div>  
</div>