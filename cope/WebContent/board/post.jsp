<%@page import="cope.beans.post.PostDto"%>
<%@page import="cope.beans.client.ClientDto"%>
<%@page import="cope.beans.client.ClientDao"%>
<%@page import="cope.beans.post.PostDao"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%
	// +기호를 파라미터로 인식할 수 있게 처리
// 	String boardGroupName;
// 	int valueLen = 15;
// 	if (request.getQueryString().substring(valueLen).contains("+")) {
// 		boardGroupName = request.getQueryString().substring(valueLen);
// 		int separator = boardGroupName.indexOf("&");
// 		boardGroupName = boardGroupName.substring(0, separator);
// 	}
// 	else {
// 		boardGroupName = request.getParameter("boardGroupName");
// 	}

	BoardDao boardDao = new BoardDao();
	int boardGroup = Integer.parseInt(request.getParameter("boardGroup"));
	request.getSession().setAttribute("boardGroup", boardGroup);
	String boardGroupName = boardDao.findBoardName(boardGroup);
	
	int postNo = Integer.parseInt(request.getParameter("postNo"));
	PostDao postDao = new PostDao();
	postDao.increaseViewCount(postNo);
	PostDto postDto = postDao.find(postNo);
	
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.myInfo(postDto.getPostClientNo());
%>

<%-- <jsp:include page="/template/aside.jsp"></jsp:include> --%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

<!-- 임시 테두리 -->
<style>
	main,
	header,
	nav,
	section,
	article,
	aside,
	footer,
	div,
	span,
	p,
	label {
	    border: 1px dotted lightgray;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title></title>

<script>
	window.addEventListener('load', function() {
		document.querySelector('.delete-btn').addEventListener('click', function(e) {
			var check = confirm('정말 삭제하시겠습니까?');
			if (!check) {
				e.preventDefault();
			}
		});
	});
</script>

</head>
<body>
<div class="container-900">
	<div class="row text-left">
		<h2><a href="<%=request.getContextPath()%>/board/postListTest.jsp?boardGroup=<%=boardGroup%>">
	<%=boardGroupName%></a></h2>
	</div>
	<div class="row text-left">
		<a href="<%=request.getContextPath()%>/board/postListTest.jsp?boardGroup=<%=boardGroup%>
				&boardNo=<%=postDto.getPostBoardNo()%>">
				<%=boardDao.findBoardName(postDto.getPostBoardNo())%>
		</a>
	</div>
	<div class="row text-left">
		<%=postDto.getPostTitle()%>
	</div>
	<div class="row float-container">
		<div class="left">
			<%=clientDto.getClientNick()%>
		</div>
		<div class="right">
			조회수 <%=postDto.getPostViewCount()%>
			좋아요 <%=postDto.getPostLikeCount()%>
		</div>		
		<div class="right">
			<%=postDto.getPostDateString()%>
		</div>
		<div class="row text-left" style="min-height:300px;">
			<pre><%=postDto.getPostContents()%></pre>
		</div>
	</div>
	
	<!-- 댓글 목록 영역 -->
<!-- 	<div class="row text-left"> -->
<!-- 		<h4>댓글 목록</h4> -->
<!-- 	</div> -->
<%-- 	<% for (CommentsListDto commentsListDto : commentsList) {%> --%>
<!-- 	<div class="row text-left" style="border: 1px solid gray;"> -->
<!-- 		<div class="float-container"> -->
<%-- 			<div class="left"><%=commentsListDto.getClientNick()%></div> --%>

				<!-- 수정과 삭제 메뉴는 본인글에만 표시되어야 한다
	 				- 본인글 : 댓글작성자번호(commentsListDto.getCommentsWriter()) == 로그인된 회원번호(clientNo)
	 			-->
<%-- 			<% if (commentsListDto.getCommentsWriter() == clientNo) {%> --%>
<!-- 			<div class="right"> -->
<!-- 				<a class="comments-edit-btn">수정</a>  -->
<!-- 				|  -->
<!-- 				<a class="comments-delete-btn" -->
<%-- 				href="commentsDelete.kh?commentsNo=<%=commentsListDto.getCommentsNo()%>&postNo=<%=postNo%>"> --%>
<!-- 				삭제</a> -->
<!-- 			</div> -->
<%-- 			<% }%> --%>
<!-- 		</div> -->
	
	 		<!-- 화면 표시 댓글 -->
<!-- 		<div class="comments-display-area"> -->
<%-- 			<pre><%=commentsListDto.getCommentsContents()%></pre> --%>
<!-- 		</div> -->

		<!-- 
			댓글 수정 영역 : 게시글번호(hidden), 댓글번호(hidden), 댓글내용(textarea)
			- 이 영역은 나의 댓글일 경우에만 출력되어야 한다.
			- 나의 댓글 판정 : 회원번호(clientNo) == 댓글작성자번호(commentsListDto.getCommentsWriter())
		--> 
<%-- 		<% if (clientNo == commentsListDto.getCommentsWriter()) {%> --%>
<!-- 		<div class="comments-edit-area"> -->
<!-- 			<form action="commentsEdit.kh" method="post"> -->
<%-- 				<input type="hidden" name="commentsNo" value="<%=commentsListDto.getCommentsNo()%>"> --%>
<%-- 				<input type="hidden" name="postNo" value="<%=commentsListDto.getPostNo()%>"> --%>
				
<%-- 				<textarea name="commentsContents" class="form-input" required><%=commentsListDto.getCommentsContents()%></textarea> --%>
<!-- 				<input type="submit" value="댓글 수정">		 -->
<!-- 				<input type="button" value="작성 취소" class="comments-edit-cancel-btn">		 -->
<!-- 			</form> -->
<!-- 		</div> -->
<%-- 		<% }%> --%>
<%-- 		<div><%=commentsListDto.getCommentsTime().toLocaleString()%></div> --%>
<!-- 	</div> -->
<%-- 	<% }%> --%>
	
	<!-- 댓글 작성 영역 -->
<!-- 	<form action="commentsInsert.kh" method="post"> -->
<%-- 		<input type="hidden" name="postNo" value="<%=postNo%>"> --%>
<!-- 		<div class="row"> -->
<!-- 			<textarea name="commentsContents" class="form-input" required></textarea> -->
<!-- 		</div> -->
<!-- 		<div class="row"> -->
<!-- 			<input type="submit" value="댓글 작성"> -->
<!-- 		</div> -->
<!-- 	</form> -->

	<!-- 버튼 영역 -->
	<div class="row text-right">
		<a href="postForm.jsp?boardGroup=<%=boardGroup%>&postNo=<%=postNo%>" class="link-btn">수정</a>
		<a href="postDelete.kh?boardGroup=<%=boardGroup%>&postNo=<%=postNo%>" class="link-btn delete-btn">삭제</a>
		<a href="postForm.jsp?boardGroup=<%=boardGroup%>&write" class="link-btn">글쓰기</a>
		<a href="postListTest.jsp?boardGroup=<%=boardGroup%>" class="link-btn">목록</a>
	</div>
	
<!-- 	<div class="row text-left"> -->
<!-- 		다음글 :  -->
<%-- 		<% if (nextPostDto == null) {%> --%>
<!-- 		다음글이 없습니다. -->
<%-- 		<% } else {%> --%>
<%-- 		<a href="postDetail.jsp?postNo=<%=nextPostDto.getPostNo()%>"> --%>
<%-- 			<%=nextPostDto.getPostTitle()%> --%>
<!-- 		</a> -->
<%-- 		<% }%> --%>
<!-- 	</div> -->
<!-- 	<div class="row text-left"> -->
<!-- 		이전글 :  -->
<%-- 		<% if (prevPostDto == null) {%> --%>
<!-- 		이전글이 없습니다. -->
<%-- 		<% } else {%> --%>
<%-- 		<a href="postDetail.jsp?postNo=<%=prevPostDto.getPostNo()%>"> --%>
<%-- 			<%=prevPostDto.getPostTitle()%> --%>
<!-- 		</a> -->
<%-- 		<% }%> --%>
<!-- 	</div> -->
</div>
</body>
</html>
