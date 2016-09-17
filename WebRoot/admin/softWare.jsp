<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--学习软件 页面--%>
<script type="text/javascript">
	$(function(){
		$("#admin_softWare_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/SoftWare_getSoftWare',
			fitColumns:true,
			fit:true,
			border:false,
			pagination:true,
			idField:'id',
			sortName:'addTime',
			sortOrder:'desc',
			pageList:[15,20,50],
			showHeader:true,
			checkOnSelect:true,
			selectOnCheck:true,
			columns : [[{
				field : 'id',
				checkbox:true
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
				field : 'url',
				width : 120,
				hidden:true
			},{
				field : 'downloadSoftWare',
				title : '软件下载',
				width : 120,
				align:'left',
				formatter:function(value,row,index){
					return '<span style="cursor:pointer;color:#8080C0;" onclick="admin_downloadSoftWare(\''+row.url+'\',\''+row.name+'\');">下载</span>';
				}
			}]],
			toolbar:'#admin_softWare_toolbar'
		});
	});
	//软件下载
	function admin_downloadSoftWare(url,name){
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
	function admin_softWare_search(value,name){
		if(name == 'userName'){
			userName = value;
			name = '';
		}else{
			userName = '';
			name = value;
		}
		$('#admin_softWare_datagrid').datagrid('load',{
			userName:userName,
			name:name
		});
	}
	//上传软件
	function admin_softWare_upload(){
		var url = '${pageContext.request.contextPath}/teacher/uploadSoftWare.jsp';
		$("<div/>").dialog({
		    title: '软件上传',  
		    width: 480,  
		    height: 360,  
		    closed: false,  
		    cache: false,  
		    content: '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:100%;"></iframe>',
		    modal: true,
		    onClose:function(){
		    	$(this).dialog('destroy');
		    }
		});
	}
	
	//删除软件信息
	function admin_softWare_remove(){
		var rows = $('#admin_softWare_datagrid').datagrid('getSelections');
		var ids = [];
		var urls = [];
		if(rows.length == 0){
			$.messager.show({
				title:'提示',
				msg:'请选择要删除的行!'
			});
		}else{
			for(var i = 0;i < rows.length;i++){
				ids.push(rows[i].id);
			}
			for(var i = 0;i < rows.length;i++){
				urls.push(rows[i].url);
			}
			$.messager.confirm('请确认','你确定要删除选中的软件吗?',function(data){
				if(data){
					$.ajax({
						url:'${pageContext.request.contextPath}/admin/SoftWare_deleteSoftWare',
						type:'post',
						data:{
							ids:ids.join(','),
							url:urls.join(',')
						},
						dataType:'json',
						success:function(d){
							if(d){
								$('#admin_softWare_datagrid').datagrid('load');
								$.messager.show({
									title:'提示',
									msg:'恭喜你,删除成功!'
								});
							}else{
								$('#admin_softWare_datagrid').datagrid('rejectChanges');
								$.messager.show({
									title:'提示',
									msg:'对不起,删除失败!'
								});
							}
							$('#admin_softWare_datagrid').datagrid('unselectAll');
						}
					});
				}else{
					$('#admin_softWare_datagrid').datagrid('unselectAll');
				}
			});
		}
	}
	
	//取消选中
	function admin_softWare_rollBack(){
		$('#admin_softWare_datagrid').datagrid('rejectChanges');
		$('#admin_softWare_datagrid').datagrid('unselectAll');
	}
	
</script>

<table id="admin_softWare_datagrid"></table>
<div id="admin_softWare_toolbar" style="height:28px;">
	<div style="float:left">
		<a onclick="admin_softWare_upload();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">上传软件</a>
		<a onclick="admin_softWare_remove()" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除软件</a>
		<a onclick="admin_softWare_rollBack()" class="easyui-linkbutton" data-options="iconCls:'icon-redo',plain:true">取消选中</a>
		
	</div>   
	<div style="float:left;margin-left:12px;margin-top:3px">
		<input class="easyui-searchbox" style="width:300px;margin-top:6px;"  data-options="searcher:admin_softWare_search,prompt:'请输入搜索信息',menu:'#admin_softWare_search'"></input>  
		<div id="admin_softWare_search" style="width:120px;">  
		    <div data-options="name:'name',iconCls:'icon-ok'">软件名称</div>  
		    <div data-options="name:'userName',iconCls:'icon-ok'">上传人</div>
		</div>  
	</div>
</div>