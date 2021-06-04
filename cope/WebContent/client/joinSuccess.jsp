<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/join.css">
    
    <div class = "text-center">
	<a href= "<%=request.getContextPath()%>/index.jsp" >
			<img src="<%=request.getContextPath()%>/image/example.png" class = "containerimg">
		</a>
	</div> 
	
	<div class = "container joinBorder">
		<div class="row text-center">
			<h2>가입이 완료되었습니다</h2>
				<p>로그인 하셔서 다양한 코드를 알아보세요!</p>
		</div>
		<div>
			<h2 class = "blank-top"> </h2>
		</div>
		<div class = "text-center padding-t">
			<img src="<%=request.getContextPath()%>/image/wellcome.png" width="70%">
		</div>
		<div>
			<h2 class = "blank-bottom"> </h2>
		</div>
		<div class = "row text-center">
			<button type = "button" style= 'cursor:pointer' class = "form-btn form-btn-normal " 
						onclick = "location.href = 'login.jsp'">로그인하기</button>
			<button type = "submit" style= 'cursor:pointer' class = "form-btn form-btn-normal " 
						onclick = "location.href = '<%=request.getContextPath()%>/index.jsp'">홈으로 돌아가기</button>
		</div>
	</div>
	<jsp:include page="/template/miniFooter.jsp"></jsp:include>