<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/join.css">
    
<div class = "container border">
	<div class="row">
		<h2>가입이 완료되었습니다</h2>
		<p>로그인 하셔서 다양한 경험을 시작하세요!</p>
	</div>
	
<div class = "text-center padding-t">
		<img src="<%=request.getContextPath()%>/image/wellcome.png" width="70%">
	</div>
	

		<div class = "row text-center">
			<button type = "button" class = "form-btn form-btn-normal " onclick = "location.href = "login.jsp"">로그인하기</button>
		</div>
		<div class = "row text-center"><a href = #>
			<input type = "submit" value = "홈으로 돌아가기" class = "form-btn form-btn-normal ">
		</a></div>
</div>

