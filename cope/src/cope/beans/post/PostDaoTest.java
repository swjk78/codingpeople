package cope.beans.post;

import java.sql.Connection;
import java.sql.PreparedStatement;

import cope.beans.utils.JdbcUtils;

// 게시글 블라인드 기능 구현을 위한 테스트 PostDao
// create by JK
public class PostDaoTest {
	// 게시글 블라인드 처리 기능
	public boolean blindPost(PostDtoTest postDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update post_list set post_blind = 'T' where post_no = ? and client_grade = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, postDto.getPostNo());
		ps.setString(2, postDto.getClientGrade());
		int result = ps.executeUpdate();
		
		con.close();
		
		return result > 0;
	}
}
