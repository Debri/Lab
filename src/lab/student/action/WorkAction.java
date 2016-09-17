package lab.student.action;

import java.io.IOException;

import lab.bean.Work;
import lab.student.service.WorkService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class WorkAction extends ActionSupport implements ModelDriven<Work>{

	private static final long serialVersionUID = 1L;
	private Work wk = new Work();
	
	/*
	 * 学生通过taskId查看自己的作业
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
	
	/*
	 * 学生通过作用id删除自己的作业，（数据库和文件）
	 * */
	public String deleteWorkByWorkId(){
		WorkService ws = new WorkService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(ws.deleteWorkByWorkId(wk)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	public Work getModel() {
		return wk;
	}
}
