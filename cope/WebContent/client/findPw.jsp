<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.loading-modal {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: rgba(0, 0, 0, 0.5);
		display: none;
	}

	.loading-modal > .loading-icon {
		width: 400px;
		height: 300px;
		position: fixed;
		top: 50%;
		left: 50%;
		margin-top: -200px;
		margin-left: -200px;
	}
</style>

<script>
	window.addEventListener('load', function () {
		if (<%=request.getParameter("fail") != null%>) {
			alert('해당 이메일로 가입한 계정이 존재하지 않습니다');
			history.replaceState({}, null, location.pathname);
		}
		var form = document.querySelector('.find-pw-form');
		form.addEventListener('submit', function (event) {
			var lodingModal = document.querySelector('.loading-modal');
			lodingModal.style.display = 'block';
		});
	});
</script>

<h2>비밀번호 찾기</h2>

<form action="findPw.kh" method="POST" class="find-pw-form">
	<label for="input-email">이메일</label>
	<input type="email" name="inputEmail" id="input-email" required>
	<input type="submit" value="전송">
</form>
<div class="loading-modal">
		<img src="<%=request.getContextPath()%>/image/mailSend.gif" class="loading-icon">
</div>

<jsp:include page="/template/sessionView.jsp"></jsp:include>