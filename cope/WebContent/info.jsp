<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/template/aside.jsp"></jsp:include>
<html>
<link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/miniFooterSide.css">
<meta charset="UTF-8">

<div class = display>

	<div class = "text-center">
		<a href= "<%=request.getContextPath()%>/index.jsp">
		<img src = "<%=request.getContextPath()%>/image/example.png" class = "containerimg">
		</a>
 	</div>
  		  <span>&nbsp;</span>
  		  <span>&nbsp;</span>
  		  			
  		 <div class = "blue-box">팀원 소개</div>
			<div class = border-footer-side>

			<pre class = "footer-side-text-left">
			
방문해주셔서 감사합니다.

저희는 개발자들 간의 고민을 해결하는 커뮤니티 사이트를 목표로 개발하고 있는 코딩피플입니다. 현재 KH에서 웹을 만들고 있습니다. 
팀 구성원은 조장 김진규를 비롯하여 이석현, 윤준혁, 이창엽, 소경수로 이루어져 있습니다. 






















			</pre>
		</div>
	</div>
</html>
<jsp:include page="/template/footer.jsp"></jsp:include>