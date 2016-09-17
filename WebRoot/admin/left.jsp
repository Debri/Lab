<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<script type="text/javascript">
	$(function(){
		$("#west-tree").tree({
			lines:true,
			data:[{
				text:'用户管理',
				state : 'open',
				children : [{
					text : '管理员信息',
					attributes : {
						url : 'adminInfo.jsp'
					}
				},{
					text : '教师信息',
					attributes : {
						url : 'teacherInfo.jsp'
					}
				},{
					text : '学生信息',
					attributes : {
						url : 'studentInfo.jsp'
					}
				},{
					text : '注册用户',
					attributes : {
						url : 'registerInfo.jsp'
					}
				}]
			},{
				text:'实验课程管理',
				state:'open',
				children:[{
					text:'实验课程',
					attributes:{
						url:'course.jsp'
					}
				},{
					text:'教师课程',
					attributes:{
						url:'teacherCourse.jsp'
					}
				},{
					text:'学生课程',
					attributes:{
						url:'studentCourse.jsp'
					}
				}]
			},{
				text:'资料管理',
				state:'open',
				children:[{
					text:'学习资料',
					attributes:{
						url:'material.jsp'
					}
				},{
					text:'学习软件',
					attributes:{
						url:'softWare.jsp'
					}
				}]
			},{
				text:'实验室管理',
				state:'open',
				children:[{
					text:'实验室公告',
					attributes:{
						url:'announce.jsp'
					}
				}]
			},{
				text:'数据信息管理',
				state:'open',
				children:[{
					text:'清除文件',
					attributes:{
						url:'tem.jsp'
					}
				},{
					text:'导入模板',
					attributes:{
						url:'tample.jsp'
					}
				}]
			}],
			onClick: function(node){
	    		   if(node.attributes.url){
	    			  var url = '${pageContext.request.contextPath}/admin/' + node.attributes.url;
						addTabs({
							title : node.text,
							href : url,
							closable : true
						});
					}
				}
		});
	});
</script>


<div class="easyui-accordion" data-options="fit:true" style="border-top:0px;border-bottom:0px;">
	<div title="系统管理" data-options="iconCls:'icon-reload',border:false" style="overflow:auto,padding:10px">
		<ul id="west-tree"></ul>
	</div>
	<div title="系统说明" data-options="iconCls:'icon-save',border:false"  style="padding:10px">实验系统管理使用介绍</div>
</div>