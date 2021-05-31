package cope.beans.client;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cope.beans.utils.DateUtils;
import cope.beans.utils.JdbcUtils;
import cope.beans.utils.ListParameter;

// 아이디/비번 찾기, 회원관리, 정지된 계정의 로그인 방지 기능 구현을 위한 ClientDao
// 충돌 방지를 위해 ClientDaoTest로 명명
// create by JK
public class ClientDaoTest {
	// 아이디 찾기 기능
	public String findId(String inputEmail) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select client_id from client where client_email = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, inputEmail);
		ResultSet rs = ps.executeQuery();

		String clientId;
		if (rs.next()) {
			clientId = rs.getString(1);
		}
		else {
			clientId = null;
		}
		
		con.close();
		
		return clientId;
	}
	
	// 비밀번호 재설정 기능
	public boolean resetPw(String inputPw, String inputEmail) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update client set client_pw = ? where client_email = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, inputPw);
		ps.setString(2, inputEmail);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count == 1;
	}
	
	// 회원 목록 기능
	public List<ClientDtoTest> list(ListParameter listParameter) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from("
							+ "select rownum rn, tmp.* from("
								+ "select client_no, client_id, client_nick, client_email, client_birth_year,"
								+ "client_grade, client_unlock_date from client order by #1 #2"
							+ ") tmp"
						+ ") where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getOrderType());
		sql = sql.replace("#2", listParameter.getOrderDirection());
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, listParameter.getStartRow());
		ps.setInt(2, listParameter.getEndRow());
		ResultSet rs = ps.executeQuery();
		
		List<ClientDtoTest> clientList = new ArrayList<>();
		while (rs.next()) {
			ClientDtoTest clientDto = new ClientDtoTest();
			clientDto.setClientNo(rs.getInt("client_no"));
			clientDto.setClientId(rs.getString("client_id"));
			clientDto.setClientNick(rs.getString("client_nick"));
			clientDto.setClientEmail(rs.getString("client_email"));
			clientDto.setClientBirthYear(rs.getShort("client_birth_year"));
			clientDto.setClientGrade(rs.getString("client_grade"));
			clientDto.setClientUnlockDateRefresh(rs.getDate("client_unlock_date"));
			clientList.add(clientDto);
		}
		
		con.close();

		return clientList;
	}
	
	// 회원 목록 검색 기능
	public List<ClientDtoTest> search(ListParameter listParameter) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from("
							+ "select rownum rn, tmp.* from("
								+ "select client_no, client_id, client_nick, client_email, client_birth_year,"
								+ "client_grade, client_unlock_date from client where instr(#1, ?) > 0 "
								+ "order by #2 #3"
							+ ") tmp"
						+ ") where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getSearchType());
		sql = sql.replace("#2", listParameter.getOrderType());
		sql = sql.replace("#3", listParameter.getOrderDirection());
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, listParameter.getSearchKeyword());
		ps.setInt(2, listParameter.getStartRow());
		ps.setInt(3, listParameter.getEndRow());
		ResultSet rs = ps.executeQuery();
		
		List<ClientDtoTest> clientList = new ArrayList<>();
		while (rs.next()) {
			ClientDtoTest clientDto = new ClientDtoTest();
			clientDto.setClientNo(rs.getInt("client_no"));
			clientDto.setClientId(rs.getString("client_id"));
			clientDto.setClientNick(rs.getString("client_nick"));
			clientDto.setClientEmail(rs.getString("client_email"));
			clientDto.setClientBirthYear(rs.getShort("client_birth_year"));
			clientDto.setClientGrade(rs.getString("client_grade"));
			clientDto.setClientUnlockDateRefresh(rs.getDate("client_unlock_date"));
			clientList.add(clientDto);
		}
		
		con.close();
		
		return clientList;
	}
	
	// 총 회원 수를 계산하는 기능
	public int getClientCount() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(client_no) from client";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int clientCount = rs.getInt(1);
		
		con.close();
		
		return clientCount;
	}

	// 총 회원 수를 계산하는 기능(검색할 경우)
	public int getClientCount(ListParameter listParameter) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(client_no) from client where instr(#1, ?) > 0";
		sql = sql.replace("#1", listParameter.getSearchType());
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, listParameter.getSearchKeyword());
		ResultSet rs = ps.executeQuery();
		rs.next();
		int clientCount = rs.getInt(1);
		
		con.close();
		
		return clientCount;
	}
	
	// 정지 해제 날짜 갱신 기능
	public void refreshUnlockDate(int clientNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update client set client_unlock_date = null where client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		ps.executeUpdate();

		con.close();
	}
	
	// 회원 정지 기능
	public boolean lockClient(int clientNo, int lockHour) throws Exception {
		Date unlockDate;
		if (lockHour > -1) {
			DateUtils dateUtils = new DateUtils();
			long unlockDateUtil = dateUtils.getUnlockDate(lockHour).getTime();
			unlockDate = new Date(unlockDateUtil);
		}
		else {
			unlockDate = null;
		}
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update client set client_unlock_date = ? where client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setDate(1, unlockDate);
		ps.setInt(2, clientNo);
		int result = ps.executeUpdate();
		
		con.close();
		
		return result > 0;
	}
	
	// 로그인 기능(회원 활동정지 테스트용)
	public ClientDtoTest login(ClientDtoTest clientDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select client_no, client_unlock_date from client where client_id = ? and client_pw = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, clientDto.getClientId());
		ps.setString(2, clientDto.getClientPw());
		ResultSet rs = ps.executeQuery();
		
		ClientDtoTest find;
		if (rs.next()) {
			find = new ClientDtoTest();
			
			find.setClientNo(rs.getInt("client_no"));
			find.setClientUnlockDateRefresh(rs.getDate("client_unlock_date"));
		}
		else {
			find = null;
		}
		
		con.close();
		
		return find;
	}
}
