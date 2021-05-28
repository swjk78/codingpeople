package cope.beans.client;

import java.sql.Date;

//아이디, 비번 찾기 기능 구현을 위한 테스트 ClientDto
//차후 ClientDto와 병합 예정
public class ClientDtoTest {
	private int clientNo;
	private String clientId, clientPw, clientNick, clientEmail;
	private short clientBirthYear;
	private String clientGrade;
	private Date clientUnlockDate; // 정지 해제 날짜
	
	public ClientDtoTest() {
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
	// 정규 표현식 필요
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public String getClientPw() {
		return clientPw;
	}
	// 정규 표현식 필요
	public void setClientPw(String clientPw) {
		this.clientPw = clientPw;
	}
	public String getClientNick() {
		return clientNick;
	}
	// 정규 표현식 필요
	public void setClientNick(String clientNick) {
		this.clientNick = clientNick;
	}
	public String getClientEmail() {
		return clientEmail;
	}
	public void setClientEmail(String clientEmail) {
		this.clientEmail = clientEmail;
	}
	public short getClientBirthYear() {
		return clientBirthYear;
	}
	public void setClientBirthYear(short clientBirthYear) {
		this.clientBirthYear = clientBirthYear;
	}
	public String getClientGrade() {
		return clientGrade;
	}
	public String getClientGradeKorean() {
		if (clientGrade.equals("normal")) return "일반";
		else if (clientGrade.equals("super")) return "관리자";
		else return "미상";
	}
	// 조건식 필요
	public void setClientGrade(String clientGrade) {
		this.clientGrade = clientGrade;
	}
	public Date getClientUnlockDate() {
		return clientUnlockDate;
	}
	public void setClientUnlockDate(Date clientUnlockDate) {
		this.clientUnlockDate = clientUnlockDate;
	}
}