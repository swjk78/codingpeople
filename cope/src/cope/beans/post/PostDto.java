package cope.beans.post;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class PostDto {
	private int postNo, postClientNo, postBoardNo;
	private String postTitle, postContents;
	private Date postDate;
	private int postLikeCount, postViewCount, postCommentsCount;
	private char postBlind;

	public PostDto() {
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
	public String getPostDateString() {
		SimpleDateFormat simpleDateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");				
		return simpleDateformat.format(postDate);
	}
	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}
	public int getPostLikeCount() {
		return postLikeCount;
	}
	public void setPostLikeCount(int postLikeCount) {
		if (postLikeCount >= 0) {
			this.postLikeCount = postLikeCount;
		} else {
			this.postLikeCount = 0;
		}
	}
	public int getPostViewCount() {
		return postViewCount;
	}
	public void setPostViewCount(int postViewCount) {
		if (postViewCount >= 0) {
			this.postViewCount = postViewCount;
		} else {
			this.postViewCount = 0;
		}
	}
	public int getPostCommentsCount() {
		return postCommentsCount;
	}
	public void setPostCommentsCount(int postCommentsCount) {
		if (postCommentsCount >= 0) {
			this.postCommentsCount = postCommentsCount;
		} else {
			this.postCommentsCount = 0;
		}
	}
	public char getPostBlind() {
		return postBlind;
	}
	public void setPostBlind(char postBlind) {
		if (postBlind == 'T' || postBlind == 'F') {
			this.postBlind = postBlind;
		} else {
			this.postBlind = 'F';
		}
	}
}
