package lab.admin.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.StringTokenizer;

import lab.bean.Material;
import lab.util.DbUtil;
import lab.util.FileUtil;

public class MaterialService {
	/*
	 * 删除学习资料
	 * */
	public boolean deleteMaterial(Material mt){
		boolean b = false;
		Connection conn = null;
		PreparedStatement ps = null;
		String sql = "delete from material where id=?";
		StringTokenizer st = new StringTokenizer(mt.getIds(), ",");
		StringTokenizer url = new StringTokenizer(mt.getUrl(), ",");
		try {
			conn = DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			while(st.hasMoreTokens()){
				ps.setInt(1, Integer.parseInt(st.nextToken()));
				ps.addBatch();
			}
			if(ps.executeBatch().length > 0){
				while(url.hasMoreTokens()){
					FileUtil.deleteFile(url.nextToken());
				}
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
