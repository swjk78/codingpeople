package cope.beans.post;

import java.sql.Date;

public class PostLikeDto {
	private int postLikeClientNo;
	private int postLikePostNo;
	private Date postLikeDate;
	
	public PostLikeDto() {
		super();
	}

	public int getPostLikeClientNo() {
		return postLikeClientNo;
	}
	public void setPostLikeClientNo(int postLikeClientNo) {
		this.postLikeClientNo = postLikeClientNo;
	}
	public int getPostLikePostNo() {
		return postLikePostNo;
	}
	public void setPostLikePostNo(int postLikePostNo) {
		this.postLikePostNo = postLikePostNo;
	}
	public Date getPostLikeDate() {
		return postLikeDate;
	}
	public void setPostLikeDate(Date postLikeDate) {
		this.postLikeDate = postLikeDate;
	}
}
