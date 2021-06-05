package cope.beans.post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cope.beans.utils.JdbcUtils;
import cope.beans.utils.ListParameter;

public class PostListDao {
	// 글목록
	public List<PostListDto> list(ListParameter listParameter, int boardGroup) {
		String sql = "select * from(select rownum rn, tmp.* from("
					 	+ "select post_no, post_client_no, post_board_no, post_title, post_contents, post_date,"
					 	+ "post_like_count, post_view_count, post_comments_count, post_blind, client_nick, board_name "
					 + "from post_list where board_group = ? order by #1 #2, post_no desc) tmp) where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getOrderType());
		sql = sql.replace("#2", listParameter.getOrderDirection());

		List<PostListDto> postList = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, boardGroup);
			ps.setInt(2, listParameter.getStartRow());
			ps.setInt(3, listParameter.getEndRow());

			try (ResultSet rs = ps.executeQuery()) {
				postList = new ArrayList<>();
				while (rs.next()) {
					PostListDto postListDto = new PostListDto();
					postListDto.setPostNo(rs.getInt("post_no"));
					postListDto.setPostClientNo(rs.getInt("post_client_no"));
					postListDto.setPostBoardNo(rs.getInt("post_board_no"));
					postListDto.setPostTitle(rs.getString("post_title"));
					postListDto.setPostContents(rs.getString("post_contents"));
					postListDto.setPostDate(rs.getDate("post_date"));
					postListDto.setPostLikeCount(rs.getInt("post_like_count"));
					postListDto.setPostViewCount(rs.getInt("post_view_count"));
					postListDto.setPostCommentsCount(rs.getInt("post_comments_count"));
					postListDto.setPostBlind(rs.getString("post_blind").charAt(0));
					postListDto.setClientNick(rs.getString("client_nick"));
					postListDto.setBoardName(rs.getString("board_name"));
					postList.add(postListDto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return postList;
	}

	// 하위 게시판 목록
	public List<PostListDto> list(ListParameter listParameter, int boardGroup, int boardNo) {
		String sql = "select * from(select rownum rn, tmp.* from("
					 	+ "select post_no, post_client_no, post_board_no, post_title, post_contents, post_date,"
					 	+ "post_like_count, post_view_count, post_comments_count, post_blind, client_nick, board_name "
					 	+ "from post_list where board_group = ? and post_board_no = ? order by #1 #2, post_no desc) tmp)"
					 + "where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getOrderType());
		sql = sql.replace("#2", listParameter.getOrderDirection());

		List<PostListDto> postList = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, boardGroup);
			ps.setInt(2, boardNo);
			ps.setInt(3, listParameter.getStartRow());
			ps.setInt(4, listParameter.getEndRow());

			try (ResultSet rs = ps.executeQuery()) {
				postList = new ArrayList<>();
				while (rs.next()) {
					PostListDto postListDto = new PostListDto();
					postListDto.setPostNo(rs.getInt("post_no"));
					postListDto.setPostClientNo(rs.getInt("post_client_no"));
					postListDto.setPostBoardNo(rs.getInt("post_board_no"));
					postListDto.setPostTitle(rs.getString("post_title"));
					postListDto.setPostContents(rs.getString("post_contents"));
					postListDto.setPostDate(rs.getDate("post_date"));
					postListDto.setPostLikeCount(rs.getInt("post_like_count"));
					postListDto.setPostViewCount(rs.getInt("post_view_count"));
					postListDto.setPostCommentsCount(rs.getInt("post_comments_count"));
					postListDto.setPostBlind(rs.getString("post_blind").charAt(0));
					postListDto.setClientNick(rs.getString("client_nick"));
					postListDto.setBoardName(rs.getString("board_name"));
					postList.add(postListDto);
				}
				rs.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return postList;
	}

	// 게시글 검색 기능
	public List<PostListDto> search(ListParameter listParameter, int boardGroup) {
		String sql = "select * from(select rownum rn, tmp.* from("
					 	+ "select post_no, post_client_no, post_board_no, post_title, post_contents, post_date,"
					 	+ "post_like_count, post_view_count, post_comments_count, post_blind, client_nick, board_name "
					 	+ "from post_list where board_group = ? and instr(#1, ?) > 0 order by #2 #3, post_no desc) tmp)"
					 + "where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getSearchType());
		sql = sql.replace("#2", listParameter.getOrderType());
		sql = sql.replace("#3", listParameter.getOrderDirection());

		List<PostListDto> postList = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, boardGroup);
			ps.setString(2, listParameter.getSearchKeyword());
			ps.setInt(3, listParameter.getStartRow());
			ps.setInt(4, listParameter.getEndRow());

			try (ResultSet rs = ps.executeQuery()) {
				postList = new ArrayList<>();
				while (rs.next()) {
					PostListDto postListDto = new PostListDto();
					postListDto.setPostNo(rs.getInt("post_no"));
					postListDto.setPostClientNo(rs.getInt("post_client_no"));
					postListDto.setPostBoardNo(rs.getInt("post_board_no"));
					postListDto.setPostTitle(rs.getString("post_title"));
					postListDto.setPostContents(rs.getString("post_contents"));
					postListDto.setPostDate(rs.getDate("post_date"));
					postListDto.setPostLikeCount(rs.getInt("post_like_count"));
					postListDto.setPostViewCount(rs.getInt("post_view_count"));
					postListDto.setPostCommentsCount(rs.getInt("post_comments_count"));
					postListDto.setPostBlind(rs.getString("post_blind").charAt(0));
					postListDto.setClientNick(rs.getString("client_nick"));
					postListDto.setBoardName(rs.getString("board_name"));
					postList.add(postListDto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return postList;
	}

	// 하위 게시글 검색 기능
	public List<PostListDto> search(ListParameter listParameter, int boardGroup, int boardNo) {
		String sql = "select * from(select rownum rn, tmp.* from("
					 	+ "select post_no, post_client_no, post_board_no, post_title, post_contents, post_date,"
					 	+ "post_like_count, post_view_count, post_comments_count, post_blind, client_nick, board_name "
					 	+ "from post_list where board_group = ? and post_board_no = ? and instr(#1, ?) > 0 "
					 + "order by #2 #3, post_no desc) tmp)" + "where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getSearchType());
		sql = sql.replace("#2", listParameter.getOrderType());
		sql = sql.replace("#3", listParameter.getOrderDirection());

		List<PostListDto> postList = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, boardGroup);
			ps.setInt(2, boardNo);
			ps.setString(3, listParameter.getSearchKeyword());
			ps.setInt(4, listParameter.getStartRow());
			ps.setInt(5, listParameter.getEndRow());

			try (ResultSet rs = ps.executeQuery()) {
				postList = new ArrayList<>();
				while (rs.next()) {
					PostListDto postListDto = new PostListDto();
					postListDto.setPostNo(rs.getInt("post_no"));
					postListDto.setPostClientNo(rs.getInt("post_client_no"));
					postListDto.setPostBoardNo(rs.getInt("post_board_no"));
					postListDto.setPostTitle(rs.getString("post_title"));
					postListDto.setPostContents(rs.getString("post_contents"));
					postListDto.setPostDate(rs.getDate("post_date"));
					postListDto.setPostLikeCount(rs.getInt("post_like_count"));
					postListDto.setPostViewCount(rs.getInt("post_view_count"));
					postListDto.setPostCommentsCount(rs.getInt("post_comments_count"));
					postListDto.setPostBlind(rs.getString("post_blind").charAt(0));
					postListDto.setClientNick(rs.getString("client_nick"));
					postListDto.setBoardName(rs.getString("board_name"));
					postList.add(postListDto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return postList;
	}

	// 페이지블럭 계산을 위한 게시글 개수(상위 게시판 선택)
	public int getPostCount(int boardGroup) {
		String sql = "select count(post_no) from post_list where board_group = ?";

		int postCount = 0;
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, boardGroup);
			
			try (ResultSet rs = ps.executeQuery()) {
				rs.next();
				postCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return postCount;
	}

	// 페이지블럭 계산을 위한 게시글 개수(상위 게시판 선택, 검색)
	public int getPostCount(ListParameter listParameter, int boardGroup) {
		String sql = "select count(post_no) from post_list where instr(#1, ?) > 0 and board_group = ?";
		sql = sql.replace("#1", listParameter.getSearchType());

		int postCount = 0;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, listParameter.getSearchKeyword());
			ps.setInt(2, boardGroup);

			try (ResultSet rs = ps.executeQuery()) {
				rs.next();
				postCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return postCount;
	}

	// 페이지블럭 계산을 위한 게시글 개수(하위 게시판 선택)
	public int getPostCount(int boardGroup, int boardNo) {
		String sql = "select count(post_no) from post_list where board_group = ? and post_board_no = ?";
		
		int postCount = 0;
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, boardGroup);
			ps.setInt(2, boardNo);
			
			try (ResultSet rs = ps.executeQuery()) {
				rs.next();
				postCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return postCount;
	}
	
	// 페이지블럭 계산을 위한 게시글 개수(하위 게시판 선택, 검색)
	public int getPostCount(ListParameter listParameter, int boardGroup, int boardNo) {
		String sql = "select count(post_no) from post_list where board_group = ? "
					 + "and post_board_no = ? and instr(#1, ?) > 0";
		sql = sql.replace("#1", listParameter.getSearchType());
		
		int postCount = 0;
		
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, boardGroup);
			ps.setInt(2, boardNo);
			ps.setString(3, listParameter.getSearchKeyword());
			
			try (ResultSet rs = ps.executeQuery()) {
				rs.next();
				postCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return postCount;
	}

	// 게시글 블라인드/블라인드 해제 기능
	public boolean blindPost(PostListDto postListDto) {
		char postBlind = postListDto.getPostBlind();

		String sql;
		if (postBlind == 'F') {
			sql = "update post_list set post_blind = 'T' where post_no = ?";
		} else {
			sql = "update post_list set post_blind = 'F' where post_no = ?";
		}

		int count = 0;
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, postListDto.getPostNo());
			count = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count > 0;
	}

	// 게시글 조회 기능
	public PostListDto find(int postNo) {
		String sql = "select * from post_list where post_no = ?";

		PostListDto postListDto = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, postNo);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					postListDto = new PostListDto();
					postListDto.setPostNo(rs.getInt("post_no"));
					postListDto.setPostClientNo(rs.getInt("post_client_no"));
					postListDto.setPostBoardNo(rs.getInt("post_board_no"));
					postListDto.setPostTitle(rs.getString("post_title"));
					postListDto.setPostContents(rs.getString("post_contents"));
					postListDto.setPostDate(rs.getDate("post_date"));
					postListDto.setPostLikeCount(rs.getInt("post_like_count"));
					postListDto.setPostViewCount(rs.getInt("post_view_count"));
					postListDto.setPostCommentsCount(rs.getInt("post_comments_count"));
					postListDto.setPostBlind(rs.getString("post_blind").charAt(0));
					postListDto.setClientNick(rs.getString("client_nick"));
					postListDto.setBoardName(rs.getString("board_name"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return postListDto;
	}

	// 특정 회원이 작성한 글 목록
	public List<PostListDto> clientPostList(ListParameter listParameter, int clientNo) {
		String sql = "select * from(select rownum rn, tmp.* from("
					 	+ "select post_no, post_client_no, post_board_no, post_title, post_contents, post_date, post_like_count,"
					 	+ "post_view_count, post_comments_count, post_blind, client_nick, board_name, board_group "
					 	+ "from post_list where post_client_no = ? order by #1 #2, post_no desc) tmp)"
					 + "where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getOrderType());
		sql = sql.replace("#2", listParameter.getOrderDirection());

		List<PostListDto> clientPostList = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, clientNo);
			ps.setInt(2, listParameter.getStartRow());
			ps.setInt(3, listParameter.getEndRow());

			try (ResultSet rs = ps.executeQuery()) {
				clientPostList = new ArrayList<>();
				while (rs.next()) {
					PostListDto postListDto = new PostListDto();
					postListDto.setPostNo(rs.getInt("post_no"));
					postListDto.setPostClientNo(rs.getInt("post_client_no"));
					postListDto.setPostBoardNo(rs.getInt("post_board_no"));
					postListDto.setPostTitle(rs.getString("post_title"));
					postListDto.setPostContents(rs.getString("post_contents"));
					postListDto.setPostDate(rs.getDate("post_date"));
					postListDto.setPostLikeCount(rs.getInt("post_like_count"));
					postListDto.setPostViewCount(rs.getInt("post_view_count"));
					postListDto.setPostCommentsCount(rs.getInt("post_comments_count"));
					postListDto.setPostBlind(rs.getString("post_blind").charAt(0));
					postListDto.setClientNick(rs.getString("client_nick"));
					postListDto.setBoardName(rs.getString("board_name"));
					postListDto.setBoardGroup(rs.getInt("board_group"));
					clientPostList.add(postListDto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return clientPostList;
	}

	// 특정 회원이 작성한 글 목록(상위 게시판 선택)
	public List<PostListDto> clientPostList(ListParameter listParameter, int clientNo, int boardGroup) {
		String sql = "select * from(select rownum rn, tmp.* from("
					 	+ "select post_no, post_client_no, post_board_no, post_title, post_contents, post_date, post_like_count,"
					 	+ "post_view_count, post_comments_count, post_blind, client_nick, board_name, board_group "
					 	+ "from post_list where post_client_no = ? and board_group = ? order by #1 #2, post_no desc) tmp)"
				 	 + "where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getOrderType());
		sql = sql.replace("#2", listParameter.getOrderDirection());

		List<PostListDto> clientPostList = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, clientNo);
			ps.setInt(2, boardGroup);
			ps.setInt(3, listParameter.getStartRow());
			ps.setInt(4, listParameter.getEndRow());

			try (ResultSet rs = ps.executeQuery()) {
				clientPostList = new ArrayList<>();
				while (rs.next()) {
					PostListDto postListDto = new PostListDto();
					postListDto.setPostNo(rs.getInt("post_no"));
					postListDto.setPostClientNo(rs.getInt("post_client_no"));
					postListDto.setPostBoardNo(rs.getInt("post_board_no"));
					postListDto.setPostTitle(rs.getString("post_title"));
					postListDto.setPostContents(rs.getString("post_contents"));
					postListDto.setPostDate(rs.getDate("post_date"));
					postListDto.setPostLikeCount(rs.getInt("post_like_count"));
					postListDto.setPostViewCount(rs.getInt("post_view_count"));
					postListDto.setPostCommentsCount(rs.getInt("post_comments_count"));
					postListDto.setPostBlind(rs.getString("post_blind").charAt(0));
					postListDto.setClientNick(rs.getString("client_nick"));
					postListDto.setBoardName(rs.getString("board_name"));
					postListDto.setBoardGroup(rs.getInt("board_group"));
					clientPostList.add(postListDto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return clientPostList;
	}

	// 특정 회원이 작성한 글 목록(상위 게시판의 하위 게시판 선택)
	public List<PostListDto> clientPostList(ListParameter listParameter, int clientNo, int boardGroup, int boardNo) {
		String sql = "select * from(select rownum rn, tmp.* from("
					 	+ "select post_no, post_client_no, post_board_no, post_title, post_contents, post_date, post_like_count,"
					 	+ "post_view_count, post_comments_count, post_blind, client_nick, board_name, board_group "
					 	+ "from post_list where post_client_no = ? and board_group = ? and post_board_no = ? "
					 + "order by #1 #2, post_no desc) tmp)" + "where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getOrderType());
		sql = sql.replace("#2", listParameter.getOrderDirection());

		List<PostListDto> clientPostList = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, clientNo);
			ps.setInt(2, boardGroup);
			ps.setInt(3, boardNo);
			ps.setInt(4, listParameter.getStartRow());
			ps.setInt(5, listParameter.getEndRow());

			try (ResultSet rs = ps.executeQuery()) {
				clientPostList = new ArrayList<>();
				while (rs.next()) {
					PostListDto postListDto = new PostListDto();
					postListDto.setPostNo(rs.getInt("post_no"));
					postListDto.setPostClientNo(rs.getInt("post_client_no"));
					postListDto.setPostBoardNo(rs.getInt("post_board_no"));
					postListDto.setPostTitle(rs.getString("post_title"));
					postListDto.setPostContents(rs.getString("post_contents"));
					postListDto.setPostDate(rs.getDate("post_date"));
					postListDto.setPostLikeCount(rs.getInt("post_like_count"));
					postListDto.setPostViewCount(rs.getInt("post_view_count"));
					postListDto.setPostCommentsCount(rs.getInt("post_comments_count"));
					postListDto.setPostBlind(rs.getString("post_blind").charAt(0));
					postListDto.setClientNick(rs.getString("client_nick"));
					postListDto.setBoardName(rs.getString("board_name"));
					postListDto.setBoardGroup(rs.getInt("board_group"));
					clientPostList.add(postListDto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return clientPostList;
	}

	// 특정 회원이 작성한 글 목록(검색할 경우)
	public List<PostListDto> clientPostListSearch(ListParameter listParameter, int clientNo) {
		String sql = "select * from(select rownum rn, tmp.* from("
					 	+ "select post_no, post_client_no, post_board_no, post_title, post_contents, post_date, post_like_count,"
					 	+ "post_view_count, post_comments_count, post_blind, client_nick, board_name, board_group "
					 	+ "from post_list where post_client_no = ? and instr(#1, ?) > 0 order by #2 #3, post_no desc) tmp)"
					 + "where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getSearchType());
		sql = sql.replace("#2", listParameter.getOrderType());
		sql = sql.replace("#3", listParameter.getOrderDirection());

		List<PostListDto> clientPostList = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, clientNo);
			ps.setString(2, listParameter.getSearchKeyword());
			ps.setInt(3, listParameter.getStartRow());
			ps.setInt(4, listParameter.getEndRow());

			try (ResultSet rs = ps.executeQuery()) {
				clientPostList = new ArrayList<>();
				while (rs.next()) {
					PostListDto postListDto = new PostListDto();
					postListDto.setPostNo(rs.getInt("post_no"));
					postListDto.setPostClientNo(rs.getInt("post_client_no"));
					postListDto.setPostBoardNo(rs.getInt("post_board_no"));
					postListDto.setPostTitle(rs.getString("post_title"));
					postListDto.setPostContents(rs.getString("post_contents"));
					postListDto.setPostDate(rs.getDate("post_date"));
					postListDto.setPostLikeCount(rs.getInt("post_like_count"));
					postListDto.setPostViewCount(rs.getInt("post_view_count"));
					postListDto.setPostCommentsCount(rs.getInt("post_comments_count"));
					postListDto.setPostBlind(rs.getString("post_blind").charAt(0));
					postListDto.setClientNick(rs.getString("client_nick"));
					postListDto.setBoardName(rs.getString("board_name"));
					postListDto.setBoardGroup(rs.getInt("board_group"));
					clientPostList.add(postListDto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return clientPostList;
	}

	// 특정 회원이 작성한 글 목록(검색할 경우, 상위 게시판 선택)
	public List<PostListDto> clientPostListSearch(ListParameter listParameter, int clientNo, int boardGroup) {
		String sql = "select * from(select rownum rn, tmp.* from("
					 	+ "select post_no, post_client_no, post_board_no, post_title, post_contents, post_date, post_like_count,"
					 	+ "post_view_count, post_comments_count, post_blind, client_nick, board_name, board_group "
					 	+ "from post_list where post_client_no = ? and instr(#1, ?) > 0 and board_group = ? "
					 + "order by #2 #3, post_no desc) tmp)" + "where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getSearchType());
		sql = sql.replace("#2", listParameter.getOrderType());
		sql = sql.replace("#3", listParameter.getOrderDirection());

		List<PostListDto> clientPostList = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, clientNo);
			ps.setString(2, listParameter.getSearchKeyword());
			ps.setInt(3, boardGroup);
			ps.setInt(4, listParameter.getStartRow());
			ps.setInt(5, listParameter.getEndRow());

			try (ResultSet rs = ps.executeQuery()) {
				clientPostList = new ArrayList<>();
				while (rs.next()) {
					PostListDto postListDto = new PostListDto();
					postListDto.setPostNo(rs.getInt("post_no"));
					postListDto.setPostClientNo(rs.getInt("post_client_no"));
					postListDto.setPostBoardNo(rs.getInt("post_board_no"));
					postListDto.setPostTitle(rs.getString("post_title"));
					postListDto.setPostContents(rs.getString("post_contents"));
					postListDto.setPostDate(rs.getDate("post_date"));
					postListDto.setPostLikeCount(rs.getInt("post_like_count"));
					postListDto.setPostViewCount(rs.getInt("post_view_count"));
					postListDto.setPostCommentsCount(rs.getInt("post_comments_count"));
					postListDto.setPostBlind(rs.getString("post_blind").charAt(0));
					postListDto.setClientNick(rs.getString("client_nick"));
					postListDto.setBoardName(rs.getString("board_name"));
					postListDto.setBoardGroup(rs.getInt("board_group"));
					clientPostList.add(postListDto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return clientPostList;
	}

	// 특정 회원이 작성한 글 목록(검색할 경우, 상위 게시판의 하위 게시판 선택)
	public List<PostListDto> clientPostListSearch(ListParameter listParameter, int clientNo, int boardGroup,
			int boardNo) {
		String sql = "select * from(select rownum rn, tmp.* from("
					 	+ "select post_no, post_client_no, post_board_no, post_title, post_contents, post_date, post_like_count,"
					 	+ "post_view_count, post_comments_count, post_blind, client_nick, board_name, board_group "
					 	+ "from post_list where post_client_no = ? and instr(#1, ?) > 0 and board_group = ? and post_board_no = ? "
					 + "order by #2 #3, post_no desc) tmp)" + "where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getSearchType());
		sql = sql.replace("#2", listParameter.getOrderType());
		sql = sql.replace("#3", listParameter.getOrderDirection());

		List<PostListDto> clientPostList = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, clientNo);
			ps.setString(2, listParameter.getSearchKeyword());
			ps.setInt(3, boardGroup);
			ps.setInt(4, boardNo);
			ps.setInt(5, listParameter.getStartRow());
			ps.setInt(6, listParameter.getEndRow());

			try (ResultSet rs = ps.executeQuery()) {
				clientPostList = new ArrayList<>();
				while (rs.next()) {
					PostListDto postListDto = new PostListDto();
					postListDto.setPostNo(rs.getInt("post_no"));
					postListDto.setPostClientNo(rs.getInt("post_client_no"));
					postListDto.setPostBoardNo(rs.getInt("post_board_no"));
					postListDto.setPostTitle(rs.getString("post_title"));
					postListDto.setPostContents(rs.getString("post_contents"));
					postListDto.setPostDate(rs.getDate("post_date"));
					postListDto.setPostLikeCount(rs.getInt("post_like_count"));
					postListDto.setPostViewCount(rs.getInt("post_view_count"));
					postListDto.setPostCommentsCount(rs.getInt("post_comments_count"));
					postListDto.setPostBlind(rs.getString("post_blind").charAt(0));
					postListDto.setClientNick(rs.getString("client_nick"));
					postListDto.setBoardName(rs.getString("board_name"));
					postListDto.setBoardGroup(rs.getInt("board_group"));
					clientPostList.add(postListDto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return clientPostList;
	}
}
