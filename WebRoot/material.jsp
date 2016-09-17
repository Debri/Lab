<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--资料下载 页面--%>
<script type="text/javascript">
	$(function(){
		$("#material_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Material_getMaterial',
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
				hidden:true,
				align:'center'
			},{
				field : 'title',
				title : '资料名称',
				width : 240,
				align:'left'
			},{
				field : 'size',
				title : '大小',
				width : 60,
				align:'left'
			},{
				field : 'userName',
				title : '上传人',
				width : 100,
				align:'left'
			},{
				field : 'addTime',
				title : '上传时间',
				width : 100,
				align:'left',
				sortable:true
			},{
				field : 'url',
				width : 120,
				hidden:true
			},{
				field : 'downloadMaterial',
				title : '下载资料',
				width : 120,
				align:'center',
				formatter:function(value,row,index){
					return '<span style="cursor:pointer;color:#8080C0;" onclick="downloadMaterial(\''+row.url+'\',\''+row.title+'\');">下载</span>';
				}
			}]],
			toolbar:'#material_toolbar'
		});
	});
	//资料下载
	function downloadMaterial(url,name){
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
	//查询
	function material_search(value,name){
		if(name == 'userName'){
			userName = value;
			title = '';
		}else{
			userName = '';
			title = value;
		}
		
		$('#material_datagrid').datagrid('load',{
			userName:userName,
			title:title
		});
	}
</script>

<table id="material_datagrid"></table>

<div id="material_toolbar">
	<input  class="easyui-searchbox" style="width:300px"  data-options="searcher:material_search,prompt:'请输入搜索信息',menu:'#material_search'"></input>  
	<div id="material_search" style="width:120px">  
	    <div data-options="name:'title',iconCls:'icon-ok'">资料名</div>  
	    <div data-options="name:'userName',iconCls:'icon-ok'">上传人</div>  
	</div>  
</div>