package cope.beans.post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cope.beans.utils.JdbcUtils;

public class PostDao {

	//게시글 시퀀스 번호 자동생성
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
	public void registPost(PostDto postDto)throws Exception{
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into post(post_no, post_client_no, post_board_no,"
				+ "post_title, post_contents) values(?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postDto.getPostNo());
		ps.setInt(2, postDto.getPostClientNo());
		ps.setInt(3, postDto.getPostBoardNo());
		ps.setString(4, postDto.getPostTitle());
		ps.setString(5, postDto.getPostContents());
		ps.execute();
		
		con.close();		
	}
	
	//게시글 수정 (게시판 no 조회 -> 제목, 내용을 수정)
	public void editPost(PostDto postDto)throws Exception{
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update post set post_title = ?, set post_contents "
				+ "where post_no = ? ";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, postDto.getPostTitle());
		ps.setString(2, postDto.getPostContents());
		ps.execute();
		
		con.close();
	}
	
	//게시글 삭제 (게시판 no 조회 -> 모두 삭제)
	public void deletePost(int postNo)throws Exception{
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete post where post_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postNo);
		ps.execute();
		
		con.close();
	}
}
