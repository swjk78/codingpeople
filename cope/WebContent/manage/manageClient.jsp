<%@page import="cope.beans.utils.ListParameter"%>
<%@page import="cope.beans.client.ClientDto"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.client.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	
	ClientDao clientDao = new ClientDao();
	List<ClientDto> clientList;
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

				document.querySelector('input[name=pageSize]').value = <%=pageSize%>;
				document.querySelector('input[name=orderType]').value = orderType;
				document.querySelector('input[name=orderDirection]').value = orderDirection;
				document.querySelector('.search-form').submit();
			});
		}
	});
</script>

<%-- <jsp:include page="/template/aside.jsp"></jsp:include> --%>
<link rel = "stylesheet" type = "text/css" href = "<%=root%>/css/manage.css">
<div class="main manage-client">
	<div class="container-1000 border">
	<a href="manageCenter.jsp" class="backToCenter"><img class="backArrow" src="<%=root %>/image/backArrow.png">관리센터로 돌아가기</a>
		<div class="row">
			<h2 class="text-center text-black"><a href="manageClient.jsp" class="">회원관리</a></h2>
		</div>
		<!-- 정렬 링크 -->
		<div class="row">
			<a class="order" id="client_no">
			가입순<img class="UDarrow" src="<%=root %>/image/UDarrow.png">
			</a>
			<a class="order" id="client_id">
			아이디순<img class="UDarrow" src="<%=root %>/image/UDarrow.png">
			</a>
			<a class="order" id="client_nick">
			닉네임순<img class="UDarrow" src="<%=root %>/image/UDarrow.png">
			</a>
		</div>
		
		<!-- 페이지 크기 조절 -->
		<div class="row">
			<select class="select-page-size" name="pageSize">
				<option value="10">10명씩 보기</option>
				<option value="20">20명씩 보기</option>
				<option value="30">30명씩 보기</option>
			</select>
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
					<% for (ClientDto clientDto : clientList) {%>
					<tr>
						<td><%=clientDto.getClientNo()%></td>
						<td><%=clientDto.getClientId()%></td>
						<td><a href="<%=root%>/client.jsp?clientNo=<%=clientDto.getClientNo()%>"><%=clientDto.getClientNick()%></a></td>
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
								<form action="lockClient.kh" method="POST" class="lock-client-form vertical-center">
									<input type="hidden" name="clientNo" value="<%=clientDto.getClientNo()%>">
									<%if (clientDto.getClientUnlockDate() == null) {%>
									<select class="select-form vertical-5px" name="lockHour">
										<option value="0">10초(시연용)</option>
										<option value="<%=1%>">1시간</option>
										<option value="<%=24%>">1일</option>
										<option value="<%=24 * 3%>">3일</option>
										<option value="<%=24 * 7%>">7일</option>
										<option value="<%=24 * 30%>">30일</option>
										<option value="<%=24 * 365%>">1년</option>
										<option value="<%=24 * 365 * 1000%>">1000년</option>
									</select>
									<input class="form-btn form-btn-lock vertical-5px" type="submit" value="활동정지">
									<%} else {%>
									<input type="hidden" name="lockHour" value="-1">
									<input class="form-btn form-btn-unlock vertical-5px "  type="submit" value="정지해제">
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
					<input type="hidden" name="pageSize">
					<input type="hidden" name="orderType">
					<input type="hidden" name="orderDirection">
					<select class="form-input-inline select-form" name="searchType">
						<option value="client_id">아이디</option>
						<option value="client_nick">닉네임</option>
					</select>
					<input type="text" name="searchKeyword" class="input-text form-input form-input-inline"
					placeholder="검색어" class="form-input form-input-inline">
					<input type="submit" value="검색" class="form-btn form-btn-inline form-btn-normal">
				</form>
			</div>
		</div>
	</div>
</div>
<div class="main">
<jsp:include page="/template/sessionView.jsp"></jsp:include>
</div>