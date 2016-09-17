<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
	var id = <%=request.getParameter("id")%>;
	$(function(){
		$.ajax({
			url:'${pageContext.request.contextPath}/Announce_getAnnounceById',
			type:'post',
			data:{
				id:id
			},
			dataType:'json',
			success:function(obj){
				$("#title").html(obj.title);
				$("#auth").html(obj.userName);
				$("#content").html(obj.content);
				$("#name").html(obj.name);
				$("#name").attr('href','${pageContext.request.contextPath}/download/Download_downloadFile?url='+obj.url+'&fileName='+obj.name);
			}
		});
	});
</script>
<div  style="width:572px;height:384px;margin:2px; border:1px solid #F5F5DC">
	<p id="title" style="font-size:16px;font-weight:bold;text-align:center"></p>
	<p id="auth" style="font-size:12px;;text-align:center"></p>
	<p id="content" style="padding:12px;"></p>
</div>
<div style="width:572px;height:36px;text-align:center;margin:2px;border:1px solid #F5F5DC">
	<span>附件:</span>&nbsp;&nbsp;<span style="cursor:pointer;color:#8080C0;"><a id="name" href='#'></a></span>
</div>