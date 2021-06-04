package cope.beans.post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import cope.beans.utils.JdbcUtils;

public class PostDao {
	// 게시글 시퀀스 번호 자동생성
	public int getSequence() {
		String sql = "select post_seq.nextval from dual";

		int no = 0;

		try (Connection con = JdbcUtils.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();) {
			rs.next();
			no = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return no;
	}

	// 게시글 등록
	public void registPost(PostDto postDto) {
		String sql = "insert into post(post_no, post_client_no, post_board_no, post_title, post_contents) values(?, ?, ?, ?, ?)";

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setInt(1, postDto.getPostNo());
			ps.setInt(2, postDto.getPostClientNo());
			ps.setInt(3, postDto.getPostBoardNo());
			ps.setString(4, postDto.getPostTitle());
			ps.setString(5, postDto.getPostContents());
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시글 수정
	public boolean editPost(PostDto postDto) {
		String sql = "update post set post_board_no = ?, post_title = ?, post_contents = ? where post_no = ?";

		int count = 0;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setInt(1, postDto.getPostBoardNo());
			ps.setString(2, postDto.getPostTitle());
			ps.setString(3, postDto.getPostContents());
			ps.setInt(4, postDto.getPostNo());
			count = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count == 1;
	}

	// 게시글 삭제
	public boolean deletePost(int postNo) {
		String sql = "delete post where post_no=?";

		int count = 0;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setInt(1, postNo);
			count = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count == 1;
	}

	// 게시글 블라인드/블라인드 해제 기능
	public boolean blindPost(PostDto postDto) {
		char postBlind = postDto.getPostBlind();

		String sql;
		if (postBlind == 'F') {
			sql = "update post_list set post_blind = 'T' where post_no = ?";
		} else {
			sql = "update post_list set post_blind = 'F' where post_no = ?";
		}

		int count = 0;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setInt(1, postDto.getPostNo());
			count = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count > 0;
	}

	// 게시글 조회 기능
	public PostDto find(int postNo) {
		String sql = "select * from post where post_no = ?";

		ResultSet rs = null;
		PostDto postDto = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setInt(1, postNo);
			rs = ps.executeQuery();

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
			} else {
				postDto = null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return postDto;
	}

	// 조회수 증가 기능
	public void increaseViewCount(int postNo) {
		String sql = "update post set post_view_count = post_view_count + 1 where post_no = ?";

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setInt(1, postNo);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시글 추천수 갱신 기능
	public void refreshLikeCount(int postNo) {
		String sql = "update post "
					 + "set post_like_count = (select count(*) from post_like where post_like_post_no = ?)"
					 + "where post_no = ?";

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setInt(1, postNo);
			ps.setInt(2, postNo);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시글 댓글수 갱신 기능
	public void refreshCommentsCount(int postNo) {
		String sql = "update post "
					 + "set post_comments_count = (select count(*) from comments where comments_post_no = ?)"
					 + "where post_no = ?";

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setInt(1, postNo);
			ps.setInt(2, postNo);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 이전글 조회 기능
	public PostDto getPrevious(int boardGroup, int postNo) {
		String sql = "select * from post "
					 + "where post_no = (select max(post_no) from post_list where board_group = ? and post_no < ?)";

		ResultSet rs = null;
		PostDto postDto = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setInt(1, boardGroup);
			ps.setInt(2, postNo);
			rs = ps.executeQuery();

			if (rs.next()) {
				postDto = new PostDto();
				postDto.setPostNo(rs.getInt("post_no"));
				postDto.setPostTitle(rs.getString("post_title"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return postDto;
	}

	// 다음글 조회 기능
	public PostDto getNext(int boardGroup, int postNo) {
		String sql = "select * from post "
					 + "where post_no = (select min(post_no) from post_list where board_group = ? and post_no > ?)";

		ResultSet rs = null;
		PostDto postDto = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setInt(1, boardGroup);
			ps.setInt(2, postNo);
			rs = ps.executeQuery();

			if (rs.next()) {
				postDto = new PostDto();
				postDto.setPostNo(rs.getInt("post_no"));
				postDto.setPostTitle(rs.getString("post_title"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return postDto;
	}
}
