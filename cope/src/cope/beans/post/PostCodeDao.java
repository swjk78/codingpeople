package cope.beans.post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cope.beans.utils.JdbcUtils;

public class PostCodeDao {
	public void insert(PostCodeDto postCodeDto) {
		String sql = "insert into code values(code_seq.nextval, ?, ?)";
		
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, postCodeDto.getCodePostNo());
			ps.setString(2, postCodeDto.getCodeUrl());
			ps.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public boolean isExist(int postNo) {
		String sql = "select * from code where code_post_no=?";
		boolean result = false;
		
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, postNo);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					result = true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	public void update(PostCodeDto postCodeDto) {
		String sql = "update code set code_url=? where code_post_no=?";
		
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, postCodeDto.getCodeUrl());
			ps.setInt(2, postCodeDto.getCodePostNo());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//삭제는 없음 null만 저장 되도록.
	
	//url가져오기
	public String get(int postNo) {
		String sql = "select * from code where code_post_no=?";
		String url = "";
		
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, postNo);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					url=rs.getString("code_url");
				}
				else {
					//null 유지
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return url;
		
	}
	
	
	//글 수정 한정 url가져오기!
	public String getToInput(int postNo) {
		String sql = "select * from code where code_post_no=?";
		String urlOrigin = "";
		String urlOutput = "";
		
		try (Connection con = JdbcUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, postNo);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					urlOrigin=rs.getString("code_url");
					urlOutput = urlOrigin.replaceAll("\"", "\'"); //jsp에서 충돌나지 않게
				}
				else {
					//null 유지
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return urlOutput;
		
	}
}


