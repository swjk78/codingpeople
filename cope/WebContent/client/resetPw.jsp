<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	window.addEventListener('load', function () {
		document.querySelector('.update-pw-form').addEventListener('submit', function() {
			var authNumInput = document.querySelector('input[name=inputAuthNum');
			var authNum = <%=request.getSession().getAttribute("authNum")%>;

			if (authNum == authNumInput.value) {
				alert('성공!');
				// 비밀번호 변경 처리
				sessionStorage.removeItem('authNum');
			}
			else {
				alert('인증번호가 다릅니다');
				event.preventDefault();
			}
		});
	});
</script>

<h2>비밀번호 재설정</h2>

<form action="updatePw.kh" method="POST" class="update-pw-form">
	<label for="input-authNum">인증번호</label>
	<input type="text" name="inputAuthNum" id="input-authNum" required />
	<label for="input-pw">비밀번호</label>
	<input type="password" name="inputPw" id="input-pw" required />
	<label for="input-pw-re">비밀번호 확인</label>
	<input type="password" name="inputPwRe" id="input-pw-re" required />
	<input type="submit" value="비밀번호 재설정" />
</form>
