<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/join.css">
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
	$(function(){
	$("#clientId").on("input",function(){
		var id = $(this).val();
		var regex = /^[a-zA-Z0-9]{8,20}$/;
		if(regex.test(id)){
			$(this).nextAll(".fail").hide();
			$(this).nextAll(".success").show();
		}
		else{
		$(this).nextAll(".fail").show();
		$(this).nextAll(".success").hide();
		}
	});	
		
	$(function(){
		$("#clientPw").on("input",function(){
			var pw = $(this).val();
			var regex = /^[a-zA-Z0-9!@#$%^&*]{8,16}$/;
			if(regex.test(id)){
				$(this).nextAll(".fail-pw").hide();
				$(this).nextAll(".success-pw").show();
			}
			else{
			$(this).nextAll(".fail-pw").show();
			$(this).nextAll(".success-pw").hide();
			}
		});	
	
	});
	</script>
</head>
<body>
<div class = "text-center">
<a href= http://www.naver.com>
<img src="<%=request.getContextPath()%>/image/example.png" class = "containerimg">
</a>
</div>
<div class = "container border">
	<div class = "row text-center">
		<h2>회원 가입</h2>
	</div>
	<form action = "join.kh" method = "post">
		<div class = "row text-left">
			<label for = "clientId">아이디</label>
			<input type = "text" id = "clientId" required class = "form-input form-input-underline" placeholder = "8~20자 이내의 영문 소대문자, 숫자 조합가능">
			<span class = "fail">아이디 형식이 올바르지 않습니다</span>
			<span class = "success">올바른 형식의 아이디입니다</span>
		</div>
		<div class = "row text-left">
			<label for = "clientPw">비밀번호</label>
			<input type = "password" id = "clientPw" required class = "form-input form-input-underline"
						placeholder = "8~16자 이내의 영문 소대문자, 숫자, 특수문자(!@#$%^&*)조합 가능">
		    <span class = "failPw">비밀번호 형식이 올바르지 않습니다</span>
			<span class = "successPw">올바른 형식의 아이디입니다.</span>
			<input type = "password" id = "clientPw2" required class = "form-input form-input-underline padding-t"
						placeholder = "비밀번호 재입력">
		</div>
		<div class = "row text-left">
			<label for = "clientEmail">이메일</label>
			<input type = "email" id = "clientEmail" required class = "form-input form-input-underline"
						placeholder = "자주 사용하는 이메일">
		</div>
		<div class = "row text-left">
			<label for = "clientNick">닉네임</label>
			<input type = "text" id = "clientNick" required class= "form-input form-input-underline"
						placeholder = "한 글자 이상, 형식 제한 없음 ">
		</div>

		<div class = "row text-left">
			<label for = "clientBirthYear">출생년도</label>
			<select id = "clientBirthYear" class= "form-input form-input-underline"></select>
		</div>
		<div class = "row text-center">
		<input type = "submit" value = "가입" class = "form-btn form-btn-normal ">
		</div>

	</form>

</div>
</body>
</html>