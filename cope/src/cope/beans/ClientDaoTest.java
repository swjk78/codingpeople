package cope.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// 아이디, 비번 찾기 기능 구현을 위한 테스트 ClientDao
// 차후 ClientDao와 병합 예정
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
	
	// 회원번호 찾기 기능
//	public long findNo(String inputEmail) throws Exception {
//		Connection con = JdbcUtils.getConnection();
//		
//		String sql = "select client_no from client where client_email = "
//		
//		con.close();
//	}
}
