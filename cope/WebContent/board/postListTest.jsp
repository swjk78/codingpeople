<%@page import="cope.beans.utils.ListParameter"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@page import="cope.beans.post.PostDto"%>
<%@page import="cope.beans.utils.DateUtils"%>
<%@page import="cope.beans.post.PostListDto"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.post.PostListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String root = request.getContextPath();

	// 글 목록 불러오기
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
	String orderType = request.getParameter("orderType");
	String orderDirection = request.getParameter("orderDirection");
	boolean isOrder = orderType != null && orderDirection != null; 
	boolean isSearch = searchType != null && searchKeyword != null && !searchKeyword.trim().equals("");
	
	// 정렬 기능을 사용하지 않을 시의 기본값
	if (!isOrder) {
		orderType = "post_no";
		orderDirection = "desc";
	}

	// 게시판 번호, 이름
	BoardDao boardDao = new BoardDao();
	int boardGroup = Integer.parseInt(request.getParameter("boardGroup"));
	request.getSession().setAttribute("boardGroup", boardGroup);
	String boardGroupName = boardDao.findBoardName(boardGroup);
	
	// 페이지 번호
	int pageNo;
	try {
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
		if (pageNo < 1) {
			throw new Exception();
		}
	}
	catch(Exception e) {
		pageNo = 1;
	}
	
	// 한 페이지에 보일 글의 개수
	int pageSize;
	try {
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
		if (pageSize < 10) {
			throw new Exception(); // 10보다 작을 시 강제 예외처리
		}
	}
	catch (Exception e) {
		pageSize = 10; //적어로 n개의 글을 보여주도록 오류시 예외처리
	}
	
	// 전달받은 파라미터들로 회원목록 불러오기
	int startRow = pageNo * pageSize - (pageSize - 1);
	int endRow = pageNo * pageSize;
	
	PostListDao postListDao = new PostListDao();
	List<PostListDto> postList;
	ListParameter listParameter = new ListParameter();
	
	listParameter.setStartRow(startRow);
	listParameter.setEndRow(endRow);
	listParameter.setOrderType(orderType);
	listParameter.setOrderDirection(orderDirection);
	
	if (isSearch) {
		listParameter.setSearchType(searchType);
		listParameter.setSearchKeyword(searchKeyword);
		postList = postListDao.search(listParameter, boardGroup);
	}
	else{
		postList = postListDao.list(listParameter, boardGroup);
	}
	
	// 페이지 네비게이션 영역 계산
	int postCount;
	if(isSearch){
		postCount = postListDao.getPostCount(listParameter);
	}
	else{
		postCount = postListDao.getPostCount();
	}
	
	int lastBlock = (postCount - 1) / pageSize + 1; 
	
	int blockSize = 10;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	if (endBlock > lastBlock) endBlock = lastBlock;

	// 오늘 날짜 구하기
	DateUtils dateUtils = new DateUtils();
	
// 	PostListDto postListDto = new PostListDto();
// 	postListDto.setPostNo(Integer.parseInt(request.getParameter("postNo")));
// 	postListDto.setBlind(request.getParameter("postBlind"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/common.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<% if (isSearch) {%>
<script>
	window.addEventListener("load", function(){
		var selectSearchType = document.querySelector("select[name=searchType]");
		selectSearchType.value = "<%=searchType%>"; <%--검색후 타입값고정 --%>
 		
		var inputSearchKeyword = document.querySelector(".searchKeywordMain");
		inputSearchKeyword.value = "<%=searchKeyword%>"; <%--검색후 키워드값고정 --%>
		
		var inputSize = document.querySelector("input[name=pageSize]");		
		inputSize.value = "<%=pageSize%>";	<%--검색후 페이지사이즈값고정 --%>
	});	
</script>
<%} %>

<script>
	window.addEventListener("load", function(){
		var formSize = document.querySelector(".form-size");
		formSize.addEventListener("change", function(){
			this.submit();
		});
		var selectPageSize = document.querySelector("select[name=pageSize]");
		selectPageSize.value = "<%=pageSize%>"

		var pagination = document.querySelectorAll(".pagination>a");
		for(var i=0; i<pagination.length; i++){
			pagination[i].addEventListener("click", function(){
				var pageNo = this.textContent;
				var moveBtn = document.querySelectorAll(".pagination>a:not(.move-link)");
				if (pageNo === '<') {
					pageNo = parseInt(pageMoveBtn[0].textContent) - 1;
				}
				else if (pageNo === '<<') {
					pageNo = 1;
				}
				else if (pageNo === '>') {
					pageNo = parseInt(pageMoveBtn[pageMoveBtn.length-1].textContent) + 1;
				}
				else if (pageNo === '>>') {
					pageNo = <%=lastBlock%>;
				}				
				document.querySelector("input[name=pageNo]").value = pageNo;
				document.querySelector(".form").submit();
			});			
		}
	});
</script>

<title>Insert title here</title>
</head>
<body>
	<h1><a href="<%=root%>/board/postListTest.jsp?boardGroup=<%=boardGroup%>">
	<%=boardGroupName%></a></h1>
	<form action="postListTest.jsp" method="post" class="form-size">
		<select name="pageSize">
			<option value="10">10개씩</option>
			<option value="20">20개씩</option>
			<option value="30">30개씩</option>
		</select>
		<%if (isSearch) {%>
			<input type="hidden" name="searchType" value ="<%=searchType%>">
			<input type="hidden" name="searchKeyword" value ="<%=searchKeyword%>">
		<%} %>
	</form>
	<table class="table table-border" >
		<thead>
			<tr>
				<th>글번호</th>
				<th width="50%">제목</th>							
				<th>글쓴이</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>좋아요</th>
			</tr>
		</thead>
		<tbody>
		<%for (PostListDto postListDto : postList) {%>
			<tr>
				<td><%=postListDto.getPostNo() %></td>				
				<td>
				<% if(postListDto.getPostBlind() == 'F') {%>
					<a href="post.jsp?boardGroup=<%=boardGroup%>
					&postNo=<%=postListDto.getPostNo()%>">
					<%=postListDto.getPostTitle()%></a>
					<%if (postListDto.getPostCommentsCount()>0) {%>						
					[<%=postListDto.getPostCommentsCount()%>]
					<%}%>
				<%} else {%>
					블라인드된 게시글입니다.				
				<%} %>
				</td>
				<td>
					<a href="<%=request.getContextPath()%>/client/profile.jsp?clientNo=
					<%=postListDto.getPostClientNo()%>"><%=postListDto.getClientNick() %>
					</a>
				</td>
				
				<% boolean isToday = dateUtils.isToday(postListDto.getPostDate()) == true; %>
				<%if (isToday) {%>
					<td><%=postListDto.getPostDate()%></td>
				<%} else {%>
					<td><%=postListDto.getPostDateToday()%></td>
				<%} %>
				<td><%=postListDto.getPostViewCount() %></td>
				<td><%=postListDto.getPostLikeCount() %></td>
			</tr>
			<%} %>
		</tbody>
	</table>
	
	<div class="pagination">
		<% if (startBlock > 1) {%>
		<a class="move-link">&lt;&lt;</a>
		<a class="move-link">&lt;</a>
		<%} %>
		<% for (int i = startBlock; i <= endBlock; i++) {%>
			<% if (i == pageNo) {%>
				<a class="on"><%=i%></a>
			<% } else {%>
				<a><%=i%></a>
			<%} %>
		<%} %>
		<% if (endBlock < lastBlock) {%>
		<a class="move-link">&gt;</a>
		<a class="move-link">&gt;&gt;</a>
		<%} %>
	</div>
	
	<a href="postListTest.jsp?boardGroup=<%=boardGroup%>">목록</a>
	<a href="postForm.jsp?boardGroup=<%=boardGroup%>&write">글쓰기</a>
	
	<form class="form" action="postListTest.jsp" method="get">
		<input type="hidden" name="boardGorup" value="<%=boardGroup%>">
		<input type="hidden" name="pageNo">
		<input type="hidden" name="pageSize" value="<%=pageSize%>" >
		<select name="searchType">
			<option value="post_title">제목</option>
			<option value="post_contents">내용</option>
			<option value="client_nick">글쓴이</option>
		</select>
		<input type="text" name="searchKeyword" placeholder="검색어를 입력하세요" class="searchKeywordMain">	
		<input type="submit" value="검색">
	</form>
</body>
</html>