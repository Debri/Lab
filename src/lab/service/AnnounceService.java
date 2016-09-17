package lab.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lab.bean.Announce;
import lab.util.DbUtil;

public class AnnounceService {
	/*
	 * 获取公告信息
	 * */
	public Map<String,Object> getAnnounce(Announce anc) throws SQLException{
		List<Announce> al = new ArrayList<Announce>();
		Map<String,Object> map = new HashMap<String, Object>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection conn = null;
		int total = 0;
		// 当前页
		int intPage = anc.getPage() == 0 ? 1 : anc.getPage();
		// 每页显示条数
		int rows = anc.getRows() == 0 ? 10 : anc.getRows();
		// 每页的开始记录
		int start = (intPage - 1) * rows;
		String sql = "SELECT id,title,content,userName,url,fileName,addTime FROM announce where 1=1";
		String sqlTotal = "select count(id) as id from announce";
		if(null != anc.getUserName()){
			sql += " and userName like '%%" + anc.getUserName().trim()+"%%";
		}
		if(null != anc.getAddTime()){
			sql += " and addTime like '%%" + anc.getAddTime().trim()+"%%";
		}
		
		sql += " ORDER BY "+anc.getSort()+ " "+anc.getOrder()+" limit ?,?";
		
		try{
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, rows);
			rs = ps.executeQuery();
			while(rs.next()){
				Announce an = new Announce();
				an.setId(rs.getInt("id"));
				an.setTitle(rs.getString("title"));
				an.setContent(rs.getString("content"));
				an.setUserName(rs.getString("userName"));
				an.setAddTime(rs.getString("addTime"));
				an.setName(rs.getString("fileName"));//附件名称
				if(null != rs.getString("url")){
					an.setUrl(rs.getString("url").replaceAll("\\\\", "\\\\\\\\"));
				}
				al.add(an);
			}
			rs = ps.executeQuery(sqlTotal); 
			while(rs.next()){
				total = rs.getInt("id");
			}
			map.put("total", total);
			map.put("rows", al);
		}catch(Exception e){
			e.printStackTrace(); 
		}finally{
			DbUtil.free(rs, ps, conn);
		}
		return map;
	}
	/*
	 * 通过id查看公告信息
	 * */
	public Announce getAnnounceById(Announce anc){
		Announce a = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection conn = null; 
		String sql = "select title,content,userName,addTime,url,fileName from announce where id=?";
		
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, anc.getId());
			rs = ps.executeQuery();
			if(rs.next()){
				a = new Announce();
				a.setAddTime(rs.getString("addTime"));
				a.setContent(rs.getString("content"));
				a.setName(rs.getString("fileName"));
				a.setTitle(rs.getString("title"));
				a.setUrl(rs.getString("url"));
				a.setUserName(rs.getString("userName"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DbUtil.free(rs, ps, conn);
		}
		return a;
	}
}
