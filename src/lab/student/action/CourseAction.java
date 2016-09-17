package lab.student.action;

import java.io.IOException;

import lab.bean.Course;
import lab.student.service.CourseService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class CourseAction extends ActionSupport implements ModelDriven<Course>{

	private static final long serialVersionUID = 1L;

	private Course cos = new Course();
	
	/*
	 * 学生添加教师发布的实验课程
	 * */
	public String addCourse(){
		CourseService cs = new CourseService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(cs.addCourse(cos)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 * 学生删除自己添加的实验课程
	 * */
	public String deleteCourse(){
		CourseService cs = new CourseService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(cs.deleteCourse(cos)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Course getModel() {
		return cos;
	}
}
