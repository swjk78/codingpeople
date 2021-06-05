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
	public List<Integer> countUnderPosts(List<BoardDto> boardSuperList) {
		PreparedStatement ps = null;
		ResultSet rs = null;

		List<Integer> countUnderpostList = null;

		try (Connection con = JdbcUtils.getConnection()) {
			// 반복이 너무 많이 되어서 선언만 해놓습니다.
			countUnderpostList = new ArrayList<>();// 마지막에서야... 하나씩 추가됨...
			String sql;
			/*
			 * 반복문 (상위게시판)과 (하위게시판)의 개수에따라 반복합니다. (대략 곱하기)
			 */
			for (int i = 0; i < boardSuperList.size(); i++) {// 상위게시판 개수 만큼 반복
				int boardSuperNo = boardSuperList.get(i).getBoardNo();
				sql = "select board_no from board where board_super_no=? order by board_no asc";
				ps = con.prepareStatement(sql);
				ps.setInt(1, boardSuperNo);
				rs = ps.executeQuery();

				List<Integer> boardSubNoList = new ArrayList<>(); // 하위게시판 번호를 담을 리스트
				while (rs.next()) {// 조회된 하위 게시판 만큼 반복합니다
					boardSubNoList.add(rs.getInt("board_no"));
				}

				rs.close();
				ps.close();

				int underPostCount = 0;
				for (int k = 0; k < boardSubNoList.size(); k++) {// 방금 구한 하위 게시판 만큼 반복합니다.
					sql = "select count(*) from post where post_board_no=?";
					ps = con.prepareStatement(sql);
					ps.setInt(1, boardSubNoList.get(k));
					rs = ps.executeQuery();

					rs.next();
					underPostCount += rs.getInt("count(*)");

					rs.close();
					ps.close();
				}
				countUnderpostList.add(underPostCount);
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
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return countUnderpostList;
	}

	// 특정 유저가 쓴 게시물들 세기 - 위와 거의 동일
	public List<Integer> countWritenPosts(int clientNo, List<BoardDto> boardSuperList) {
		PreparedStatement ps = null;
		ResultSet rs = null;

		List<Integer> countWritenpostList = null;

		try (Connection con = JdbcUtils.getConnection()) {
			countWritenpostList = new ArrayList<>();
			String sql;
			/*
			 * 반복문 (상위게시판)과 (하위게시판)의 개수에따라 반복합니다. (대략 곱하기)
			 */
			for (int i = 0; i < boardSuperList.size(); i++) {// 상위게시판 개수 만큼 반복
				int boardSuperNo = boardSuperList.get(i).getBoardNo();
				sql = "select board_no from board where board_super_no=? order by board_no asc";
				ps = con.prepareStatement(sql);
				ps.setInt(1, boardSuperNo);
				rs = ps.executeQuery();

				List<Integer> boardSubNoList = new ArrayList<>(); // 하위게시판 번호를 담을 리스트
				while (rs.next()) {// 조회된 하위 게시판 만큼 반복합니다
					boardSubNoList.add(rs.getInt("board_no"));
				}

				rs.close();
				ps.close();

				int underPostCount = 0;
				for (int k = 0; k < boardSubNoList.size(); k++) {// 방금 구한 하위 게시판 만큼 반복합니다.
					sql = "select count(*) from post where post_board_no=? and post_client_no = ?";
					ps = con.prepareStatement(sql);
					ps.setInt(1, boardSubNoList.get(k));
					ps.setInt(2, clientNo);
					rs = ps.executeQuery();

					rs.next();
					underPostCount += rs.getInt("count(*)");

					rs.close();
					ps.close();
				}
				countWritenpostList.add(underPostCount);
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
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return countWritenpostList;
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