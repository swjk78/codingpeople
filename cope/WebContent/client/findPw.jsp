<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/template/aside.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/client.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/loadingPageEmail.css">

<script>
	window.addEventListener('load', function () {
		if (<%=request.getParameter("fail") != null%>) {
			alert('해당 이메일로 가입한 계정이 존재하지 않습니다.');
			history.replaceState({}, null, location.pathname);
		}
		var form = document.querySelector('.form-find');
		form.addEventListener('submit', function () {
			var lodingModal = document.querySelector('.loading-modal');
			lodingModal.style.display = 'block';
		});
	});
</script>

<div class = float-left>
<div class="main-margin-exit">
	<div class="container-600 border">
		<div class="row"><h2 class="text-center">비밀번호 찾기</h2></div>
		<form action="findPw.kh" method="POST" class="form-find">
			<label for="input-email">이메일</label>
			<input type="email" name="inputEmail" id="input-email"  class="form-input form-input-underline" required>
			<br><br>
			<input type="submit" value="전송" class="form-btn form-btn-normal float-right">
		</form>
		<br><br>
		<div class="loading-modal">
			<img src="<%=request.getContextPath()%>/image/sendMail.png" class="loading-icon">
		</div>
	</div>
</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>