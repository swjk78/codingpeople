<%@page import="cope.beans.client.ClientDto"%>
<%@page import="cope.beans.client.ClientDao"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/common.css">
<%
//파라미터는 남들도 내정보를볼수있으므로 세션으로 구현
//Integer도 써도되지만 로그인후처리이므로 null값이 나올수가없어 int썻습니다
//내정보불러오기
	request.setCharacterEncoding("UTF-8");
	int clientNo = (int)session.getAttribute("clientNo");
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.myInfo(clientNo);
	

%>

</head>
<body>
	
		<div class="row">
			<span>아이디 : <%=clientDto.getClientId() %></span>
		</div>		
		
		<div class="row"><span>닉네임 : <%=clientDto.getClientNick() %></span></div>
		<div class="row"><span>이메일 : <%=clientDto.getClientEmail() %></span></div>
		<div class="row"><span>생년 : <%=clientDto.getClientBirthYear() %></span></div>
		<div class="row"><span>등급 : <%=clientDto.getClientGrade() %></span></div>		
			
				
				
				
	
		
		
		<div class="row"><a href="<%=request.getContextPath()%>/board/myPostList.jsp">내글보기</a></div> 
		<div class="row"><a href="<%=request.getContextPath()%>/board/myLikePost.jsp">내가 좋아요한 글</a></div>
		<div class="row"><a href="editInfo.jsp">내정보 수정</a></div>
		<div class="row"><a href="editPw.jsp">비밀번호 수정</a></div>
		<div class="row"><a href="exit.jsp">탈퇴</a></div>
		
		
		
		
		
		
<!-- 		테스트세션 -->
		세션번호<%=session.getAttribute("clientNo") %> 
		

</body>
</html>