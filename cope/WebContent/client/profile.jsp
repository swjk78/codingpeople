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
	
//내가 쓴글


//내가 좋아요한글
%>

</head>
<body>
	<table class="table table-border">
		<thead>
			<tr>
				<th>아이디</th>
				<th>닉네임</th>
				<th>이메일</th>
				<th>생년</th>
				<th>등급</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><%=clientDto.getClientId() %></td>
				<td><%=clientDto.getClientNick() %></td>
				<td><%=clientDto.getClientEmail() %></td>
				<td><%=clientDto.getClientBirthYear() %></td>
				<td><%=clientDto.getClientGrade() %></td>
			</tr>
		</tbody>
	
	
	</table>
		
		
		<a href="#">내글보기</a>
		<a href="#">내가 좋아요한 글</a>
		<a href="editInfo.jsp">내정보 수정</a>
		<a href="editPw.jsp">비밀번호 수정</a>
		<a href="exit.jsp">탈퇴</a>
		
<!-- 		테스트세션 -->
		세션번호<%=session.getAttribute("clientNo") %> 
		

</body>
</html>