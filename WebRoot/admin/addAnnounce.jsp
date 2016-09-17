<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>SWFUpload Demos - Simple Demo</title>
<script charset="utf-8" src="${pageContext.request.contextPath}/kindeditor-4.1.10/kindeditor.js"></script>
<script charset="utf-8" src="${pageContext.request.contextPath}/kindeditor-4.1.10/lang/zh_CN.js"></script>
<link href="${pageContext.request.contextPath}/css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/swfu/swfupload.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/swfu/swfupload.queue.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/swfu/fileprogress.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/swfu/handlers.js"></script>
<script type="text/javascript">
		KindEditor.ready(function(K) {
                window.editor = K.create('#editor_id');
        });
		var swfu;
		window.onload = function() {
			var settings = {
				flash_url : "${pageContext.request.contextPath}/javaScript/swf/swfupload.swf",
				upload_url: '${pageContext.request.contextPath}/admin/AnnounceUtil_addAnnounceOf',
				file_post_name : "file",
				file_size_limit : "20 MB",
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
				upload_success_handler : uploadSuccess,
			};

			swfu = new SWFUpload(settings);
	     };
	     
	     function uploadStartFile(){
	    	//上传文件前在这设置参数
			var userName = '${sessionScope.user.userName}';
			var title = $("#title").val();
			// 取得HTML内容
			html = editor.html();
			
			// 同步数据后可以直接取得textarea的value
			editor.sync();
			html = $('#editor_id').val();
			var obj = {
						 "title": title,
						 "content":html,
						 "userName":userName,
				};
			 swfu.setPostParams(obj);
	     }
	/*
		添加附件
	*/
	function showLegend(){
		$("#showLegend").show();
		$("#submitContent").hide();
		$("#addLegend").hide();
	}	
	/*
		取消附件
	*/     
	function rollBackLegend(){
		$("#showLegend").hide();
		$("#addLegend").show();
		$("#submitContent").show();
	}
	/*
		没附件的发布
	*/
	function submitContent(){
		var userName = '${sessionScope.user.userName}';
		var title = $("#title").val();
		// 取得HTML内容
		html = editor.html();
		
		// 同步数据后可以直接取得textarea的value
		editor.sync();
		html = $('#editor_id').val();
		$.ajax({
			url:'${pageContext.request.contextPath}/admin/Announce_addAnnounce',
			type:'post',
			data:{
				userName:userName,
				title:title,
				content:html
			},
			dataType:'json',
			success:function(obj){
				if(obj){
					alert("发布成功");
				}else{
					alert("发布失败");
				}
			}
		});
	}
</script>
</head>
<body>

<div id="content">
	<form  method="post" enctype="multipart/form-data">
		<div>
			<table>
				<tr><td><b>公告标题&nbsp;</b><input type="text" id="title" style="border:1px solid #999999;width:360px;"/></td></tr>
				<tr><td><b>公告内容</b></td></tr>
				<tr><td><textarea id="editor_id" name="content" style="width:700px;height:240px;"></textarea></td></tr>
			</table>
		</div>
		<div id="addLegend" style="margin-top:12px;"><span onclick="showLegend();" style="font-weight:bold;cursor:pointer;color:#999999;">添加附件</span></div>
		<div id="showLegend" style="display:none;">
			<div id="rollBackLegend"  style="margin-top:12px;padding:4px;"><span onclick="rollBackLegend();" style="font-weight:bold;cursor:pointer;color:#999999;">取消附件</span></div>
			<div class="fieldset flash" id="fsUploadProgress">
			<span class="legend">请选择附件</span>
			</div>
			<div id="swfupload_btn">
				<span id="spanButtonPlaceHolder"></span>
				<input type="button" value="确认提交" onclick="swfu.startUpload()"  style="margin-left: 2px; font-size: 8pt; height: 24px;"/>
			</div>
		</div>
		<div id="submitContent" style="margin-top:24px;"><span style="cursor:pointer;color:#8080C0;" onclick="submitContent();"><b>确认提交</b></span></div>
	</form>
</div>
</body>
</html>
