<%@page import="cope.beans.client.ClientDao"%>
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
	
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));
	int boardGroup = 0;
	if (request.getParameter("boardGroup") != null) {
		boardGroup = Integer.parseInt(request.getParameter("boardGroup"));
	}
	int boardNo = 0;
	if (request.getParameter("boardNo") != null) {
		boardNo = Integer.parseInt(request.getParameter("boardNo"));
	}

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
	List<PostListDto> clientPostList;
	ListParameter listParameter = new ListParameter();
	
	listParameter.setStartRow(startRow);
	listParameter.setEndRow(endRow);
	listParameter.setOrderType(orderType);
	listParameter.setOrderDirection(orderDirection);
	
	int postCount;
	// 회원이 작성한 글 목록 및 게시글 개수 계산
	if (request.getParameter("boardGroup") == null) {
		if (isSearch) {
			listParameter.setSearchType(searchType);
			listParameter.setSearchKeyword(searchKeyword);
			clientPostList = postListDao.clientPostListSearch(listParameter, clientNo);
			postCount = postListDao.getClientPostCount(listParameter, clientNo);
		}
		else{
			clientPostList = postListDao.clientPostList(listParameter, clientNo);
			postCount = postListDao.getClientPostCount(clientNo);
		}
	}
	
	// 상위 게시판 선택 시 회원이 작성한 글 목록
	else if (request.getParameter("boardNo") == null) {
		if (isSearch) {
			listParameter.setSearchType(searchType);
			listParameter.setSearchKeyword(searchKeyword);
			clientPostList = postListDao.clientPostListSearch(listParameter, clientNo, boardGroup);
			postCount = postListDao.getClientPostCount(listParameter, clientNo, boardGroup);
		}
		else{
			clientPostList = postListDao.clientPostList(listParameter, clientNo, boardGroup);
			postCount = postListDao.getClientPostCount(clientNo, boardGroup);
		}
	}
	
	// 상위 게시판의 하위 게시판 선택 시 회원이 작성한 글 목록
	else {
		if (isSearch) {
			listParameter.setSearchType(searchType);
			listParameter.setSearchKeyword(searchKeyword);
			clientPostList = postListDao.clientPostListSearch(listParameter, clientNo, boardGroup, boardNo);
			postCount = postListDao.getClientPostCount(listParameter, clientNo, boardGroup, boardNo);
		}
		else{
			clientPostList = postListDao.clientPostList(listParameter, clientNo, boardGroup, boardNo);
			postCount = postListDao.getClientPostCount(clientNo, boardGroup, boardNo);
		}
	}
	
	// 페이지 네비게이션 영역 계산
	int lastBlock = (postCount - 1) / pageSize + 1; 
	
	int blockSize = 10;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	if (endBlock > lastBlock) endBlock = lastBlock;

	// 오늘 날짜 구하기
	DateUtils dateUtils = new DateUtils();
	
	// 상위 게시판 링크 나열용 리스트
	BoardDao boardDao = new BoardDao();
	List<BoardDto> superBoardList = boardDao.showListBoardSuper();
	
	ClientDao clientDao = new ClientDao();
%>

<!DOCTYPE html>
<jsp:include page="/template/aside.jsp"></jsp:include>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/client.css">

<!-- 임시 스타일링 -->

<style>

	h1{
		text-align:center;
		margin-top:5%;
		margin-bottom:5%;
	}
	h1>a{
		font-size:28px;
	}
	
	a {		color:rgb(78, 78, 78);
		text-decoration: none;
		
	}
	.top-menu{
		
		margin-bottom:1%;
	}
	
	.table{
	width:100%;
		border-top:1px solid rgb(78, 78, 78);
/* 		font-size:13px; */
		font-color:black;
	}
	.select-page-size{
		padding:5px 5px 5px 12px;
		border:thin;
		
	}
	.order{
		background-color:#9A9EC2;
		color:white;
		padding:5px 5px 5px 5px;
	}
	
	.th-line{
		border-bottom:1px solid rgb(242, 242, 242);
		color:rgb(78, 78, 78);
		font-color:black;
		text-align:left;		
		
	}
	.td-line{
		border-bottom:1px solid rgb(242, 242, 242);
	}
	.pagination, .search-form{
		text-align:center;
		font-size:13px;
		margin-top:3%;
	}
	
	.select-search, .select-input {
		padding:5px 36px 5px 12px;
 		border:none; 
		border-bottom:1px solid rgb(78, 78, 78);
		font-size:12px;
	}
	.select-btn{
		border:none;
		background-color:#9A9EC2;
		padding:5px 15px 5px 12px;
		color:white;
		border:thin;
		text-align:center;
	}
	.blind{
		text-decoration:line-through;
		font-style:italic;
	}
	
	    float 스타일(다단 레이아웃)
*/
.float-container-postlist::after {
	content: '';
	display: block;
	clear: both;
}
.float-container-postlist > .left {
	float: left;
}
.float-container-postlist > .right {
	float: right;
}

.position-pag{
margin-top : 400px;
padding-top = 300px;
bottom:0px;
}
.test-border{
border:10px solid;
}
.border-thin{
border: thin;
top:0;
}

.container-800-postlist{
	width:800px;
	margin-left:auto;
	margin-right:auto;
}

</style>

<%if (isSearch) {%>
<script>
	window.addEventListener('load', function() {
		var selectSearchType = document.querySelector('select[name=searchType]');
		var inputSearchKeyword = document.querySelector('input[name=searchKeyword]');
		selectSearchType.value = '<%=searchType%>';
		inputSearchKeyword.value = '<%=searchKeyword%>';
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
<body class = left>
	<div class="container-800-postlist">
		<h1><a href="clientPostList.jsp?clientNo=<%=clientNo%>">
		<%=clientDao.findClientNick(clientNo)%>의 작성한 글 목록</a></h1>
		
		<!-- 상위 게시판 선택 링크 -->
					<select class = "border-thin top-menu">
							<%for (BoardDto boardDto : superBoardList) {%>
		    				clientPostList.jsp?clientNo=<%=clientNo%>&boardGroup=<%=boardDto.getBoardNo()%>
							&pageSize=<%=pageSize%>
					<option><%=boardDto.getBoardName()%></option>	
								<%} %>
		</select>
		
		<!-- 정렬 링크 -->
		<div class="float-container-postlist top-menu">
			<div class="float-left">
				<a class="order" id="post_date">
				작성순
	<%-- 			<img class="UDarrow" src="<%=root %>/image/UDarrow.png"> --%>
				</a>
				<a class="order" id="post_view_count">
				조회순
	<%-- 			<img class="UDarrow" src="<%=root %>/image/UDarrow.png"> --%>
				</a>
				<a class="order" id="post_like_count">
				추천순
	<%-- 			<img class="UDarrow" src="<%=root %>/image/UDarrow.png"> --%>
				</a>
			</div>
			
			<!-- 페이지 크기 선택 -->
			<div class="float-right">
				<select class="select-page-size" name="pageSize">
					<option value="10">10개씩</option>
					<option value="20">20개씩</option>
					<option value="30">30개씩</option>
				</select>
			</div>
		</div>
		<!-- 게시글 목록 -->
		<table class="table" >
			<thead>
				<tr>
					<th class="th-line">글번호</th>
					<th class="th-line" width="50%">제목</th>
					<th class="th-line">글쓴이</th>				
					<th class="th-line">작성일</th>
					<th class="th-line">조회수</th>
					<th class="th-line">좋아요</th>
				</tr>
			</thead>
			<tbody>
			<%for (PostListDto postListDto : clientPostList) {%>
				<tr>
					<td class="td-line"><%=postListDto.getPostNo() %></td>				
					<td class="td-line">
					<a href="clientPostList.jsp?clientNo=<%=clientNo%>&boardGroup=<%=postListDto.getBoardGroup()%>">
					[<%=boardDao.findBoardName(postListDto.getBoardGroup())%>]</a>
					<% if(postListDto.getPostBlind() == 'F') {%>
						<a href="clientPostList.jsp?clientNo=<%=clientNo%>&boardGroup=<%=postListDto.getBoardGroup()%>
						&boardNo=<%=postListDto.getPostBoardNo()%>">
						[<%=postListDto.getBoardName()%>]</a>
						<a href="<%=root%>/board/post.jsp?boardGroup=<%=postListDto.getBoardGroup()%>
						&postNo=<%=postListDto.getPostNo()%>">
						<%=postListDto.getPostTitle()%></a>
						<%if (postListDto.getPostCommentsCount()>0) {%>						
						[<%=postListDto.getPostCommentsCount()%>]
						<%}%>
					<%} else {%>
						<span class="blind"> 블라인드된 게시글입니다. </span>				
					<%} %>
					</td>
					<td class="td-line">
						<a href="<%=request.getContextPath()%>/client/profile.jsp?clientNo=
						<%=postListDto.getPostClientNo()%>"><%=postListDto.getClientNick() %>
						</a>
					</td>
					<% boolean isToday = dateUtils.isToday(postListDto.getPostDate()) == true; %>
					<%if (isToday) {%>
						<td class="td-line"><%=postListDto.getPostDate()%></td>
					<%} else {%>
						<td class="td-line"><%=postListDto.getPostDateToday()%></td>
					<%} %>
					<td class="td-line"><%=postListDto.getPostViewCount() %></td>
					<td class="td-line"><%=postListDto.getPostLikeCount() %></td>
				</tr>
				<%} %>
			</tbody>
		</table>
		
		<div class= "position-pag">
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
	
		<form action="clientPostList.jsp" method="get" class="search-form">
			<input type="hidden" name="clientNo" value="<%=clientNo%>">
			<input type="hidden" name="pageNo">
			<input type="hidden" name="pageSize" value="<%=pageSize%>">
			<input type="hidden" name="orderType">
			<input type="hidden" name="orderDirection">
			<%if (request.getParameter("boardGroup") != null) {%>
			<input type="hidden" name="boardGroup" value="<%=request.getParameter("boardGroup")%>">
			<%} %>
			<%if (request.getParameter("boardNo") != null) {%>
			<input type="hidden" name="boardNo" value="<%=request.getParameter("boardNo")%>">
			<%} %>
			<select name="searchType" class="select-search">
				<option value="post_title">제목</option>
				<option value="post_contents">내용</option>
			</select>
			<input type="text" name="searchKeyword" placeholder="검색어" class="select-input">	
			<input type="submit" value="검색" class="select-btn">
		</form>
	</div>
	</div>
</body>
</html>
		<jsp:include page="/template/footer.jsp"></jsp:include>	