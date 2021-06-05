<%@page import="cope.beans.board.BoardDto"%>
<%@page import="cope.beans.utils.DateUtils"%>
<%@page import="cope.beans.comments.CommentsDao"%>
<%@page import="cope.beans.comments.CommentsViewDto"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.post.PostDto"%>
<%@page import="cope.beans.client.ClientDto"%>
<%@page import="cope.beans.client.ClientDao"%>
<%@page import="cope.beans.post.PostDao"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/post.css">

<style>
	.imgRound {
	border: 1.5px solid #ffffff;
	border-radius: 50%;
	padding: 5px;
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title></title>
<%
	BoardDao boardDao = new BoardDao();
	int boardGroup = Integer.parseInt(request.getParameter("boardGroup"));
	String boardGroupName = boardDao.findBoardName(boardGroup);
	
	boolean isWrite = request.getParameter("write") != null;
	PostDto postDto = new PostDto();
	if (!isWrite) {
		PostDao postDao = new PostDao();
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		postDto = postDao.find(postNo);
	}
	
	List<BoardDto> subBoardList = boardDao.showListBoardSub(boardGroup);
 %>
 
 <script>
 	window.addEventListener('load', function () {
	 	if (<%=!isWrite%>) {
	 		var selectBoardNo = document.querySelector('select[name=postBoardNo]');
	 		selectBoardNo.value = '<%=postDto.getPostBoardNo()%>';
	 	}
 	});
 </script>
</head>
<body>

<div class=post-form>
	<div class="container-900 border">
		<div class="row text-left boardName-div">
			<a class = "boardSuperName" href="<%=request.getContextPath()%>/board/postListTest.jsp?boardGroup=<%=boardGroup%>">
			<%=boardGroupName%></a>
		</div>
		<div class = "post-form-title-box">
			<%if (isWrite) {%>
				<p class="post-form-title">글 작성</p>
			<%}else{ %>
				<p class="post-form-title">글 수정</p>
			<%} %>
		</div>
		
		<%if (isWrite) {//글작성%>
		<form action="postInsert.kh" method="post" class="layout">
			<input type="hidden" name="boardGroup" value="<%=boardGroup%>">
			<div class="row text-left">
				<select class="select-form vertical-5px"name="postBoardNo">
					<%for (BoardDto boardDto : subBoardList) {%>
						<option value="<%=boardDto.getBoardNo()%>"><%=boardDto.getBoardName()%></option>
					<%} %>
				</select>
			</div>
			<div class="post-title-input-div">
				<input type="text" name="postTitle" placeholder="제목을 입력하세요" class="post-title-input post-title-input-underline input-title" required>
			</div>
			<div>
				<div class="post-contents-input-div">
					<textarea name="postContents" placeholder="내용을 입력하세요" class="box-contents" required></textarea>
					<div class="row text-right">
						<input class="form-btn form-btn-normal" type="submit" value="작성완료">
					</div>
				</div>			
			</div>
		</form>

		<%}else{//글수정1 %>
		<form action="postEdit.kh" method="post" class="layout">
			<input type="hidden" name="postNo" value="<%=request.getParameter("postNo")%>">
			<input type="hidden" name="boardGroup" value="<%=boardGroup%>">
			<div class="row text-left">
				<select class="select-form vertical-5px" name="postBoardNo">
					<%for (BoardDto boardDto : subBoardList) {%>
						<option value="<%=boardDto.getBoardNo()%>"><%=boardDto.getBoardName()%></option>
					<%} %>
				</select>
			</div>
			<div class="post-title-input-div">
				<input type="text" name="postTitle" placeholder="제목을 입력하세요" class="post-title-input post-title-input-underline input-title" required>
			</div>
				<div>
					<div class="post-contents-input-div">
						<textarea name="postContents" placeholder="내용을 입력하세요" class="box-contents" required></textarea>
						<div class="row text-right">
							<input class="form-btn form-btn-normal" type="submit" value="작성완료">
						</div>
					</div>
				</div>
		</form>
		<%} %>
	</div>
</div>
</body>
</html>
