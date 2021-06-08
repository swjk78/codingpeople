<%@page import="java.util.TimerTask"%>
<%@page import="java.util.Timer"%>
<%@page import="cope.beans.auth.AuthDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String inputEmail = request.getParameter("inputEmail");
	AuthDao authDao = new AuthDao();
	int authNum = authDao.findAuthNum(inputEmail);
	
	// 5분 뒤 인증정보 제거
	Timer timer = new Timer();
	TimerTask task = new TimerTask() {
		public void run() {
			authDao.deleteAuth(inputEmail);
		};
	};
	timer.schedule(task, 300000);
%>

<link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/join.css">
<style>
	.form-btn.form-btn-normal {
		width:auto;
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath()%>/js/join.js"></script>
	
<script>
	window.addEventListener('load', function () {
		if (<%=request.getParameter("inputEmail") != null%>) {
			alert('이메일 전송을 성공했습니다.\n인증번호의 유효기간은 5분입니다.');
			history.replaceState({}, null, location.pathname);
		}
		document.querySelector('.reset-pw-form').addEventListener('submit', function () {
			var authNum = <%=authNum%>;
			var authNumInput = document.querySelector('#input-authNum');

			if (authNum != authNumInput.value) {
				alert('인증번호가 다릅니다.');
				event.preventDefault();
			} else if (document.querySelector('#clientPw').value != document.querySelector('#clientPw2').value) {
				alert('비밀번호 확인을 다시 확인해주세요.');
				event.preventDefault();
			} else {
				alert('비밀번호 재설정을 성공했습니다.');
			}
		});
	});
</script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/client.css">
<jsp:include page="/template/aside.jsp"></jsp:include>
<div class = float-left>
<div class="main-margin-exit">
	<div class="container-600 border">
		<div class="row"><h2 class="text-center">비밀번호 재설정</h2></div>
		<form action="resetPw.kh?inputEmail=<%=inputEmail%>" method="POST" class="reset-pw-form">
			<label for="input-authNum">인증번호</label>
			<input type="text" id="input-authNum" class="form-input form-input-underline" required>
			<label for="clientPw">새 비밀번호</label>
			<input type="password" name="inputPw" id="clientPw" class="form-input form-input-underline" required>
			<label for="clientPw2">새 비밀번호 확인</label>
			<input type="password" id="clientPw2" class="form-input form-input-underline" required>
			<div class = "fail failPw">비밀번호 형식이 올바르지 않습니다</div>
	 	    <div class = "success successPw">올바른 형식의 비밀번호입니다</div>
			<div class = "fail failPw2">비밀번호와 재입력하신 비밀번호가 다릅니다</div>
			<div class = "success successPw2">일치하는 비밀번호입니다</div>
			<div class = "fail firstPw">비밀번호를 먼저 입력해주세요</div>
			<br><br>
			<input type="submit" value="비밀번호 재설정" class="form-btn form-btn-normal float-right">
		</form>
		<br><br>
	</div>
</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>