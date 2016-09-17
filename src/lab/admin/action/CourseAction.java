package lab.admin.action;

import java.io.IOException;

import lab.admin.service.CourseService;
import lab.bean.Course;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class CourseAction extends ActionSupport implements ModelDriven<Course>{

	private static final long serialVersionUID = 1L;
	private Course cos = new Course();
	/*
	 * 删除学生课程
	 * */
	public String deleteStudentCourse(){
		CourseService cs =  new CourseService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(cs.deleteStudentCourse(cos)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * 添加课程
	 * */
	public String addCourse(){
		CourseService cs =  new CourseService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(cs.addCourse(cos)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * 删除课程
	 * */
	public String deleteCourse(){
		CourseService cs =  new CourseService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(cs.deleteCourse(cos)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 * 删除教师课程
	 */
	public String deleteTeacherCourse(){
		CourseService cs =  new CourseService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(cs.deleteTeacherCourse(cos)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Course getModel() {
		return cos;
	} 
}
