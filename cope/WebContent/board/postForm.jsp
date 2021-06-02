<%@page import="cope.beans.post.PostDto"%>
<%@page import="cope.beans.post.PostDao"%>
<%@page import="cope.beans.board.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%-- <jsp:include page="/template/aside.jsp"></jsp:include> --%>
<html>
<link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/join.css">
<head>
<meta charset="UTF-8">
	<title>게시판 작성/수정</title>
	<style>
		.display-inline-block {
			border : solid black;
			display:inline-block;
			margin-left: auto;
			margin-right: auto;		   
			width : auto%;
		}
		.layout {
			padding : 100px;
			width:auto;
			hegith:auto;	
		}
		.box-contents {
			width : 1000px;
			height : 500px;
		}
		.box-title {
			width : 1000px;
			height : 25px;
		}
		.boardSubList, .fail {
			display: none;
		}
	</style>
</head>
		
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

<div class = "display-inline-block text-center">
	<h2><a href="<%=request.getContextPath()%>/board/postListTest.jsp?boardGroup=<%=boardGroup%>">
	<%=boardGroupName%></a></h2>
	<hr>
	<div class="display-inline-block">
		<%if (isWrite) {%>
		<h3>글 작성</h3>
		<form action="postInsert.kh" method="post" class="layout">
			<input type="hidden" name="boardGroup" value="<%=boardGroup%>">
			<div class="row text-left">
				<select name="postBoardNo">
					<%for (BoardDto boardDto : subBoardList) {%>
						<option value="<%=boardDto.getBoardNo()%>"><%=boardDto.getBoardName()%></option>
					<%} %>
				</select>
			</div>
			<div class="row text-left">
				<input type="text" name="postTitle" placeholder="제목을 입력하세요" class="box-title" required>
			</div>
			<div class="row text-left">
				<textarea name="postContents" placeholder="내용을 입력하세요" class="box-contents" required>
				</textarea>
			</div>
			<div class="row">
				<input type="submit" value="작성완료">
			</div>
		</form>
		<%} else {%>
		<h3>글 수정</h3>
		<form action="postEdit.kh" method="post" class="layout">
			<input type="hidden" name="postNo" value="<%=request.getParameter("postNo")%>">
			<input type="hidden" name="boardGroup" value="<%=boardGroup%>">
			<div class="row text-left">
				<select name="postBoardNo">
					<%for (BoardDto boardDto : subBoardList) {%>
						<option value="<%=boardDto.getBoardNo()%>"><%=boardDto.getBoardName()%></option>
					<%} %>
				</select>
			</div>
			<div>
				<input type="text" name="postTitle" placeholder="제목을 입력하세요"
				class="box-title" value="<%=postDto.getPostTitle()%>">
			</div>
			<div>
				<textarea name="postContents" placeholder="내용을 입력하세요"
				class="box-contents"><%=postDto.getPostContents()%></textarea>
			</div>
			<input type="submit" value="작성완료">
		</form>
		<%} %>
	</div>
</div>
</html>

<jsp:include page="/template/footer.jsp"></jsp:include>