package cope.beans;

public class BoardDto {
	private int boardNo;
	private String boardName;
	private int boardGroup;
	private int boardSuperNo;
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public int getBoardGroup() {
		return boardGroup;
	}
	public void setBoardGroup(int boardGroup) {
		this.boardGroup = boardGroup;
	}
	public int getBoardSuperNo() {
		return boardSuperNo;
	}
	public void setBoardSuperNo(int boardSuperNo) {
		this.boardSuperNo = boardSuperNo;
	}
	public BoardDto() {
		super();
	}

	
}
	