package cope.beans.comments;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cope.beans.utils.JdbcUtils;

public class CommentsDao {

	public void insert (CommentsDto commentsDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into comments values (comments_seq.nextval, ?, ?, ?, sysdate, 'F')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, commentsDto.getCommentsClientNo());
		ps.setInt(2, commentsDto.getCommentsPostNo());
		ps.setString(3, commentsDto.getCommentsContents());
		ps.execute();
		
		con.close();
	}
	
	public void update (CommentsDto commentsDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update comments set comments_contents = ? where comments_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, commentsDto.getCommentsContents());
		ps.setInt(2, commentsDto.getCommentsNo());
		ps.execute();
		
		con.close();
	}
	
	public List<CommentsViewDto> showList (int postNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select comments_no, comments_client_no, comments_post_no, comments_contents, comments_date, comments_blind, client_nick \r\n"
				+ "    from comments_view where comments_post_no=? and comments_blind='F' order by comments_no asc"; //대댓글이 있었다면 TopN쿼리 사용
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postNo);
		ResultSet rs = ps.executeQuery();
		
		List<CommentsViewDto> commentsList = new ArrayList<>();
		while(rs.next()) {
			CommentsViewDto commentsViewDto = new CommentsViewDto();
			
			commentsViewDto.setCommentsClientNo(rs.getInt("COMMENTS_CLIENT_NO"));
			commentsViewDto.setCommentsPostNo(rs.getInt("COMMENTS_POST_NO"));
			commentsViewDto.setCommentsContents(rs.getString("COMMENTS_CONTENTS"));
			commentsViewDto.setCommentsDate(rs.getDate("COMMENTS_DATE"));
			commentsViewDto.setCommentsBlind(rs.getString("COMMENTS_BLIND"));
			commentsViewDto.setClientNick(rs.getString("CLIENT_NICK"));
			commentsViewDto.setCommentsNo(rs.getInt("COMMENTS_NO"));
			
			commentsList.add(commentsViewDto);
		}
		con.close();
		
		return commentsList;
	}
	
	public List<CommentsViewDto> showAllList (int postNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select comments_no, comments_client_no, comments_post_no, comments_contents, comments_date, comments_blind, client_nick \r\n"
				+ "    from comments_view where comments_post_no=? order by comments_no asc"; 
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postNo);
		ResultSet rs = ps.executeQuery();
		
		List<CommentsViewDto> commentsList = new ArrayList<>();
		while(rs.next()) {
			CommentsViewDto commentsViewDto = new CommentsViewDto();
			
			commentsViewDto.setCommentsClientNo(rs.getInt("COMMENTS_CLIENT_NO"));
			commentsViewDto.setCommentsPostNo(rs.getInt("COMMENTS_POST_NO"));
			commentsViewDto.setCommentsContents(rs.getString("COMMENTS_CONTENTS"));
			commentsViewDto.setCommentsDate(rs.getDate("COMMENTS_DATE"));
			commentsViewDto.setCommentsBlind(rs.getString("COMMENTS_BLIND"));
			commentsViewDto.setClientNick(rs.getString("CLIENT_NICK"));
			commentsViewDto.setCommentsNo(rs.getInt("COMMENTS_NO"));
			
			commentsList.add(commentsViewDto);
		}
		con.close();
		
		return commentsList;
	}
	
	public void delete(int commetnsNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete comments where comments_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, commetnsNo);
		ps.execute();
		
		con.close();
	}

	public String getNick(int clientNo) throws Exception { //단순 구분을 위해 만든 기능 ClientDao.myInfo();와 같습니다.
			
			Connection con = JdbcUtils.getConnection();
			String sql = "select client_nick from client where client_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, clientNo);
			ResultSet rs = ps.executeQuery();
			
			String clientNick;
			if(rs.next()) {
				clientNick = rs.getString("client_nick");
			}
			else {
				clientNick = null;
			}
			con.close();
			
			return clientNick;
	}
}