<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--学生实验任务 页面--%>
<script type="text/javascript">
	
	var userId = '${sessionScope.user.userId }';
	$(function(){
		$("#student_studentCourse_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Course_getCourseByUserId?type=student&userId='+userId,
			fitColumns:true,
			fit:true,
			pagination:true,
			border:true,
			idField:'id',
			sortName:'addTime',
			sortOrder:'desc',
			pageList:[14,20,50],
			showHeader:true,
			singleSelect:true,
			columns : [[{
				//学生实验课程id，用于删除实验任务和查询实验任务
				field : 'studentCourseId',
				width:60,
				align:'center',
				hidden:true
			},{
				field : 'teacherCourseId',
				width:60,
				align:'center',
				hidden:true
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
				title : '实验教师',
				width : 120,
				align:'left'
			},{
				field : 'addTime',
				title : '选课时间',
				width : 120,
				align:'left',
				sortable:true
			},{
				field : 'delStudentCourse',
				title : '课程处理',
				width : 120,
				align:'left',
				formatter:function(value,row,index){
					return '<span style="cursor:pointer;color:#B22222;" onclick="student_allStudentCourse_deleteCourse(\''+row.studentCourseId+'\');">删除任务</span>';
				}
			}]],
			view: detailview,
            detailFormatter:function(index,row){
                return '<div style="padding:2px;"><table id="student_studentCourse-' + index + '"></table></div>';
            },
            onExpandRow: function(index,row){
            	var studentCourseId = row.studentCourseId;
                $('#student_studentCourse-'+index).datagrid({
                	//学生查看对应课程下的实验任务
                    url:'${pageContext.request.contextPath}/Task_getTaskByTeacherCourseId?teacherCourseId='+row.teacherCourseId,
                    fitColumns:true,
                    singleSelect:true,
                    loadMsg:'',
                    height:'auto',
                    columns:[[
						{field:'id',width:60,hidden:true,align:'left'},
						{field:'workDir',width:60,hidden:true,align:'left'}, 
						{field:'url',width:60,hidden:true,align:'left'},  
                        {field:'taskName',title:'实验任务',width:60,align:'left'},
                        {field:'fileNameF',title:'附件名称',width:180,align:'left',
                        	formatter:function(value,row,index){
                       			/*  undefined显示为null */
                        		if(value=== undefined) {
                       				value=' ';
                       			}else{
            					return '<span style="cursor:pointer;color:#8080C0;" onclick="student_studentCourse_downloadTask(\''+row.fileNameF+'\',\''+row.url+'\');">'+value+'</span>';
                       			}
                       		}
                        	
                        },
                        {field:'addTime',title:'发布时间',width:60,align:'left'},
                        {field:'uploadWork',title:'作业处理',width:100,align:'left',
                        	formatter:function(value,row,index){
            					return '<span style="cursor:pointer;color:#8080C0;" onclick="student_studentWork_uploadWork(\''+studentCourseId+'\',\''+row.workDir+'\',\''+row.id+'\');">上传作业</span>'+
            					'<span style="cursor:pointer;color:#8080C0;margin-left:14px;" onclick="student_studentCourse_getWork(\''+row.id+'\');">查看作业</span>';
            				}
                        }
                    ]],
                    onResize:function(){
                        $('#student_studentCourse_datagrid').datagrid('fixDetailRowHeight',index);
                    },
                    onLoadSuccess:function(){
                        setTimeout(function(){
                            $('#student_studentCourse_datagrid').datagrid('fixDetailRowHeight',index);
                        },0);
                    }
                });
                $('#student_studentCourse_datagrid').datagrid('fixDetailRowHeight',index);
            }
		});
	});
	
	//学生删除自己添加的实验课程
	function student_allStudentCourse_deleteCourse(studentCourseId){
		$.messager.confirm('请确认','删除该任务会删除自己上传到该任务下的作业，你确定吗?',function(data){
			if(data){
				$.ajax({
					url:'${pageContext.request.contextPath}/student/Course_deleteCourse',
					type:'post',
					data:{
						studentCourseId:studentCourseId
					},
					dataType:'json',
					success:function(d){
						if(d){
							$('#student_studentCourse_datagrid').datagrid('load');
							$.messager.show({
								title:'提示',
								msg:'删除成功!'
							});
						}else{
							$.messager.show({
								title:'提示',
								msg:'对不起,删除失败!'
							});
						}
					}
				});
			}else{
				$.messager.show({
					title:'提示',
					msg:'已取消删除操作!'
				});
			}
			$('#student_studentCourse_datagrid').datagrid('unselectAll');
		});
	}
	
	//学生上传作业
	function student_studentWork_uploadWork(studentCourseId,workDir,taskId){
		
		var url = '${pageContext.request.contextPath}/student/uploadWork.jsp?workDir='+workDir+'&studentCourseId='+studentCourseId+'&taskId='+taskId;
		$("<div/>").dialog({
		    title: '上传作业',  
		    width: 480,  
		    height: 240,  
		    closed: false,  
		    cache: false,  
		    content: '<iframe src="' + encodeURI(url) + '" frameborder="0" style="border:0;width:100%;height:100%;"></iframe>',
		    modal: true  
		});
	}
	//学生查看自己的作业
	function student_studentCourse_getWork(id){
		var url = '${pageContext.request.contextPath}/student/studentWork.jsp?taskId='+id;
		$("<div/>").dialog({
		    title: '作业信息',  
		    width: 734,  
		    height: 350,  
		    closed: false,  
		    cache: false,  
		    href: url,
		    modal: true,
		    onClose:function(){
		    	$(this).dialog('destroy');
		    }
		});
	}
	
	//学生下载实验指导书
	function student_studentCourse_downloadTask(name,url){
		$.messager.confirm('请确认','你确定要下载选择的资料吗?',function(data){
			if(data){
				//ajax实现文件下载
				var form = $("<form>");  //==>jQuery创建隐藏表单,实现ajax下载
				form.attr('style','display:none');  
				form.attr('target','');  
				form.attr('method','post');  
				form.attr('action','${pageContext.request.contextPath}/download/Download_downloadFile');  
				$('body').append(form);  
				form.append("<input type='hidden' name='url' value='"+url+"'>");
				form.append("<input type='hidden' name='fileName' value='"+name+"'>");
				form.submit();  
				form.remove();
			}
		});
	}
</script>

<div id="student_studentCourse_tabs" class="easyui-tabs" data-options="fit:true,border:false">
	<div title="我的任务" data-options="tools:[{
        iconCls:'icon-reload',
        handler:function(){
           $('#student_studentCourse_datagrid').datagrid('load');
           $('#student_studentCourse_datagrid').datagrid('unselectAll');
        }
    }]" 
    style="padding:2px;">
    
		<div id="student_studentCourse_datagrid"></div>
	</div>
	<div title="所有任务" style="padding:2px;" data-options="href:'${pageContext.request.contextPath}/student/allTeacherCourse.jsp',tools:[{
        iconCls:'icon-mini-refresh',
        handler:function(){
           $('#student_allTeacherCourse_datagrid').datagrid('load',{});
           $('#student_allTeacherCourse_datagrid').datagrid('unselectAll');
        }
    }]"></div>
</div>
