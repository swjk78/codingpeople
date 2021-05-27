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
		$(this).nextAll(".success").hide();
		$(this).nextAll(".fail").show();
		}
	});	
		
		$("#clientPw").on("input",function(){
			var pw = $(this).val();
			var regex = /^[a-zA-Z0-9!@#$%^&*]{8,16}$/;
			if(regex.test(pw)){
				$(this).nextAll(".fail").hide();
				$(this).nextAll(".successPw").show();
				$(this).off();
			}
			else{
			$(this).nextAll(".failPw").show();
			$(this).nextAll(".success").hide();
			}
		});	
	
		$("#clientPw2").on("input",function(){
			var pw = $(this).val();
			var pw2 = $("#clientPw").val();
			if(pw==pw2){
				$(this).nextAll(".fail").hide();
				$(this).nextAll(".successPw2").show();
			}
			else{
			$(this).nextAll(".failPw2").show();
			$(this).nextAll(".success").hide();
			}
		});	
		//비밀번호를 입력하지 않고, 비밀번호재입력칸을 입력했을때
		$("#clientPw2").blur("input",function(){
			var pw = $("#clientPw").val();
			var pw2 = $(this).val();
			if(pw==""){
				pw2 =$(this).val("");
				$("#clientPw").focus();
				$(this).nextAll(".firstPw").show();				
			}
		});	
		
		$("#clientEmail").on("input",function(){
			var pw = $(this).val();
			var regex = /^[a-zA-Z0-9!@#$%^&*]{8,16}$/;
			if(regex.test(pw)){
				$(this).nextAll(".fail").hide();
				$(this).nextAll(".successPw").show();
				$(this).off();
			}
			else{
			$(this).nextAll(".failPw").show();
			$(this).nextAll(".success").hide();
			}
		});	
		
		$("#clientNick").on("input",function(){
			var pw = $(this).val();
			var regex = /^[a-zA-Z0-9!@#$%^&*]{8,16}$/;
			if(regex.test(pw)){
				$(this).nextAll(".fail").hide();
				$(this).nextAll(".successPw").show();
				$(this).off();
			}
			else{
			$(this).nextAll(".failPw").show();
			$(this).nextAll(".success").hide();
			}
		});	
		
		
	});
	</script>
</head>

<body>
<div class = "text-center">
<a href= home.jsp>
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
			<input type = "email" id = "clientEmail" required class = "form-input form-input-underline"
						placeholder = "자주 사용하는 이메일">
				<span class = "fail">이메일 형식이 올바르지 않습니다</span>
				<span class = "success">올바른 형식의 이메일입니다</span>
		</div>
		
		<div class = "row text-left">
			<label for = "clientNick">닉네임</label>
			<input type = "text" id = "clientNick" required class= "form-input form-input-underline"
						placeholder = "한 글자 이상, 형식 제한 없음 ">
						<span class = "fail">닉네임은 한글자 이상이어야 합니다</span>
						<span class = "success">멋진 닉네임입니다.</span>
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