<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
	$(function() {
		var ul = $(".lxfscroll ul");
		var li = $(".lxfscroll li");
		var tli = $(".lxfscroll-title li");
		var speed = 350;
		var autospeed = 5000;
		var i = 1;
		var n = 0;
		/* 标题按钮事件 */
		function lxfscroll() {
			var index = tli.index($(this));
			tli.removeClass("cur");
			$(this).addClass("cur");
			ul.css({
				"left" : "0px"
			});
			li.css({
				"left" : "0px"
			});
			li.eq(index).css({
				"z-index" : i
			});
			li.eq(index).css({
				"left" : "528px"
			});
			ul.animate({
				left : "-528px"
			}, speed);
			i++;
		}
		;
		/* 自动轮换 */
		function autoroll() {
			if (n >= 6) {
				n = 0;
			}
			tli.removeClass("cur");
			tli.eq(n).addClass("cur");
			ul.css({
				"left" : "0px"
			});
			li.css({
				"left" : "0px"
			});
			li.eq(n).css({
				"z-index" : i
			});
			li.eq(n).css({
				"left" : "528px"
			});
			n++;
			i++;
			timer = setTimeout(autoroll, autospeed);
			ul.animate({
				left : "-528px"
			}, speed);
		}
		;
		/* 鼠标悬停即停止自动轮换 */
		function stoproll() {
			li.hover(function() {
				clearTimeout(timer);
				n = $(this).prevAll().length + 1;
			}, function() {
				timer = setTimeout(autoroll, autospeed);
			});
			tli.hover(function() {
				clearTimeout(timer);
				n = $(this).prevAll().length + 1;
			}, function() {
				timer = setTimeout(autoroll, autospeed);
			});
		}
		;
		tli.mouseenter(lxfscroll);
		autoroll();
		stoproll();
	});
</script>
<style type="text/css">
ul{
	margin:0;
	padding:0;
}
.lxfscroll {
	width: 528px;
	margin-left: auto;
	margin-right: auto;
	position: relative;
	height: 428px;
	border: 4px solid #EFEFEF;
	overflow: hidden;
}

.lxfscroll ul li {
	height: 428px;
	width: 528px;
	text-align: center;
	line-height: 300px;
	position: absolute;
	font-size: 40px;
	font-weight: bold;
	list-style: none;
}

.lxfscroll-title {
	width: 528px;
	margin-right: auto;
	margin-left: auto;
	list-style: none;
}

.lxfscroll-title li {
	height: 20px;
	width: 20px;
	float: left;
	line-height: 20px;
	text-align: center;
	border: 1px dashed pink;
	margin-top: 2px;
	cursor: pointer;
	margin-right: 2px;
	list-style: none;
}

.cur {
	color: #FFF;
	font-weight: bold;
	background: #87CEEB;
}

.lxfscroll ul {
	position: absolute;
}
</style>
<div id="img_content">
	<div class="lxfscroll">
		<ul>
			<li><img src="${pageContext.request.contextPath}/images/1.jpg" width="528"
				height="428" />
			</li>
			<li><img src="${pageContext.request.contextPath}/images/2.jpg" width="528"
				height="428" />
			</li>
			<li><img src="${pageContext.request.contextPath}/images/3.jpg" width="528"
				height="428" />
			</li>
			<li><img src="${pageContext.request.contextPath}/images/4.jpg" width="528"
				height="428" />
			</li>
			<li><img src="${pageContext.request.contextPath}/images/5.jpg" width="528"
				height="428" />
			</li>
			<li><img src="${pageContext.request.contextPath}/images/6.jpg" width="528"
				height="428" />
			</li>
		</ul>
	</div>
	<div class="lxfscroll-title">
		<ul>
			<li class="cur">1</li>
			<li>2</li>
			<li>3</li>
			<li>4</li>
			<li>5</li>
			<li>6</li>
		</ul>
	</div>
</div>

