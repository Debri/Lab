package lab.teacher.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lab.bean.Work;
import lab.util.DbUtil;

public class WorkService {

	/*
	 * 教师根据自己的实验任务id获取学生作业
	 * */
	public Map<String,Object> getWorkByTaskId(Work wk){
		Map<String,Object> map = new HashMap<String, Object>();
		List<Work> al = new ArrayList<Work>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int total = 0;
		// 当前页
		int intPage = wk.getPage() == 0 ? 1 : wk.getPage();
		// 每页显示条数
		int rows = wk.getRows() == 0 ? 10 : wk.getRows();
		// 每页的开始记录
		int start = (intPage - 1) * rows;
		
		String sqlTotal = "select count(*) as taskName from work LEFT JOIN USER" +
				" ON work.studentId=user.userId WHERE  work.taskId="+"'"+wk.getTaskId()+"'";
		String sql = "SELECT work.id,work.workName,user.userId,user.userName,work.url,work.addTime FROM WORK LEFT JOIN USER" +
				" ON work.studentId=user.userId WHERE  work.taskId="+"'"+wk.getTaskId()+"'";
		if(null != wk.getUserName() && !wk.getUserName().equals("")){
			sql += " and user.userName like '%%"+wk.getUserName()+"%%'";
			sqlTotal += " and user.userName like '%%"+wk.getUserName()+"%%'";
		} 
		if(null != wk.getUserId() && !wk.getUserId().equals("")){
			sql += " and user.userId like '%%"+wk.getUserId()+"%%'";
			sqlTotal += " and user.userId like '%%"+wk.getUserId()+"%%'";
		}
		sql += " limit ?,?";
		
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, rows);
			rs = ps.executeQuery();
			while(rs.next()){
				Work w = new Work();
				w.setAddTime(rs.getString("addTime"));
				w.setId(rs.getInt("id"));
				w.setUserId(rs.getString("userId"));
				w.setUrl(rs.getString("url"));
				w.setWorkName(rs.getString("workName"));
				w.setUserName(rs.getString("userName"));
				al.add(w);
			}
			rs = ps.executeQuery(sqlTotal);
			if(rs.next()){
				total = rs.getInt("taskName");
			}
			map.put("total", total);
			map.put("rows", al);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			DbUtil.free(rs, ps, conn);
		}
		return map;
	}
}
