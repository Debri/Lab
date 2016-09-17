package lab.teacher.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lab.bean.Register;
import lab.util.DbUtil;

public class RegisterService {
	/*
	 * 获取注册用户信息
	 * */	
	public Map<String,Object> getRegister(Register rgs){
		Map<String, Object> map = new HashMap<String, Object>();
		List<Register> al = new ArrayList<Register>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int total = 0;
		// 当前页
		int intPage = rgs.getPage() == 0 ? 1 : rgs.getPage();
		// 每页显示条数
		int rows = rgs.getRows() == 0 ? 10 : rgs.getRows();
		// 每页的开始记录
		int start = (intPage - 1) * rows;
		String sql = "select id,userId,userName,academy,discipline,cls,grade,sex,state,type,password,phone from register where 1=1 ";
		String sqlTotal = "select count(*) as num from register where 1=1 ";
		if (null != rgs.getUserName() && !rgs.getUserName().equals("")) {
			sql += " and userName like '%%" + rgs.getUserName().trim() + "%%'";
			sqlTotal += " and userName like '%%" + rgs.getUserName().trim() + "%%'";
		}
		if (null != rgs.getUserId() && !rgs.getUserId().equals("")) {
			sql += " and userId like '%%" + rgs.getUserId().trim() + "%%'";
			sqlTotal += " and userId like '%%" + rgs.getUserId().trim() + "%%'";
		}
		if (null != rgs.getTeacherId() && !rgs.getTeacherId().equals("")) {
			sql += " and teacherId like '%%" + rgs.getTeacherId().trim() + "%%'";
			sqlTotal += " and teacherId like '%%" + rgs.getTeacherId().trim() + "%%'";
		}
		sql += " ORDER BY "+rgs.getSort()+ " "+rgs.getOrder()+" limit ?,?";
		
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, rows);
			rs = ps.executeQuery();
			while(rs.next()){
				Register r = new Register();
				r.setAcademy(rs.getString("academy"));
				r.setCls(rs.getString("cls"));
				r.setDiscipline(rs.getString("discipline"));
				r.setGrade(rs.getString("grade"));
				r.setId(rs.getInt("id"));
				r.setPassword(rs.getString("password"));
				r.setPhone(rs.getString("phone"));
				r.setSex(rs.getString("sex"));
				r.setState(rs.getString("state"));
				r.setType(rs.getString("type"));
				r.setUserId(rs.getString("userId"));
				r.setUserName(rs.getString("userName"));
				al.add(r);
			}
			ps = conn.prepareStatement(sqlTotal);
			rs = ps.executeQuery();
			while(rs.next()){
				total = rs.getInt("num");
			}
			map.put("total", total);
			map.put("rows", al);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DbUtil.free(ps, conn);
		}
		return map;
	}
	
	/*
	 * 教师授权用户
	 * */
	public boolean grantRegister(Register rgs) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "INSERT IGNORE INTO USER(userId,userName,academy,grade,discipline,cls,sex,phone,TYPE,PASSWORD) " +
				"SELECT userId,userName,academy,grade,discipline,cls,sex,phone,TYPE,PASSWORD"+
				"	FROM register WHERE userId = ?";
		String sqlU = "update register set state='yes' where userId=?";
		try {
			conn =  DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, rgs.getUserId());
			if(ps.executeUpdate() > 0){
				b = true;
			}
			ps = conn.prepareStatement(sqlU);
			ps.setString(1, rgs.getUserId());
			ps.executeUpdate();
		} catch (SQLException e) {
			b = false;
			e.printStackTrace();
		}finally{
			DbUtil.free(ps, conn);
		}
		return b;
	}

	/*
	 * 删除注册用户
	 * */
	public boolean deleteRegister(Register rgs) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from register where userId=?";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, rgs.getUserId());
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
