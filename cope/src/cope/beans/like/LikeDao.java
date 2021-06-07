package cope.beans.like;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cope.beans.utils.JdbcUtils;

public class LikeDao {
	
	//좋아요 삽입
	public void likeInsert(int clientNo, int postNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into post_like values(?,?,sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		ps.setInt(2, postNo);
		ps.execute();
		con.close();
	}
	
	//좋아요삭제
	public boolean likeDelete(int clientNo, int postNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete post_like where client_no=? and post_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		ps.setInt(2, postNo);
		int count = ps.executeUpdate();
		
		con.close();
		return count>0;
	}
	//좋아요 확인
	public boolean likeCheck(int clientNo, int postNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql ="select * from post_like where client_no=? and post_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		ps.setInt(2, postNo);
		ResultSet rs = ps.executeQuery();
		boolean check = rs.next();
		
		con.close();
		return check;
	}
}
