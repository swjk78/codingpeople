package cope.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class JoinDao {
	// 회원가입 정보 저장
		public void regist(JoinDto joinDto) 
				throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "insert into client values(client_seq," +"?,?,?,?,?,'normal','')";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, joinDto.getClientId());
			ps.setString(2, joinDto.getClientPw());
			ps.setString(3, joinDto.getClientEmail());
			ps.setString(4, joinDto.getClientNick());
			ps.setShort(5, joinDto.getClientBirthYear());
			ps.execute();

			con.close();
		}
	}