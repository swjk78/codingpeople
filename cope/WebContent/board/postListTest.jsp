<%@page import="cope.beans.board.BoardDto"%>
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

	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
	String orderType = request.getParameter("orderType");
	String orderDirection = request.getParameter("orderDirection");
	boolean isOrder = orderType != null && orderDirection != null &&
			!orderType.trim().equals("") && !orderDirection.trim().equals("");
	boolean isSearch = searchType != null && searchKeyword != null && !searchKeyword.trim().equals("");
	
	// 정렬 기능을 사용하지 않을 시의 기본값
	if (!isOrder) {
		orderType = "post_date";
		orderDirection = "desc";
	}

	// 게시판 번호, 이름
	BoardDao boardDao = new BoardDao();
	int boardGroup = Integer.parseInt(request.getParameter("boardGroup"));
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
	
	// 게시판 전체 글 목록
	if (request.getParameter("boardNo") == null) {
		if (isSearch) {
			listParameter.setSearchType(searchType);
			listParameter.setSearchKeyword(searchKeyword);
			postList = postListDao.search(listParameter, boardGroup);
		}
		else{
			postList = postListDao.list(listParameter, boardGroup);
		}
	}
	
	// 하위 게시판 선택 시 목록
	else {
		if (isSearch) {
			listParameter.setSearchType(searchType);
			listParameter.setSearchKeyword(searchKeyword);
			postList = postListDao.search(listParameter, boardGroup, Integer.parseInt(request.getParameter("boardNo")));
		}
		else{
			postList = postListDao.list(listParameter, boardGroup, Integer.parseInt(request.getParameter("boardNo")));
		}
	}
	
	// 페이지 네비게이션 영역 계산
	int postCount;
	if (isSearch) {
		postCount = postListDao.getPostCount(listParameter);
	}
	else {
		postCount = postListDao.getPostCount();
	}
	
	int lastBlock = (postCount - 1) / pageSize + 1; 
	
	int blockSize = 10;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	if (endBlock > lastBlock) endBlock = lastBlock;

	// 오늘 날짜 구하기
	DateUtils dateUtils = new DateUtils();
	
	// 하위 게시판 링크 나열용 리스트
	List<BoardDto> subBoardList = boardDao.showListBoardSub(boardGroup);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/common.css">

<!-- 임시 스타일링 -->
<style>
	a {
		text-decoration: none;
	}
	.UDarrow {
	height: 15px;
	}
</style>

<%if (isSearch) {%>
<script>
	window.addEventListener('load', function() {
		var selectSearchType = document.querySelector('select[name=searchType]');
		var inputSearchKeyword = document.querySelector('input[name=searchKeyword]');
		var inputPageSize = document.querySelector('input[name=pageSize]');		
		selectSearchType.value = '<%=searchType%>';
		inputSearchKeyword.value = '<%=searchKeyword%>';
		inputPageSize.value = '<%=pageSize%>';
	});	
</script>
<%} %>

<script>
	window.addEventListener('load', function() {
		// 페이지 사이즈 유지
		var selectPageSize = document.querySelector('select[name=pageSize]');
		selectPageSize.value = '<%=pageSize%>';

		// 페이지네이션 버튼 처리
		var pagination = document.querySelectorAll(".pagination>a");
		for(var i=0; i<pagination.length; i++){
			pagination[i].addEventListener("click", function() {
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
				document.querySelector('input[name=pageNo]').value = pageNo;
				document.querySelector('.search-form').submit();
			});			
		}
	
		// 페이지 사이즈 조절 구현	
		var selectPageSize = document.querySelector('.select-page-size');
		selectPageSize.addEventListener('change', function() {
			var pageSize = this.value;
			
			document.querySelector('input[name=pageSize]').value = pageSize;
			document.querySelector('.search-form').submit();
		})
		
		// 정렬 기능 구현
		var sortBtn = document.querySelectorAll('.order');
		for (var i = 0; i < sortBtn.length; i++) {
			sortBtn[i].addEventListener('click', function() {
				var orderType = this.id;
				var orderDirection = '<%=orderDirection%>';
				
				if (orderDirection == 'desc') {
					orderDirection = 'asc';
				}
				else {
					orderDirection = 'desc';	
				}

				document.querySelector('input[name=orderType]').value = orderType;
				document.querySelector('input[name=orderDirection]').value = orderDirection;
				document.querySelector('.search-form').submit();
			});
		}
	});
</script>

<title>Insert title here</title>
</head>
<body>
	<h1><a href="<%=root%>/board/postListTest.jsp?boardGroup=<%=boardGroup%>">
	<%=boardGroupName%></a></h1>
	
	<!-- 하위 게시판 선택 링크 -->
	<%for (BoardDto boardDto : subBoardList) {%>
	<a href="<%=root%>/board/postListTest.jsp?boardGroup=<%=boardGroup%>
	&boardNo=<%=boardDto.getBoardNo()%>&pageSize=<%=pageSize%>"><%=boardDto.getBoardName()%>
	</a>
	<%} %>
	
	<!-- 정렬 링크 -->
	<div class="row">
		<a class="order" id="post_date">
		작성순<img class="UDarrow" src="<%=root %>/image/UDarrow.png">
		</a>
		<a class="order" id="post_view_count">
		조회순<img class="UDarrow" src="<%=root %>/image/UDarrow.png">
		</a>
		<a class="order" id="post_like_count">
		추천순<img class="UDarrow" src="<%=root %>/image/UDarrow.png">
		</a>
	</div>
	
	<!-- 페이지 크기 선택 -->
	<div class="row">
		<select class="select-page-size" name="pageSize">
			<option value="10">10개씩</option>
			<option value="20">20개씩</option>
			<option value="30">30개씩</option>
		</select>
	</div>
	
	<!-- 게시글 목록 -->
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
						<a href="<%=root%>/board/postListTest.jsp?boardGroup=<%=boardGroup%>
						&boardNo=<%=postListDto.getPostBoardNo()%>">
						[<%=postListDto.getBoardName()%>]
						</a>
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
	
	<form action="postListTest.jsp" method="get" class="search-form">
		<input type="hidden" name="pageNo">
		<input type="hidden" name="pageSize">
		<input type="hidden" name="orderType">
		<input type="hidden" name="orderDirection">
		<input type="hidden" name="boardGroup" value="<%=boardGroup%>">
		<%if (request.getParameter("boardNo") != null) {%>
		<input type="hidden" name="boardNo" value="<%=request.getParameter("boardNo")%>">
		<%} %>
		<select name="searchType">
			<option value="post_title">제목</option>
			<option value="post_contents">내용</option>
			<option value="client_nick">글쓴이</option>
		</select>
		<input type="text" name="searchKeyword" placeholder="검색어">	
		<input type="submit" value="검색">
	</form>
</body>
</html>