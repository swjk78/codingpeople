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
  		  			<div class = "title-border ">방문 및 연락</div>
  		  			</div>
<div class = " display-inline-block border">
        <p class = "text-left border-inner">
        
        <strong>주 소</strong> (07212) 서울특별시 영등포구 선유동2로 57 이레빌딩(구관) 19F,20F<br><br>
        
        <strong>TEL</strong> 02)1544-9970 | FAX. 02)2163-8560 | 사업자등록번호 : 876-85-00632 | 기관명 : KH정보교육원 당산지원 | 대표자 : 양진선<br><br>
        
        <strong>오시는 길</strong> 지하철 2, 9호선 당산역 12번 출구 400m
        <br><br>
        
        <img src = "<%=request.getContextPath()%>/image/map.png" class = "text-center" width = 100%>
      
</p>
</div>
</div>
</body>

</html>
<jsp:include page="/template/miniFooter.jsp"></jsp:include>