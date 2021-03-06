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
		var form = document.querySelector(".form");
		form.addEventListener("submit",function(e){
			
			var originPw = document.querySelector("input[name=originPw]");
			var chgPw = document.querySelector("input[name=chgPw]");
			var regexChgPw = /^[a-zA-Z0-9!@#$%^&*]{5,16}$/;
			
			if(!regexChgPw.test(chgPw.value)){
				var chgPwSpan = document.querySelector("input[name=chgPw]+span");
				chgPwSpan.textContent="비밀번호는 영문: 대문자,소문자 숫자:0~9 특수기호 : !@#$%^&* 을 포함한 5~16 자리만 가능합니다";
				chgPwSpan.style.color="red";
				e.preventDefault();
				chgPw.select();
				
			}
			else{
				var chgPwSpan = document.querySelector("input[name=chgPw]+span");
				chgPwSpan.textContent="";
			}
			var checkPw = document.querySelector("input[name=checkPw]");
			
				if(chgPw.value == checkPw.value){
					var checkPwSpan = document.querySelector("input[name=checkPw]+span");
					checkPwSpan.textContent="";
					
					var choice = window.confirm("수정하시겠습니까?");
					if(!choice){
						e.preventDefault();
					}
				}
				else{
					var checkPwSpan = document.querySelector("input[name=checkPw]+span");
					checkPwSpan.textContent = "새로운 비밀번호가 일치하지않습니다";
					checkPwSpan.style.color="red";
					e.preventDefault();
					checkPw.select();
					
				}
				
				if(originPw.value == chgPw.value){
					checkPwSpan.textContent="";
					var chgPwSpan = document.querySelector("input[name=chgPw]+span");
					chgPwSpan.textContent="기존 비밀번호와 변경하실 비밀번호가 같습니다.";
					chgPwSpan.style.color="red";
					e.preventDefault();
					chgPw.select();	
				}
		});
	});
</script>
</head>
<body>
<div class = float-left>
<div class="main-margin-editinfo">
	<div class="container-600 border">
	<div class=row><h2 class="text-center">비밀번호 변경</h2></div>
	
	<form action="editPw.kh" method="post" class="form-input form">
	
	<div class="row">	
	<input  type="password" placeholder="현재 비밀번호를 입력하세요" name="originPw" class=" pw-font form-input form-input-underline">
	<span></span>
	</div>
	
	<div class="row">
	<input  type="password" placeholder="바꿀 비밀번호를 입력하세요" name="chgPw" class="pw-font form-input form-input-underline">
	<span></span>
	</div>
	
	<div class="row">
	<input  type="password" placeholder="바꿀 비밀번호를 입력하세요" name="checkPw" class=" pw-font form-input form-input-underline">
	<span></span>
	</div>
	<div>
		<%if(request.getParameter("error") != null){%>
			<div>
				<span class="error">현재 비밀번호가 일치하지않습니다</span>
			</div>
		<%} %>
	</div>
	
	
	<div class="row">
	<input type="submit" value="변경" class="form-btn form-btn-normal float-right">
	</div>
	</form>
	<br><br><br>
	</div>
</div>
</div>
</body>
</html>
<jsp:include page="/template/footer.jsp"></jsp:include>