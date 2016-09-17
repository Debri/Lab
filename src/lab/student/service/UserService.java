package lab.student.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import lab.bean.User;
import lab.util.DbUtil;

public class UserService {

	/*
	 * 学生修改自己的信息
	 */
	public boolean updateUser(User user) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;

		String sql = "update user set userId=?, userName=?,academy=?,discipline=?,cls=?,grade=?,phone=?,sex=?,type=? where userId=?";
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
			ps.setString(10, user.getUserId().trim());
			if (ps.executeUpdate() > 0) {
				b = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtil.free(ps, conn);
		}
		return b;
	}

	/**
	 * 学生修改密码并设置密保
	 */
	public boolean updatePasswordAndSecurity(User user) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String querySql = "select password from user where userId=?";
		String updateSql = "update user set password=?,securityQuestion=?,answer=? where userId=?";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(querySql);
			ps.setString(1, user.getUserId());
			rs = ps.executeQuery();
		
			while (rs.next()) {
				if (rs.getString("password").equals(user.getPassword().trim())) {
					ps = conn.prepareStatement(updateSql);
					ps.setString(1, user.getNewPassword().trim());
					ps.setString(2, user.getSecurityQuestion());
					ps.setString(3, user.getAnswer().trim());
					ps.setString(4, user.getUserId().trim());
					if (ps.executeUpdate() == 1)
						b = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtil.free(ps, conn);
		}
		return b;
	}
	
}
