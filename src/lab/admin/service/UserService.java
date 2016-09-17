package lab.admin.service;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.StringTokenizer;

import lab.bean.User;
import lab.util.DbUtil;
import lab.util.FileUtil;

public class UserService {

	/*
	 * 管理员批量导入用户信息
	 * 保证了插入的数据不会重复
	 * */
	public int addAllUser(List<User> al){
		int total = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		
		String sql = "insert IGNORE into user(userId,userName,academy,grade,discipline,cls,sex,phone,type,password) values(?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			for (User u : al) {
				if(null != u.getUserId()){
					ps.setString(1, u.getUserId());
					ps.setString(2, u.getUserName());
					ps.setString(3, u.getAcademy());
					ps.setString(4, u.getGrade());
					ps.setString(5, u.getDiscipline());
					ps.setString(6, u.getCls());
					ps.setString(7, u.getSex());
					ps.setString(8, u.getPhone());
					ps.setString(9, u.getType());
					ps.setString(10, u.getPassword());
					if(ps.executeUpdate() > 0){
						total ++;
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtil.free(ps, conn);
		}
		return total;
	}
	/*
	 * 单个添加用户信息
	 * */
	public int addUser(User user){
		int total = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "insert IGNORE into user(userId,userName,academy,grade,discipline,cls,sex,phone,type,password) values(?,?,?,?,?,?,?,?,?,?)";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserId());
			ps.setString(2, user.getUserName());
			ps.setString(3, user.getAcademy());
			ps.setString(4, user.getGrade());
			ps.setString(5, user.getDiscipline());
			ps.setString(6, user.getCls());
			ps.setString(7, user.getSex());
			ps.setString(8, user.getPhone());
			ps.setString(9, user.getType());
			ps.setString(10, user.getPassword());
			
			total = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DbUtil.free(ps, conn);
		}
		return total;
	}
	/*
	 * 删除用户
	 * */
	
	public int deleteUser(User user){
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int total = 0;
		
		/* 
		 * 教师
		 * 
		 * */
		//获取教师的课程
		//删除课程
		String sqlTeacherCourse = "delete from teacherCourse where teacherId =?";
		String sqlCourse = "select courseId from teacherCourse where teacherId =?";
		//删除任务
		String sqlTask = "delete from task where teacherCourseId in(select id from teacherCourse where teacherId=?)";
		//删除作业
		String sqlTWork = "delete from work where taskId in " +
				" (SELECT id FROM task WHERE teacherCourseId IN" +
				" (SELECT id FROM teacherCourse WHERE teacherId=?))";
		//删除学习资料
		String sqlMaterial = "delete from material where userId=?";
		//删除信息软件
		String sqlSoftWare = "delete from softWare where userId=?";
		/* 
		 * 学生
		 * 
		 * */
		String sqlStudentCourse = "delete from studentCourse where studentId =?";
		String sqlWork = "delete from work where studentId =?";
		String getWorkSql = "select url from work where studentId =?";
		
		String userSql = "delete from user where userId=?";
		
		StringTokenizer st = new StringTokenizer(user.getIds(), ",");
		while(st.hasMoreTokens()){
			String userId = st.nextToken();
			try {
				conn = DbUtil.getConnection();
				conn.setAutoCommit(false);
				//学生
				if((user.getType()).equals("student")){
					//删除课程
					ps = conn.prepareStatement(sqlStudentCourse);
					ps.setString(1, userId);
					int i = ps.executeUpdate();
					//删除作业
					ps = conn.prepareStatement(getWorkSql);
					ps.setString(1, userId);
					rs = ps.executeQuery();
					while(rs.next()){
						File dir = new File(rs.getString("url"));
						dir.delete();
					}
					//
					ps = conn.prepareStatement(sqlWork);
					ps.setString(1, userId);
					i = ps.executeUpdate();
				}
				//教师
				if((user.getType()).equals("teacher")){
					//删除任务
					ps = conn.prepareStatement(sqlTask);
					ps.setString(1, userId);
					ps.executeUpdate();
					//删除作业
					ps = conn.prepareStatement(sqlTWork);
					ps.setString(1, userId);
					ps.executeUpdate();
					//删除学习软件
					ps = conn.prepareStatement(sqlSoftWare);
					ps.setString(1, userId);
					ps.executeUpdate();
					//删除学习资料
					ps = conn.prepareStatement(sqlMaterial);
					ps.setString(1, userId);
					ps.executeUpdate();
					//删除相关文件
					ps = conn.prepareStatement(sqlCourse);
					ps.setString(1, userId);
					rs = ps.executeQuery();
					while(rs.next()){
						File dir = new File("E:\\lab\\"+rs.getInt("courseId")+"\\"+userId);
						FileUtil.deleteDir(dir);
					}
					//删除学生上传的作业
					ps = conn.prepareStatement(sqlTWork);
					ps.setString(1, userId);
					ps.executeUpdate();
					//删除课程
					ps = conn.prepareStatement(sqlTeacherCourse);
					ps.setString(1, userId);
					ps.executeUpdate();
				}
				//删除用户
				ps = conn.prepareStatement(userSql);
				ps.setString(1, userId);
				ps.executeUpdate();
				conn.commit();
				total = 1;
			} catch (SQLException e) {
				try {
					conn.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				e.printStackTrace();
			}finally{
				DbUtil.free(ps, conn);
			}
		}	
		return total;
	}
	/*
	 * 修改自己的信息
	 * */
	public boolean updateUser(User user) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "update user set phone=?,password=? where userId=?";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getPhone());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getUserId());
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
}
