<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/template/aside.jsp"></jsp:include>
 <%String root= request.getContextPath(); %>
<html>
<head>
<meta charset="UTF-8">
<style>
.welcome-div{
	width:650px;
	text-align: center;
	margin-left: auto;
	margin-right: auto;
}

</style>

</head>

<div>
	<div class="welcome-div">
		<div class="welcome-div massage">
		<br><br>
 			<h1>코딩 피플에 오신 것을 환영합니다.</h1>
 		</div>
 		 <br>
 		<div class="welcome-div image">
 			<img src ="<%=root %>/image/main-Image.png"  width=100%>
 		</div>
 	</div>
</div>

</html>
<jsp:include page="/template/footer.jsp"></jsp:include>