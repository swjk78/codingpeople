package cope.beans.post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cope.beans.utils.JdbcUtils;

public class PostLikeDao {
	// 게시글 추천 등록 기능
	public void insertPostLike(PostLikeDto postLikeDto) {
		String sql = "insert into post_like(post_like_client_no, post_like_post_no) values(?, ?)";
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, postLikeDto.getPostLikeClientNo());
			ps.setInt(2, postLikeDto.getPostLikePostNo());
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시글 추천 확인 기능(중복 방지)
	public boolean checkPostLike(PostLikeDto postLikeDto) {
		String sql = "select * from post_like where post_like_client_no = ? and post_like_post_no = ?";

		boolean result = false;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, postLikeDto.getPostLikeClientNo());
			ps.setInt(2, postLikeDto.getPostLikePostNo());

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					result = true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
}
