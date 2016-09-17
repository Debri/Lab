<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<script type="text/javascript">
	//管理员清除教师下载学生作业是产生的临时文件
	function admin_tem_remove(){
		$.messager.confirm('请确认','你确定要清除 吗?',function(data){
			if(data){
				$.ajax({
					url:'${pageContext.request.contextPath}/Tem_clear',
					type:'post',
					data:{
						url:'E:\\lab\\tem'
					},
					dataType:'json',
					success:function(d){
						if(d){
							$.messager.show({
								title:'温馨提示',
								msg:'恭喜你,清理已完成!'
							});
						}else{
							$.messager.show({
								title:'温馨提示',
								msg:'对不起,清理失败!'
							});
						}
					}
				});
			}else{
				$.messager.show({
					title:'温馨提示',
					msg:'清理已取消!'
				});
			}
		});
	}
</script>


<div class="easyui-panel" data-options="title:'清除说明'" style="height:240px; font-size:16px;text-align:left;padding:12px;margin:2px;">
	<b>	
		该功能是用于删除教师在批量下载学生作业时所产生的打包临时文件<br/><br/>
		删除时只会删除临时文件<br/><br/>
		不会对学生作业产生影响<br/><br/>
		删除的好处是节约系统硬盘空间
	</b>
</div>

<a onclick="admin_tem_remove()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-cut'">确认清除</a>