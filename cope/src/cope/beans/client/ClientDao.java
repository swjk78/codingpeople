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
	public boolean exit(int clientNo, String clientPw) {
		String sql = "delete client where client_no=? and client_pw=?";

		int count = 0;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, clientNo);
			ps.setString(2, clientPw);
			count = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count > 0;
	}

	// 회원 상세보기
	public ClientDto myInfo(int clientNo) {
		String sql = "select * from client where client_no=?";

		ClientDto clientDto = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, clientNo);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					clientDto = new ClientDto();

					clientDto.setClientId(rs.getString("client_id"));
					clientDto.setClientNick(rs.getString("client_nick"));
					clientDto.setClientEmail(rs.getString("client_email"));
					clientDto.setClientBirthYear(rs.getShort("client_birth_year"));
					clientDto.setClientGrade(rs.getString("client_grade"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return clientDto;
	}

	public boolean chgPw(int clientNo, String originPw, String chgPw) {
		String sql = "update client set client_pw =? where client_no=? and client_pw=?";

		int count = 0;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, chgPw);
			ps.setInt(2, clientNo);
			ps.setString(3, originPw);

			count = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count > 0;
	}

	public boolean chgMyInfo(ClientDto clientDto) {
		String sql = "update client set client_nick=? , client_email=? where client_no=? and client_pw=?";

		int count = 0;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, clientDto.getClientNick());
			ps.setString(2, clientDto.getClientEmail());
			ps.setInt(3, clientDto.getClientNo());
			ps.setString(4, clientDto.getClientPw());

			count = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count > 0;
	}

	// 아이디 찾기 기능
	public String findId(String inputEmail) {
		String sql = "select client_id from client where client_email = ?";

		String clientId = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, inputEmail);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					clientId = rs.getString(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return clientId;
	}

	// 비밀번호 재설정 기능
	public boolean resetPw(String inputPw, String inputEmail) {
		String sql = "update client set client_pw = ? where client_email = ?";

		int count = 0;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, inputPw);
			ps.setString(2, inputEmail);
			count = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count == 1;
	}

	// 회원 목록 기능
	public List<ClientDto> list(ListParameter listParameter) {
		String sql = "select * from(select rownum rn, tmp.* from("
					 	+ "select client_no, client_id, client_nick, client_email, client_birth_year,"
					 	+ "client_grade, client_unlock_date from client order by #1 #2, client_no desc) tmp"
					+ ") where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getOrderType());
		sql = sql.replace("#2", listParameter.getOrderDirection());

		List<ClientDto> clientList = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, listParameter.getStartRow());
			ps.setInt(2, listParameter.getEndRow());

			try (ResultSet rs = ps.executeQuery()) {
				clientList = new ArrayList<>();
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
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return clientList;
	}

	// 회원 목록 검색 기능
	public List<ClientDto> search(ListParameter listParameter) {
		String sql = "select * from(select rownum rn, tmp.* from("
					 	+ "select client_no, client_id, client_nick, client_email, client_birth_year, client_grade,"
					 	+ "client_unlock_date from client where instr(#1, ?) > 0 order by #2 #3, client_no desc) tmp"
					+ ") where rn between ? and ?";
		sql = sql.replace("#1", listParameter.getSearchType());
		sql = sql.replace("#2", listParameter.getOrderType());
		sql = sql.replace("#3", listParameter.getOrderDirection());

		List<ClientDto> clientList = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, listParameter.getSearchKeyword());
			ps.setInt(2, listParameter.getStartRow());
			ps.setInt(3, listParameter.getEndRow());

			try (ResultSet rs = ps.executeQuery()) {
				clientList = new ArrayList<>();
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
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return clientList;
	}

	// 총 회원 수를 계산하는 기능
	public int getClientCount() {
		String sql = "select count(client_no) from client";

		int clientCount = 0;

		try (Connection con = JdbcUtils.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			rs.next();
			clientCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return clientCount;
	}

	// 총 회원 수를 계산하는 기능(검색할 경우)
	public int getClientCount(ListParameter listParameter) {
		String sql = "select count(client_no) from client where instr(#1, ?) > 0";
		sql = sql.replace("#1", listParameter.getSearchType());

		int clientCount = 0;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, listParameter.getSearchKeyword());

			try (ResultSet rs = ps.executeQuery()) {
				rs.next();
				clientCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return clientCount;
	}

	// 정지 해제 날짜 갱신 기능
	public void refreshUnlockDate(int clientNo) {
		String sql = "update client set client_unlock_date = null where client_no = ?";

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, clientNo);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 회원 정지 기능
	public boolean lockClient(int clientNo, int lockHour) {
		Date unlockDate = null;
		long unlockDateUtil = 0;

		if (lockHour > -1) {
			DateUtils dateUtils = new DateUtils();
			try {
				unlockDateUtil = dateUtils.getUnlockDate(lockHour).getTime();
			} catch (Exception e) {
				e.printStackTrace();
			}
			unlockDate = new Date(unlockDateUtil);
		}

		String sql = "update client set client_unlock_date = ? where client_no = ?";

		int count = 0;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setDate(1, unlockDate);
			ps.setInt(2, clientNo);
			count = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count > 0;
	}

	// 회원가입 기능
	public void regist(ClientDto clientDto) {
		String sql = "insert into client(client_no, client_id, client_pw, client_email, client_nick,"
					 + "client_birth_year) values(client_seq.nextval, ?, ?, ?, ?, ?)";

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, clientDto.getClientId());
			ps.setString(2, clientDto.getClientPw());
			ps.setString(3, clientDto.getClientEmail());
			ps.setString(4, clientDto.getClientNick());
			ps.setShort(5, clientDto.getClientBirthYear());
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 로그인 기능
	public ClientDto login(ClientDto clientDto) {
		String sql = "select client_no, client_unlock_date from client where client_id = ? and client_pw = ?";

		ClientDto find = null;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, clientDto.getClientId());
			ps.setString(2, clientDto.getClientPw());

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					find = new ClientDto();

					find.setClientNo(rs.getInt("client_no"));
					find.setClientUnlockDateRefresh(rs.getDate("client_unlock_date"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return find;
	}

	// 회원 연령대 구하는 기능 (우리 홈페이지는 1950년생부터 가입할 수 있습니다 good)
	public List<ClientAgeRangeDto> getAgeRange() {
		String sql = "select (substr((2021-CLIENT_BIRTH_YEAR+10)/10, 1, 1)*10-10) AGE_RANGE, count(*) from client group by (substr((2021-CLIENT_BIRTH_YEAR+10)/10, 1, 1)*10-10) order by AGE_RANGE asc";
		
		ResultSet rs = null;
		List<ClientAgeRangeDto> ageRangeList = null;
		
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			rs = ps.executeQuery();
			
			ageRangeList = new ArrayList<>();
			while(rs.next()) {
				ClientAgeRangeDto clientAgeRangeDto = new ClientAgeRangeDto();
				clientAgeRangeDto.setTeen((rs.getString("age_range"))+"대");
				clientAgeRangeDto.setCount(rs.getInt("count(*)"));
				System.out.println(clientAgeRangeDto.getTeen()+"는 " + clientAgeRangeDto.getCount() + "명");
				
				ageRangeList.add(clientAgeRangeDto);
			}
		}
		catch (Exception e) { 
			e.printStackTrace();
		}
	return ageRangeList;
	}

	// 회원이 super인지 판단하는 기능
	public boolean isSuper(int clientNo) {
		String sql = "select client_grade from client where client_no=?";

		boolean isSuper = false;

		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, clientNo);

			try (ResultSet rs = ps.executeQuery()) {
				rs.next();
				// System.out.println("등급" + rs.getString("client_grade"));
				isSuper = rs.getString("client_grade").equals("super");
				// System.out.println("불린" + isSuper);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return isSuper;
	}
	
	// 회원번호로 회원 닉네임을 찾는 기능
	public String findClientNick(int clientNo) {
		String sql = "select client_nick from client where client_no = ?";
		
		String clientNick = null;
		
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, clientNo);
			
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					clientNick = rs.getString(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return clientNick;
	}
}
