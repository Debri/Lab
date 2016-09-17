package lab.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DbUtil {

	//定义一个连接池
	private static DataSource ds = null;

	private DbUtil() {

	}

	//加载驱动并初始化数据库连接池
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			ds = new DataSource();
		} catch (Exception e) {
			throw new ExceptionInInitializerError(e);
		}
	}

	//调用数据库连接池获得连接
	public static Connection getConnection() throws SQLException {
		return ds.getConnection();
	}

	
	/*
	 * 释放不带ResultSet的资源
	 * */
	public static void free(PreparedStatement ps, Connection conn){
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (conn != null)
					try {
						ds.close(conn);
					} catch (Exception e) {
						e.printStackTrace();
					}
			}
	}
	
	/*
	 * 释放所有资源
	 * */
	public static void free(ResultSet rs, PreparedStatement ps, Connection conn) {
		try {
			if (rs != null)
				rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (conn != null)
					try {
						ds.close(conn);
					} catch (Exception e) {
						e.printStackTrace();
					}
			}
		}
	}
}
