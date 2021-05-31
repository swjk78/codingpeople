package cope.beans.comments;

import java.sql.Date;

public class CommentsDto { //일반적으로 쓰일 Dto
	private int commentsNo;
	private int commentsClientNo;
	private int commentsPostNo;
	private String commentsContents;
	private Date commentsDate;
	private String commentsBlind;
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
	public void setCommentsDate(Date commentsDate) {
		this.commentsDate = commentsDate;
	}
	public String getCommentsBlind() {
		return commentsBlind;
	}
	public void setCommentsBlind(String commentsBlind) {
		this.commentsBlind = commentsBlind;
	}
	public CommentsDto() {
		super();
	}
	
	
}
