<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	window.addEventListener('load', function () {
		if (<%=request.getParameter("success") != null%>) {
			alert('이메일 전송을 성공했습니다');
			history.replaceState({}, null, location.pathname);
		}
		document.querySelector('.reset-pw-form').addEventListener('submit', function () {
			var authNumInput = document.querySelector('#input-authNum');
			var authNum = <%=request.getSession().getAttribute("authNum")%>;

			if (authNum == authNumInput.value) {
				alert('성공!');
				<%
					request.getSession().removeAttribute("authNum");
				%>
			} else {
				alert('인증번호가 다릅니다');
				event.preventDefault();
			}
		});
	});
</script>

<h2>비밀번호 재설정</h2>

<form action="resetPw.kh" method="POST" class="reset-pw-form">
	<label for="input-authNum">인증번호</label>
	<input type="text" id="input-authNum" required>
	<label for="input-pw">새 비밀번호</label>
	<input type="password" name="inputPw" id="input-pw" required>
	<label for="input-pw-re">새 비밀번호 확인</label>
	<input type="password" id="input-pw-re" required>
	<input type="submit" value="비밀번호 재설정">
</form>

<jsp:include page="/template/sessionView.jsp"></jsp:include>
