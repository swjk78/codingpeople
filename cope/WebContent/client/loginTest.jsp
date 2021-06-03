<%@page import="cope.beans.client.ClientDtoTest"%>
<%@page import="cope.beans.client.ClientDaoTest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 활동정지된 회원의 로그인 방지 테스트를 위한 페이지
	  create by JK
-->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

<script>
	window.addEventListener('load', function() {
		if (<%=request.getParameter("success") != null%>) {
			alert('이메일 전송을 성공했습니다');
			history.replaceState({}, null, location.pathname);
		}
		var unlockDate = '<%=request.getSession().getAttribute("unlockDate")%>';
		if (unlockDate != 'null') {
			alert('활동정지당한 계정입니다\n' + '정지해제 날짜: ' + unlockDate);
			// 새로고침 시 알림창 재발생을 막기 위한 세션 제거
			<%request.getSession().removeAttribute("unlockDate");%>
		}
	});
</script>

<div class="container-600">
	<div class="row">
		<h2>회원 정보 입력</h2>
	</div>
	<form action="loginTest.kh" method="post">
		<div class="row text-left">
			<label>아이디</label>
			<input type="text" name="clientId" required class="form-input form-input-underline">
		</div>
		<div class="row text-left">
			<label>비밀번호</label>
			<input type="password" name="clientPw" required class="form-input form-input-underline">
		</div>
		<div class="row">
			<input type="submit" value="로그인" class="form-btn form-btn-positive">
		</div>
		
		<!-- 오류인 상황에는 오류 메시지를 추가해준다. -->
		<% if (request.getParameter("error") != null) {%>
		<div class="row">
			<h5 class="error">정보가 일치하지 않습니다.</h5>
		</div>
		<% }%>
	</form>
</div>

<jsp:include page="/template/sessionView.jsp"></jsp:include>