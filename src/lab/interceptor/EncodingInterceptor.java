package lab.interceptor;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class EncodingInterceptor extends AbstractInterceptor {

	private static final long serialVersionUID = 1L;
	/*
	 * 字符拦截器
	 * */
	public String intercept(ActionInvocation invocation) throws Exception {
		
		ServletActionContext.getRequest().setCharacterEncoding("utf-8");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		return invocation.invoke();
	}

}
