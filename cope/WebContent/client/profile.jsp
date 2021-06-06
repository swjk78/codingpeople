<%@page import="cope.beans.board.BoardChartDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cope.beans.board.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@page import="cope.beans.client.ClientDto"%>
<%@page import="cope.beans.client.ClientDao"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%
	String root = request.getContextPath();

	request.setCharacterEncoding("UTF-8");
	
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));
	
	// 프로필을 보는 사람이 본인인지 아닌지 판별
	boolean isOwn = false;
	if (session.getAttribute("clientNo") != null) {
		isOwn = (int) session.getAttribute("clientNo") == clientNo;
	}
	
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = new ClientDto();
	clientDto = clientDao.myInfo(clientNo);
	
	// 존재하지 않는 계정의 프로필일 경우
	if (clientDto == null) {
		response.sendRedirect(root + "/error/notExist.jsp");
	}

	//(석현)
	//위는 세션으로 불러오는 경우에 자신의 정보를 보게끔하고
	//다른 사람 정보는 파라미터로 받게하겠습니다(url에서 숨길 수 있으면 더 좋을 거 같은데 구현해보겠습니다.)

	//아이디에 따라 랜덤 숫자 부여 placehodler에 사용할 예정!
	if (clientDto != null) {
		String clientId = clientDto.getClientId();
		char ch =  clientId.charAt(0);
		int no = (int)ch;
		
		int seed = 216823123;
		int randomInt= (seed/no)%1000000;
		
		BoardDao boardDao = new BoardDao();
		List<BoardChartDto>countWritenpostList = new ArrayList<>();
		countWritenpostList = boardDao.countWritenPosts(clientNo);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/client.css">

<style>
.chart{
	width: 315px;
	height: 200px;
}
</style>
<script>
	
</script>
</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.3.2/chart.min.js"></script>
<jsp:include page="/template/aside.jsp"></jsp:include>
<div class="main">
	<div class="container-800 border">	

		<div class="row"><h2 class="text-center">회원 프로필카드</h2></div>
		
<table class="table-card">
<tbody>
	<tr>
		<td>
			<div class="profile-card float-left">
				<div class="profile-card-top">
					<span class="grade"><%=clientDto.getClientGradeKorean()%></span>
					<img class="imgRound" src="https://dummyimage.com/200/<%=randomInt %>/ffffff&text=<%=ch %>" >
					<h3><%=clientDto.getClientNick() %></h3>
					<%if (isOwn){%>
					<h4><%=clientDto.getClientEmail() %></h4>
					<%}else{%>
					<h4><%=clientDto.getClientEmail().substring(1,3) %>********</h4>
					<%} %>
					<p>okky 회원</p>
				</div>
				
				<div class="profile-card-bottom">
						<%if (isOwn) {%>
							<a href="<%=root%>/client/editInfo.jsp"><button class="client-btn">내 정보 수정</button></a>
							<a href="<%=root%>/client/editPw.jsp"><button class="client-btn">비밀번호 변경</button></a>
							<a href="<%=root%>/client/exit.jsp"><button class="client-btn">회원탈퇴</button></a>
						<%} %>
				</div>
			</div>
		</td>
		<td>
		<div class="profile-card-back float-left">
			<div class="profile-card-top">
			
				<h2 class="text-center rid-margin">회원 게시글 분석</h2>
				
					<br>
					<div class="chart">
						<canvas id="postChartUser" ></canvas>
					</div>
					<script>
					var boardNames = [];
					<%for(int i=0; i<countWritenpostList.size(); i++){%>
					boardNames[<%=i%>] = '<%=countWritenpostList.get(i).getName()%>';
					<%}%>
					
					var count =[];
					<%for(int i=0; i<countWritenpostList.size(); i++){%>
					count[<%=i%>] = <%=countWritenpostList.get(i).getCount()%>; // 배열을 복사합니다.
					<%}%>	
					
					var ctx = document.getElementById('postChartUser').getContext('2d');
					var myChart = new Chart(ctx, {
					    type: 'bar',
					    data: {
					    	labels: boardNames,
					        datasets: [{
					            label: '게시글 수',
					            data: count,
					            backgroundColor: [
					                'rgba(255, 255, 153, 0.2)',
					                'rgba(204, 255, 153, 0.2)',
					                'rgba(102, 255, 204, 0.2)',
					                'rgba(102, 255, 255, 0.2)',
					                'rgba(204, 153, 255, 0.2)',
					                'rgba(255, 153, 204, 0.2)',
					                'rgba(51, 204, 204, 0.2)'
					            ],
					            borderColor: [
					                'rgba(50, 50, 50, 1)',
					                'rgba(50, 50, 50, 1)',
					                'rgba(50, 50, 50, 1)',
					                'rgba(50, 50, 50, 1)',
					                'rgba(50, 50, 50, 1)',
					                'rgba(50, 50, 50, 1)',
					                'rgba(50, 50, 50, 1)'
					            ],
					            borderWidth: 1
					        }]
					    },
					    options: {
					    	
					        scales: {
					            x: {
					                display: false,
					              }
					        }
					    }
					});	
					</script>
				</div>
				<div class="profile-card-bottom">
					<a href="clientPostList.jsp?clientNo=<%=clientNo%>">
					<button class="client-btn">작성한 글 보기</button></a>
					<a href="#"><button class="client-btn">작성한 댓글 보기</button></a>
				</div>
			</div>
		</td>
	</tr>
</tbody>
</table>

<br><br>
</div>
</div>
		
</body>
<%} %>
</html>