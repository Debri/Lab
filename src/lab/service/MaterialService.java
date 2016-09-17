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


import lab.bean.Material;
import lab.util.DbUtil;
import lab.util.FileUtil;


public class MaterialService {

	/*
	 * 获取学习资料
	 * */
	public Map<String,Object> getMaterial(Material mt){
		List<Material> al = new ArrayList<Material>();
		Map<String,Object> map = new HashMap<String, Object>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection conn = null;
		int total = 0;
		int intPage = mt.getPage() == 0 ? 1 : mt.getPage();
		int rows = mt.getRows() == 0 ? 10 : mt.getRows();
		int start = (intPage - 1) * rows;
		
		String sqlTotal = "select count(*) as id from material" +
				"  LEFT JOIN user ON material.userId=user.userId  where 1=1 ";
		
		String sql = "SELECT material.id,material.title,material.url,user.userName,material.addTime ,material.size" +
				" FROM material LEFT JOIN user ON material.userId=user.userId  WHERE 1=1";
		
		
		if(null != mt.getUserId() && !mt.getUserId().equals("")){
			sql += " and material.userId='" + mt.getUserId().trim()+"'";
			sqlTotal += " and material.userId='" + mt.getUserId().trim()+"'";
		}
		if(null != mt.getTitle() && !mt.getTitle().equals("")){
			sql += " and material.title like '%%" + mt.getTitle().trim()+"%%'";
			sqlTotal += " and material.title like '%%" + mt.getTitle().trim()+"%%'";
		}
		if(null != mt.getUserName() && !mt.getUserName().equals("")){
			sql += " and user.userName like '%%" + mt.getUserName().trim()+"%%'";
			sqlTotal += " and user.userName like '%%" + mt.getUserName().trim()+"%%'";
		}
		
		sql += " ORDER BY "+mt.getSort()+ " "+mt.getOrder()+" limit ?,?";
		
		try{
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, rows);
			rs = ps.executeQuery();
			while(rs.next()){
				Material m = new Material();
				m.setId(rs.getInt("id"));
				m.setTitle(rs.getString("title"));
				m.setUrl(rs.getString("url").replaceAll("\\\\", "\\\\\\\\"));
				m.setUserName(rs.getString("userName"));
				m.setAddTime(rs.getString("addTime"));
				m.setSize(rs.getString("size"));
				al.add(m);
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
	//上传资料
	public boolean addMaterial(String uploadFileName, String name,
			String dstPath, String userId,String size) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "insert into material(title,url,userId,addTime,size) value(?,?,?,?,?)";
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String date = formatter.format(currentTime);
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, uploadFileName);
			ps.setString(2, dstPath);
			ps.setString(3, userId);
			ps.setString(4, date);
			ps.setString(5, size);
			
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
	/*
	 * 删除学习资料
	 * */
	public boolean deleteMaterialById(Material mt) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from material where id=?";
		
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mt.getId());
			if(ps.executeUpdate() == 1){
				FileUtil.deleteFile(mt.getUrl());
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
