package cope.beans.post;

import java.sql.Connection;
import java.sql.PreparedStatement;

import cope.beans.utils.JdbcUtils;

// 게시글 블라인드 기능 구현을 위한 테스트 PostDao
// create by JK
public class PostDaoTest {
	// 게시글 블라인드/블라인드 해제 기능
	public boolean blindPost(PostDtoTest postDto) throws Exception {
		char postBlind = postDto.getPostBlind();
		
		String sql;
		if (postBlind == 'F') {
			sql = "update post_list set post_blind = 'T' where post_no = ?";
		}
		else {
			sql = "update post_list set post_blind = 'F' where post_no = ?";
		}

		Connection con = JdbcUtils.getConnection();
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postDto.getPostNo());
		int result = ps.executeUpdate();
		
		con.close();
		
		return result > 0;
	}
}
