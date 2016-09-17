package lab.util;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;


/*
 * Json格式工具，还未完成
 * */
public class JsonUtil{

	public static void writeJson(Object o) throws IOException{
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("application/json; charset=utf-8");
		response.setHeader("cache-control", "no-cache");

		PrintWriter out = response.getWriter();
		out.print(o);
		out.flush();
		out.close();
	}
}
