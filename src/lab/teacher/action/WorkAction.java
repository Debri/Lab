package lab.teacher.action;

import java.io.IOException;

import lab.bean.Work;
import lab.teacher.service.WorkService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class WorkAction extends ActionSupport implements ModelDriven<Work>{

	
	private static final long serialVersionUID = 1L;

	private Work wk = new Work();
	/*
	 * 教师根据自己发布的实验任务获取学生作业
	 * */
	public String getWorkByTaskId(){
		WorkService ws = new WorkService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(ws.getWorkByTaskId(wk)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	public Work getModel() {
		return wk;
	}
}
