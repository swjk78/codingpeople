package cope.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class JoinDao {
	// 회원가입 정보 저장
		public void join(String clientId, String clientPw, String clientEmail, String clientNick, short clientBirthYear) 
				throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "insert into client values(client_seq," +"?,?,?,?,?,'normal','')";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, clientId);
			ps.setString(2, clientPw);
			ps.setString(3, clientEmail);
			ps.setString(4, clientNick);
			ps.setShort(5, clientBirthYear);
			ps.execute();

			con.close();
		}
	}