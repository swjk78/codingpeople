package cope.beans.client;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

import cope.beans.utils.DateUtils;

public class ClientDto {
	private int clientNo;
	private String clientId, clientPw, clientNick, clientEmail;
	private short clientBirthYear;
	private String clientGrade;
	private Date clientUnlockDate; // 정지 해제 날짜
	
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
		if (Pattern.matches("^[a-zA-Z0-9]{8,20}$", clientId)) {
			this.clientId = clientId;
		}
	}
	public String getClientPw() {
		return clientPw;
	}
	public void setClientPw(String clientPw) {
		if (Pattern.matches("^[a-zA-Z0-9!@#$%^&*]{8,16}$", clientPw)) {
			this.clientPw = clientPw;
		}
	}
	public String getClientNick() {
		return clientNick;
	}
	public void setClientNick(String clientNick) {
		if (Pattern.matches("^[가-힣a-zA-Z0-9!@#$%^&*]{1,10}$", clientNick)) {
			this.clientNick = clientNick;
		}
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
	public void setClientGrade(String clientGrade) {
		if (clientGrade.equals("normal") || clientGrade.equals("super")) {
			this.clientGrade = clientGrade;
		} else {
			this.clientGrade = "normal";
		}
	}
	public Date getClientUnlockDate() {
		return clientUnlockDate;
	}
	public String getClientUnlockDateString() {
		SimpleDateFormat simpleDateformat = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");				
		return simpleDateformat.format(clientUnlockDate);
	}
	public void setClientUnlockDate(Date clientUnlockDate) {
		this.clientUnlockDate = clientUnlockDate;
	}
	// 정지해제 날짜 설정 및 갱신
	public void setClientUnlockDateRefresh(Date clientUnlockDate) throws Exception {
		this.clientUnlockDate = clientUnlockDate;
		DateUtils dateUtils = new DateUtils();
		if (clientUnlockDate != null && dateUtils.compareWithSysdate(clientUnlockDate)) {
			this.clientUnlockDate = null;
		}
	}
}
