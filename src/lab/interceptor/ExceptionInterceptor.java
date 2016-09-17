package lab.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class ExceptionInterceptor extends AbstractInterceptor {

	private static final long serialVersionUID = 1L;

	public String intercept(ActionInvocation invocation) throws Exception {
		String result = "error";
		try{
			result = invocation.invoke();
		}catch (Exception e) {
			throw new Exception();
		}
		return result;
	}
}
