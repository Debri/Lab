<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function(){
		$("#admin_tample_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/admin/tample.json',
			fitColumns:true,
			fit:true,
			border:false,
			showHeader:true,
			checkOnSelect:true,
			selectOnCheck:true,
			columns : [[{
				field : 'type',
				title : '模板类型',
				width : 180,
				align:'left'
			},{
				field : 'name',
				title : '模板名称',
				width : 240,
				align:'left',
				formatter:function(value,row,index){
					return '<span style="cursor:pointer;color:#8080C0;" onclick="admin_downloadImport(\''+row.name+'\');">'+row.name+'</span>';
				}
			}]]
		});
	});
	
	function admin_downloadImport(name){
		var url = "E:\\lab\\tample\\"+name;
		$.messager.confirm('请确认','你确定要下载此模板吗?',function(data){
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
			}else{
				$('#computerMaterial_datagrid').datagrid('unselectAll');
			}
		});
	}
</script>



<div class="easyui-panel" data-options="title:'导入说明',border:false" style="height:240px;font-size:16px; margin-left:120px;padding:12px;">
	<br/><br/>
	<b>此系统的数据库导入至支持excel 2003或excel 2007 。<br/><br/>
		若要导入学生信息,只需要在学生信息中点击批量导入,然后选择相应的学生文件。<br/><br/>
		教师的导入和学生的一样。<br/><br/>
		课程的导入是下载课程导入模板，然后将课程信息按模板格式填写后导入。
	</b>
</div>
<div class="easyui-panel" data-options="title:'格式模版下载',border:false" style="height:240px;">
	<table id="admin_tample_datagrid"></table>
</div>
