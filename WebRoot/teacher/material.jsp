<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--资料下载 页面--%>
<script type="text/javascript">
	$(function(){
		$("#teacher_material_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Material_getMaterial',
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
			columns : [[{
				field : 'id',
				width : 60,
				hidden:true
			},{
				field : 'title',
				title : '资料名',
				width : 240,
				align:'left'
			},{
				field : 'size',
				title : '大小',
				width : 40,
				align:'left'
			},{
				field : 'uuid',
				title : '资料uuid',
				width : 120,
				align:'center',
				hidden:true
			},{
				field : 'type',
				width : 120,
				align:'center',
				hidden:true
			},{
				field : 'url',
				title : '资料url',
				width : 120,
				align:'center',
				hidden:true
			},{
				field : 'userName',
				title : '上传人',
				width : 120,
				align:'left',
				sortable:true
			},{
				field : 'addTime',
				title : '上传时间',
				width : 120,
				align:'left',
				sortable:true
			},{
				field : 'download',
				title : '下载资料',
				width : 120,
				align:'left',
				formatter:function(value,row,index){
					return '<span style="cursor:pointer;color:#8080C0;" onclick="teacher_downloadMaterial(\''+row.url+'\',\''+row.title+'\');">下载</span>';
				}
			}]],
			toolbar:'#teacher_material_toolbar'
		});
	});
	
	
	
	//资料下载
	function teacher_downloadMaterial(url,name){
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
			}else{
				$('#computerMaterial_datagrid').datagrid('unselectAll');
			}
		});
	}
	//资料搜索
	function teacher_material_search(value,name){
		if(name == 'userName'){
			userName = value;
			title = '';
		}else{
			userName = '';
			title = value;
		}
		
		$('#teacher_material_datagrid').datagrid('load',{
			userName:userName,
			title:title
		});
	}
</script>

<div class="easyui-tabs" data-options="fit:true,border:false" style="height:480px;">
	
	<%-- 我的资料--%>
	<div title="我的资料" style="padding:2px;" data-options="href:'${pageContext.request.contextPath}/teacher/myMaterial.jsp',tools:[{
        iconCls:'icon-mini-refresh',
        handler:function(){
           $('#teacher_myMaterial_datagrid').datagrid('load',{});
           $('#teacher_myMaterial_datagrid').datagrid('unselectAll');
        }
    }]">
    </div>
	
	<%-- 计算机类资料--%>
	<div title="所有资料" style="padding:2px;" data-options="tools:[{
        iconCls:'icon-mini-refresh',
        handler:function(){
           $('#teacher_material_datagrid').datagrid('load',{});
           $('#teacher_material_datagrid').datagrid('unselectAll');
        }
    }]" style="padding:2px;">
		<table id="teacher_material_datagrid"></table>
	</div>
</div>

<div id="teacher_material_toolbar" style="height:28px;">  
<div style="margin-top:3px">
	<input class="easyui-searchbox" style="width:300px;margin-top:6px;"  data-options="searcher:teacher_material_search,prompt:'请输入搜索信息',menu:'#teacher_material_search'"></input>  
	<div id="teacher_material_search" style="width:120px;">  
	    <div data-options="name:'name',iconCls:'icon-ok'">资料名</div>  
	    <div data-options="name:'userName',iconCls:'icon-ok'">上传人</div>
	</div>  
	</div>
</div>
