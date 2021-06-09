package cope.beans.auth;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Timer;
import java.util.TimerTask;

import cope.beans.utils.JdbcUtils;

public class AuthDao {
	// 인증정보 등록 기능
	public void insertAuth(AuthDto authDto) {
		String sql = "insert into auth values(?, sysdate, ?)";
		
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, authDto.getAuthEmail());
			ps.setInt(2, authDto.getAuthNum());
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 이메일로 인증번호 찾기 기능
	public int findAuthNum(String inputEmail) {
		String sql = "select auth_num from auth where auth_email = ?";
		
		int authNum = -1;
		
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, inputEmail);
			
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					authNum = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return authNum;
	}
	
	// 인증정보 제거 기능
	public boolean deleteAuth(String inputEmail) {
		String sql = "delete auth where auth_email = ?";
		
		int count = 0;
		
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, inputEmail);
			count = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count > 0;
	}
}
