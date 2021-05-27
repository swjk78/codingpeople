<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cope로그인기능</title>
<script>
function password(){
	var target = document.querySelector("input[name=ClientPw]");
	target.type = "password";
}
</script>
<style>
/* 아이디,비밀번호입력창 회원가입 로그인버튼 */
.row{
		width:100%;
		margin-top: 10px;
		margin-bottom: 10px;
}

.container-400{
width:400px;
}
/* text-center를 센터로 */
.text-center{
text-align:center;
}
div{
border-width:1px;
border-color:grey;
border-style:"";
}
/* 로그인입력창 */
.form-input{
width:100%;
box-sizing: border-box;
margin-top:10px;
margin-bottom:10px;
font-size: 15px;
padding:1rem;
}
/* 로그인 회원가입 버튼 */
.form-btn{
width:100%;
box-sizing: border-box;
margin-top:10px;
margin-bottom:10px;
font-size: 15px;
padding:2rem;
}
/* 아이디입력창 */
.id-input{

}
/* 비밀번호입력창 */
.pw-input{

}
/* 회원가입 버튼 */
.btn-noraml{
}
/* 로그인 버튼 */
.btn-submit{

}
</style>
</head>
<body>
<div class="container-400">
	<div class="row text-center">
		<div class="cope-logo">
			<span>cope로그인화면</span>
</div>
</div>
	<form action = "#" method = "post">
	<div class="row">
	<input type = "text" name = "clientId" placeholder="아이디" class="form-input id-intput">
	</div>
	<div class="row">
	<input type = "password" name = "clientPw" placeholder="비밀번호" required class="form-input pw-input">	
	</div>
	<div class="row">
	<input type = "submit" value ="로그인" class="form-btn btn-submit">
	</div>
	</form>
	<hr>
	<div class="row">
	<input type="button" value="회원가입" class="form-btn btn-normal">
	</div>
		</div>
</body>
</html>