package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/*
 * 权限过滤器
 * */
public class AuthFilter implements Filter {

	//过滤方法的实现
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;  
		HttpSession session = request.getSession();
		//获得请求的资源路径
		//成功过滤
		if(session.getAttribute("user") != null){
			chain.doFilter(req, res);
		}else{
			if(!request.getRequestURI().contains("/student/") && !request.getRequestURI().contains("/teacher/") && !request.getRequestURI().contains("/admin/")){
				chain.doFilter(req, res);
			}else {
				//会话结束或者请求资源受限重定向到主页
				response.sendRedirect("/error.jsp");
			}
		}
	}
	//初始化过滤器
	public void init(FilterConfig arg0) throws ServletException {
	}
	//销毁过滤器
	public void destroy() {
	}
}
