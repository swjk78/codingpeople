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
			
			var form = document.querySelector(".form");
			form.addEventListener("submit",function(e){
				
// 				var originPw=document.querySelector("input[name=originPw]");
// 				var regexOriginPw = /^[a-zA-Z0-9!@#$%^&*]{8,16}$/;
// 				if(!regexOriginPw.test(originPw.value)){
// 					var originPwSpan = document.querySelector("input[name=originPw]+span");
// 					chgPwSpan.textContent="비밀번호는 영문: 대문자,소문자 숫자:0~9 특수기호 : !@#$%^&* 을 포함한8~16 자리만 가능합니다";
// 				}
				
				
				var chgPw = document.querySelector("input[name=chgPw]");
				var regexChgPw = /^[a-zA-Z0-9!@#$%^&*]{8,16}$/;
				
				if(!regexChgPw.test(chgPw.value)){
					var chgPwSpan = document.querySelector("input[name=chgPw]+span");
					chgPwSpan.textContent="비밀번호는 영문: 대문자,소문자 숫자:0~9 특수기호 : !@#$%^&* 을 포함한8~16 자리만 가능합니다";
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
				
				
			});
		});
		
 			
			
			
		
				
			
	
	
	</script>
</head>
<body>
	<div class="container-1000">
	<div class=row><span>비밀번호 변경</span></div>
	
	<form action="editPw.kh" method="post" class="form-input form">
	
	<div class="row">	
	<input  type="password" placeholder="현재비밀번호를입력하세요" name="originPw" class="form-input form-input-underline">
	<span></span>
	</div>
	
	<div class="row">
	<input  type="password" placeholder="바꿀비밀번호를입력하세요" name="chgPw" class="form-input form-input-underline">
	<span></span>
	</div>
	
	<div class="row">
	<input  type="password" placeholder="바꿀비밀번호를입력하세요" name="checkPw" class="form-input form-input-underline">
	<span></span>
	</div>
	<div>
		<%if(request.getParameter("error") != null){%>
			<div>
				<span class="error">비밀번호가 일치하지않습니다</span>
			</div>
		<%} %>
	</div>
	
	
	<div class="row">
	<input type="submit" value="변경" class="form-btn form-btn-normal">
	</div>
	
	</form>
	</div>
</body>
</html>