package cope.beans.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


import cope.beans.utils.JdbcUtils;


public class BoardDao {

	// 상위 게시판 (중복검사 후)추가 기능
	public boolean insertBoardSuper(BoardDto boardDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
			String sql = "select * from board where board_name=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, boardDto.getBoardName());
			ResultSet rs = ps.executeQuery();
			
			if(!rs.next()){
				sql = "insert into board values(board_seq.nextval, ?, board_seq.currval, ?)";
				ps = con.prepareStatement(sql);
				ps.setString(1, boardDto.getBoardName());
				ps.setInt(2, boardDto.getBoardSuperNo());
				ps.execute();
				con.close();
				
				return true;
			}
			else {
				return false;
			}
	}


	// 하위 게시판 추가 기능
	public boolean insertBoardSub(BoardDto boardDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from board where board_name=? and board_super_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, boardDto.getBoardName());
		ps.setInt(2, boardDto.getBoardSuperNo());
		ResultSet rs = ps.executeQuery();
		
		if(!rs.next()){
			sql = "insert into board values(board_seq.nextval, ?, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, boardDto.getBoardName());
			ps.setInt(2, boardDto.getBoardGroup());
			ps.setInt(3, boardDto.getBoardSuperNo());
			ps.execute();
			con.close();
			return true;
		}
		else {
			return false;
		}
	}
	// 상위 게시판 조회 기능(게시판관리, 메인화면에서 쓰임)
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

	// 하위 게시판 조회 기능
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

	// 게시판 수정 기능
	public void editBoard(BoardDto boardDto) throws Exception{
		
		Connection con = JdbcUtils.getConnection();
		String sql = "update board set board_name = ? where board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, boardDto.getBoardName());
		ps.setInt(2, boardDto.getBoardNo());
		ps.execute();
	}
	
	// 게시판 삭제 기능
	public void deleteBoard(int BoardNo) throws Exception {

		Connection con = JdbcUtils.getConnection();
		String sql = "delete board where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, BoardNo);
		ps.execute();
	}

	//게시판 개수 세기
	public int countBoardSuper() throws Exception {
		
		Connection con = JdbcUtils.getConnection();
		String sql = "select count(*) from board where board_super_no = 0";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		int countSuper =rs.getInt("count(*)");
		return countSuper;
	}
}