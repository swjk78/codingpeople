<%@page import="java.util.ArrayList"%>
<%@page import="cope.beans.board.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@page import="cope.beans.client.ClientDto"%>
<%@page import="cope.beans.client.ClientDao"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/client.css">
<%

String root = request.getContextPath();
//otherNo가 있으면 -> 다른사람 정보
//otherNo가 없으면 -> 세션에서 clientNo를 가져와 내정보

//파라미터는 남들도 내정보를볼수있으므로 세션으로 구현
//Integer도 써도되지만 로그인후처리이므로 null값이 나올수가없어 int썻습니다
//내정보불러오기
	request.setCharacterEncoding("UTF-8");
	int clientNo = (int)session.getAttribute("clientNo");
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = new ClientDto();
	
	if (request.getParameter("otherNo") == null) {
	clientDto = clientDao.myInfo(clientNo);
	}else if(Integer.parseInt(request.getParameter("otherNo"))==clientNo){
	clientDto = clientDao.myInfo(clientNo);
	}else{
	clientDto = clientDao.myInfo(Integer.parseInt(request.getParameter("otherNo"))); 
	}

	
//(석현)
//위는 세션으로 불러오는 경우에 자신의 정보를 보게끔하고
//다른 사람 정보는 파라미터로 받게하겠습니다(url에서 숨길 수 있으면 더 좋을 거 같은데 구현해보겠습니다.)

	//아이디에 따라 랜덤 숫자 부여 placehodler에 사용할 예정!
	String clientId = clientDto.getClientId();
	char ch =  clientId.charAt(0);
	int no = (int)ch;
	
	int seed = 216823123;
	int randomInt= (seed/no)%1000000;
	
  BoardDao boardDao = new BoardDao();
  List<BoardDto>boardSuperList = boardDao.showListBoardSuper();
  List<Integer>countWritenpostList = new ArrayList<>();
  if (request.getParameter("otherNo") == null || Integer.parseInt(request.getParameter("otherNo"))==clientNo) {//otherNo가 없거나 otherNo가 본인이라면
  	countWritenpostList = boardDao.countWritenPosts(clientNo, boardSuperList);
  }else{
	countWritenpostList = boardDao.countWritenPosts(Integer.parseInt(request.getParameter("otherNo")), boardSuperList); 
  }
%>

<style>
.chart{
	width: 315px;
	height: 200px;
}
</style>
</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.3.2/chart.min.js"></script>
<jsp:include page="/template/aside.jsp"></jsp:include>
<div class="main">
	<div class="container-800 border">	

		<%if (request.getParameter("otherNo") == null || Integer.parseInt(request.getParameter("otherNo"))==clientNo){%>
		<div class="row"><h2 class="text-center">내 프로필카드</h2></div>
		<%}else{%>
		<div class="row"><h2 class="text-center">회원 프로필카드</h2></div>
		<%} %>
		
<table class="table-card">
<tbody>
	<tr>
		<td>
			<div class="profile-card float-left">
				<div class="profile-card-top">
					<span class="grade"><%=clientDto.getClientGradeKorean()%></span>
					<img class="imgRound" src="https://dummyimage.com/200/<%=randomInt %>/ffffff&text=<%=ch %>" >
					<h3><%=clientDto.getClientNick() %></h3>
					<%if (request.getParameter("otherNo") == null || Integer.parseInt(request.getParameter("otherNo"))==clientNo){%>
					<h4><%=clientDto.getClientEmail() %></h4>
					<%}else{%>
					<h4><%=clientDto.getClientEmail().substring(1,3) %>********</h4>
					<%} %>
					<p>okky 회원</p>
				</div>
				
				<div class="profile-card-bottom">
						<%if (request.getParameter("otherNo") == null || Integer.parseInt(request.getParameter("otherNo"))==clientNo) {%>
							<a href="<%=root%>/client/editInfo.jsp"><button class="client-btn">내 정보 수정</button></a>
							<a href="<%=root%>/client/resetPw.jsp"><button class="client-btn">비밀번호 재설정</button></a>
							<a href="<%=root%>/client/exit.jsp"><button class="client-btn">회원탈퇴</button></a>
						<%}else{%>
							
						<%} %>

				</div>
			</div>
		</td>
		<td>
		<div class="profile-card-back float-left">
			<div class="profile-card-top">
			
				<%if (request.getParameter("otherNo") == null || Integer.parseInt(request.getParameter("otherNo"))==clientNo){%>
				<h2 class="text-center rid-margin">내 게시글 분석</h2>
				<%}else{%>
				<h2 class="text-center rid-margin">회원 게시글 분석</h2>
				<%} %>			

				
				
				
					<br>
					<div class="chart">
						<canvas id="postChartUser" ></canvas>
					</div>
					<script>
					var boardSuperNames = [];
					<%for(int i=0; i<boardSuperList.size(); i++){%>
					boardSuperNames[<%=i%>] = '<%=boardSuperList.get(i).getBoardName()%>';
					<%}%>
					
					var countWrttenpostArray =[];
					<%for(int i=0; i<countWritenpostList.size(); i++){%>
					countWrttenpostArray[<%=i%>] = <%=countWritenpostList.get(i)%>; // 배열을 복사합니다.
					<%}%>	
					
					var ctx = document.getElementById('postChartUser').getContext('2d');
					var myChart = new Chart(ctx, {
					    type: 'bar',
					    data: {
					    	labels: boardSuperNames,
					        datasets: [{
					            label: '게시글 수',
					            data: countWrttenpostArray,
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
					<%if (request.getParameter("otherNo") == null || Integer.parseInt(request.getParameter("otherNo"))==clientNo){%>
					<a href="#"><button class="client-btn">내 글 보기</button></a>
					<%}else{%>
					<a href="#"><button class="client-btn">회원 글 보기</button></a>
					<%} %>	
					<a href="#"><button class="client-btn">"좋아요"한 글 보기</button></a>
				</div>
			</div>
		</td>
	</tr>
</tbody>
</table>

<br><br><br>
</div>
</div>
		
<!-- 		테스트세션 -->
		세션번호<%=session.getAttribute("clientNo") %> 
		

</body>
</html>