<%@page import="cope.beans.client.ClientDto"%>
<%@page import="cope.beans.client.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/template/aside.jsp"></jsp:include>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/client.css">
	
	<style>
		.error{
			color:red;
		}
		
	.pw-font{
	 font-family : "맑은 고딕", "돋움", sans-serif; 
	}
	</style>
<%
	request.setCharacterEncoding("UTF-8");
	int clientNo = (int)session.getAttribute("clientNo");
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.myInfo(clientNo);
	
%>
<script>
	window.addEventListener("load",function(){
		var form = document.querySelector(".form");
		form.addEventListener("submit",function(e){
			
			var chgNick = document.querySelector("input[name=clientNick]");
			var regexNick = /^[가-힣a-zA-Z0-9!@#$%^&*]{1,10}$/;
			
			if(!regexNick.test(chgNick.value)){
				var spanNick = document.querySelector("input[name=clientNick]+span");
				spanNick.textContent = "1~10 글자만 변경가능합니다 ";
				spanNick.style.color="red";
				chgNick.select();
				
				e.preventDefault();
				
				}
			
			else{
				var spanNick = document.querySelector("input[name=clientNick]+span");
				spanNick.textContent ="";
				var choice = window.confirm("수정하시겠습니까?");
				if(!choice){
					e.preventDefault();
				}
			}
			
			
			
		});

		
	});

</script>

	
</head>
<body>
<div class = float-left>
<div class="main-margin-editinfo">
	<div class="container-600 border">
	<div class="row"><h2 class="text-center">회원정보 수정</h2></div>
	
	<form action="editInfo.kh" method="post" class="form">
	<div class="row">
		<label>닉네임</label>
		<input type="text" name="clientNick" required class="form-input form-input-underline"
				value="<%=clientDto.getClientNick()%>"> <span></span>
	</div>
	<div class="row">
		<label>이메일</label>
		<input type="email" name="clientEmail" required class="form-input form-input-underline" 
				value="<%=clientDto.getClientEmail()%>"> <span></span>
	</div>
	<div class="row">
		<label>현재비밀번호</label>
		<input type="password" name="clientPw" required class="pw-font form-input form-input-underline"> 
	</div>
	<div>
		<%if(request.getParameter("error") != null){%>
			<div>
				<span class="error">비밀번호가 일치하지않습니다</span>
			</div>
		<%} %>
	</div>
	<div>
		<input type="submit" value="수정" class="form-btn form-btn-normal float-right">
		<br><br>
	</div>
	</form>
	</div>
</div>
</div>

</body>
</html>

<jsp:include page="/template/footer.jsp"></jsp:include>