package lab.teacher.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lab.bean.User;
import lab.util.DbUtil;

public class UserService {

	/*
	 * 教师通过自己的登录号获取学生注册信息
	 * */
	public Map<String,Object> getUserByUserId(User user){
		Map<String,Object> map = new HashMap<String, Object>();
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
		
		String sqlTotal = "select count(*) as num from register where teacherId='"+user.getTeacherId()+"'";
		String sql = "select id,userId,userName,academy,discipline,cls,grade,sex,type,password,phone,state from register where teacherId='"
				+ user.getTeacherId()+"'";
		if(null != user.getUserId() && !user.getUserName().equals("")){
			sql += " and user.userId like '%%"+user.getUserId()+"%%'";
		} 
		if(null != user.getUserName() && !user.getUserId().equals("")){
			sql += " and user.userName like '%%"+user.getUserName()+"%%'";
		}
		sql += " limit ?,?";
		
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, rows);
			rs = ps.executeQuery();
			while(rs.next()){
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
				u.setState(rs.getString("state"));
				al.add(u);
			}
			rs = ps.executeQuery(sqlTotal);
			if(rs.next()){
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
	 * 修改i信息
	 * */
	public boolean updateUser(User user) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "update user set userId=?, userName=?,academy=?,discipline=?,cls=?,grade=?,phone=?,sex=?,type=?,password=? where userId=?";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserId().trim());
			ps.setString(2, user.getUserName().trim());
			ps.setString(3, user.getAcademy().trim());
			ps.setString(4, user.getDiscipline().trim());
			ps.setString(5, user.getCls().trim());
			ps.setString(6, user.getGrade().trim());
			ps.setString(7, user.getPhone().trim());
			ps.setString(8, user.getSex().trim());
			ps.setString(9, user.getType().trim());
			ps.setString(10, user.getPassword().trim());
			ps.setString(11, user.getUserId().trim());
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
	 * 重置密码
	 * */
	public boolean resetUserPassword(User user) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "update user set password=? where userId=?";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1,"123");
			ps.setString(2,user.getUserId());
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
