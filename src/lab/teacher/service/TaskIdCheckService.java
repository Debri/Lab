package lab.teacher.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import lab.bean.Task;
import lab.util.DbUtil;

public class TaskIdCheckService {
	public int getTaskIdCheckService(){
		int b = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select max(id) from task";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()){
				b = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DbUtil.free(ps, conn);
		}
		return b;
	}
}
