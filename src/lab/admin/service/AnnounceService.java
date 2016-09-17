package lab.admin.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.StringTokenizer;

import lab.bean.Announce;
import lab.util.DbUtil;
import lab.util.FileUtil;

public class AnnounceService {

	/*
	 * 管理员发布实验公告
	 */
	public boolean addAnnounce(Announce anc) {

		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String date = formatter.format(new Date());
		String sql = "insert into announce(title,content,userName,ADDTIME,url,fileName) value(?,?,?,?,?,?)";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, anc.getTitle());
			ps.setString(2, anc.getContent());
			ps.setString(3, anc.getUserName());
			ps.setString(4, date);
			ps.setString(5, anc.getUrl());
			ps.setString(6, anc.getName());
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

	/*
	 * 添加带附件的公告
	 */
	public boolean addAnnounceOf(String title, String content, String userName,
			String url, String name) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String date = formatter.format(new Date());
		String sql = "insert into announce(title,content,userName,ADDTIME,url,fileName) value(?,?,?,?,?,?)";
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, title);
			ps.setString(2, content);
			ps.setString(3, userName);
			ps.setString(4, date);
			ps.setString(5, url);
			ps.setString(6, name);
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

	/*
	 * 删除实验室公告
	 */
	public boolean deleteAnnounce(Announce anc) {
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from announce where id in(?)";

		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, anc.getIds());
			if(ps.executeUpdate() > 0){
				StringTokenizer st = new StringTokenizer(anc.getUrl(),",");
				while(st.hasMoreTokens()){
					FileUtil.deleteFile(st.nextToken());
				}
				b = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbUtil.free(ps, conn);
		}
		return b;
	}
}
