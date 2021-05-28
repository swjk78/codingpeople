<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
	window.addEventListener('load', function () {
		if (<%=request.getParameter("error") != null%>) {
			alert('해당 이메일로 가입한 계정이 존재하지 않습니다');
		}
		var form = document.querySelector('.find-pw-form');
		form.addEventListener('submit', function (event) {
			// 여기서 알림 보낼 경우 이메일 존재 여부와 관계 없이 무조건 가기 때문에 수정 필요
			alert('알림 대신 전송 로딩 페이지를 불러올 예정');
		});
	});
</script>

<h2>비밀번호 찾기</h2>

<form action="findPw.kh" method="POST" class="find-pw-form">
	<label for="input-email">이메일</label>
	<input type="email" name="inputEmail" id="input-email" required />
	<input type="submit" value="전송" />
</form>

<jsp:include page="/template/sessionView.jsp"></jsp:include>