<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
var oAnswer;
	$(function(){
		/* var n=parseInt(Q.charAt(1));
		var oArray = ["您就读的高中叫什么名字？","您的母亲叫什么名字？","您就读的小学叫什么名字？"];
		$('#question').html(oArray[n-1]); */
		var Question = {
			"Q1": "您就读的高中叫什么名字？",
			"Q2": "您的母亲叫什么名字？",
			"Q3": "您就读的小学叫什么名字？"
		};
		$('#question').html(Question[Q]||Question[Q]||Question[Q]);
		$('#answer').focus();
		
		//回车提交表单
		document.getElementById("user-resetForm").onkeydown=function(ev){
				var oEvent=ev||event;
				if(oEvent.keyCode==13){
				oAnswer = $('#answer').val();
					$.ajax({
		    			url:'${pageContext.request.contextPath}/User_resetPasswordBySecurity',
		    			type:'post',
		    			async: true,
		    			data:{
		    				"userId":userId,
		    				"securityQuestion":Q,
		    				"answer":oAnswer
		    			},
		    			dataType:'json',
		    			 success:function(d){
	    					if(d){
	    						alert("重置成功为123！");
	    						window.location.href='${pageContext.request.contextPath}/index.jsp';
	    					}else{
		    					alert("重置失败！");
		    				}
		    			},
		    			error: function(){
		    				alert("回答错误！");
		    			}
		    		}); 
				}
			};
			//点击提交按钮提交重置密码的表单
			$('.l-btn-text').click(function(){
			oAnswer = $('#answer').val();
				console.log(oAnswer);
				$.ajax({
		    			url:'${pageContext.request.contextPath}/User_resetPasswordBySecurity',
		    			type:'post',
		    			async: true,
		    			data:{
		    				"userId":userId,
		    				"securityQuestion":Q,
		    				"answer":oAnswer
		    			},
		    			dataType:'json',
		    			 success:function(d){
	    					if(d){
	    						alert("重置成功为123！");
	    						window.location.href='${pageContext.request.contextPath}/index.jsp';
	    						
	    					}else{
		    					alert("回答错误！");
		    				}
		    			},
		    			error: function(){
		    				alert("重置失败！");
		    			}
		    		}); 
			});
	});
</script>
<form id="user-resetForm" method="post">
	<table style="padding:20px 0">
  		<tr style="display: block;height: 30px;">
  			<td style="font-weight:bold;font-size:13px;">问题：</td>
  			<td><span id="question"  style="font-weight:bold;font-size:13px;"></span></td>
  		</tr>
  		<tr style="display: block; height: 30px;">
  			<td style="font-weight:bold;font-size:13px;">答案</td>
  			<td><input id="answer" type="text"  name="text"/></td>
  		</tr>
  	</table>
</form>
