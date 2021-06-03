package cope.beans.comments;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cope.beans.utils.JdbcUtils;
import cope.servlet.comments.CommentsChooseServlet;

public class CommentsDao {
	
	//댓글 추가 기능
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
	
	//댓글 수정 기능
	public void update (CommentsDto commentsDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update comments set comments_contents = ? where comments_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, commentsDto.getCommentsContents());
		ps.setInt(2, commentsDto.getCommentsNo());
		ps.executeUpdate();
		
		con.close();
	}
	
//	//댓글 목록 기능 --  블라인드된 글도 (블라인드 된 글입니다)라고 보게 하기 위해 임시 주석처리
//	public List<CommentsViewDto> showList (int postNo) throws Exception {
//		Connection con = JdbcUtils.getConnection();
//		
//		String sql = "select comments_no, comments_client_no, comments_post_no, comments_contents, comments_date, comments_blind, client_nick "
//				+ "    from comments_view where comments_post_no=? and comments_blind='F' order by comments_no asc"; //대댓글이 있었다면 TopN쿼리 사용
//		PreparedStatement ps = con.prepareStatement(sql);
//		ps.setInt(1, postNo);
//		ResultSet rs = ps.executeQuery();
//		
//		List<CommentsViewDto> commentsList = new ArrayList<>();
//		while(rs.next()) {
//			CommentsViewDto commentsViewDto = new CommentsViewDto();
//			
//			commentsViewDto.setCommentsClientNo(rs.getInt("COMMENTS_CLIENT_NO"));
//			commentsViewDto.setCommentsPostNo(rs.getInt("COMMENTS_POST_NO"));
//			commentsViewDto.setCommentsContents(rs.getString("COMMENTS_CONTENTS"));
//			commentsViewDto.setCommentsDate(rs.getDate("COMMENTS_DATE"));
//			commentsViewDto.setCommentsBlind(rs.getString("COMMENTS_BLIND"));
//			commentsViewDto.setClientNick(rs.getString("CLIENT_NICK"));
//			commentsViewDto.setCommentsNo(rs.getInt("COMMENTS_NO"));
//			
//			commentsList.add(commentsViewDto);
//		}
//		con.close();
//		
//		return commentsList;
//	}
	
	//댓글 관리자 보기 기능(블라인드 된 것도 조회)
	public List<CommentsViewDto> showList (int postNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select comments_no, comments_client_no, comments_post_no, comments_contents, comments_date, comments_blind, client_nick "
				+ "from comments_view where comments_post_no=? order by comments_no asc"; 
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
	
	//댓글 삭제 기능
	public void delete(int commetnsNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete comments where comments_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, commetnsNo);
		ps.execute();
		
		con.close();
	}
	
	//블라인드, 언블라인드 기능
	public void blind(CommentsDto commentsDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		boolean isBlind = commentsDto.getCommentsBlind().equals("T");
		String sql;
		if(!isBlind) { // 블라인드 된 것이 아닌 댓글이라면 -> 블라인드 처리
			 sql= "update comments set comments_blind = 'T' where comments_no = ?";
		}
		else { //블라인드 된 댓글이라면 -> 언블라인드 처리
			sql = "update comments set comments_blind = 'F' where comments_no = ?";
		}
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, commentsDto.getCommentsNo());
		ps.execute();
		con.close();
}
	//댓글 채택 기능
	public void choose (CommentsChooseDto commentsChooseDto) throws Exception {

		Connection con = JdbcUtils.getConnection();
		String sql = "insert into choose values(choose_seq.nextval, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, commentsChooseDto.getChoosePostNo());
		ps.setInt(2, commentsChooseDto.getChooseCommentsNo());
		ps.execute();
		
		con.close();
	}
	
	//이미 채택된 글인지 boolean
	public boolean isChoose (int postNo) throws Exception {
		
		Connection con = JdbcUtils.getConnection();
		String sql = "select choose_post_no from choose where choose_post_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postNo);
		ResultSet rs = ps.executeQuery();
		
		boolean isChoose;
		if(rs.next()) {//조회 성공
			isChoose = true;
		}
		else {
			isChoose = false;
		}
		return isChoose;
	}
	
	//이미 채택된 글인지 boolean
	public int getChooseNo (int postNo) throws Exception {
		
		Connection con = JdbcUtils.getConnection();
		String sql = "select choose_comments_no from choose where choose_post_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postNo);
		ResultSet rs = ps.executeQuery();
		
		int ChooseNo;
		if(rs.next()) {//조회 성공
			ChooseNo = rs.getInt("choose_comments_no");
		}
		else {
			ChooseNo = 0;
		}
		return ChooseNo;
	}
	
	
	//댓글 닉네임 보이기 기능 - 단순 구분을 위해 만든 기능 ClientDao.myInfo();와 유사합니다
	public String getNick(int clientNo) throws Exception {
			
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
	
	//게시글 쓴 사람 ClientNo만 가져오기
	public int getPostWriter(int PostNo) throws Exception {
			
			Connection con = JdbcUtils.getConnection();
			String sql = "select post_client_no from post where post_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, PostNo);
			ResultSet rs = ps.executeQuery();
			
			int clientNo;
			if(rs.next()) {
				clientNo = rs.getInt("post_client_no");
			}
			else {
				clientNo = 0;
			}
			con.close();
			
			return clientNo;
	}
	
}