<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/bottom.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.title-border{
padding : 20px;
color:white;
font-size : 18px;
width:85.78%;
background-color:#5A5F94;
position : relative;
}
    .padding-left{
    padding-left:188px;
    }
    
    .margin{
    margin-left : 10px;
    }

.border-inner{
width : 100%
}
</style>
</head>
<body>
<div class = "text-center">
	<a href= "<%=request.getContextPath()%>/index.jsp">
<img src = "<%=request.getContextPath()%>/image/example.png" class = "containerimg">
</a>
 </div>
   	
  		  			<span>&nbsp;</span>
  		  			<span>&nbsp;</span>
  		  			<div class = " text-center ">
  		  			<div class = padding-left>
  		  			<div class = "title-border ">팀원 소개</div>
  		  			</div>
<div class = " display-inline-block border">
        <div  >
<pre class = "text-left border-inner">
방문해주셔서 감사합니다.

저희는 개발자들 간의 고민을 해결하는 커뮤니티 사이트를 목표로 개발하고 있는 코딩피플입니다. 현재 KH에서 웹을 만들고 있습니다. 
팀 구성원은 조장 김진규를 비롯하여 이석현, 윤준혁, 이창엽, 소경수로 이루어져 있습니다. 










이미지 넣을까요?














 

</pre>
</div>
</div>
</div>
</body>

</html>
<jsp:include page="/template/miniFooter.jsp"></jsp:include>