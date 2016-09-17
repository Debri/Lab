package lab.student.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lab.bean.Work;
import lab.util.DbUtil;
import lab.util.FileUtil;

public class WorkService {
	
	/*
	 * 学生通过taskId查看自己的作业
	 * */
	public Map<String, Object> getWorkByTaskId(Work wk){
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<Work> al = new ArrayList<Work>();
		Connection conn = null;
		PreparedStatement ps =null;
		ResultSet rs = null;
		int total = 0;
		String sql = "SELECT work.id,work.workName,work.addTime,work.url FROM WORK  WHERE work.studentId=? AND taskId=?";
		String sqlTotal = "SELECT count(*) as taskName FROM WORK  WHERE work.studentId="+"'"+wk.getUserId()+"'"+" AND taskId="+wk.getTaskId();
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, wk.getUserId());
			ps.setInt(2, wk.getTaskId());
			rs = ps.executeQuery();
			while(rs.next()){
				Work w = new Work();
				w.setUrl(rs.getString("url").replaceAll("\\\\", "\\\\\\\\"));
				w.setAddTime(rs.getString("addTime"));
				w.setId(rs.getInt("id"));
				w.setWorkName(rs.getString("workName"));
				al.add(w);
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
	/*
	 * 学生上传作业
	 * */
	public int uploadWork(int studentCourseId, int taskId,String studentId, String url, String workName){
		int i = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String date = formatter.format(currentTime);
		String sql = "insert into work(taskId,studentCourseId,studentId,workName,url,addTime) value" +
				"(?,?,?,?,?,?)";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, taskId);
			ps.setInt(2, studentCourseId);
			ps.setString(3, studentId);
			ps.setString(4, workName);
			ps.setString(5, url.replaceAll("\\\\", "\\\\\\\\"));
			ps.setString(6, date);
			if(ps.executeUpdate() > 0){
				i = 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DbUtil.free(ps, conn);
		}
		return i;
	}
	/*
	 * 学生通过作用id删除自己的作业，（数据库和文件）
	 * */
	public boolean deleteWorkByWorkId(Work wk){
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		
		String sql = "delete from work where id=?";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, wk.getId());
			if(ps.executeUpdate() > 0){
				//删除文件
				if(FileUtil.deleteFile(wk.getUrl())){
					b = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DbUtil.free(ps, conn);
		}
		return b;
	}
}
