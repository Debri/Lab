package lab.teacher.service;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lab.bean.Course;
import lab.util.DbUtil;
import lab.util.FileUtil;

public class CourseService {

	/*
	 * 教师根据课程id添加自己的实验课程
	 * */
	public boolean addCourseByCourseId(Course cos){
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String date = formatter.format(new Date());
		String sql = "insert ignore into teacherCourse(courseId,teacherId,addTime) value(?,?,?)";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cos.getCourseId());
			ps.setString(2, cos.getUserId());
			ps.setString(3, date);
			if(ps.executeUpdate() > 0){
				b = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DbUtil.free(ps, conn);
		}
		return b;
	}
	/*
	 * 教师删除自己添加的课程（目录结构/lab/courseId/teacherId/实验次数）教师删除是只要删除teacherId下的文件和teacherId目录
	 * */
	public boolean deleteCourseByTeacherCourseId(Course cos){
		boolean b = false;
		int[] n = new int[5];
		Connection conn = null;
		PreparedStatement ps = null;
		//删除任务(连指导书一起删除)
		String sqlDelTask = "delete from task where teacherCourseId="+cos.getTeacherCourseId();
		//删除教师课程
		String sqlDelTeacherCourse = "delete from teacherCourse where id="+cos.getTeacherCourseId();
		//删除学生作业（连作业一起删除）
		String sqlDelWork = "delete from work where taskId in (select id from task where teacherCourseId="+cos.getTeacherCourseId()+")";
		
		//删除学生课程
		String sqlDelStudentCourse = "delete from studentcourse where teachercourseId="+cos.getTeacherCourseId();
		
		try {
			conn = DbUtil.getConnection();
			//删除学生作业（数据库）
			ps = conn.prepareStatement(sqlDelWork);
			n[0] = ps.executeUpdate();
			//删除学生课程
			ps = conn.prepareStatement(sqlDelStudentCourse);
			n[1] = ps.executeUpdate();
			//删除教师课程对应的实验任务
			ps = conn.prepareStatement(sqlDelTask);
			n[2] = ps.executeUpdate();
			//删除教师课程 
			ps = conn.prepareStatement(sqlDelTeacherCourse);
			n[3] = ps.executeUpdate();
			
			
			
			if(n[0]>=0 && n[1]>=0 && n[2]>=0 && n[3] > 0 ){
				//删除学生作业(文件)
				File dir = new File("E:\\lab\\"+cos.getCourseId()+"\\"+cos.getUserId());
				FileUtil.deleteDir(dir);
				b = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DbUtil.free(ps, conn);
		}
		return b;
	}
}
