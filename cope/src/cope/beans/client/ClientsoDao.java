package cope.beans.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cope.beans.utils.ClientsoDto;

	public class ClientsoDao {
		//로그인기능
		public ClientsoDto login(ClientsoDto clientDto)throws Exception{
			Connection con = JdbcUtils.getConnection();
			String sql = "select * from client where client_id = ? and client_pw = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1,clientDto.getClientId());
			ps.setString(2,clientDto.getClientPw());
			ResultSet rs = ps.executeQuery();
			
			ClientsoDto find;
			if(rs.next()) {
				find = new ClientsoDto();
				
				find.setClientNo(rs.getInt("client_no"));
			}
			else {
				find = null;
			}
			con.close();
			return find;
		}
		//로그아웃기능
		public boolean exit(int clientNo) throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "delete client where member_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, clientNo);
			int count = ps.executeUpdate();
			
			con.close();
			
			return count > 0;
		}

		}
//주석
