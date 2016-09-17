package lab.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lab.bean.Work;
import lab.util.DbUtil;

public class WorkService {

	/*
	 * 通过学生课程id该学生对应课程下的作业
	 * */
	public Map<String,Object> getWorkByStudentCourseId(Work wk){
		Map<String,Object> map = new HashMap<String, Object>();
		List<Work> al = new ArrayList<Work>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT work.id,work.workName,work.url,work.addTime FROM WORK WHERE work.studentCourseId=?"+
				" ORDER BY addTime desc";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, wk.getStudentCourseId());
			rs = ps.executeQuery();
			while(rs.next()){
				Work w = new Work();
				w.setAddTime(rs.getString("addTime"));
				w.setId(rs.getInt("id"));
				w.setUrl(rs.getString("url"));
				w.setWorkName(rs.getString("workName"));
				al.add(w);
			}
			map.put("rows", al);
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally{
			DbUtil.free(rs, ps, conn);
		}
		return map;
	}
}
