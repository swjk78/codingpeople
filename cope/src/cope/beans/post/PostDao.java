package cope.beans.post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cope.beans.utils.JdbcUtils;

public class PostDao {
	// 게시글 시퀀스 번호 자동생성
	public int getSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select post_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int no = rs.getInt(1);

		con.close();
		return no;
	}

	// 게시글 등록
	public void registPost(PostDto postDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into post(post_no, post_client_no, post_board_no, post_title, post_contents) values(?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postDto.getPostNo());
		ps.setInt(2, postDto.getPostClientNo());
		ps.setInt(3, postDto.getPostBoardNo());
		ps.setString(4, postDto.getPostTitle());
		ps.setString(5, postDto.getPostContents());
		ps.execute();

		con.close();
	}

	// 게시글 수정
	public boolean editPost(PostDto postDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update post set post_board_no = ?, post_title = ?, post_contents = ? where post_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postDto.getPostBoardNo());
		ps.setString(2, postDto.getPostTitle());
		ps.setString(3, postDto.getPostContents());
		ps.setInt(4, postDto.getPostNo());
		int count = ps.executeUpdate();

		con.close();
		
		return count == 1;
	}

	// 게시글 삭제
	public boolean deletePost(int postNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "delete post where post_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postNo);
		int count = ps.executeUpdate();

		con.close();
		
		return count == 1;
	}

	// 게시글 블라인드/블라인드 해제 기능
	public boolean blindPost(PostDto postDto) throws Exception {
		char postBlind = postDto.getPostBlind();

		String sql;
		if (postBlind == 'F') {
			sql = "update post_list set post_blind = 'T' where post_no = ?";
		} else {
			sql = "update post_list set post_blind = 'F' where post_no = ?";
		}

		Connection con = JdbcUtils.getConnection();

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postDto.getPostNo());
		int result = ps.executeUpdate();

		con.close();

		return result > 0;
	}
	
	// 게시글 조회 기능
	public PostDto find(int postNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from post where post_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postNo);
		ResultSet rs = ps.executeQuery();
		
		PostDto postDto;
		if (rs.next()) {
			postDto = new PostDto();
			postDto.setPostNo(rs.getInt("post_no"));
			postDto.setPostClientNo(rs.getInt("post_client_no"));
			postDto.setPostBoardNo(rs.getInt("post_board_no"));
			postDto.setPostTitle(rs.getString("post_title"));
			postDto.setPostContents(rs.getString("post_contents"));
			postDto.setPostDate(rs.getDate("post_date"));
			postDto.setPostLikeCount(rs.getInt("post_like_count"));
			postDto.setPostViewCount(rs.getInt("post_view_count"));
			postDto.setPostCommentsCount(rs.getInt("post_comments_count"));
			postDto.setPostBlind(rs.getString("post_blind").charAt(0));
		}
		else {
			postDto = null;
		}
		
		con.close();
		
		return postDto;
	}
	
	// 조회수 증가 기능
	public void increaseViewCount(int postNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update post set post_view_count = post_view_count + 1 where post_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postNo);
		ps.executeUpdate();
		
		con.close();
	}
	
	// 게시글 추천수 갱신 기능
	public void refreshLikeCount(int postNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update post "
					 + "set post_like_count = (select count(*) from post_like where post_like_post_no = ?)"
					 + "where post_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postNo);
		ps.setInt(2, postNo);
		ps.executeUpdate();
		
		con.close();
	}
	
	// 게시글 댓글수 갱신 기능
	public void refreshCommentsCount(int postNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update post "
					 + "set post_comments_count = (select count(*) from comments where comments_post_no = ?)"
					 + "where post_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postNo);
		ps.setInt(2, postNo);
		ps.executeUpdate();
		
		con.close();
	}
	
	// 이전글 조회 기능
	public PostDto getPrevious(int boardGroup, int postNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		String sql = "select * from post "
					 + "where post_no = (select max(post_no) from post_list where board_group = ? and post_no < ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardGroup);
		ps.setInt(2, postNo);
		ResultSet rs = ps.executeQuery();
		
		PostDto postDto;
		if(rs.next()) {
			postDto = new PostDto();
			postDto.setPostNo(rs.getInt("post_no"));
			postDto.setPostTitle(rs.getString("post_title"));
		}
		else {
			postDto = null;
		}

		con.close();

		return postDto;
	}

	// 다음글 조회 기능
	public PostDto getNext(int boardGroup, int postNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		String sql = "select * from post "
				  	 + "where post_no = (select min(post_no) from post_list where board_group = ? and post_no > ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardGroup);
		ps.setInt(2, postNo);
		ResultSet rs = ps.executeQuery();
		PostDto postDto;
		if(rs.next()) {
			postDto = new PostDto();
			postDto.setPostNo(rs.getInt("post_no"));
			postDto.setPostTitle(rs.getString("post_title"));
		}
		else {
			postDto = null;
		}

		con.close();

		return postDto;
	}

}
