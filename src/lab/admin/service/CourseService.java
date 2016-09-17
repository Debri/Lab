package lab.admin.service;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import lab.bean.Course;
import lab.util.DbUtil;
import lab.util.FileUtil;

public class CourseService {
	/*
	 * 删除学生课程
	 */
	public boolean deleteStudentCourse(Course cos) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sqlDelstudentCourse = "delete from studentCourse where id in("
				+ cos.getIds() + ")";
		String sqlWork = "select url from work where studentCourseId=?";
		String sqlDelWork = "delete from work where studentCourseId in("
				+ cos.getIds() + ")";
		StringTokenizer st = new StringTokenizer(cos.getIds(), ",");
		try {
			conn = DbUtil.getConnection();
			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sqlWork);
			while (st.hasMoreTokens()) {
				// 查出学生作业
				ps.setInt(1, Integer.parseInt(st.nextToken()));
				rs = ps.executeQuery();
				while (rs.next()) {
					FileUtil.deleteFile(rs.getString("url"));
				}
			}
			// 删除学生作业
			ps.executeUpdate(sqlDelWork);
			// 删除学生课程
			ps.executeUpdate(sqlDelstudentCourse);
			conn.commit();
			conn.setAutoCommit(true);
			b = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtil.free(rs, ps, conn);
		}
		return b;
	}

	public int addCourse(Course course) {
		int n = 0;
		Connection conn = null;
		PreparedStatement ps = null;

		String sql = "insert into course(courseNumber,courseName,term,userId,addTime) value(?,?,?,?,?)";
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String date = formatter.format(currentTime);
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			if (course.getCourseName() != null) {
				ps.setString(1, course.getCourseNumber());
				ps.setString(2, course.getCourseName());
				ps.setString(3, course.getTerm());
				ps.setString(4, "a001");
				ps.setString(5, date);
				n = ps.executeUpdate();
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			DbUtil.free(ps, conn);
		}

		return n;
	}

	/*
	 * 删除课程
	 */
	@SuppressWarnings("resource")
	public boolean deleteCourse(Course cos) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		String sql = "delete from course where id=?";
		// 教师课表
		String tcSql = "delete from teacherCourse where courseId=?";
		String gtcSql = "select id from teacherCourse where courseId=?";
		// 教师任务表
		String tsql = "delete from task where teacherCourseId=?";
		String gtSql = "select url from task where teacherCourseId=?";
		// 学生课表
		String sSql = "delete from studentCourse where teacherCourseId=?";
		String gsSql = "select id from studentCourse where teacherCourseId=?";
		// 学生作业表
		String wSql = "delete from work where studentcourseId=?";
		StringTokenizer st = new StringTokenizer(cos.getIds(), ",");

		while (st.hasMoreTokens()) {
			try {
				conn = DbUtil.getConnection();
				conn.setAutoCommit(false);
				// 删除课程
				ps = conn.prepareStatement(sql);
				int cosId = Integer.parseInt(st.nextToken());
				ps.setInt(1, cosId);
				ps.executeUpdate();
				// 查出教师课表id
				ps = conn.prepareStatement(gtcSql);
				ps.setInt(1, cosId);
				rs = ps.executeQuery();
				while (rs.next()) {
					// 查教师任务
					ps = conn.prepareStatement(gtSql);
					ps.setInt(1, rs.getInt("id"));
					rs1 = ps.executeQuery();
					while (rs1.next()) {
						FileUtil.deleteFile(rs1.getString("url"));
					}
					// 删除教师任务
					ps = conn.prepareStatement(tsql);
					ps.setInt(1, rs.getInt("id"));
					ps.executeUpdate();
					// 查出教师课程
					ps = conn.prepareStatement(gsSql);
					ps.setInt(1, rs.getInt("id"));
					rs1 = ps.executeQuery();
					while (rs1.next()) {
						// 删除学生作业
						ps = conn.prepareStatement(wSql);
						ps.setInt(1, rs1.getInt("id"));
						ps.executeUpdate();
					}
					// 删除学生课表
					ps = conn.prepareStatement(sSql);
					ps.setInt(1, rs.getInt("id"));
					ps.executeUpdate();
				}
				ps = conn.prepareStatement(tcSql);
				ps.setInt(1, cos.getId());
				ps.executeUpdate();

				conn.commit();
				// conn.setAutoCommit(true);
				// 删除目录
				File dir = new File("E:\\lab\\" + cos.getId());
				FileUtil.deleteDir(dir);
				b = true;

			} catch (SQLException e) {
				e.printStackTrace();
				try {
					conn.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			} finally {
				DbUtil.free(ps, conn);
			}
		}
		return b;
	}

	/*
	 * 删除教师课程
	 */
	public boolean deleteTeacherCourse(Course cos) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;

		// 删除教师课程
		String sqlDelTeacherCourse = "delete from teacherCourse where id=?";
		// 删除学生作业
		String sqlDelWork = "delete from work where taskId in (select id from task where teacherCourseId=?)";
		// 删除任务
		String sqlDelTask = "delete from task where teacherCourseId=?";
		// 删除学生课程
		String sqlDelStudentCourse = "delete from studentcourse where teachercourseId=?";

		StringTokenizer st = new StringTokenizer(cos.getIds(), ",");
		String teacherCourseId = "";
		StringTokenizer courseId = new StringTokenizer(cos.getCourseIds(), ",");
		StringTokenizer userId = new StringTokenizer(cos.getUserId(), ",");
		while (st.hasMoreTokens()) {
			teacherCourseId = st.nextToken();
			try {
				conn = DbUtil.getConnection();
				conn.setAutoCommit(false);

				// 删除教师课程
				ps = conn.prepareStatement(sqlDelTeacherCourse);
				ps.setInt(1, Integer.parseInt(teacherCourseId));
				ps.executeUpdate();
				// 删除学生作业
				ps = conn.prepareStatement(sqlDelWork);
				ps.setInt(1, Integer.parseInt(teacherCourseId));
				ps.executeUpdate();
				// 删除教师课程对应的实验任务
				ps = conn.prepareStatement(sqlDelTask);
				ps.setInt(1, Integer.parseInt(teacherCourseId));
				ps.executeUpdate();
				// 删除学生课程
				ps = conn.prepareStatement(sqlDelStudentCourse);
				ps.setInt(1, Integer.parseInt(teacherCourseId));
				ps.executeUpdate();
				conn.commit();
				// 删除相关文件
				if (courseId.hasMoreTokens() && userId.hasMoreTokens()) {
					File dir = new File("E:\\lab\\" + courseId.nextToken()
							+ "\\" + userId.nextToken());
					FileUtil.deleteDir(dir);
				}
				b = true;
			} catch (SQLException e) {
				try {
					conn.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				e.printStackTrace();
			} finally {
				DbUtil.free(ps, conn);
			}
		}
		return b;
	}

	/*
	 * 管理员批量导入课程
	 */
	public int addAllCourse(List<Course> al) {
		int total = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "insert into course(courseNumber,courseName,term,userId,addTime) value(?,?,?,?,?)";
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String date = formatter.format(currentTime);
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			for (Course cos : al) {
				if (null != cos.getCourseName()) {
					ps.setString(1, cos.getCourseNumber());
					ps.setString(2, cos.getCourseName());
					ps.setString(3, cos.getTerm());
					ps.setString(4, "a001");
					ps.setString(5, date);
					if (ps.executeUpdate() > 0) {
						total++;
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
}
