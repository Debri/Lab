<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--学生作业 --%>

<script type="text/javascript">
	var taskId = <%=request.getParameter("taskId")%>;
	$(function(){
		$("#teacher_studentWork_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/teacher/Work_getWorkByTaskId?taskId='+taskId,
			fitColumns:true,
			fit:true,
			border:true,
			pagination:true,
			idField:'id',
			sortName:'addTime',
			sortOrder:'desc',
			pageList:[14,100,500],
			showHeader:true,
			checkOnSelect:true,
			selectOnCheck:true,
			frozenColumns:[[{
				field : 'id',
				width : 60,
				align:'center',
				checkbox:true
			},{
				field : 'userName',
				title : '学生姓名',
				width : 120,
				align:'left'
			},{
				field : 'userId',
				title : '学号',
				width : 130,
				align:'left'
			}]],
			columns : [[{
				field : 'workName',
				title : '作业名称',
				width : 150,
				align:'left',
				sortable:true
			},{
				field : 'addTime',
				title : '上传时间',
				width : 80,
				align:'left',
				sortable:true
			},{
				field : 'url',
				title : '作业url',
				width : 120,
				align:'left',
				hidden:true
			}]],
			toolbar:'#teacher_studentWork_toolbar'
		});
	});
	
	
	//教师下载学生作业
	function teacher_studentWork_download(){
		var rows = $('#teacher_studentWork_datagrid').datagrid('getSelections');
		//javaScript获取数字的正则表达式
		var taskName = '<%=request.getParameter("taskName") %>';
		var urls = [];
		if(rows.length == 0){
			$.messager.show({
				title:'提示',
				msg:'请选择要下载的数据!'
			});
		}else{
			for(var i = 0;i < rows.length;i++){
				urls.push(rows[i].url);
			}
			$.messager.confirm('请确认','你确定要下载选择的作业吗?',function(data){
				if(data){
					//ajax实现文件下载
					var form = $("<form>");  //==>jQuery创建隐藏表单,实现ajax下载
					form.attr('style','display:none');  
					form.attr('target','');  
					form.attr('method','post');  
					form.attr('action','${pageContext.request.contextPath}/download/WorkUtil_downloadWork');  
					$('body').append(form);  
					form.append("<input type='hidden' name='urls' value='"+ urls +"'>");
					form.append("<input type='hidden' name='num' value='"+ taskName +"'>");
					form.submit();  
					form.remove();
				}else{
					$('#teacher_studentWork_datagrid').datagrid('unselectAll');
					teacher_studentWork_editRow = undefined;
				}
		});
		}
	}
	//取消选中
	function teacher_studentWork_rollBack(){
		$('#teacher_studentWork_datagrid').datagrid('unselectAll');
	}
	
	//查询功能
	function teacher_studentWork_search(value,name){
		if(name == 'userName'){
			userName = value;
			userId = '';
		}else{
			userName = '';
			userId = value;
		}
		$('#teacher_studentWork_datagrid').datagrid('load',{
			userName:userName,
			userId:userId
		});
	}
</script>

<table id="teacher_studentWork_datagrid"></table>


<div id="teacher_studentWork_toolbar" style="height:28px;">
	<div style="float:left">
		<a onclick="teacher_studentWork_download()" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">下载</a>
	    <a onclick="teacher_studentWork_rollBack()" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">取消</a>
	</div>   
	<div style="float:left;margin-left:12px;margin-top:3px">
		<input class="easyui-searchbox" style="width:300px"  data-options="searcher:teacher_studentWork_search,prompt:'请输入搜索信息',menu:'#teacher_studentWork_search'"></input>  
		<div id="teacher_studentWork_search" style="width:120px">  
		    <div data-options="name:'userName',iconCls:'icon-ok'">姓名</div> 
		    <div data-options="name:'userId',iconCls:'icon-ok'">学号</div> 
		</div>  
	</div>
</div>
