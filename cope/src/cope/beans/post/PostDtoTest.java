package cope.beans.post;

import java.sql.Date;

// 게시글 블라인드 기능 구현을 위한 테스트 PostDto

// create or replace view post_list as
// select post.*, client_nick, client_grade from post
// left outer join client on post_client_no = client_no;
// 일반 회원의 게시글만 블라인드하기 위해 post_list view 이용

//create by JK
public class PostDtoTest {
	private int postNo, postClientNo, postBoardNo;
	private String postTitle, postContents;
	private Date postDate;
	private int postLikeCount, postViewCount, postCommentsCount;
	private char postBlind;
	private String clientNick, clientGrade;

	public PostDtoTest() {
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
	public String getClientGrade() {
		return clientGrade;
	}
	public void setClientGrade(String clientGrade) {
		this.clientGrade = clientGrade;
	}
}
