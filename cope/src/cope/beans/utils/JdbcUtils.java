package cope.beans.utils;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// 데이터베이스 관련 유용한 작업들을 수행
public class JdbcUtils {
	// DBCP 연결 기능
	private static DataSource ds;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/oracle");
		}
		catch (Exception e) {
			System.err.println("데이터베이스 연결 실패");
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() throws Exception {
		return ds.getConnection();
	}
}