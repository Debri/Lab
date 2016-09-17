package lab.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lab.util.DbUtil;
import lab.bean.User;

public class UserService {
	
	/*
	 * 用户登录验证
	 * */
	public User login(User user){
		
		User u = new User();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Connection conn = null;
		String sql = "select userId,userName,type from user where userId=? and password=? and type=?";
		try{
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserId());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getType());
			rs = ps.executeQuery();
			if(rs.next()){
				u.setUserId(rs.getString("userId"));
				u.setUserName(rs.getString("userName"));
				if(rs.getString("type").equals("student")){
					u.setType("学生");
				}else if(rs.getString("type").equals("teacher")){
					u.setType("教师");
				}else if(rs.getString("type").equals("admin")){
					u.setType("管理员");
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DbUtil.free(rs, ps, conn);
		}
		return u;
	}
	
	/*
	 * 用户注册
	 * */
	@SuppressWarnings("resource")
	public boolean register(User user){
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "insert IGNORE into register(userId,userName,academy,grade,discipline,cls,sex,phone,type,password,teacherId) value(?,?,?,?,?,?,?,?,?,?,?)";
		String sqlCheck = "select userId from user where userId='"+user.getUserId().trim()+"'";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sqlCheck);
			rs = ps.executeQuery();
			if(rs.next()){
				return b;
			}
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserId().trim());
			ps.setString(2, user.getUserName());
			ps.setString(3, user.getAcademy());
			ps.setString(4, user.getGrade());
			ps.setString(5, user.getDiscipline());
			ps.setString(6, user.getCls());
			ps.setString(7, user.getSex());
			ps.setString(8, user.getPhone());
			ps.setString(9, user.getType());
			ps.setString(10, user.getPassword());
			ps.setString(11, user.getTeacherId());
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
	 * 根据用户类型获取所有用户信息
	 * */
	@SuppressWarnings("resource")
	public Map<String, Object> getUserByType(User user){
		Map<String, Object> map = new HashMap<String, Object>();
		List<User> al = new ArrayList<User>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int total = 0;
		// 当前页
		int intPage = user.getPage() == 0 ? 1 : user.getPage();
		// 每页显示条数
		int rows = user.getRows() == 0 ? 10 : user.getRows();
		// 每页的开始记录
		int start = (intPage - 1) * rows;
		String sql = "select id,userId,userName,academy,discipline,cls,grade,sex,type,password,phone,securityQuestion,answer from user where 1=1 and type='"
				+ user.getType()+"'";
		String sqlTotal = "select count(*) as num from user where type='"
				+ user.getType()+"'";
		if (null != user.getUserName() && !user.getUserName().equals("")) {
			sql += " and userName like '%%" + user.getUserName().trim() + "%%'";
			sqlTotal += " and userName like '%%" + user.getUserName().trim() + "%%'";
		}
		if (null != user.getUserId() && !user.getUserId().equals("")) {
			sql += " and userId like '%%" + user.getUserId().trim() + "%%'";
			sqlTotal += " and userId like '%%" + user.getUserId().trim() + "%%'";
		}
		if (null != user.getGrade() && !user.getGrade().equals("")) {
			sql += " and grade like '%%" + user.getGrade().trim() + "%%'";
			sqlTotal += " and grade like '%%" + user.getGrade().trim() + "%%'";
		}
		sql += " ORDER BY convert("+user.getSort()+ " using gbk) "+user.getOrder()+" limit ?,?";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, rows);
			rs = ps.executeQuery();
			while (rs.next()) {
				User u = new User();
				u.setAcademy(rs.getString("academy"));
				u.setCls(rs.getString("cls"));
				u.setDiscipline(rs.getString("discipline"));
				u.setPhone(rs.getString("phone"));
				u.setGrade(rs.getString("grade"));
				u.setId(rs.getInt("id"));
				u.setSex(rs.getString("sex"));
				u.setType(rs.getString("type"));
				u.setUserId(rs.getString("userId"));
				u.setUserName(rs.getString("userName"));
				u.setPassword(rs.getString("password"));
				u.setSecurityQuestion(rs.getString("securityQuestion"));
				u.setAnswer(rs.getString("answer"));
				al.add(u);
			}
			rs = ps.executeQuery(sqlTotal);
			while (rs.next()) {
				total = rs.getInt("num");
			}
			map.put("total", total);
			map.put("rows", al);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DbUtil.free(rs, ps, conn);
		}
		return map;
	}
	/*
	 * 通过UserId获取自己的信息
	 * */
	public User getUserByUserId(User user){
		User u = new User();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select id,userId,userName,academy,discipline,cls,grade,sex,type,password,phone from user where userId=?";
		
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserId());
			rs = ps.executeQuery();
			if(rs.next()){
				u.setAcademy(rs.getString("academy"));
				u.setCls(rs.getString("cls"));
				u.setDiscipline(rs.getString("discipline"));
				u.setPhone(rs.getString("phone"));
				u.setGrade(rs.getString("grade"));
				u.setId(rs.getInt("id"));
				u.setSex(rs.getString("sex"));
				u.setType(rs.getString("type"));
				u.setUserId(rs.getString("userId"));
				u.setUserName(rs.getString("userName"));
				u.setPassword(rs.getString("password"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DbUtil.free(rs, ps, conn);
		}
		return u;
	}
	/**
	 * 通过密保问题重置密码
	 * @param user
	 * @return 
	 */
	@SuppressWarnings("resource")
	public boolean resetPasswordBySecurity(User user) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String querySql = "select securityQuestion,answer from user where userId=?";
		String updateSql = "update user set password=? where userId=?";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(querySql);
			ps.setString(1, user.getUserId().trim());
			rs = ps.executeQuery();
			if (rs.next()) {
				if (rs.getString("securityQuestion").equals(
						user.getSecurityQuestion())
						&& rs.getString("answer").equals(user.getAnswer())) {
					ps = conn.prepareStatement(updateSql);
					ps.setString(1, "123");
					ps.setString(2, user.getUserId());
					if (ps.executeUpdate() == 1) {
						b = true;
					}
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DbUtil.free(rs, ps, conn);
		}
		return b;
	}
	/**
	 * 通过用户id找到密保问题
	 */
	public User getSecurity(User user){
		User u = new User();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "select securityQuestion from user where userId=?";
		System.out.println(user.getUserId());
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserId().trim());
			rs=ps.executeQuery();
			if(rs.next()){
				u.setSecurityQuestion(rs.getString("securityQuestion"));
				u.setUserId(user.getUserId().trim());
				System.out.println(rs.getString("securityQuestion"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DbUtil.free(rs, ps, conn);
		}
		return u;
	}
	
}
