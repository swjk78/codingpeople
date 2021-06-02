package cope.beans.client;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import cope.beans.utils.DateUtils;
import cope.beans.utils.JdbcUtils;
import cope.beans.utils.ListParameter;

public class ClientDao {
	// 비밀번호 확인후 탈퇴처리
	public boolean exit(int clientNo, String clientPw) throws Exception {

		Connection con = JdbcUtils.getConnection();
		String sql = "delete client where client_no=? and client_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		ps.setString(2, clientPw);
		int count = ps.executeUpdate();

		con.close();
		return count > 0;

	}

	// 회원 상세보기
	public ClientDto myInfo(int clientNo) throws Exception {

		Connection con = JdbcUtils.getConnection();
		String sql = "select * from client where client_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		ResultSet rs = ps.executeQuery();

		ClientDto clientDto;
		if (rs.next()) {
			clientDto = new ClientDto();

			clientDto.setClientId(rs.getString("client_id"));
			clientDto.setClientNick(rs.getString("client_nick"));
			clientDto.setClientEmail(rs.getString("client_email"));
			clientDto.setClientBirthYear(rs.getShort("client_birth_year"));
			clientDto.setClientGrade(rs.getString("client_grade"));

		} else {
			clientDto = null;
		}
		con.close();
		return clientDto;

	}

	public boolean chgPw(int clientNo, String originPw, String chgPw) throws Exception {
		Connection con = JdbcUtils.getConnection();
		String sql = "update client set client_pw =? where client_no=? and client_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, chgPw);
		ps.setInt(2, clientNo);
		ps.setString(3, originPw);

		int count = ps.executeUpdate();
		con.close();
		return count > 0;
	}

	public boolean chgMyInfo(ClientDto clientDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		String sql = "update client set client_nick=? , client_email=? where client_no=? and client_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, clientDto.getClientNick());
		ps.setString(2, clientDto.getClientEmail());
		ps.setInt(3, clientDto.getClientNo());
		ps.setString(4, clientDto.getClientPw());

		int count = ps.executeUpdate();
		con.close();
		return count > 0;
	}

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
		} else {
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
	public List<ClientDto> list(ListParameter listParameter) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from(" + "select rownum rn, tmp.* from("
						+ "select client_no, client_id, client_nick, client_email, client_birth_year,"
						+ "client_grade, client_unlock_date from client order by #1 #2, client_no desc) tmp"
					+ ") where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getOrderType());
		sql = sql.replace("#2", listParameter.getOrderDirection());
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, listParameter.getStartRow());
		ps.setInt(2, listParameter.getEndRow());
		ResultSet rs = ps.executeQuery();

		List<ClientDto> clientList = new ArrayList<>();
		while (rs.next()) {
			ClientDto clientDto = new ClientDto();
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
	public List<ClientDto> search(ListParameter listParameter) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from(" + "select rownum rn, tmp.* from("
						+ "select client_no, client_id, client_nick, client_email, client_birth_year, client_grade,"
						+ "client_unlock_date from client where instr(#1, ?) > 0 order by #2 #3, client_no desc) tmp"
					+ ") where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getSearchType());
		sql = sql.replace("#2", listParameter.getOrderType());
		sql = sql.replace("#3", listParameter.getOrderDirection());
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, listParameter.getSearchKeyword());
		ps.setInt(2, listParameter.getStartRow());
		ps.setInt(3, listParameter.getEndRow());
		ResultSet rs = ps.executeQuery();

		List<ClientDto> clientList = new ArrayList<>();
		while (rs.next()) {
			ClientDto clientDto = new ClientDto();
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
		} else {
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

	// 회원가입 기능
	public void regist(ClientDto clientDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into client(client_no, client_id, client_pw, client_nick, client_email,"
				+ "client_birth_year) values(client_seq.nextval, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, clientDto.getClientId());
		ps.setString(2, clientDto.getClientPw());
		ps.setString(3, clientDto.getClientEmail());
		ps.setString(4, clientDto.getClientNick());
		ps.setShort(5, clientDto.getClientBirthYear());
		ps.execute();

		con.close();
	}

	// 로그인 기능
	public ClientDto login(ClientDto clientDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select client_no, client_unlock_date from client where client_id = ? and client_pw = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, clientDto.getClientId());
		ps.setString(2, clientDto.getClientPw());
		ResultSet rs = ps.executeQuery();

		ClientDto find;
		if (rs.next()) {
			find = new ClientDto();

			find.setClientNo(rs.getInt("client_no"));
			find.setClientUnlockDateRefresh(rs.getDate("client_unlock_date"));
		} else {
			find = null;
		}

		con.close();

		return find;
	}

	//회원 연령대 구하는 기능 (우리 홈페이지는 1950년생부터 가입할 수 있습니다 good)
	public List<Integer>getAgeRange() throws Exception{//void 나중에 리스트로 바꾸기
		
		Connection con = JdbcUtils.getConnection();
		
		Calendar cal = Calendar.getInstance();
		int currYear = cal.get(Calendar.YEAR);
		int maxAge = currYear-1950; //최대나이 71세
		int maxAgeRange = (maxAge/10)*10;//최대 70대
		
		List<Integer>ageRangeList = new ArrayList<>();
		String sql;
		
		for(int i=0; i<=maxAgeRange; i+=10) {//i가 maxAgeRange까지(같아도 실행)
			
			sql ="select count(TEMP.AGE) age_count "
					+ "from (select client_no 회원번호, ((EXTRACT(YEAR FROM SYSDATE)-client_birth_year)) AGE "
					+ "from client) TEMP where TEMP.AGE >=? and TEMP.AGE <?"; //이렇게 DB를 여러번 갔다 와야할까 아니면 뷰를 만들까... 조회하는 횟수는 같을 텐데.
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, i); //보다 크거나 같다
			ps.setInt(2, i+10); //보다 작다
			ResultSet rs = ps.executeQuery();
			
			rs.next();
			int count = rs.getInt("age_count");
			//System.out.println((i) +"대 조회결과..." + count + "명");
			ageRangeList.add(count);
		}
		return ageRangeList;
	}
}
