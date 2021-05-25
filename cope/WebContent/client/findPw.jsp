<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	window.addEventListener('load', function () {
		var form = document.querySelector('.find-pw-form');
		form.addEventListener('submit', function (event) {
			// 여기서 알림 보낼 경우 이메일 존재 여부와 관계 없이 무조건 가기 때문에 수정 필요
			alert('입력하신 이메일로 인증번호가 전송되었습니다');
		});
	});
</script>

<h2>비밀번호 찾기</h2>

<form action="findPw.kh" method="POST" class="find-pw-form">
	<label for="input-email">이메일</label>
	<input type="email" name="inputEmail" id="input-email" required />
	<input type="submit" value="전송" />
</form>
