package cope.beans.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cope.beans.client.JdbcUtils;
import cope.beans.comments.CommentsDto;

public class PostListDao {
	//글목록
	public List<PostListDto> postList(int startRow, int endRow) throws Exception{
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from("
						+ "select tmp.*,rownum rn from( "
						+ 		"select * from post_list order by post_no desc "
						+ ")tmp "
						+ ") where rn between ? and ?";
		
//		String sql = "select post_no,post_title,post_client_no,client_no,client_nick, "
//							+ "post_comments_count,post_view_count,post_like_count,post_date "
//					+ "from post p left outer join client c on p.post_client_no = c.client_no";
//		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<PostListDto> list = new ArrayList<>();
		while(rs.next()) {
			PostListDto postListDto = new PostListDto();
			
			postListDto.setPostNo(rs.getInt("post_no"));
			postListDto.setPostTitle(rs.getString("post_title"));			
			postListDto.setPostCommentsCount(rs.getInt("post_comments_count"));						
			postListDto.setPostViewCount(rs.getInt("post_view_count"));
			postListDto.setPostLikeCount(rs.getInt("post_like_count"));
			postListDto.setPostDate(rs.getDate("post_date"));
			//내용검색을 위한
			postListDto.setPostContents(rs.getString("post_contents"));
			
			//닉네임표시
			postListDto.setClientNick(rs.getString("client_nick"));
			
			postListDto.setBlind(rs.getString("post_blind").charAt(0));
			
						
			list.add(postListDto);
		}
		con.close();
		return list;
	}
	
	public List<PostListDto> searchList(String type,String keyword, int startRow, int endRow) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from( "
						+ "select tmp.*,rownum rn from( "
							+ "select * from post_list "
							+ "where instr(#1,?)>0 order by post_no desc "
						+ ")tmp "
						+ ")where rn between ? and ?";
//		String sql = "select post_no,post_title,post_client_no,client_no,client_nick, "
//							+ "post_comments_count,post_view_count,post_like_count,post_date "
//					+ "from post "
//						+ "where instr(#1,?)>0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<PostListDto> search = new ArrayList<>();
		while(rs.next()) {
			PostListDto postListDto = new PostListDto();
			
			
			postListDto.setPostNo(rs.getInt("post_no"));
			postListDto.setPostTitle(rs.getString("post_title"));					
			postListDto.setPostCommentsCount(rs.getInt("post_comments_count"));						
			postListDto.setPostViewCount(rs.getInt("post_view_count"));
			postListDto.setPostLikeCount(rs.getInt("post_like_count"));
			postListDto.setPostDate(rs.getDate("post_date"));
			//내용검색을위한
			postListDto.setPostContents(rs.getString("post_contents"));
			
					
			//닉네임표시
			postListDto.setClientNick(rs.getString("client_nick"));
			search.add(postListDto);
		}
		con.close();
		return search;
	}
	//페이지블럭 계산을위한 카운트(개수) 
	public int getCount(String type, String keyword) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from post_list where instr(#1,?)>0 ";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		return count;
	}
	public int getCount() throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from post_list";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		con.close();
		return count;
	}
	
	//블라인드
	
	public boolean blind(PostListDto postListDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		char postBlind = postListDto.getBlind();
		
		String sql;
		if (postBlind == 'F') {
			sql = "update post_list set post_blind = 'T' where post_no = ?";
		}
		else {
			sql = "update post_list set post_blind = 'F' where post_no = ?";
		}

		
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postListDto.getPostNo());
		int result = ps.executeUpdate();
		
		con.close();
		
		return result > 0;
	}
}
