<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
//root
String root = request.getContextPath();%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=root%>/css/client.css">
</head>
<body>
<jsp:include page="/template/aside.jsp"></jsp:include>
<div class="main">
    <div class = "text-center">
		<a href= "<%=root%>/index.jsp">
			<img src="<%=request.getContextPath()%>/image/example.png" class = "containerimg">
		</a>
	</div> 
	
	<div class = "container-500 border">
		<div class="row text-center">
			<h2>탈퇴가 완료되었습니다</h2>
		</div>
		<div>
			<h2 class = "blank-top"> </h2>
		</div>
		<div class = "text-center padding-t">
			<img src="<%=root%>/image/goodbye.jpg" width="70%">
		</div>
		<div>
			<h2 class = "blank-bottom"> </h2>
		</div>
		<div class = "row text-center">
			<button type = "submit" style= 'cursor:pointer' class = "form-input form-btn form-btn-home" 
						onclick = "location.href = '<%=root %>/index.jsp'">홈으로 돌아가기</button>
		</div>
	</div>
</div>

</body>
</html>