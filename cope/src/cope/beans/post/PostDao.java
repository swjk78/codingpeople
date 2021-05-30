package cope.beans.post;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;

import cope.beans.utils.JdbcUtils;

// 게시글 등록
public class PostDao {
	
	public void registPost(PostDto postDto)throws Exception{
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into post(post_no, post_client_no, post_board_no,"
				+ "post_title,post_contents,post_date,post_like_count,post_view_count"
				+ "post_comments_count,post_blind)values(post_seq.nextval, ?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postDto.getPostClientNo());
		ps.setInt(2, postDto.getPostBoardNo());
		ps.setString(3, postDto.getPostTitle());
		ps.setString(4, postDto.getPostContents());
		ps.setDate(5, (Date) postDto.getPostDate()); //(Date), 안될경우 이 부분을 삭제해서 방법을 찾아볼것
		ps.setInt(6, postDto.getPostLikeCount());
		ps.setInt(7, postDto.getPostViewCount());
		ps.setInt(8, postDto.getPostCommentsCount());
		ps.setString(9, postDto.getPostBlind());
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
	}
	
	//게시글 삭제 (게시판 no 조회 -> 모두 삭제)
	public void deletePost(int postNo)throws Exception{
		
		Connection con = JdbcUtils.getConnection();
		String sql = "delete post where post_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postNo);
		ps.execute();
	}
	
	
	
	
}
