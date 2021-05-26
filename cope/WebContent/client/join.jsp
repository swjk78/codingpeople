<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
	<style>
* {
 	font-family: 'NanumSquare', sans-serif;
	box-sizing: border-box;
	}
	
.border{			
			width: 100%;
			border: 2px solid #B8BAD4;
			padding-top: 15px;
			padding-left : 30px;
			padding-right : 30px;
}

.row{
			width:100%;
			margin-top: 30px;
			margin-bottom : 30px;
			}
			
.text-center{
			text-align:center;
}
.text-left{
			text-align:left;
			}

.container{
			width : 500px;
			margin-left:auto;
			margin-right:auto;
}

.containerimg{
			width : 400px;
			margin-left:auto;
			margin-right:auto;
}

.form-input, .form-btn {
			width : 100%;
			padding : 1;
			margin-top: 10px;
			outline: none;
}

.form-input.form-input-underline {
			border:none;
			border-bottom: 2px solid #E2E3ED;
}

.form-input.form-input-underline:focus {
			border-bottom-color: #9A9EC2;		
}

.form-input.form-input-inline,
.form-btn.form-btn-inline {
			width:auto;
}
	
.form-btn {
			border:none;
}
.form-btn.form-btn-normal {
			background-color: #9A9EC2;
			font-size: 15px;
			color:white;
			padding : 18px
}

</style>
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
			<label>아이디</label>
			<input type = "text" name = "clientId" required class = "form-input form-input-underline" placeholder = "8~20자 이내의 영문 소문자, 숫자">
		</div>
		<div class = "row text-left">
			<label>비밀번호</label>
			<input type = "text" name = "clientPw" required class = "form-input form-input-underline"
						placeholder = "8~16자 이내의 영문 소문자, 숫자, 특수문자">
		</div>
		<div>
			<label> </label>
			<input type = "text" name = "clientPw" required class = "form-input form-input-underline"
						placeholder = "비밀번호 재입력">
		</div>
		<div class = "row text-left">
			<label>이메일</label>
			<input type = "text" name = "clientEmail" required class = "form-input form-input-underline"
						placeholder = "자주 사용하는 이메일">
		</div>
		<div class = "row text-left">
			<label>닉네임</label>
			<input type = "text" name = "clientNick" required class= "form-input form-input-underline"
						placeholder = "한 글자 이상, 형식 제한 없음 ">
		</div>

		<div class = "row text-left">
			<label>출생년도</label>
			<select name = "clientBirthYear" class= "form-input form-input-underline"></select>
		</div>
		<div class = "row text-center">
		<input type = "submit" value = "가입" class = "form-btn form-btn-normal ">
		</div>

	</form>

</div>
</body>
</html>