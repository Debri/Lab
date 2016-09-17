<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var teacher_myMaterial_editRow = undefined;
	var userId = '${sessionScope.user.userId}';
	$(function(){
		$("#teacher_myMaterial_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/Material_getMaterial?userId='+userId,
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
				field : 'url',
				title : '资料url',
				width : 120,
				align:'center',
				hidden:true
			},{
				field : 'addTime',
				title : '上传时间',
				width : 120,
				align:'left',
				sortable:true
			},{
				field : 'delMyMaterial',
				title : '资料处理',
				width : 120,
				align:'left',
				formatter:function(value,row,index){
					return '<span style="cursor:pointer;color:#B22222;" onclick="teacher_myMaterial_delete(\''+row.url+'\',\''+row.id+'\');">删除</span>';
				}
			}]],
			toolbar:'#teacher_material_toolbar'
		});
	});
	
	//教师删除自己的资料
	function teacher_myMaterial_delete(url1,id){
		$.messager.confirm('请确认!','你确定要删除该资料吗?',function(data){
			if(data){
				$.ajax({
					url:'${pageContext.request.contextPath}/Material_deleteMaterialById',
					type:'post',
					data:{
						id:id,
						url:url1
					},
					dataType:'json',
					success:function(d){
						if(d){
							$('#teacher_myMaterial_datagrid').datagrid('load');
							$.messager.show({
								title:'提示',
								msg:'恭喜你,删除成功!'
							});
						}else{
							$('#teacher_myMaterial_datagrid').datagrid('rejectChanges');
							$.messager.show({
								title:'提示',
								msg:'对不起,删除失败!'
							});
						}
						$('#teacher_myMaterial_datagrid').datagrid('unselectAll');
					}				
				});
			}
		});
	}
	
	//上传
	function teacher_material_upload(){
		var url = '${pageContext.request.contextPath}/teacher/uploadMaterial.jsp';
		$("<div/>").dialog({
		    title: '上传资料(120M以内哦！)',  
		    width: 500,  
		    height: 420,  
		    closed: false,  
		    cache: false,  
		    content: '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:100%;"></iframe>',
		    modal: true,
		    onClose:function(){
		    	$(this).dialog('destroy');
		    }
		});
	}
</script>

<table id="teacher_myMaterial_datagrid"></table>

<div id="teacher_material_toolbar" style="height:28px;border-bottom:1px solid #F3F3F3">
	<div style="float:left">
		<a onclick="teacher_material_upload();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">资料上传</a>
	</div> 
</div>

