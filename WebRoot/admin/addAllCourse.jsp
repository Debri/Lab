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
<script type="text/javascript">
		var swfu;
		window.onload = function() {
			var settings = {
				flash_url : "${pageContext.request.contextPath}/javaScript/swfu/swfupload.swf",
				upload_url: '${pageContext.request.contextPath}/admin/CourseUtil_addAllCourse',
				use_query_string:false,
				file_post_name : "file",
				file_size_limit : "20 MB",
				file_types : "*.xls;*.xlsx",
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
				upload_start_handler : uploadStart,
				
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_success_handler : uploadSuccess,
				//upload_complete_handler : uploadComplete
				//queue_complete_handler : queueComplete	// Queue plugin event
			};

			swfu = new SWFUpload(settings);
	     };
	</script>
</head>
<body>

<div id="content">
	<form  method="post" enctype="multipart/form-data">
		<div>请选择20M以内的Excel文件</div>
		<div class="fieldset flash" id="fsUploadProgress">
			<span class="legend">请选择课程Excel文件</span>
		</div>
		<div id="swfupload_btn">
			<span id="spanButtonPlaceHolder"></span>
			<input type="button" value="开始导入" onclick="swfu.startUpload()"  style="margin-left: 2px; font-size: 8pt; height: 24px;"/>
		</div>
	</form>
</div>
</body>
</html>
