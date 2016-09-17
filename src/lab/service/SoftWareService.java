package lab.service;

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

import lab.bean.SoftWare;
import lab.util.DbUtil;
import lab.util.FileUtil;

public class SoftWareService {

	/*
	 * 获取学习软件信息
	 * */
	public Map<String ,Object> getSoftWare(SoftWare sw){
		Map<String,Object> map = new HashMap<String, Object>();
		List<SoftWare> al = new ArrayList<SoftWare>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int total = 0;
		int intPage = sw.getPage() == 0 ? 1 : sw.getPage();
		int rows = sw.getRows() == 0 ? 10 : sw.getRows();
		int start = (intPage - 1) * rows;
		
		
		String sqlTotal = "select count(*) as id from softWare join user on" +
				" softWare.userId=user.userId where 1=1";
		String sql = "select softWare.id,softWare.name,softWare.addTime,softWare.url,softWare.userId,user.userName,softWare.size" +
				" from softWare left join user on" +
				" softWare.userId=user.userId where 1=1";
		
		
		if(null != sw.getUserId() && !sw.getUserId().equals("")){
			sql += " and softWare.userId='" + sw.getUserId().trim()+"'";
			sqlTotal += " and softWare.userId='" + sw.getUserId().trim()+"'";
		}
		
		if(null != sw.getName() && !sw.getName().equals("")){
			sql += " and softWare.name like '%%" + sw.getName().trim()+"%%'";
			sqlTotal += " and softWare.name like '%%" + sw.getName().trim()+"%%'";
		}
		if(null != sw.getUserName() && !sw.getUserName().equals("")){
			sql += " and user.userName like '%%" + sw.getUserName().trim()+"%%'";
			sqlTotal += " and user.userName like '%%" + sw.getUserName().trim()+"%%'";
		}
		
		sql += " ORDER BY "+sw.getSort()+ " "+sw.getOrder()+" limit ?,?";
		
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, rows);
			rs = ps.executeQuery();
			while(rs.next()){
				SoftWare s = new SoftWare();
				s.setAddTime(rs.getString("addTime"));
				s.setId(rs.getInt("id"));
				s.setName(rs.getString("name"));
				s.setUrl(rs.getString("url").replaceAll("\\\\", "\\\\\\\\"));
				s.setUserId(rs.getString("userId"));
				s.setUserName(rs.getString("userName"));
				s.setSize(rs.getString("size"));
				al.add(s);
			}
			rs = ps.executeQuery(sqlTotal);
			if(rs.next()){
				total = rs.getInt("id");
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
	/*
	 * 软件上传
	 * */
	public boolean addSoftWare(String userId, String uploadFileName,
			String url,String size) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "insert into softWare(userId,name,url,addTime,size) value(?,?,?,?,?)";
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String date = formatter.format(currentTime);
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, userId);
			ps.setString(2, uploadFileName);
			ps.setString(3, url.replaceAll("\\\\", "\\\\\\\\"));
			ps.setString(4, date);
			ps.setString(5, size);
			if(ps.executeUpdate() == 1){
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
	 * 删除学习软件
	 * */
	public boolean deleteSoftWareById(SoftWare sw){
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from softWare where id=?";
		
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sw.getId());
			if(ps.executeUpdate() == 1){
				FileUtil.deleteFile(sw.getUrl());
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
