package cope.beans.post;

import java.util.Date;

public class PostDto {
	private int postNo, postClientNo, postBoardNo;
	private String postTitle, postContents;
	private Date postDate;
	private int postLikeCount, postViewCount;
	private  int postCommentsCount;
	private String postBlind;
	
	@Override
	public String toString() {
		return "PostDto [postNo=" + postNo + ", postClientNo=" + postClientNo + ", postBoardNo=" + postBoardNo
				+ ", postTitle=" + postTitle + ", postContents=" + postContents + ", postDate=" + postDate
				+ ", postLikeCount=" + postLikeCount + ", postViewCount=" + postViewCount + ", postCommentsCount="
				+ postCommentsCount + ", postBlind=" + postBlind + ", getPostNo()=" + getPostNo()
				+ ", getPostClientNo()=" + getPostClientNo() + ", getPostBoardNo()=" + getPostBoardNo()
				+ ", getPostTitle()=" + getPostTitle() + ", getPostContents()=" + getPostContents() + ", getPostDate()="
				+ getPostDate() + ", getPostLikeCount()=" + getPostLikeCount() + ", getPostViewCount()="
				+ getPostViewCount() + ", getPostCommentsCount()=" + getPostCommentsCount() + ", getPostBlind()="
				+ getPostBlind() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
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
	public String getPostBlind() {
		return postBlind;
	}
	public void setPostBlind(String postBlind) {
		this.postBlind = postBlind;
	}
	
	
	
}
	
