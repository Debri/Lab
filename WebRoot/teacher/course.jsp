<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--课程页面，教师用于发布实验任务 --%>
<script type="text/javascript">
	$(function(){
		$("#teacher_course_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Course_getCourseByType?type=admin',
			fitColumns:true,
			fit:true,
			border:true,
			pagination:true,
			idField:'id',
			sortName:'addTime',
			sortOrder:'desc',
			pageList:[14,20,50],
			showHeader:true,
			singleSelect:true,
			frozenColumns:[[{
				field : 'id',
				hidden:true
			},{
				field : 'courseName',
				title : '课程名',
				width : 320,
				align:'left'
			}]],
			columns : [[{
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
				field : 'addTime',
				title : '发布时间',
				width : 100,
				align:'left',
				sortable:true
			},{
				field : 'addCourse',
				title : '添加实验课程',
				width : 100,
				align:'left',
				formatter:function(value,row,index){
					return '<span style="cursor:pointer;color:#8080C0;" onclick="teacher_course_addCourse(\''+row.id+'\');">添加课程</span>';
				}
			}]],
			toolbar:'#teacher_course_toolbar'
		});
	});
	
	//教师添加课程
	function teacher_course_addCourse(courseId){
		var userId = '${sessionScope.user.userId}';
		$.messager.confirm('请确认','你确定要添加实验课程吗?',function(data){
			if(data){
				$.ajax({
					url:'${pageContext.request.contextPath}/teacher/Course_addCourseByCourseId',
					type:'post',
					data:{
						courseId:courseId,
						userId:userId
					},
					dataType:'json',
					success:function(d){
						if(d){
							$.messager.show({
								title:'温馨提示',
								msg:'恭喜你,添加成功!'
							});
							$('#teacher_teacherCourse_datagrid').datagrid('load');
						}else{
							$.messager.show({
								title:'温馨提示',
								msg:'对不起,课程已添加!'
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
			$('#teacher_course_datagrid').datagrid('unselectAll');
		});
	}
	
	//查询
	function teacher_course_search(value,name){
		if(name == 'courseName'){
			courseName = value;
			term = '';
		}else{
			courseName = '';
			term = value;
		}
		
		$('#teacher_course_datagrid').datagrid('load',{
			term:term,
			courseName:courseName
		});
	}
</script>

<table id="teacher_course_datagrid"></table>


<div id="teacher_course_toolbar">
	<input  class="easyui-searchbox" style="width:300px"  data-options="searcher:teacher_course_search,prompt:'请输入搜索信息',menu:'#teacher_course_search'"></input>  
	<div id="teacher_course_search" style="width:120px"> 
	 	<div data-options="name:'courseName',iconCls:'icon-ok'">课程名</div>   
	    <div data-options="name:'term',iconCls:'icon-ok'">学期</div>  
	</div>  
</div>