package lab.teacher.action;

import java.io.File;
import java.io.IOException;

import lab.bean.Course;
import lab.teacher.service.CourseService;
import lab.util.JsonUtil;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class CourseAction extends ActionSupport implements ModelDriven<Course>{
	
	private static final long serialVersionUID = 1L;
	private Course cos = new Course();
	/*
	 * 教师根据课程id添加自己的实验课程
	 * */
	public String addCourseByCourseId(){
		CourseService cs = new CourseService();
		Gson g = new Gson();
		//创建教师课程目录，用于存放学生作业
		
		//old dir  "E:\\lab\\"+cos.getCourseId()+"\\"+cos.getUserId()
		//update date 2016/8/14
		File dir = new File("E:\\work\\"+cos.getCourseId()+"\\"+cos.getUserId());
		if(!dir.exists()){
			dir.mkdirs();
		}
		try {
			JsonUtil.writeJson(g.toJson(cs.addCourseByCourseId(cos)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * 教师根据教师课程id删除自己添加的实验课程
	 * */
	public String deleteCourseByTeacherCourseId(){
		CourseService cs = new CourseService();
		Gson g = new Gson();
		try {
			JsonUtil.writeJson(g.toJson(cs.deleteCourseByTeacherCourseId(cos)));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	public Course getModel() {
		return cos;
	}
}
