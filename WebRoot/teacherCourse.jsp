<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--上机任务 页面--%>
<script type="text/javascript">
	$(function(){
		$("#teacherCourse_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Course_getCourseByType?type=teacher',
			fitColumns:true,
			fit:true,
			pagination:true,
			idField:'id',
			sortName:'addTime',
			sortOrder:'desc',
			pageList:[15,20,50],
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
				width : 120,
				align:'left'
			},{
				field : 'term',
				title : '学期',
				width : 120,
				align:'left',
				formatter:function(value,row,index){
					return '<span>第'+value+'个学期</span>';
				}
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
			toolbar:'#teacherCourse_toolbar',
			view: detailview,
            detailFormatter:function(index,row){
                return '<div style="padding:2px;"><table id="teacherCourse-' + index + '"></table></div>';
            },
            onExpandRow: function(index,row){
                $('#teacherCourse-'+index).datagrid({
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
        				width : 120,
        				align:'left',
        				//formatter:function(value,row,index){
        				//	return '<span">第'+value+'次实验任务</span>';
        				//}
        			},{
        				field : 'fileNameF',
        				title : '实验任务附件',
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
                        $('#teacherCourse_datagrid').datagrid('fixDetailRowHeight',index);
                    },
                    onLoadSuccess:function(){
                        setTimeout(function(){
                            $('#teacherCourse_datagrid').datagrid('fixDetailRowHeight',index);
                        },0);
                    }
                });
                $('#teacherCourse_datagrid').datagrid('fixDetailRowHeight',index);
            }
		});
	});
	
	//查询
	function teacherCourse_search(value,name){
		if(name == 'userName'){
			userName = value;
			courseName = '';
		}else{
			userName = '';
			courseName = value;
		}
		
		$('#teacherCourse_datagrid').datagrid('load',{
			userName:userName,
			courseName:courseName
		});
	}
</script>

<table id="teacherCourse_datagrid"></table>

<div id="teacherCourse_toolbar">
	<input class="easyui-searchbox" style="width:300px"  data-options="searcher:teacherCourse_search,prompt:'请输入搜索信息',menu:'#teacherCourse_search'"></input>  
	<div id="teacherCourse_search" style="width:120px">  
	    <div data-options="name:'userName',iconCls:'icon-ok'">教师姓名</div>  
	    <div data-options="name:'courseName',iconCls:'icon-ok'">课程名</div>  
	</div>  
</div>