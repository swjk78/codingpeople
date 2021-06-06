<%@page import="cope.beans.client.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/template/aside.jsp"></jsp:include>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/client.css">
<style>
	.error{
		color:red;
	}
		.pw-font{
	 font-family : "맑은 고딕", "돋움", sans-serif; 
	}
</style>
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

<div class = float-left>
<div class="main-margin-exit">
	<div class="container-600 border">
	<div class="row"><h2 class="text-center">탈퇴</h2></div>
	
	<form action="exit.kh" method="post" class="form">
	
	<div class="row">
	<input type="password" name="clientPw" placeholder="비밀번호를 입력하세요" required class="pw-font form-input form-input-underline">
		
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
	
	<input type="submit" value="확인" class="form-btn form-btn-normal float-right">
	</div>
				
	
	</form>
	
	<br><br><br>
</div>
	</div>
	</div>
</body>
</html>
<jsp:include page="/template/footer.jsp"></jsp:include>