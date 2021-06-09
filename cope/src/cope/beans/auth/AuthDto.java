package cope.beans.auth;

import java.sql.Date;

public class AuthDto {
	private String authEmail;
	private Date authDate;
	private int authNum;
	
	public AuthDto(String authEmail) {
		super();
		this.authEmail = authEmail;
	}
	
	public String getAuthEmail() {
		return authEmail;
	}
	public void setAuthEmail(String authEmail) {
		this.authEmail = authEmail;
	}
	public Date getAuthDate() {
		return authDate;
	}
	public void setAuthDate(Date authDate) {
		this.authDate = authDate;
	}
	public int getAuthNum() {
		return authNum;
	}
	public void setAuthNum(int authNum) {
		this.authNum = authNum;
	}
}
