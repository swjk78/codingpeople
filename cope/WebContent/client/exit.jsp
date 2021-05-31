<%@page import="cope.beans.client.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/common.css">
<style>
	.error{
		color:red;
	}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	
	
	
	
	
 	window.addEventListener("load",function(){
 		var form = document.querySelector(".form")
 		form.addEventListener("submit",function(e){
 		
 			var choice = confirm("정말 탈퇴하시겠습니까?");
 			if(!choice){
 				e.preventDefault();
 			}
 			
 			
 		});
 	});

	
</script>

</head>
<body>
	<div class="container-1000">
	<div class="row">회원탈퇴</div>
	
	<form action="exit.kh" method="post" class="form">
	
	<div class="row">
	<input type="password" name="clientPw" placeholder="비밀번호를 입력하세요" required class="form-input form-input-underline">
		
	</div>
	
	<div>
		<%if(request.getParameter("error") != null){%>
			<div>
<!-- 				span을 빨간색으로 입히고싶은데  -->
				<span class="error">비밀번호가 일치하지 않습니다</span>
			</div>
		<%} %>
	</div>
	
	<div class="row">
	<input type="submit" value="확인" class="form-btn form-btn-normal">
	</div>
				
	
	</form>
	

	
	
	
	</div>
</body>
</html>