<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	window.addEventListener('load', function () {
		var form = document.querySelector('.find-id-form');
		form.addEventListener('submit', function (event) {
			alert('입력하신 이메일로 아이디가 전송되었습니다');
		});
	});
</script>

<h2>아이디 찾기</h2>

<form action="findId.kh" method="POST" class="find-id-form">
	<label for="input-email">이메일</label>
	<input type="email" name="inputEmail" id="input-email" required />
	<input type="submit" value="전송" />
</form>
