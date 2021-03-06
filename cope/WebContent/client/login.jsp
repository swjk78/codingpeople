<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
*{
font-family : monospace,sans-serif;
}
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
/* 로그인 비밀번호입력창 */
.form-input{
width:100%;
box-sizing: border-box;
margin-top:5px;
margin-bottom:5px;
font-size: 15px;
padding:0.8rem;
}
/* 로그인 회원가입 버튼 */
.form-btn{
width:100%;
box-sizing: border-box;
margin-top:5px;
margin-bottom:5px;
font-size: 15px;
padding:0.8rem;
}
/* 아이디입력창 */
.id-input{

}
/* 비밀번호입력창 */
.pw-input{

}
/* 회원가입 버튼 */
.btn-noraml{
color:white;
}
/* 로그인 버튼 */
.btn-submit{
border-style: solid;
border-color: #B8BAD4;
background-color : #B8BAD4;
}
/*COPE로고*/
.cope-logo{
font-family : Neo Sans Pro, sans-serif;
font-size:50px;
}
/*cope<로고를 설정*/
.cope-logo > span{

}
.cope-login{
text-align:center;
width:400px;
margin : 0 auto;
}
.id-find, .pw-find{
font-family : Neo Sans Pro, sans-serif;
font-size:10px;
padding:0.6rem;

}
.id-find,.pw-find{
display:inline-block;
width:49%;
}
</style>

<script>
window.addEventListener('load', function() {
	if (<%=request.getParameter("notFound") != null%>) {
		alert('입력한 정보에 해당하는 계정이 없습니다.');
		history.replaceState({}, null, location.pathname);
	}
	if (<%=request.getParameter("success") != null%>) {
		alert('이메일 전송을 성공했습니다.');
		history.replaceState({}, null, location.pathname);
	}
	if (<%=request.getParameter("unlockDate") != null%>) {
		alert('활동정지당한 계정입니다\n' + '정지해제 날짜: ' + '<%=request.getParameter("unlockDate")%>'
		+ '\n정지사유: ' + '<%=request.getParameter("clientLockReason")%>');
		history.replaceState({}, null, location.pathname);
	}
});
</script>

</head>
<body>
<div class= "cope-login">
	<div class="container-400">
		<div class="row text-center">
			<div class="cope-logo">
				<span><a onclick="location.href='<%=request.getContextPath()%>/index.jsp'"><img class="image image-logo" alt="cope" src="/cope/image/example.png" width="350" height="150"></a></span>
			</div>
		</div>
		<form action = "login.kh" method = "post">
			<div class="row">
				<input type = "text" name = "clientId" placeholder="아이디" required class="form-input id-intput">
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
			<input type="button" value="회원가입" class="form-btn btn-normal"
			onclick="location.href='<%=request.getContextPath()%>/client/join.jsp'">
		</div>
	</div>
	<div class="row">
		<a href="<%=request.getContextPath()%>/client/findId.jsp"><input type= "button" value="아이디 찾기" class= "id-find"></a>
		<a href="<%=request.getContextPath()%>/client/findPw.jsp"><input type= "button" value="비밀번호 찾기" class= "pw-find" ></a>
	</div>
</div>

<jsp:include page="/template/miniFooter.jsp"></jsp:include>

</body>
</html>