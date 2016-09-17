<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--学习软件 页面--%>
<script type="text/javascript">
	$(function(){
		$("#softWare_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/SoftWare_getSoftWare',
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
				field : 'name',
				title : '软件名称',
				width : 240,
				align:'left'
			},
			{
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
				field : 'userId',
				width : 120,
				hidden:true
			},{
				field : 'uuid',
				width : 120,
				hidden:true
			},{
				field : 'url',
				width : 120,
				hidden:true
			},{
				field : 'downloadSoftWare',
				title : '软件下载',
				width : 120,
				align:'left',
				formatter:function(value,row,index){
					return '<span style="cursor:pointer;color:#8080C0;" onclick="downloadSoftWare(\''+row.url+'\',\''+row.name+'\');">下载</span>';
				}
			}]],
			toolbar:'#softWare_toolbar'
		});
	});
	//软件下载
	function downloadSoftWare(url,name){
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
	function softWare_search(value,name){
	//alert(name);
		if(name == 'userName'){
			userName = value;
			name = '';
		}else{
			userName = '';
			name = value;
		}
		$('#softWare_datagrid').datagrid('load',{
			userName:userName,
			name:name
		});
	}
	
</script>

<table id="softWare_datagrid"></table>
<div id="softWare_toolbar" style="height:28px;">
	<input class="easyui-searchbox" style="width:300px;margin-top:6px;"  data-options="searcher:softWare_search,prompt:'请输入搜索信息',menu:'#softWare_search'"></input>  
	<div id="softWare_search" style="width:120px;">  
	    <div data-options="name:'name',iconCls:'icon-ok'">软件名称</div>  
	    <div data-options="name:'userName',iconCls:'icon-ok'">上传人</div>
	</div>
</div>