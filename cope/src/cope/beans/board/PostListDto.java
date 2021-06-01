package cope.beans.board;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class PostListDto {
	
	private int postNo;
	private String postTitle;
	private int postCommentsCount;
	private String clientNick;
	private Date postDate;
	private int postViewCount;
	private int postLikeCount;
	private String postContents;
	public PostListDto() {
		super();
	}
	public int getPostNo() {
		return postNo;
	}
	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}
	public String getPostTitle() {
		return postTitle;
	}
	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}
	public int getPostCommentsCount() {
		return postCommentsCount;
	}
	public void setPostCommentsCount(int postCommentsCount) {
		this.postCommentsCount = postCommentsCount;
	}
	public String getClientNick() {
		return clientNick;
	}
	public void setClientNick(String clientNick) {
		this.clientNick = clientNick;
	}
	public Date getPostDate() {
		return postDate;
	}
	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}
	
	public String getPostDateToday() {
		SimpleDateFormat simpleDateformat = new SimpleDateFormat("HH:mm");				
		return simpleDateformat.format(postDate);
	}
	public int getPostViewCount() {
		return postViewCount;
	}
	public void setPostViewCount(int postViewCount) {
		this.postViewCount = postViewCount;
	}
	public int getPostLikeCount() {
		return postLikeCount;
	}
	public void setPostLikeCount(int postLikeCount) {
		this.postLikeCount = postLikeCount;
	}
	public String getPostContents() {
		return postContents;
	}
	public void setPostContents(String postContents) {
		this.postContents = postContents;
	}
	
	
	
}
