<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--学习软件 页面--%>
<script type="text/javascript">
	$(function(){
		$("#teacher_softWare_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/SoftWare_getSoftWare',
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
				hidden:true,
				align:'center'
			},{
				field : 'name',
				title : '软件名称',
				width : 240,
				align:'left'
			},{
				field : 'size',
				title : '大小',
				width : 40,
				align:'left'
			},{
				field : 'userName',
				title : '上传人',
				width : 120,
				align:'left'
			},{
				field : 'addTime',
				title : '上传时间',
				width : 120,
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
					return '<span style="cursor:pointer;color:#8080C0;" onclick="teacher_downloadSoftWare(\''+row.url+'\',\''+row.name+'\');">下载</span>';
				}
			}]],
			toolbar:'#teacher_softWare_toolbar'
		});
	});
	//软件下载
	function teacher_downloadSoftWare(url,name){
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
	function teacher_softWare_search(value,name){
		if(name == 'userName'){
			userName = value;
			name = '';
		}else{
			userName = '';
			name = value;
		}
		$('#teacher_softWare_datagrid').datagrid('load',{
			userName:userName,
			name:name
		});
	}
	
</script>

<div class="easyui-tabs" data-options="fit:true,border:false" style="height:480px;">
	<%-- 我的软件--%>
	<div title="我的软件" style="padding:2px;" data-options="href:'${pageContext.request.contextPath}/teacher/mySoftWare.jsp',tools:[{
        iconCls:'icon-mini-refresh',
        handler:function(){
           $('#teacher_mySoftWare_datagrid').datagrid('load',{});
           $('#teacher_mySoftWare_datagrid').datagrid('unselectAll');
        }
    }]">
	</div>
	
	<%-- 所有软件--%>
	<div title="所有软件" data-options="tools:[{
        iconCls:'icon-mini-refresh',
        handler:function(){
           $('#teacher_softWare_datagrid').datagrid('load',{});
           $('#teacher_softWare_datagrid').datagrid('unselectAll');
        }
    }]" style="padding:2px;">
    	<table id="teacher_softWare_datagrid"></table>
    </div>
</div>

<div id="teacher_softWare_toolbar" style="height:28px;">  
	<div style="margin-top:3px">
		<input class="easyui-searchbox" style="width:300px;margin-top:6px;"  data-options="searcher:teacher_softWare_search,prompt:'请输入搜索信息',menu:'#teacher_softWare_search'"></input>  
		<div id="teacher_softWare_search" style="width:120px;">  
		    <div data-options="name:'name',iconCls:'icon-ok'">软件名称</div>  
		    <div data-options="name:'userName',iconCls:'icon-ok'">上传人</div>
		</div>  
	</div>
</div>