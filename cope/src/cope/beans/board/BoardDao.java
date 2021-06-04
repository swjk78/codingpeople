package cope.beans.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


import cope.beans.utils.JdbcUtils;


public class BoardDao {

	// 상위 게시판 (중복검사 후)추가 기능 + 기본 하위 게시판(질문게시판, 팁게시판도 추가)
	public boolean insertBoardSuper(BoardDto boardDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
			String sql = "select * from board where board_name=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, boardDto.getBoardName());
			ResultSet rs = ps.executeQuery();
			
			boolean result;
			if(!rs.next()){
				//1. 상위 게시판 등록			
				sql = "insert into board values(board_seq.nextval, ?, board_seq.currval, ?)";
				ps = con.prepareStatement(sql);
				ps.setString(1, boardDto.getBoardName());
				ps.setInt(2, boardDto.getBoardSuperNo());
				ps.execute();
				
				//2.방금 등록된 게시판번호(board_no)가져오기	
				sql= "select board_no from board where board_name=?";
				ps = con.prepareStatement(sql);
				ps.setString(1, boardDto.getBoardName());
				rs = ps.executeQuery();
				
				rs.next();
				int boardNo = rs.getInt("board_no");
				
				//3. 가져온 번호로 기본 게시판 추가
				String [] BoardSub = {"질문게시판","팁게시판"}; // 자동 추가 될 하위 게시판들
				
				for(int i =0; i<BoardSub.length; i++) {
					sql = "insert into board values(board_seq.nextval, ?, ?, ?)";
					ps = con.prepareStatement(sql);
					ps.setString(1, BoardSub[i]);
					ps.setInt(2, boardNo);
					ps.setInt(3, boardNo);
					ps.execute();
				}
				con.close();
				
				result = true;
			}
			else {
				result = false;
			}
			
			con.close();
			
			return result;
	}


	// 하위 게시판 추가 기능
	public boolean insertBoardSub(BoardDto boardDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from board where board_name=? and board_super_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, boardDto.getBoardName());
		ps.setInt(2, boardDto.getBoardSuperNo());
		ResultSet rs = ps.executeQuery();
		
		boolean result;
		if(!rs.next()){
			sql = "insert into board values(board_seq.nextval, ?, ?, ?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, boardDto.getBoardName());
			ps.setInt(2, boardDto.getBoardGroup());
			ps.setInt(3, boardDto.getBoardSuperNo());
			ps.execute();

			result = true;
		}
		else {
			result = false;
		}
		
		con.close();
		
		return result;
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
		}
		con.close();
		return boardSuperList;
	}

	// 게시판 이름 조회 기능
	public String findBoardName(int boardNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select board_name from board where board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardNo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		String boardName = rs.getString(1);
		
		con.close();
		
		return boardName;
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
		ps.executeUpdate();
		
		con.close();
	}
	
	// 게시판 삭제 기능
	public void deleteBoard(int BoardNo) throws Exception {

		Connection con = JdbcUtils.getConnection();
		String sql = "delete board where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, BoardNo);
		ps.execute();
		
		con.close();
	}
	
	//상위게시판에 속한 게시물들 세기
	public List<Integer> countUnderPosts(List<BoardDto> boardSuperList) throws Exception {
		
		Connection con = JdbcUtils.getConnection();
		//반복이 너무 많이 되어서 선언만 해놓습니다.
		List<Integer> countUnderpostList = new ArrayList<>();// 마지막에서야... 하나씩 추가됨...
		String sql;
		/*
		 * 반복문 (상위게시판)과 (하위게시판)의 개수에따라 반복합니다. (대략 곱하기)
		 */
		for(int i=0; i<boardSuperList.size(); i++) {//상위게시판 개수 만큼 반복
			int boardSuperNo = boardSuperList.get(i).getBoardNo();
			sql = "select board_no from board where board_super_no=? order by board_no asc";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, boardSuperNo);
			ResultSet rs =ps.executeQuery();
			
			List<Integer> boardSubNoList = new ArrayList<>(); //하위게시판 번호를 담을 리스트
			while(rs.next()) {//조회된 하위 게시판 만큼 반복합니다
				boardSubNoList.add(rs.getInt("board_no"));
			}
			int underPostCount = 0;
			for(int k = 0; k<boardSubNoList.size(); k++) {//방금 구한 하위 게시판 만큼 반복합니다.
				sql = "select count(*) from post where post_board_no=?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, boardSubNoList.get(k));
				rs = ps.executeQuery();
				
				rs.next();
				underPostCount += rs.getInt("count(*)");
			}
			countUnderpostList.add(underPostCount);
		}
		con.close();
		
		return countUnderpostList;
	}
	
	//특정 유저가 쓴 게시물들 세기 - 위와 거의 동일
	public List<Integer> countWritenPosts(int clientNo, List<BoardDto> boardSuperList) throws Exception {
		
		Connection con = JdbcUtils.getConnection();

		List<Integer> countWritenpostList = new ArrayList<>();
		String sql;
		/*
		 * 반복문 (상위게시판)과 (하위게시판)의 개수에따라 반복합니다. (대략 곱하기)
		 */
		for(int i=0; i<boardSuperList.size(); i++) {//상위게시판 개수 만큼 반복
			int boardSuperNo = boardSuperList.get(i).getBoardNo();
			sql = "select board_no from board where board_super_no=? order by board_no asc";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, boardSuperNo);
			ResultSet rs =ps.executeQuery();
			
			List<Integer> boardSubNoList = new ArrayList<>(); //하위게시판 번호를 담을 리스트
			while(rs.next()) {//조회된 하위 게시판 만큼 반복합니다
				boardSubNoList.add(rs.getInt("board_no"));
			}
			int underPostCount = 0;
			for(int k = 0; k<boardSubNoList.size(); k++) {//방금 구한 하위 게시판 만큼 반복합니다.
				sql = "select count(*) from post where post_board_no=? and post_client_no = ?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, boardSubNoList.get(k));
				ps.setInt(2, clientNo);
				rs = ps.executeQuery();
				
				rs.next();
				underPostCount += rs.getInt("count(*)");
			}
			countWritenpostList.add(underPostCount);
		}
		con.close();
		
		return countWritenpostList;
	}
	

	//게시판 개수 세기
	public int countBoardSuper() throws Exception {
		
		Connection con = JdbcUtils.getConnection();
		String sql = "select count(*) from board where board_super_no = 0";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		int countSuper =rs.getInt("count(*)");
		
		con.close();
		
		return countSuper;
	}
	
	//post.jps한정 파라미터의groupNo로 조회하여
	//상위 게시판의 board_no인지 아닌지 판별(파라미터의groupNo가 매개변수)
	public boolean checkBoardSuper(int groupNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		String sql = "select board_super_no from board where board_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, groupNo);
		ResultSet rs = ps.executeQuery();
		
		rs.next();
		boolean isBoardSuper = rs.getInt("board_super_no") ==0;//상위 게시판은 board_super_no가 0 이므로
		
		con.close();
		
		return isBoardSuper;
	}
}