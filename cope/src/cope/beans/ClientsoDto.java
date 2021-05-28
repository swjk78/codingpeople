package cope.beans;

public class ClientsoDto {
	private int ClientNo;
	private String ClientNickname;
	private String ClientId;
	private String ClientPw;
	private String ClientBirth;
	public ClientsoDto() {
		super();
	}
	public int getClientNo() {
		return ClientNo;
	}
	public void setClientNo(int clientNo) {
		this.ClientNo = clientNo;
	}
	public String getClientNickname() {
		return ClientNickname;
	}
	public void setClientNickname(String nickname) {
		ClientNickname = nickname;
	}
	public String getClientId() {
		return ClientId;
	}
	public void setClientId(String clientId) {
		this.ClientId = clientId;
	}
	public String getClientPw() {
		return ClientPw;
	}
	public void setClientPw(String clientPw) {
		this.ClientPw = clientPw;
	}
	public String getClientBirth() {
		return ClientBirth;
	}
	public void setClientBirth(String birth) {
		ClientBirth = birth;
	}

}
//주석