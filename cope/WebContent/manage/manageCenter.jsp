<%@page import="cope.beans.client.ClientAgeRangeDto"%>
<%@page import="cope.beans.board.BoardDto"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.client.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
 <%String root = request.getContextPath(); %>
 		<jsp:include page="/template/aside.jsp"></jsp:include>
<html>
<head>
<link rel = "stylesheet" type = "text/css" href = "<%=root%>/css/layout.css">
<link rel = "stylesheet" type = "text/css" href = "<%=root%>/css/manage.css">
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 차트.js를 가져오는 코드 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.3.2/chart.min.js"></script>

 <% 
 	//나이를 List에 담기
    ClientDao clientDao = new ClientDao();
    List<ClientAgeRangeDto>ageRangeList = clientDao.getAgeRange();
    BoardDao boardDao = new BoardDao();
    //게시글 개수 List에 담기
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
<out class ="float-left position-center">
<div class="MAIN-ZONE">
	<div class="aside-sector">

	</div>

	<div class="content-sector">
		<div class="">
			<div class="manage-center">
				<div class="container-1000 border">
					<h2 class="text-center">관리센터(버튼스타일 고칠예정!)</h2>
		
						<table class="table table-border text-center">
							<tr>
							<td width=50%;>
								<div class="chart">
									<canvas id="ageChart" ></canvas>
								</div>
									<script>
// 									var boardSuperNames = [];
<%-- 									<%for(int i=0; i<boardSuperList.size(); i++){%> --%>
<%-- 									boardSuperNames[<%=i%>] = '<%=boardSuperList.get(i).getBoardName()%>'; --%>
<%-- 									<%}%> --%>
									
// 									var countUnderpostArray =[];
<%-- 									<%for(int i=0; i<countUnderpostList.size(); i++){%> --%>
<%-- 									countUnderpostArray[<%=i%>] = <%=countUnderpostList.get(i)%>; // 배열을 복사합니다. --%>
<%-- 									<%}%>	 --%>
									
									var teenNames=[];
									<%for(int i=0; i<ageRangeList.size(); i++){%>
									teenNames[<%=i%>] = '<%=ageRangeList.get(i).getTeen()%>';
									<%}%>
									
									var count = [];
									<%for(int i=0; i<ageRangeList.size(); i++){%>
									count[<%=i%>] = <%=ageRangeList.get(i).getCount()%>; // 배열을 복사합니다.
									<%}%>
									
									var ctx = document.getElementById('ageChart').getContext('2d');
									var myChart = new Chart(ctx, {
									    type: 'pie',
									    data: {
									    	labels: teenNames,
									        datasets: [{
									            label: '게시판 비율',
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
								<td class="underBtn"><a href="manageClient.jsp" class ="manage">회원관리</a></td>
								<td class="underBtn"><a href="manageBoard.jsp"  class ="manage">게시판관리</a></td>
								<td>게시글관리</td>
							</tr>
						
						</table>
				</div>
			</div>
		</div>	
	</div>
</div>

<div class="BOTTOM-ZONE">
	<div class="footer-sector">

	</div>
</div>
</out>

</body>
</html>
		<jsp:include page="/template/footer.jsp"></jsp:include>			