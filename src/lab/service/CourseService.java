package lab.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lab.bean.Course;
import lab.util.DbUtil;

public class CourseService {

	/*
	 * 通过用户类型获取实验课程
	 * */
	public Map<String,Object> getCourseByType(Course cos){
		
		Map<String,Object> map = new HashMap<String, Object>();
		List<Course> al = new ArrayList<Course>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int total = 0;
		// 当前页
		int intPage = cos.getPage() == 0 ? 1 : cos.getPage();
		// 每页显示条数
		int rows = cos.getRows() == 0 ? 10 :cos.getRows();
		// 每页的开始记录
		int start = (intPage - 1) * rows;
		
		String sqlTotal = "";
		String sql = "";
		if((cos.getType()).equals("teacher")){
			sqlTotal = "SELECT count(*) as id FROM teachercourse LEFT JOIN course ON teachercourse.courseId=course.id " +
					" LEFT JOIN USER ON teachercourse.teacherId=user.userId where 1=1";
			
			sql = "SELECT teacherCourse.id,course.courseName,course.courseNumber,course.id as courseId,user.userName,course.term,teacherCourse.addTime" +
					" ,user.userId FROM teachercourse LEFT JOIN course ON teachercourse.courseId=course.id " +
					" LEFT JOIN USER ON teachercourse.teacherId=user.userId where 1=1";
			
		}else if((cos.getType()).equals("student")){
			sqlTotal = "SELECT count(*) as id FROM "+
					" (SELECT studentCourse.id,studentCourse.studentId,studentCourse.teacherCourseId,studentCourse.addTime FROM studentCourse) AS studentCourse" +
					" LEFT JOIN teacherCourse ON studentCourse.teacherCourseId=teacherCourse.id" +
					" LEFT JOIN course ON teacherCourse.courseId=course.id" +
					" LEFT JOIN USER ON studentCourse.studentId=user.userId  where 1=1";
			sql = "SELECT studentCourse.id,course.courseName,course.courseNumber,course.id as courseId,user.userName,course.term,studentCourse.addTime ,user.userId FROM " +
					" (SELECT studentCourse.id,studentCourse.studentId,studentCourse.teacherCourseId,studentCourse.addTime FROM studentCourse) AS studentCourse" +
					" LEFT JOIN teacherCourse ON studentCourse.teacherCourseId=teacherCourse.id" +
					" LEFT JOIN course ON teacherCourse.courseId=course.id" +
					" LEFT JOIN USER ON studentCourse.studentId=user.userId  where 1=1";
			
		}else if((cos.getType()).equals("admin")){
			sqlTotal = "select count(*) as id from course left join"+
					" user on user.userId=course.userId where 1=1";
			sql = "select course.id ,courseName,course.courseNumber,term,course.addTime,user.userName,user.userId from course left join" +
					" user on user.userId=course.userId where 1=1";
		}
		
		if(null != cos.getUserName() && !cos.getUserName().equals("")){
			sql += " and user.userName like '%%"+cos.getUserName()+"%%'";
			sqlTotal += " and user.userName like '%%"+cos.getUserName()+"%%'";
		}
		if(null != cos.getCourseName() && !cos.getCourseName().equals("")){
			sql += " and course.courseName like '%%"+cos.getCourseName()+"%%'";
			sqlTotal += " and course.courseName like '%%"+cos.getCourseName()+"%%'";
		}
		if(null != cos.getUserId() && !cos.getUserId().equals("")){
			sql += " and user.userId like '%%"+cos.getUserId().trim()+"%%'";
		}
		if(null!=cos.getTerm()&&!cos.getTerm().equals("")){
			sql += " and course.term like '%%"+cos.getTerm()+"%%'";
			sqlTotal += " and course.term like '%%"+cos.getTerm()+"%%'";
		}
		sql += " ORDER BY "+cos.getSort()+ " "+cos.getOrder()+" limit ?,?";
		
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, rows);
			rs = ps.executeQuery();
			while(rs.next()){
				Course c = new Course();
				c.setAddTime(rs.getString("addTime"));
				c.setCourseName(rs.getString("courseName"));
				c.setCourseNumber(rs.getString("courseNumber"));
				c.setId(rs.getInt("id"));
				if(!cos.getType().equals("admin")){
					c.setCourseId(rs.getInt("courseId"));
				}
				c.setTerm(rs.getString("term"));
				c.setUserId(rs.getString("userId"));
				c.setUserName(rs.getString("userName"));
				al.add(c);
			}
			rs = ps.executeQuery(sqlTotal);
			while(rs.next()){
				total = rs.getInt("id");
			}
			map.put("total", total);
			map.put("rows", al);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DbUtil.free(rs, ps, conn);
		}
		return map;
	}
	/*
	 * 通过用户类型和userId获取自己的课程信息
	 * */
	@SuppressWarnings("resource")
	public Map<String,Object> getCourseByUserId(Course cos){
		Map<String,Object> map = new HashMap<String, Object>();
		List<Course> al = new ArrayList<Course>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection conn = null;
		int total = 0;
		// 当前页
		int intPage = cos.getPage() == 0 ? 1 : cos.getPage();
		// 每页显示条数
		int rows = cos.getRows() == 0 ? 10 :cos.getRows();
		// 每页的开始记录
		int start = (intPage - 1) * rows;
		
		String sql = "";
		String sqlTotal = "";
		
		if(cos.getType().equals("student")){
			 sqlTotal = "SELECT count(*) as taskName FROM studentcourse  WHERE studentcourse.studentId="+"'"+cos.getUserId()+"'";
			
			 sql = "SELECT studentcourse.id,teachercourse.id AS teacherCourseId ,course.id as courseId,course.courseName,course.courseNumber,course.term,user.userName,studentcourse.addTime FROM " +
					" (SELECT studentcourse.id,studentcourse.addTime,studentcourse.teacherCourseId FROM studentcourse WHERE studentcourse.studentId="+"'"+cos.getUserId()+"'"+" LIMIT ?,?) AS studentcourse" +
					" LEFT JOIN teachercourse ON studentcourse.teacherCourseId=teacherCourse.id" +
					" LEFT JOIN USER ON user.userId=teachercourse.teacherId" +
					" LEFT JOIN course ON teachercourse.courseId=course.id";
			 
		}else if(cos.getType().equals("teacher")){
			 sqlTotal = "SELECT count(*) as taskName" +
						" FROM teachercourse LEFT JOIN course ON teachercourse.courseId=course.id " +
						" WHERE teachercourse.teacherId="+"'"+cos.getUserId()+"'";
			
			 sql = "SELECT teacherCourse.id,course.id AS courseId,course.courseName,course.courseNumber,course.term,teacherCourse.addTime" +
						" FROM teachercourse LEFT JOIN course ON teachercourse.courseId=course.id" +
						" WHERE teachercourse.teacherId="+"'"+cos.getUserId()+"'";
		}
		if(null != cos.getUserName() && !cos.getUserName().equals("")){
			sql += " and user.userName like '%%"+cos.getUserName()+"%%'";
			sqlTotal +=" and user.userName like '%%"+cos.getUserName()+"%%'";
		}
		if(null != cos.getCourseName() && !cos.getCourseName().equals("")){
			sql += " and course.courseName like '%%"+cos.getCourseName()+"%%'";
			sqlTotal += " and course.courseName like '%%"+cos.getCourseName()+"%%'";
		}
		
		if(cos.getType().equals("teacher")){
			sql += " ORDER BY "+cos.getSort()+ " "+cos.getOrder()+" limit ?,?";
		}
		
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, rows);
			rs = ps.executeQuery();
			if(cos.getType().equals("student")){
				while(rs.next()){
					Course c = new Course();
					c.setAddTime(rs.getString("addTime"));
					c.setCourseName(rs.getString("courseName"));
					c.setCourseNumber(rs.getString("courseNumber"));
					c.setStudentCourseId(rs.getInt("id"));
					c.setCourseId(rs.getInt("courseId"));
					c.setTeacherCourseId(rs.getInt("teacherCourseId"));
					c.setTerm(rs.getString("term"));
					c.setUserName(rs.getString("userName"));
					al.add(c);
				}
			}else{
				while(rs.next()){
					Course c = new Course();
					c.setAddTime(rs.getString("addTime"));
					c.setCourseName(rs.getString("courseName"));
					c.setCourseNumber(rs.getString("courseNumber"));
					c.setId(rs.getInt("id"));
					c.setCourseId(rs.getInt("courseId"));
					c.setTerm(rs.getString("term"));
					al.add(c);
				}
			}
			
			rs = ps.executeQuery(sqlTotal);
			while(rs.next()){
				total = rs.getInt("taskName");
			}
			map.put("total", total);
			map.put("rows", al);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DbUtil.free(rs, ps, conn);
		}
		return map;
	}
}
