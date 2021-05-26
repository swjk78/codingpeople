package cope.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.Types;

public class BoardDao {

	public static final String USERNAME = "cope";
	public static final String PASSWORD = "cope";

	// 게시판 추가 기능 (상위 하위 둘 다 가능)
	public void insertBoardSuper(BoardDto boardDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		if (boardDto.getBoardSuperNo() == 0) { // 상위 게시판인 경우

			String sql = "insert into board values(board_seq.nextval, ?, board_seq.currval, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, boardDto.getBoardName());
			ps.setInt(2, boardDto.getBoardSuperNo());
			ps.execute();
			con.close();
		}

		else if (boardDto.getBoardSuperNo() != 0) { // 상위 게시판이 아닌 경우(하위 게시판인 경우)

			String sql = "insert into board values(board_seq.nextval, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, boardDto.getBoardName());
			ps.setInt(2, boardDto.getBoardSuperNo());
			ps.setInt(3, boardDto.getBoardSuperNo());
			ps.execute();
			con.close();
		}
	}

//하위게시판 추가 기능
	public void insertBoardSub(BoardDto boardDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into board values(board_seq.nextval, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, boardDto.getBoardName());
		ps.setInt(2, boardDto.getBoardGroup());
		ps.setInt(3, boardDto.getBoardSuperNo());
		ps.execute();
		con.close();
	}

	// 상위 게시판 조회(게시판관리, 메인화면에서 쓰임)
	public List<BoardDto> showListBoardSuper() throws Exception {

		Connection con = JdbcUtils.getConnection();
		String sql = "select board_no, board_name from board where board_Super_no = 0  order by board_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<BoardDto> boardSuperList = new ArrayList<>();

		while (rs.next()) {
			BoardDto boardDto = new BoardDto();

			boardDto.setBoardNo(rs.getInt("board_no"));
			boardDto.setBoardName(rs.getString("board_name"));

			boardSuperList.add(boardDto);

			System.out.println("dto추가!");
		}
		con.close();
		return boardSuperList;
	}

	// 하위 게시판 조회
	public List<BoardDto> showListBoardSub(int boardSuperNo) throws Exception {

		Connection con = JdbcUtils.getConnection();
		String sql = "select board_no, board_name, board_super_no from board where board_Super_no = ? order by board_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardSuperNo);
		ResultSet rs = ps.executeQuery();

		List<BoardDto> boardSubList = new ArrayList<>();

		while (rs.next()) {
			BoardDto boardDto = new BoardDto();

			boardDto.setBoardNo(rs.getInt("board_no"));
			boardDto.setBoardName(rs.getString("board_name"));
			boardDto.setBoardSuperNo(rs.getInt("board_super_no"));

			boardSubList.add(boardDto);

		}
		con.close();
		return boardSubList;
	}

	// 게시판 수정
	public void editBoard(BoardDto boardDto) throws Exception{
		
		Connection con = JdbcUtils.getConnection();
		String sql = "update board set board_name = ? where board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, boardDto.getBoardName());
		ps.setInt(2, boardDto.getBoardNo());
		ps.execute();
	}
	
	// 게시판 삭제
	public void deleteBoard(int BoardNo) throws Exception {

		Connection con = JdbcUtils.getConnection();
		String sql = "delete board where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, BoardNo);
		ps.execute();
	}

}

