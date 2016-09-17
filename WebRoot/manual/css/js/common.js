//chenjiajun 
//2014/09/02

var Upindex = 0;
var Downindex = 0;
var Uptimer = null;
var Downtimer = null;
var speed = 400;
var index = 1;
//page init
$(document).ready(function() {
	setPageHeight();
	$(".next").click(function() {
		if (Uptimer) {
			clearTimeout(Uptimer);
		}
		Uptimer = setTimeout(function(){
			next();
		},200);

	});

	$(".prev").click(function() {
		if (Downtimer) {
			clearTimeout(Downtimer);
		}
		Downtimer = setTimeout(function() {
			prev();
		}, 200);
	});

	//统计总共页数
	$(".sum").text($(".page").length);
	$(".current").each(function(index) {
		$(this).text(index + 1);
	});

	//动态添加导航
	$(".mmain").append("<ul class='pagesmenu'></ul>");
	$(".page").each(function(index) {
		if (index == 0) {
			$(".pagesmenu").append("<li  class='ends'><span></span></li>");
		}

		var text = $(this).find(".current").text() + " " + $(this).find(".text").text();
		var li = $("<li><span class='stepNav'></span>" + text + "</li>");
		$(".pagesmenu").append(li);

		if (index == ($(".page").length - 1)) {
			$(".pagesmenu").append("<li  class='ends'><span class='endsBottom'></span></li>");
		}
	});

	$(".pagesmenu li:eq(" + index + ")").addClass("activeNav");
	$(".pagesmenu").click(function(event) {
		var target = event.target || event.srcElement;
		var index = $(target).index();
		if (index != 0 && index != ($(".pagesmenu li").length - 1)) {
			$(".pagesmenu li").each(function() {
				if ($(this).hasClass("activeNav")) {
					$(this).removeClass("activeNav");
				}
			});
			$(".pagesmenu li:eq(" + index + ")").addClass("activeNav");
			var marginTop = -(index - 1) * $(".page").height();
			$(".pages").animate({
				"margin-top": marginTop
			}, speed);
		}

	});
	//鼠标滚轮事件触发翻页
	var timere = null;
	var scrollFoc = function(e) {
		var e = e || window.event;
		if (e.wheelDelta < 0 || e.detail > 0) //向上滚动
		{
			if (Uptimer) {
				clearTimeout(Uptimer);
			}
			Uptimer = setTimeout(function() {
				next();
			}, 200);
		} else if (e.wheelDelta > 0 || e.detail < 0) //向下滚动
		{
			if (Downtimer) {
				clearTimeout(Downtimer);
			}
			Downtimer = setTimeout(function() {
				prev();
			}, 200);

		}
	}
	if (document.addEventListener) {
		document.addEventListener('DOMMouseScroll', scrollFoc, false); //兼容火狐浏览器
	}
	window.onmousewheel = scrollFoc;


});

$(window).resize(function() {
	setPageHeight();
});

// 设置每一页的宽高
function setPageHeight() {
	//set page width and height
	var clientHeight = $(window).height();
	var pageHeight = clientHeight - $(".header").height() - 50;
	if (pageHeight < 500) {
		pageHeight = 500;
	}
	$(".page,.showPage").height(pageHeight);
	//控制图片的宽高
	var imgDivHeight = $(".imageItem").height();
	$(".imageItem img").each(function() {
		var index = $(this).height() + 30 - pageHeight;
		if (index >= 0) {
			$(this).height(imgDivHeight * 0.90);
		}
	});
	$(".pagetext").each(function(){
		if($(this).height()> (pageHeight - 80)){
			$(this).css("overflow-y","scroll").css("height",(pageHeight - 80)).children().children("li").css("list-style","decimal inside");
		}
	});
}

//查看下一张图片
function next() {
	var pageHeight = $(".page").height();
	var pageCount = $(".page").length;
	var MarginTop = 0;
	index++;
	if(index > pageCount){
		index = 1;
	}
	MarginTop = -(index-1) * pageHeight;
	$(".pages").animate({
			"margin-top": MarginTop
		}, speed);

	$(".pagesmenu li").each(function() {
		if ($(this).hasClass("activeNav")) {
			$(this).removeClass("activeNav");
		}
	});
	$(".pagesmenu li:eq(" + index + ")").addClass("activeNav");
}

//查看上一张图片
function prev() {
	var pageHeight = $(".page").height();
	var pageCount = $(".page").length;
	var MarginTop = 0;
	index--;
	if(index <= 0){
		index = $(".page").length;
	}

	MarginTop = -(index-1) * pageHeight;
	$(".pages").animate({
			"margin-top": MarginTop
		}, speed);

	$(".pagesmenu li").each(function() {
		if ($(this).hasClass("activeNav")) {
			$(this).removeClass("activeNav");
		}
	});
	$(".pagesmenu li:eq(" + index + ")").addClass("activeNav");
}