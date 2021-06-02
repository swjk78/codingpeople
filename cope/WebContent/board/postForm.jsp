<%@page import="cope.beans.board.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/template/aside.jsp"></jsp:include>
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
	 String boardName = request.getParameter("boardName");
 %>

<div class = "display-inline-block text-center">
	<h2><%=boardName%></h2>
	<hr>
	<div class="display-inline-block">
		<%if (request.getParameter("write") != null) {%>
		<h3>글 작성</h3>
		<form action="postForm.kh" method="post" class="layout">
			<div>
				<input type="text" name="postTitle" placeholder="제목을 입력하세요" class="box-title">
			</div>
			<div>
				<textarea name="postContents" placeholder="내용을 입력하세요" class="box-contents"></textarea>
			</div>
			<input type="submit" value="작성완료">
		</form>
		<%} else {%>
		<h3>글 수정</h3>
		<form action="postForm.kh" method="post" class="layout">
			<div>
				<input type="text" name="postTitle" placeholder="제목을 입력하세요" class="box-title">
			</div>
			<div>
				<textarea name="postContents" placeholder="내용을 입력하세요" class="box-contents"></textarea>
			</div>
			<input type="submit" value="작성완료">
		</form>
		<%} %>
	</div>
</div>
</html>

<jsp:include page="/template/footer.jsp"></jsp:include>