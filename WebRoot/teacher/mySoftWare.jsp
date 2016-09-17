<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--学习软件 页面--%>
<script type="text/javascript">
    var userId = '${sessionScope.user.userId}';
	$(function(){
		$("#teacher_mySoftWare_datagrid").datagrid({
			url : '${pageContext.request.contextPath}/SoftWare_getSoftWare?userId='+userId,
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
			},{
				field : 'size',
				title : '大小',
				width : 40,
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
				field : 'delMySoftWare',
				title : '软件处理',
				width : 120,
				align:'left',
				formatter:function(value,row,index){
					return '<span style="cursor:pointer;color:#B22222;" onclick="teacher_deleteMySoftWare(\''+row.url+'\',\''+row.id+'\');">删除</span>';
				}
			}]],
			toolbar:'#teacher_softWare_toolbar'
		});
	});
	//教师删除自己上传的软件
	function teacher_deleteMySoftWare(url1,id){
		$.messager.confirm('请确认!','你确定要删除此软件吗?',function(data){
			if(data){
				$.ajax({
					url:'${pageContext.request.contextPath}/SoftWare_deleteSoftWareById',
					type:'post',
					data:{
						id:id,
						url:url1
					},
					dataType:'json',
					success:function(d){
						if(d){
							$('#teacher_mySoftWare_datagrid').datagrid('load');
							$.messager.show({
								title:'提示',
								msg:'恭喜你,删除成功!'
							});
						}else{
							$('#teacher_mySoftWare_datagrid').datagrid('rejectChanges');
							$.messager.show({
								title:'提示',
								msg:'对不起,删除失败!'
							});
						}
						$('#teacher_mySoftWare_datagrid').datagrid('unselectAll');
					}				
				});
			}
		});
	}
	//上传软件
	function teacher_softWare_upload(){
		var url = '${pageContext.request.contextPath}/teacher/uploadSoftWare.jsp';
		$("<div/>").dialog({
		    title: '软件上传（1024M以内哦！）',  
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
</script>

<table id="teacher_mySoftWare_datagrid"></table>
<div id="teacher_softWare_toolbar" style="height:28px;">
	<div style="float:left">
		<a onclick="teacher_softWare_upload();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">软件上传</a>
	</div>   
</div>