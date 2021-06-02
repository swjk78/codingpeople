package cope.beans.post;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class PostListDto {
	private int postNo, postClientNo, postBoardNo;
	private String postTitle, postContents;
	private Date postDate;
	private int postLikeCount, postViewCount, postCommentsCount;
	private char postBlind;
	private String clientNick;
	private int groupNo;
	
	public PostListDto() {
		super();
	}
	
	public int getPostNo() {
		return postNo;
	}
	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}
	public int getPostClientNo() {
		return postClientNo;
	}
	public void setPostClientNo(int postClientNo) {
		this.postClientNo = postClientNo;
	}
	public int getPostBoardNo() {
		return postBoardNo;
	}
	public void setPostBoardNo(int postBoardNo) {
		this.postBoardNo = postBoardNo;
	}
	public String getPostTitle() {
		return postTitle;
	}
	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}
	public String getPostContents() {
		return postContents;
	}
	public void setPostContents(String postContents) {
		this.postContents = postContents;
	}
	public Date getPostDate() {
		return postDate;
	}
	public String getPostDateToday() {
		SimpleDateFormat simpleDateformat = new SimpleDateFormat("HH:mm");				
		return simpleDateformat.format(postDate);
	}
	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}
	public int getPostLikeCount() {
		return postLikeCount;
	}
	public void setPostLikeCount(int postLikeCount) {
		this.postLikeCount = postLikeCount;
	}
	public int getPostViewCount() {
		return postViewCount;
	}
	public void setPostViewCount(int postViewCount) {
		this.postViewCount = postViewCount;
	}
	public int getPostCommentsCount() {
		return postCommentsCount;
	}
	public void setPostCommentsCount(int postCommentsCount) {
		this.postCommentsCount = postCommentsCount;
	}
	public char getPostBlind() {
		return postBlind;
	}
	public void setPostBlind(char postBlind) {
		this.postBlind = postBlind;
	}
	public String getClientNick() {
		return clientNick;
	}
	public void setClientNick(String clientNick) {
		this.clientNick = clientNick;
	}
	public int getGroupNo() {
		return groupNo;
	}
	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}
}
