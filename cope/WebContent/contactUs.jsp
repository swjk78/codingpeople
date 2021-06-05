<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/template/aside.jsp"></jsp:include>
<html>
<link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/miniFooterSide.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>

<div class = display>
<div class = "text-center">
	<a href= "<%=request.getContextPath()%>/index.jsp">
<img src = "<%=request.getContextPath()%>/image/example.png" class = "containerimg">
</a>
 </div>

  		 <div class = "blue-box-contact">방문 및 연락</div>
			<div class = "border-footer-side-contact" >
			<div class = "footer-side-text-left">
        
        <strong>주 소</strong> : (07212) 서울특별시 영등포구 선유동2로 57 이레빌딩(구관) 19F,20F<br>
        <strong>TEL</strong> : 02)1544-9970<span>&nbsp;</span><span>·</span><span>&nbsp;</span>   
        <strong>FAX</strong> :  02)2163-8560<span>&nbsp;</span><span>·</span><span>&nbsp;</span> 
        <strong>사업자등록번호</strong> : 876-85-00632<span>&nbsp;</span><span>·</span><span>&nbsp;</span>   
        <strong>기관명</strong> : KH정보교육원 당산지원<span>&nbsp;</span><span>·</span><span>&nbsp;</span>  
        <strong>대표자</strong> : 양진선<br><br>
        <strong>오시는 길</strong> : 지하철 2, 9호선 당산역 12번 출구 400m
        

</div>
</div>
</div>
        <img src = "<%=request.getContextPath()%>/image/map.png" class = "test-border display " width = 74.3%>
</html>
<jsp:include page="/template/footer.jsp"></jsp:include>