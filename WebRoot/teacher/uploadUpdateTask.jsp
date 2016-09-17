<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>SWFUpload Demos - Simple Demo</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/swfu/swfupload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/swfu/swfupload.queue.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/swfu/fileprogress.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/swfu/handlers.js"></script>
<script type="text/javascript"	src="${pageContext.request.contextPath}/javaScript/jquery-1.8.0.min.js"></script>
<script type="text/javascript">
        var swfu;
		window.onload = function() {
		//修改任务
		var oTask = document.getElementById('taskName');
		var oTaskName = "<%=new String(request.getParameter("taskName").getBytes("ISO-8859-1"),"utf-8")%>";
		if(oTaskName === "undefined" || oTaskName === null || oTaskName === ""){
			oTask.value = "";
		}else{
			
			oTask.value = oTaskName;
		}

		var oSure=document.getElementById('sure');
		var oS=document.getElementById('select');
		var oStart=document.getElementById('start');
		var oCancel = document.getElementById('cancel');
		var oUpload = document.getElementById('upload');
		oStart.onclick=function(){
			oS.style.display='inline';
			oStart.style.display='none';
			oSure.style.display='none';
		};
		//只修改任务名称
		oSure.onclick=function(){
			//alert(oTask.value);
			var taskId = '<%=request.getParameter("taskId")%>';
			var url = '<%=new String(request.getParameter("url").getBytes("ISO-8859-1"),"utf-8")%>';
			var workDir = '<%=new String(request.getParameter("workDir").getBytes("ISO-8859-1"),"utf-8")%>';
			var taskName = document.getElementById('taskName').value;
			
			var obj = {
						 "taskId":taskId,
						 "url":url,
						 "workDir":workDir,
						 "taskName": taskName
				};
				//swfu.setPostParams(obj);
			$.ajax({
				url:'${pageContext.request.contextPath}/teacher/TaskUtil_onlyUpdateTask',
    			type:'post',
    			data:obj,
    			dataType:'json',
    			success:function(b){
    				
    				alert(b);
    				
    			}
			});
		};
		
		oCancel.onclick = function(){
			oS.style.display='none';
			oStart.style.display='inline';
			oSure.style.display='inline';
		};
		
		//修改实验指导书
		oUpload.onclick = function(){
			alert("上传后将会覆盖原实验任务附件");
			swfu.startUpload();
		};
		
		
		
			var settings = {
				flash_url : "${pageContext.request.contextPath}/javaScript/swfu/swfupload.swf",
				upload_url: '${pageContext.request.contextPath}/teacher/TaskUtil_updateTask',
				file_post_name : "file",
				file_size_limit : "30 MB",
				file_types : "*.*",
				file_types_description : "All Files",
				file_upload_limit : 100,
				file_queue_limit : 0,
				custom_settings : {
					progressTarget : "fsUploadProgress",
				},
				debug: false,

				// Button settings
				button_image_url: "${pageContext.request.contextPath}/images/uploadbtn.png",
				button_width: "65",
				button_height: "26",
				button_placeholder_id: "spanButtonPlaceHolder",
				
				// The event handler functions are defined in handlers.js
				file_queued_handler : fileQueued,
				file_queue_error_handler : fileQueueError,
				file_dialog_complete_handler : fileDialogComplete,
				
				//文件选择好后可以在这里设置上传参数post_params{},调用handlers.js中的uploadStart()方法
				upload_start_handler : uploadStartFile,
				
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_success_handler : uploadSuccess
			};

			swfu = new SWFUpload(settings);
		
	     };
	     
	     function uploadStartFile(){
	    	//上传文件前在这设置参数
			var taskId = <%=request.getParameter("taskId")%>;
			var url = '<%=new String(request.getParameter("url").getBytes("ISO-8859-1"),"utf-8")%>';
			var workDir = '<%=new String(request.getParameter("workDir").getBytes("ISO-8859-1"),"utf-8")%>';
			var taskName = document.getElementById('taskName').value;
			var obj = {
						 "taskId":taskId,
						 "url":url,
						 "workDir":workDir,
						 "taskName": taskName
				};
			 swfu.setPostParams(obj);
	     }
	     

	</script>
</head>
<body>

<div id="content">
	<form  method="post" enctype="multipart/form-data">
	
		<!--修改发布任务  -->
		<div>
			<span><b>任务名称</b></span>
			<span>
				<input id="taskName" type="text" value="" style="border-color:gray;"/>
			</span>
		<input type="button" id="sure" value="发布任务" style="width:60px;display:inline;height:24px;font-size:1em;"/>
		<input type="button" id="start" value="重新上传实验任务附件" onclick="uploadTaskName()"  style="margin-left: 2px;"/>
		</div>
	
		<div id="select" style="display:none">
			<div>您只能上传30M以内的文件哦</div>
			<div class="fieldset flash" id="fsUploadProgress">
				<span class="legend">请选择实验任务附件</span>
			</div>
			<div id="swfupload_btn">
				<span id="spanButtonPlaceHolder"></span>
				<!-- 文件名称为num -->
				<input id="upload" type="button" value="上传并发布任务" style="margin-left: 2px; font-size: 8pt; height: 24px;"/>
				<input id="cancel" type="button" value="取消上传"  style="margin-left: 2px; font-size: 8pt; height: 24px;"/>
			</div>
		</div>
	</form>
</div>
</body>
</html>
