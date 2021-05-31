<%@page import="cope.beans.utils.ListParameter"%>
<%@page import="cope.beans.client.ClientDtoTest"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.client.ClientDaoTest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String root = request.getContextPath();
	
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
	String orderType = request.getParameter("orderType");
	String orderDirection = request.getParameter("orderDirection");
	boolean isOrder = orderType != null && orderDirection != null; 
	boolean isSearch = searchType != null && searchKeyword != null && !searchKeyword.trim().equals("");
	
	// 정렬 기능을 사용하지 않을 시의 기본값
	if (!isOrder) {
		orderType = "client_no";
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
			throw new Exception();
		}
	}
	catch (Exception e) {
		pageSize = 10;
	}
	
	// 전달받은 파라미터들로 회원목록 불러오기
	int startRow = pageNo * pageSize - (pageSize - 1);
	int endRow = pageNo * pageSize; 
	
	ClientDaoTest clientDao = new ClientDaoTest();
	List<ClientDtoTest> clientList;
	ListParameter listParameter = new ListParameter();
	
	listParameter.setStartRow(startRow);
	listParameter.setEndRow(endRow);
	listParameter.setOrderType(orderType);
	listParameter.setOrderDirection(orderDirection);
	
	if (isSearch) {
		listParameter.setSearchType(searchType);
		listParameter.setSearchKeyword(searchKeyword);
		clientList = clientDao.search(listParameter);
	}
	else {
		clientList = clientDao.list(listParameter);
	}
	
	// 페이지 네비게이션 영역 계산
	int clientCount;
	if (isSearch) {
		clientCount = clientDao.getClientCount(listParameter);
	}
	else {
		clientCount = clientDao.getClientCount();
	}
	
	int lastBlock = (clientCount - 1) / pageSize + 1; 
	
	int blockSize = 10;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	if (endBlock > lastBlock) endBlock = lastBlock;
%>

<link rel="stylesheet" type="text/css" href="<%=root%>/css/common.css">

<%if (isSearch) {%>
<script>
	window.addEventListener('load', function() {
		var selectSearchType = document.querySelector('select[name=searchType]');
		var inputSearchKeyword = document.querySelector('.searchKeywordMain');
		var inputPageSize = document.querySelector('input[name=pageSize]');
		selectSearchType.value = '<%=searchType%>';
		inputSearchKeyword.value = '<%=searchKeyword%>';
		inputPageSize.value = '<%=pageSize%>';
	});
</script>
<%} %>

<script>
	window.addEventListener('load', function() {
		// 페이지 사이즈 변경 시 form 전송
		document.querySelector('.pageSize-form').addEventListener('change', function() {
			this.submit();
		})
		
		var errorCheck = '<%=request.getParameter("error")%>';
		if (errorCheck == 'lockFail') {
			alert('관리자는 정지시킬 수 없습니다');
		}
		else if (errorCheck == 'unlockFail') {
			alert('정지해제하는데 실패했습니다');
		}
		
		// 페이지 사이즈 유지
		var selectPageSize = document.querySelector('select[name=pageSize]');
		selectPageSize.value = '<%=pageSize%>';
		
		// 페이지네이션 버튼 처리
		var pageBtn = document.querySelectorAll('.pagination > a');
		for (var i = 0; i < pageBtn.length; i++) {
			pageBtn[i].addEventListener('click', function() {
				var pageNo = this.textContent;
				var pageMoveBtn = document.querySelectorAll('.pagination > a:not(.move-link)');
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
	});
</script>

<div class="container-1000">
	<div class="row">
		<h2><a href="manageClient.jsp">회원관리</a></h2>
	</div>
	<!-- 정렬 링크 -->
	<div class="row">
	<%if (isSearch) {%>
		<%if (listParameter.getOrderDirection().equals("asc") && listParameter.getOrderType().equals("client_no")) {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_no&orderDirection=desc&searchType=<%=searchType%>&searchKeyword=<%=searchKeyword%>&pageSize=<%=pageSize%>">가입순</a>
		<%}  else {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_no&orderDirection=asc&searchType=<%=searchType%>&searchKeyword=<%=searchKeyword%>&pageSize=<%=pageSize%>">가입순</a>
		<%} %>
		<%if (listParameter.getOrderDirection().equals("asc") && listParameter.getOrderType().equals("client_id")) {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_id&orderDirection=desc&searchType=<%=searchType%>&searchKeyword=<%=searchKeyword%>&pageSize=<%=pageSize%>">아이디순</a>
		<%}  else {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_id&orderDirection=asc&searchType=<%=searchType%>&searchKeyword=<%=searchKeyword%>&pageSize=<%=pageSize%>">아이디순</a>
		<%} %>
		<%if (listParameter.getOrderDirection().equals("asc") && listParameter.getOrderType().equals("client_nick")) {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_nick&orderDirection=desc&searchType=<%=searchType%>&searchKeyword=<%=searchKeyword%>&pageSize=<%=pageSize%>">닉네임순</a>
		<%}  else {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_nick&orderDirection=asc&searchType=<%=searchType%>&searchKeyword=<%=searchKeyword%>&pageSize=<%=pageSize%>">닉네임순</a>
		<%} %>
	<%} else {%>
		<%if (listParameter.getOrderDirection().equals("asc") && listParameter.getOrderType().equals("client_no")) {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_no&orderDirection=desc">가입순</a>
		<%}  else {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_no&orderDirection=asc">가입순</a>
		<%} %>
		<%if (listParameter.getOrderDirection().equals("asc") && listParameter.getOrderType().equals("client_id")) {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_id&orderDirection=desc">아이디순</a>
		<%}  else {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_id&orderDirection=asc">아이디순</a>
		<%} %>
		<%if (listParameter.getOrderDirection().equals("asc") && listParameter.getOrderType().equals("client_nick")) {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_nick&orderDirection=desc">닉네임순</a>
		<%}  else {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_nick&orderDirection=asc">닉네임순</a>
		<%} %>
	<%} %>
	</div>
	<!-- 페이지 크기 조절 -->
	<div class="row">
		<form action="manageClient.jsp" method="get" class="pageSize-form">
			<select name="pageSize" onchange="this.form.submit()">
				<option>10</option>
				<option>20</option>
				<option>30</option>
			</select>
			<%if (searchType != null && searchKeyword != null) {%>
				<input type="hidden" name="searchType" value="<%=searchType%>">
				<input type="hidden" name="searchKeyword" value="<%=searchKeyword%>">
			<%} %>
		</form>
	</div>
	<!-- 회원 목록 -->
	<div class="row">
		<table class="table table-border table-hover text-center">
			<thead>
				<tr>
					<th>회원번호</th>
					<th>아이디</th>
					<th>닉네임</th>
					<th>이메일</th>
					<th>출생연도</th>
					<th>등급</th>
					<th>정지해제날짜</th>
					<th>활동정지</th>
				</tr>
			</thead>
			<tbody>
				<% for (ClientDtoTest clientDto : clientList) {%>
				<tr>
					<td><%=clientDto.getClientNo()%></td>
					<td><%=clientDto.getClientId()%></td>
					<td><a href=""><%=clientDto.getClientNick()%></a></td>
					<td><%=clientDto.getClientEmail()%></td>
					<td>
						<%if (clientDto.getClientBirthYear() == 0) {%>
						미입력
						<%} else {%>
							<%=clientDto.getClientBirthYear()%>
						<%} %>
					</td>
					<td><%=clientDto.getClientGradeKorean()%></td>
					<td>
					<%if (clientDto.getClientUnlockDate() == null) {%>
					미정지
					<%} else {%>
					<%=clientDto.getClientUnlockDateString()%>
					<%} %>
					</td>
					<td>
						<%if (clientDto.getClientGrade().equals("normal")) {%>
							<form action="lockClient.kh" method="POST" class="lock-client-form">
								<input type="hidden" name="clientNo" value="<%=clientDto.getClientNo()%>">
								<%if (clientDto.getClientUnlockDate() == null) {%>
								<select name="lockHour">
									<option value="0">10초(시연용)</option>
									<option value="<%=1%>">1시간</option>
									<option value="<%=24%>">1일</option>
									<option value="<%=24 * 3%>">3일</option>
									<option value="<%=24 * 7%>">7일</option>
									<option value="<%=24 * 30%>">30일</option>
									<option value="<%=24 * 365%>">1년</option>
									<option value="<%=24 * 365 * 1000%>">1000년</option>
								</select>
								<input type="submit" value="활동정지">
								<%} else {%>
								<input type="hidden" name="lockHour" value="-1">
								<input type="submit" value="정지해제">
								<%} %>
							</form>
						<%} else {%>
							<%=clientDto.getClientGradeKorean()%>
						<%} %>
					</td>
				</tr>
				<%} %>
			</tbody>
		</table>
		<div class="row">
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
		</div>
		<div class="row">
			<form action="manageClient.jsp" method="get" class="search-form">
				<input type="hidden" name="pageNo">
				<input type="hidden" name="pageSize" value="<%=pageSize%>">
				<select class="form-input form-input-inline" name="searchType">
					<option value="client_id">아이디</option>
					<option value="client_nick">닉네임</option>
				</select>
				<input type="text" name="searchKeyword" class="searchKeywordMain" placeholder="검색어" class="form-input form-input-inline">
				<input type="submit" value="검색" class="form-btn form-btn-positive form-btn-inline">
			</form>
		</div>
	</div>
</div>

<jsp:include page="/template/sessionView.jsp"></jsp:include>