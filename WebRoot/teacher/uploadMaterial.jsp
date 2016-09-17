<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>资料上传</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/javaScript/plupload/jquery.plupload.queue/css/jquery.plupload.queue.css" type="text/css"></link>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/plupload/plupload.full.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/plupload/jquery.plupload.queue/jquery.plupload.queue.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/javaScript/plupload/i18n/zh_CN.js"></script>
  
  <body style="padding: 0;margin: 0;">
  
    <div id="uploader">&nbsp;</div>
    
	<script type="text/javascript">
		var userId = '${sessionScope.user.userId }';
		$(function() {
			$("#uploader").pluploadQueue({
				// General settings
				runtimes : 'gears,flash,silverlight,browserplus,html5,html4',
				url : '${pageContext.request.contextPath}/MaterialUtil_upload?userId='+userId,
				max_file_size : '120mb',
				unique_names : true,
				chunk_size: '2mb',
				// Specify what files to browse for
				filters : [
					{title : "文档", extensions : "avi,rmvb,mp4,flv,wmv,jpg,rar,zip,doc,docx,xls,xlsx,ppt,pptx,pdf"}
				],
		
				// Flash settings
				flash_swf_url : '${pageContext.request.contextPath}/javaScript/plupload/plupload.flash.swf',
				// Silverlight settings
				silverlight_xap_url : '${pageContext.request.contextPath}/javaScript/plupload/plupload.silverlight.xap'
			});
			$('form').submit(function(e) {
		        var uploader = $('#uploader').pluploadQueue();
		        if (uploader.files.length > 0) {
		            // When all files are uploaded submit form
		            uploader.bind('StateChanged', function() {
		                if (uploader.files.length === (uploader.total.uploaded + uploader.total.failed)) {
		                    $('form')[0].submit();
		                }
		            });
		            uploader.start();
		        } else {
					alert('请先上传数据文件.');
				}
		        return false;
			});
		});
	</script>
  </body>
</html>
