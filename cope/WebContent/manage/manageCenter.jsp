<%@page import="cope.beans.board.BoardDto"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.client.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
 <%String root = request.getContextPath(); %>
 

 
<html>
<head>
<link rel = "stylesheet" type = "text/css" href = "<%=root%>/css/manage.css">
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 차트.js를 가져오는 코드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.3.2/chart.min.js"></script>

 <% //나이를 List에 담기
    ClientDao clientDao = new ClientDao();
    List<Integer>ageRangeList = clientDao.getAgeRange();
    BoardDao boardDao = new BoardDao();
    List<BoardDto>boardSuperList = boardDao.showListBoardSuper();
    List<Integer>countUnderpostList = boardDao.countUnderPosts(boardSuperList);
 %>

<style>
   .chart{
   width: 450px;;
   height: 450px;
   }
   .underBtn{
   
   }
  </style>
  
</head>
<body>

<jsp:include page="/template/aside.jsp"></jsp:include>
<div class="main">
	<div class="main manage-center">
		<div class="container-1000 border">
			<h2 class="text-center">관리센터</h2>

				<table class="table table-border text-center">
					<tr>
					<td width=50%;>
						<div class="chart">
							<canvas id="ageChart" ></canvas>
						</div>
							<script>
							var ageRangeArray = [];
							<%for(int i=0; i<ageRangeList.size(); i++){%>
							ageRangeArray[<%=i%>] = <%=ageRangeList.get(i)%>; // 배열을 복사합니다.
							<%}%>
							
							var ctx = document.getElementById('ageChart').getContext('2d');
							var myChart = new Chart(ctx, {
							    type: 'pie',
							    data: {
							        labels: ['10대이하', '10대', '20대', '30대', '40대', '50대', '60대', '70대'],
							        datasets: [{
							            label: '연령분포',
							            data: ageRangeArray,
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
					
					
					</td>
					<td width="50%" colspan="2">
						<div class="chart">
							<canvas id="postChart" ></canvas>
						</div>
							<script>
							var boardSuperNames = [];
							<%for(int i=0; i<boardSuperList.size(); i++){%>
							boardSuperNames[<%=i%>] = '<%=boardSuperList.get(i).getBoardName()%>';
							<%}%>
							
							var countUnderpostArray =[];
							<%for(int i=0; i<countUnderpostList.size(); i++){%>
							countUnderpostArray[<%=i%>] = <%=countUnderpostList.get(i)%>; // 배열을 복사합니다.
							<%}%>	
							
							var ctx = document.getElementById('postChart').getContext('2d');
							var myChart = new Chart(ctx, {
							    type: 'pie',
							    data: {
							    	labels: boardSuperNames,
							        datasets: [{
							            label: '게시판 비율',
							            data: countUnderpostArray,
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
					
					
					
					
					</td>
					</tr>
					
					<tr>
						<td class="underBtn"><a href="manageClient.jsp">회원관리</a></td>
						<td class="underBtn"><a href="manageBoard.jsp">게시판관리</a></td>
						<td>게시글관리</td>
					</tr>
				
				</table>
		</div>
	</div>
</div>


</body>
</html>