<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/template/aside.jsp"></jsp:include>
<html>
<link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/join.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

    .text-align-center{
    text-align: center; 
    }
    
    .box{
    width:100%;
    height:100%;
    padding-top: 80px;
    display: inline-block;	
    }
    
</style>
</head>
<body class = text-align-center>
<div>
방문해주셔서 감사합니다.
<br>
저희는 개발자들 간의 고민을 해결하는 커뮤니티 사이트를 목표로 개발하고 있는 코딩피플입니다. 현재 KH에서 웹을 만들고 있습니다. 
<br> 팀 구성원은 조장 김진규를 비롯하여 이석현, 윤준혁, 이창엽, 소경수로 이루어져 있습니다. 
</div>
</body>
<div>
<div></div>
<img src = "<%=request.getContextPath()%>/image/example.png" class = "containerimg">
</div>
</html>
<jsp:include page="/template/miniFooter.jsp"></jsp:include>