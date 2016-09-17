package lab.action;

import lab.bean.Task;
import lab.service.TaskService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class TaskAction extends ActionSupport implements ModelDriven<Task>{
	private static final long serialVersionUID = 1L;

	private Task tk = new Task();
	/*
	 * 通过教师课程id获取实验任务
	 * */
	public String getTaskByTeacherCourseId(){
		TaskService ts = new TaskService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(ts.getTaskByTeacherCourseId(tk)));
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return null;
	}
	public Task getModel() {
		return tk;
	}
}
