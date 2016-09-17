<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>SWFUpload Demos - Simple Demo</title>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/swf/swfupload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/swf/swfupload.queue.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/swf/fileprogress.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/swf/handlers.js"></script>
<script type="text/javascript">
		var swfu;
		window.onload = function() {
			var settings = {
				flash_url : "${pageContext.request.contextPath}/js/swf/swfupload.swf",
				upload_url: "PictureAction",
				use_query_string:false,
				//post_params: {"firstname" : "fffffffffff"},
				file_post_name : "file",
				file_size_limit : "100 MB",
				file_types : "*.*",
				file_types_description : "All Files",
				file_upload_limit : 100,
				file_queue_limit : 0,
				custom_settings : {
					progressTarget : "fsUploadProgress",
					cancelButtonId : "btnCancel"
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
				upload_start_handler : uploadStart,
				
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_success_handler : uploadSuccess,
				upload_complete_handler : uploadComplete,
				//queue_complete_handler : queueComplete	// Queue plugin event
			};

			swfu = new SWFUpload(settings);
	     };
	</script>
</head>
<body>

<div id="content">
	<form  method="post" enctype="multipart/form-data">
		<div class="fieldset flash" id="fsUploadProgress">
			<span class="legend">请选择文件</span>
		</div>
		<div id="swfupload_btn">
			<span id="spanButtonPlaceHolder"></span>
			<input id="btnCancel" type="button" value="取消上传" onclick="swfu.cancelQueue();" disabled="disabled" style="margin-left: 2px; font-size: 8pt; height: 24px;" />
			<input type="button" value="开始上传" onclick="swfu.startUpload();"  style="margin-left: 2px; font-size: 8pt; height: 24px;"/>
		</div>
	</form>
</div>
</body>
</html>
