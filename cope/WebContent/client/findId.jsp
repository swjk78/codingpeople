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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/client.css">

<script>
	window.addEventListener('load', function () {
		if (<%=request.getParameter("fail") != null%>) {
			alert('해당 이메일로 가입한 계정이 존재하지 않습니다');
			history.replaceState({}, null, location.pathname);
		}
		var form = document.querySelector('.find-id-form');
		form.addEventListener('submit', function (event) {
			var lodingModal = document.querySelector('.loading-modal');
			lodingModal.style.display = 'block';
		});
	});
</script>
<jsp:include page="/template/aside.jsp"></jsp:include>
<div class="main">
	<div class="container-600 border">
		<div class="row"><h2 class="text-center">아이디 찾기</h2></div>
		<form action="findId.kh" method="POST" class="find-id-form">
			<label for="input-email" >이메일</label>
			<input type="email" name="inputEmail" id="input-email" class="form-input form-input-underline"  required >
			<br><br>
			<input type="submit" value="전송" class="form-btn form-btn-normal float-right">
		</form>
		<br><br>
		<div class="loading-modal">
				<img src="<%=request.getContextPath()%>/image/mailSend.gif" class="loading-icon">
		</div>
	</div>
</div>
	<div class="main">
	<jsp:include page="/template/sessionView.jsp"></jsp:include>
	</div>