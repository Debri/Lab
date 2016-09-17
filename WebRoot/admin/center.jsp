<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" charset="utf-8">
	function addTabs(opts) {
 		var t = $('#admin_center_tabs');
 		if (t.tabs('exists', opts.title)) {
 			t.tabs('select', opts.title);
 		} else {
			t.tabs('add', opts);
			$(".tabs-title").css("font-size","13px");
		}
	}
</script>
<div id="admin_center_tabs"  class="easyui-tabs" data-options="fit:true,border:false">
	<div title="管理首页">我是管理首页</div>
</div>