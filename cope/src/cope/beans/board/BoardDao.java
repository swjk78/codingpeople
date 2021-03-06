package cope.beans.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import cope.beans.utils.JdbcUtils;

public class BoardDao {
	// 게시판 이름 중복 검사 기능
	public boolean checkSameBoardName(String boardName) {
		String sql = "select * from board where board_name=?";

		boolean result = false;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, boardName);

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

	// 상위 게시판 등록 기능
	public void insertBoardSuper(BoardDto boardDto) {
		String sql = "insert into board values(board_seq.nextval, ?, board_seq.currval, ?)";

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, boardDto.getBoardName());
			ps.setInt(2, boardDto.getBoardSuperNo());
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 현재 시퀀스 번호를 가져오는 기능
	public int getCurrentSequence() {
		String sql = "select board_seq.currval from dual";
		int currval = 0;

		try (Connection con = JdbcUtils.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				currval = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return currval;
	}

	// 기본 게시판 등록 기능
	public void insertDefaultBoard(String boardName, int boardNo) {
		String sql = "insert into board values(board_seq.nextval, ?, ?, ?)";

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, boardName);
			ps.setInt(2, boardNo);
			ps.setInt(3, boardNo);
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 하위 게시판 추가 기능
	public boolean insertBoardSub(BoardDto boardDto) {
		String sql = "select * from board where board_name=? and board_super_no = ?";

		PreparedStatement ps = null;
		boolean result = false;

		try (Connection con = JdbcUtils.getConnection()) {
			ps = con.prepareStatement(sql);
			ps.setString(1, boardDto.getBoardName());
			ps.setInt(2, boardDto.getBoardSuperNo());

			try (ResultSet rs = ps.executeQuery()) {
				if (!rs.next()) {
					sql = "insert into board values(board_seq.nextval, ?, ?, ?)";

					ps.close();
					ps = con.prepareStatement(sql);
					ps.setString(1, boardDto.getBoardName());
					ps.setInt(2, boardDto.getBoardGroup());
					ps.setInt(3, boardDto.getBoardSuperNo());
					ps.execute();
					
					ps.close();

					result = true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return result;
	}

	// 상위 게시판 조회 기능(게시판관리, 메인화면에서 쓰임)
	public List<BoardDto> showListBoardSuper() {
		String sql = "select board_no, board_name from board where board_Super_no = 0  order by board_no asc";

		List<BoardDto> boardSuperList = null;

		try (Connection con = JdbcUtils.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			boardSuperList = new ArrayList<>();
			while (rs.next()) {
				BoardDto boardDto = new BoardDto();

				boardDto.setBoardNo(rs.getInt("board_no"));
				boardDto.setBoardName(rs.getString("board_name"));

				boardSuperList.add(boardDto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return boardSuperList;
	}

	// 게시판 이름 조회 기능
	public String findBoardName(int boardNo) {
		String sql = "select board_name from board where board_no = ?";

		String boardName = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, boardNo);

			try (ResultSet rs = ps.executeQuery()) {
				rs.next();
				boardName = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardName;
	}

	// 하위 게시판 조회 기능
	public List<BoardDto> showListBoardSub(int boardSuperNo) {
		String sql = "select board_no, board_name, board_super_no "
					 + "from board where board_Super_no = ? order by board_no asc";

		List<BoardDto> boardSubList = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, boardSuperNo);

			try (ResultSet rs = ps.executeQuery()) {
				boardSubList = new ArrayList<>();
				while (rs.next()) {
					BoardDto boardDto = new BoardDto();

					boardDto.setBoardNo(rs.getInt("board_no"));
					boardDto.setBoardName(rs.getString("board_name"));
					boardDto.setBoardSuperNo(rs.getInt("board_super_no"));

					boardSubList.add(boardDto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return boardSubList;
	}

	// 게시판 수정 기능
	public void editBoard(BoardDto boardDto) {
		String sql = "update board set board_name = ? where board_no = ?";

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, boardDto.getBoardName());
			ps.setInt(2, boardDto.getBoardNo());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게시판 삭제 기능
	public void deleteBoard(int BoardNo) {
		String sql = "delete board where board_no=?";

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, BoardNo);
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 상위게시판에 속한 게시물들 세기
	
	//
	public List<BoardChartDto> countUnderPosts() {
		String sql = "select board_name, count(*) from (select board_name from (select B.board_super_no from post P inner join board B on P.post_board_no = B.board_no order by B.board_no) X inner join board Y on X.board_super_no = Y.board_no) group by board_name";
		
		List<BoardChartDto> boardChartDtoList = null;
		
		try (Connection con = JdbcUtils.getConnection();
				PreparedStatement ps = con.prepareStatement(sql)){
				
				try(ResultSet rs = ps.executeQuery()) {
					boardChartDtoList = new ArrayList<>();
					while (rs.next()) {
						BoardChartDto clientAgeRangeDto = new BoardChartDto();
						clientAgeRangeDto.setName(rs.getString("board_name"));
						clientAgeRangeDto.setCount(rs.getInt("count(*)"));

				boardChartDtoList.add(clientAgeRangeDto);
					}
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardChartDtoList;
	}

	// 특정 유저가 쓴 게시물들 세기 - 위와 거의 동일
	public List<BoardChartDto> countWritenPosts(int clientNo) {
		String sql = "select board_name, count(*) from (select board_name from (select B.board_super_no from post P inner join board B on P.post_board_no = B.board_no where P.post_client_no=? order by B.board_no) X inner join board Y on X.board_super_no = Y.board_no) group by board_name";
		
		List<BoardChartDto> boardChartDtoList = null;
		
		try (Connection con = JdbcUtils.getConnection();
				PreparedStatement ps = con.prepareStatement(sql)){
				ps.setInt(1, clientNo);
				
				try(ResultSet rs = ps.executeQuery()) {
					boardChartDtoList = new ArrayList<>();
					while (rs.next()) {
						BoardChartDto clientAgeRangeDto = new BoardChartDto();
						clientAgeRangeDto.setName(rs.getString("board_name"));
						clientAgeRangeDto.setCount(rs.getInt("count(*)"));

				boardChartDtoList.add(clientAgeRangeDto);
					}
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardChartDtoList;
	}


	// 게시판 개수 세기
	public int countBoardSuper() {
		String sql = "select count(*) from board where board_super_no = 0";

		int countSuper = 0;

		try (Connection con = JdbcUtils.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			rs.next();
			countSuper = rs.getInt("count(*)");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return countSuper;
	}

	// post.jsp한정 파라미터의groupNo로 조회하여
	// 상위 게시판의 board_no인지 아닌지 판별(파라미터의groupNo가 매개변수)
	public boolean checkBoardSuper(int groupNo) {
		String sql = "select board_super_no from board where board_no=?";

		boolean isBoardSuper = false;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, groupNo);

			try (ResultSet rs = ps.executeQuery()) {
				rs.next();
				isBoardSuper = rs.getInt("board_super_no") == 0;// 상위 게시판은 board_super_no가 0 이므로
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isBoardSuper;
	}
}