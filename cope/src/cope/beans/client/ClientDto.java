package cope.beans.client;

import java.sql.Date;

public class ClientDto {
	private int clientNo;
	private String clientId;
	private String clientPw;
	private String clientNick;
	private String clientEmail;
	private short clientBirthYear;
	private String clientGrade;
	private Date clientUnlockDate;
	public ClientDto() {
		super();
	}
	public int getClientNo() {
		return clientNo;
	}
	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public String getClientPw() {
		return clientPw;
	}
	public void setClientPw(String clientPw) {
		this.clientPw = clientPw;
	}
	public String getClientNick() {
		return clientNick;
	}
	public void setClientNick(String clientNick) {
		this.clientNick = clientNick;
	}
	public String getClientEmail() {
		return clientEmail;
	}
	public void setClientEmail(String clientEmail) {
		this.clientEmail = clientEmail;
	}
	
	public String getClientGrade() {
		return clientGrade;
	}
	public void setClientGrade(String clientGrade) {
		this.clientGrade = clientGrade;
	}
	public Date getClientUnlockDate() {
		return clientUnlockDate;
	}
	public void setClientUnlockDate(Date clientUnlockDate) {
		this.clientUnlockDate = clientUnlockDate;
	}
	public short getClientBirthYear() {
		return clientBirthYear;
	}
	public void setClientBirthYear(short clientBirthYear) {
		this.clientBirthYear = clientBirthYear;
	}
	
	
	
}
