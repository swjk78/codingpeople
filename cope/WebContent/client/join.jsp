<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/join.css">
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="<%=request.getContextPath()%>/js/join.js"></script>

<body>
<div class="container">
	<a href= "<%=request.getContextPath()%>/index.jsp" >
	<img src="<%=request.getContextPath()%>/image/example.png" class = inline-block>
	</a>
		</div>
		
	<div class = "container joinBorder">
		<div class = "row text-center">
			<h2>회원 가입</h2>
		</div>
		
		<form action = "join.kh" id = "form" method = "post" class="join-form">
			<div class = "row text-left">
				<label for = "clientId">아이디</label>
				<input type = "text" name="clientId" id = "clientId" required class = "form-input form-input-underline" placeholder = "8~20자 이내의 영문 소대문자, 숫자 조합가능">
				<button class = "form-btn form-btn-normal " onclick = "">ID중복확인</button>
					<span class = "fail">아이디 형식이 올바르지 않습니다</span>
					<span class = "success">올바른 형식의 아이디입니다</span>
			</div>
			<div class = "row text-left">
				<label for = "clientPw">비밀번호</label>
				<input type = "password" name="clientPw" id = "clientPw" required class = "form-input form-input-underline"
							placeholder = "8~16자 이내의 영문 소대문자, 숫자, 특수문자(!@#$%^&*)조합 가능">
				<input type = "password" id = "clientPw2" required class = "form-input form-input-underline padding-t"
							placeholder = "비밀번호 재입력">
					<div class = "fail failPw">비밀번호 형식이 올바르지 않습니다</div>
			 	   <div class = "success successPw">올바른 형식의 비밀번호입니다</div>
					<div class = "fail failPw2">비밀번호와 재입력하신 비밀번호가 다릅니다</div>
					<div class = "success successPw2">일치하는 비밀번호입니다</div>
					<div class = "fail firstPw">비밀번호를 먼저 입력해주세요</div>
			</div>
			
			<div class = "row text-left">
				<label for = "clientEmail">이메일</label>
				<input type = "email" name="clientEmail" id = "clientEmail" required class = "form-input form-input-underline"
							placeholder = "자주 사용하는 이메일">
			</div>
			
			<div class = "row text-left">
				<label for = "clientNick">닉네임</label>
				<input type = "text" name="clientNick" id = "clientNick" required class= "form-input form-input-underline"
							placeholder = "한 글자 이상, 형식 제한 없음 ">
							<span class = "fail">닉네임은 한글자 이상이어야 합니다</span>
							<span class = "success">멋진 닉네임입니다.</span>
			</div>
	
			<div class = "row text-left">
				<label for = "clientBirthYear">출생년도</label>
				<select name="clientBirthYear" id = "clientBirthYear" class= "form-input form-input-underline">
				<option value = "0">(선택 사항) 연도를 선택해주세요</option>
				</select>
			</div>
			<div class = "row text-center">
			<input type = "submit" id= "submit" style= 'cursor:pointer' value = "가입" class = "form-btn form-btn-normal ">
			</div>
		</form>
	</div>

</body>
</html>
<jsp:include page="/template/miniFooter.jsp"></jsp:include>