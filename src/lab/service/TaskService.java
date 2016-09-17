package lab.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lab.bean.Task;
import lab.util.DbUtil;

public class TaskService {
	/*
	 * 通过教师课程id获取实验任务
	 * */
	public Map<String, Object> getTaskByTeacherCourseId(Task tk) throws SQLException {
		List<Task> al = new ArrayList<Task>();
		Map<String, Object> map = new HashMap<String, Object>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection conn = null;
		String sql = "SELECT task.id,task.fileNameF,task.taskName,task.workDir,task.teacherCourseId,task.url,task.addTime "
				+ "FROM task LEFT JOIN teachercourse ON teachercourse.id=task.teacherCourseId "
				+ "WHERE teachercourse.id=" + tk.getTeacherCourseId()+
				" ORDER BY addTime desc";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				Task t = new Task();
				t.setAddTime(rs.getString("addTime"));
				t.setTaskName(rs.getString("taskName"));
				t.setId(rs.getInt("id"));
				t.setWorkDir(rs.getString("workDir").replaceAll("\\\\", "\\\\\\\\"));
				t.setTeacherCourseId(rs.getInt("teacherCourseId"));
				t.setFileNameF(rs.getString("fileNameF"));
				t.setUrl(rs.getString("url").replaceAll("\\\\", "\\\\\\\\"));
				al.add(t);
			}
			map.put("rows", al);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbUtil.free(rs, ps, conn);
		}
		return map;
	}
}
