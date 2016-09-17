package lab.action;

import java.io.IOException;

import lab.bean.Work;
import lab.service.WorkService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class WorkAction extends ActionSupport implements ModelDriven<Work>{

	private static final long serialVersionUID = 1L;
	
	private Work wk = new Work();
	
	/*
	 * 通过学生课程id该学生对应课程下的作业
	 * */
	public String getWorkByStudentCourseId(){
		WorkService ws = new WorkService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(ws.getWorkByStudentCourseId(wk)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Work getModel() {
		return wk;
	}
}
