package lab.util;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.LinkedList;

public class DataSource {
	private static String url = "jdbc:mysql://localhost:3306/lab";
	private static String user = "root";
	//old password = lab123
	private static String password = "lab123";

	private static int initCount = 30;
	private static int maxCount = 50;
	private int currentCount = 0;

	//初始化connnection连接池
	LinkedList<Connection> connectionsPool = new LinkedList<Connection>();
	
	//创建Connection连接池
	public DataSource() {
		try {
			for (int i = 0; i < initCount; i++) {
				this.connectionsPool.addLast(this.createConnection());//创建30个与数据库的连接
				this.currentCount++;
			}
		} catch (SQLException e) {
			throw new ExceptionInInitializerError(e);
		}
	}

	//提供connection连接
	public Connection getConnection() throws SQLException {
		synchronized (connectionsPool) {
			if (this.connectionsPool.size() > 0)//使用一个连接，与数据库的连接就减少一个为什么currentCount没有减减--------------------
				return this.connectionsPool.removeFirst();//返回和去除第一个元素

			if (this.currentCount < maxCount) {//判断连接池是否满了，没有，则可以在继续创建知道满  为什么不是initCount------------------
				this.currentCount++;
				return this.createConnection();
			}
			//链接用完时抛出异常
			throw new SQLException("数据库的链接以用完");
		}
	}

	//创建连接的方法
	private Connection createConnection() throws SQLException {
		return DriverManager.getConnection(url, user, password);
	}
	//conn用完后重新放入连接池
	public void close(Connection conn) {
		this.connectionsPool.addLast(conn);//放入连接池的时候没有判断连接池是否满了-----------------------------------------
	}
}
