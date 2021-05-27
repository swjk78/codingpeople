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
		var inputSearchKeyword = document.querySelector('input[name=searchKeyword]');
		selectSearchType.value = '<%=searchType%>';
		inputSearchKeyword.value = '<%=searchKeyword%>';
	})
</script>
<%} %>

<div class="container-1000">
	<div class="row">
		<h2><a href="manageClient.jsp">회원관리</a></h2>
	</div>
	<div class="row">
	<%if (isSearch) {%>
		<%if (listParameter.getOrderDirection().equals("asc") && listParameter.getOrderType().equals("client_no")) {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_no&orderDirection=desc&searchType=<%=searchType%>&searchKeyword=<%=searchKeyword%>">가입순</a>
		<%}  else {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_no&orderDirection=asc&searchType=<%=searchType%>&searchKeyword=<%=searchKeyword%>">가입순</a>
		<%} %>
		<%if (listParameter.getOrderDirection().equals("asc") && listParameter.getOrderType().equals("client_id")) {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_id&orderDirection=desc&searchType=<%=searchType%>&searchKeyword=<%=searchKeyword%>">아이디순</a>
		<%}  else {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_id&orderDirection=asc&searchType=<%=searchType%>&searchKeyword=<%=searchKeyword%>">아이디순</a>
		<%} %>
		<%if (listParameter.getOrderDirection().equals("asc") && listParameter.getOrderType().equals("client_nick")) {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_nick&orderDirection=desc&searchType=<%=searchType%>&searchKeyword=<%=searchKeyword%>">닉네임순</a>
		<%}  else {%>
			<a href="<%=root%>/manage/manageClient.jsp?orderType=client_nick&orderDirection=asc&searchType=<%=searchType%>&searchKeyword=<%=searchKeyword%>">닉네임순</a>
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
					<td><%=clientDto.getClientBirthYear()%></td>
					<td><%=clientDto.getClientGradeKorean()%></td>
					<td>
					<%if (clientDto.getClientUnlockDate()==null) {%>
					미정지
					<%} else {%>
					<%=clientDto.getClientUnlockDate()%>
					<%} %>
					</td>
					<form action="lock.kh" method="post">
						<td>
							<select name="lockTime">
								<option>1시간</option>
								<option>1일</option>
								<option>3일</option>
								<option>7일</option>
								<option>30일</option>
								<option>1년</option>
								<option>1000년</option>
							</select>
							<input type="submit" value="활동정지">
						</td>
					</form>
				</tr>
				<% }%>
			</tbody>
		</table>
		<div class="row">
			<div class="pagination">
				<% if (startBlock > 1) {%>
				<a class="move-link">이전</a>
				<% }%>
				<% for (int i = startBlock; i <= endBlock; i++) {%>
					<% if (i == pageNo) {%>
						<a class="on"><%=i%></a>
					<% } else {%>
						<a><%=i%></a>
					<% }%>
				<% }%>
				<% if (endBlock < lastBlock) {%>
				<a class="move-link">다음</a>
				<% }%>
			</div>
		</div>
		<div class="row">
			<form action="manageClient.jsp" method="get" class="search-form">
				<input type="hidden" name="pageNo">
				<select class="form-input form-input-inline" name="searchType">
					<option value="client_id">아이디</option>
					<option value="client_nick">닉네임</option>
				</select>
				<input type="text" name="searchKeyword" placeholder="검색어" class="form-input form-input-inline" />
				<input type="submit" value="검색" class="form-btn form-btn-positive form-btn-inline" />
			</form>
		</div>
	</div>
</div>

<jsp:include page="/template/sessionView.jsp"></jsp:include>