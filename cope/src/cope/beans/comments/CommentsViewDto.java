package cope.beans.comments;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class CommentsViewDto { //client와 조인하여 사용될 Dto
	private int commentsNo;
	private int commentsClientNo;
	private int commentsPostNo;
	private String commentsContents;
	private Date commentsDate;
	private String commentsBlind;
	private String clientNick;
	public int getCommentsNo() {
		return commentsNo;
	}
	public void setCommentsNo(int commentsNo) {
		this.commentsNo = commentsNo;
	}
	public int getCommentsClientNo() {
		return commentsClientNo;
	}
	public void setCommentsClientNo(int commentsClientNo) {
		this.commentsClientNo = commentsClientNo;
	}
	public int getCommentsPostNo() {
		return commentsPostNo;
	}
	public void setCommentsPostNo(int commentsPostNo) {
		this.commentsPostNo = commentsPostNo;
	}
	public String getCommentsContents() {
		return commentsContents;
	}
	public void setCommentsContents(String commentsContents) {
		this.commentsContents = commentsContents;
	}
	public Date getCommentsDate() {
		return commentsDate;
	}
	public String getCommentsDateToday() {
		SimpleDateFormat simpleDateformat = new SimpleDateFormat("HH:mm:ss");				
		return simpleDateformat.format(commentsDate);
	}
	public void setCommentsDate(Date commentsDate) {
		this.commentsDate = commentsDate;
	}
	public String getCommentsBlind() {
		return commentsBlind;
	}
	public void setCommentsBlind(String commentsBlind) {
		this.commentsBlind = commentsBlind;
	}
	public String getClientNick() {
		return clientNick;
	}
	public void setClientNick(String clientNick) {
		this.clientNick = clientNick;
	}
	public CommentsViewDto() {
		super();
	}
}