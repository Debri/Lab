package lab.action;

import java.io.IOException;

import lab.bean.Course;
import lab.service.CourseService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class CourseAction extends ActionSupport implements ModelDriven<Course>{

	private static final long serialVersionUID = 1L;
	private Course cos = new Course();
	
	/*
	 * 通过类型获取实验课程
	 * */
	public String getCourseByType(){
		CourseService cs = new CourseService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(cs.getCourseByType(cos)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * 通过用户类型和userId获取自己的课程信息
	 * */
	public String getCourseByUserId(){
		CourseService cs = new CourseService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(cs.getCourseByUserId(cos)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	public Course getModel() {
		return cos;
	}
}
