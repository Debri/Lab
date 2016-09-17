<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--上机任务 页面--%>
<script type="text/javascript">
	$(function(){
		$("#teacher_allTeacherCourse_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Course_getCourseByType?type=teacher',
			fitColumns:true,
			fit:true,
			pagination:true,
			idField:'id',
			sortName:'addTime',
			sortOrder:'asc',
			pageList:[14,20,50],
			showHeader:true,
			singleSelect:true,
			columns : [[{
				field : 'id',
				width:60,
				hidden:true,
				align:'left'
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
				width : 100,
				align:'left',
				formatter:function(value,row,index){
					return '<span>第'+value+'个学期</span>';
				}
			},{
				field : 'userName',
				title : '课程教师',
				width : 100,
				align:'left'
			},{
				field : 'addTime',
				title : '发布时间',
				width : 120,
				align:'left',
				sortable:true
			}]],
			toolbar:'#teacher_allTeacherCourse_toolbar',
			view: detailview,
            detailFormatter:function(index,row){
                return '<div style="padding:2px;"><table id="teacher_allTeacherCourse-' + index + '"></table></div>';
            },
            onExpandRow: function(index,row){
                $('#teacher_allTeacherCourse-'+index).datagrid({
                    url:'${pageContext.request.contextPath}/Task_getTaskByTeacherCourseId?teacherCourseId='+row.id,
                    fitColumns:true,
                    singleSelect:true,
                    loadMsg:'',
                    height:'auto',
                    columns : [[{
        				field : 'taskId',
        				hidden:true,
        				align:'left'
        			},{
        				field : 'courseId',
        				hidden:true,
        				align:'left'
        			},{
        				field : 'taskName',
        				title : '实验任务',
        				width : 120,
        				align:'left'
        			},{
        				field : 'fileNameF',
        				title : '附件名称',
        				width : 240,
        				align:'left',
        				formatter:function(value,row,index){
        					return '<span style="cursor:pointer;color:#8080C0;" onclick="teacher_downloadTask(\''+row.fileNameF+'\',\''+row.url+'\');">'+value+'</span>';
        				}
        			},{
        				field : 'addTime',
        				title : '发布时间',
        				width : 120,
        				align:'left',
        				sortable:true
        			}]],
                    onResize:function(){
                        $('#teacher_allTeacherCourse_datagrid').datagrid('fixDetailRowHeight',index);
                    },
                    onLoadSuccess:function(){
                        setTimeout(function(){
                            $('#teacher_allTeacherCourse_datagrid').datagrid('fixDetailRowHeight',index);
                        },0);
                    }
                });
                $('#teacher_allTeacherCourse_datagrid').datagrid('fixDetailRowHeight',index);
            }
		});
	});
	
	//查询
	function teacher_allTeacherCourse_search(value,name){
		if(name == 'userName'){
			userName = value;
			courseName = '';
			term='';
		}else if(name=='courseName'){
			userName = '';
			courseName = value;
			term='';
		}else if(name='term'){
			userName='';
			courseName='';
			term=value;
			
		
		}
		
		$('#teacher_allTeacherCourse_datagrid').datagrid('load',{
			userName:userName,
			courseName:courseName,
			term:term
		});
	}
</script>
<table id="teacher_allTeacherCourse_datagrid"></table>

<div id="teacher_allTeacherCourse_toolbar">
	<input id="teacher_allTeacherCourse_input"  class="easyui-searchbox" style="width:300px"  data-options="searcher:teacher_allTeacherCourse_search,prompt:'请输入搜索信息',menu:'#teacher_allTeacherCourse_search'"></input>  
	<div id="teacher_allTeacherCourse_search" style="width:120px">  
	    <div data-options="name:'userName',iconCls:'icon-ok'">教师姓名</div>  
	    <div data-options="name:'courseName',iconCls:'icon-ok'">课程名</div>  
	    <div data-options="name:'term',iconCls:'icon-ok'">学期</div> 
	</div>  
</div>