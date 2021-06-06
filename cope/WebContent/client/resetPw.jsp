<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	window.addEventListener('load', function () {
		if (<%=request.getParameter("success") != null%>) {
			alert('이메일 전송을 성공했습니다.');
			history.replaceState({}, null, location.pathname);
		}
		document.querySelector('.reset-pw-form').addEventListener('submit', function () {
			var authNumInput = document.querySelector('#input-authNum');
			var authNum = <%=request.getSession().getAttribute("authNum")%>;

			if (authNum == authNumInput.value) {
				alert('비밀번호 재설정을 성공했습니다.');
				<%
					request.getSession().removeAttribute("authNum");
				%>
			} else {
				alert('인증번호가 다릅니다.');
				event.preventDefault();
			}
		});
	});
</script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/client.css">
<jsp:include page="/template/aside.jsp"></jsp:include>
<div class="main">
	<div class="container-600 border">
		<div class="row"><h2 class="text-center">비밀번호 재설정</h2></div>
		<form action="resetPw.kh" method="POST" class="reset-pw-form">
			<label for="input-authNum">인증번호</label>
			<input type="text" id="input-authNum" class="form-input form-input-underline" required>
			<label for="input-pw">새 비밀번호</label>
			<input type="password" name="inputPw" id="input-pw" class="form-input form-input-underline" required>
			<label for="input-pw-re">새 비밀번호 확인</label>
			<input type="password" id="input-pw-re" class="form-input form-input-underline" required>
			<br><br>
			<input type="submit" value="비밀번호 재설정" class="form-btn form-btn-normal float-right">
		</form>
		<br><br>
	</div>
</div>