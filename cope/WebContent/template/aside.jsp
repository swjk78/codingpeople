<%@page import="cope.beans.client.ClientDao"%>
<%@page import="cope.beans.client.ClientDto"%>
<%@page import="cope.beans.board.BoardDto"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<%
Integer clientNo = (Integer) request.getSession().getAttribute("clientNo");
boolean isLogin = clientNo!=null;
System.out.println("isLogin" + isLogin);
boolean isSuper=false;
	if(isLogin){
		ClientDao clientDao = new  ClientDao();
		isSuper =  clientDao.isSuper(clientNo)==true;
		System.out.println("isSuper" + isSuper);
	}
%>

<%
String root = request.getContextPath();
request.setCharacterEncoding("UTF-8");
//int clientNoPro = (int)session.getAttribute("clientNo");
ClientDao clientDao = new ClientDao();
ClientDto clientDto = new ClientDto();

if(clientNo!=null){	
clientDto = clientDao.myInfo(clientNo);

String clientId = clientDto.getClientId();
char ch =  clientId.charAt(0);
int no = (int)ch;
	
int seed = 216823123;
int randomInt= (seed/no)%1000000;
}
%>


<html>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>

function logout(){
	location.href="/client/logout.kh"
}
	});
	
</script>

<head>

<meta charset="UTF-8">
<title>코딩 피플</title>

	<link rel="stylesheet" type="text/css" href="<%=root%>/css/aside.css">


</head>
<style>
* {
 	font-family: 'NanumSquare', sans-serif;
	box-sizing: border-box;
	}

.text-left{
			text-align:left;
			}

.white{
color:white;

}
.border{
border: 3px solid red;
}

.imgdiv{
padding-top: 5px;
	background-color: white;
	width: 100%;
}
.division{
	position: absolute;
	float: left;
}

.subsidemenudiv{
    padding: 0 20px;
}

#button{
padding : 10px;
font-size : 15px;
width: 100%;
background-color : #5858A4
}

.loginButton{
width:auto;
border:red;
background-color: #9A9EC2;
			font-size: 15px;
			color:white;
			padding : 18px
}

.imgRound {
	border: 1.5px solid #ffffff;
	border-radius: 50%;
	padding: 5px;

</style>

<!-- 왼쪽 화면 구현 -->

		<div class="sidemenu border white">
			<div class = "text-center imgcontainer imgdiv">
			<a href= "<%=request.getContextPath()%>/index.jsp" >
				<img src ="<%=root %>/image/example.png" width= 200;>
				</a>
				</div>
				
				<div class = "text-center">
				<a href = "<%=request.getContextPath()%>/client/login.jsp" >
					<%if(!isLogin){//로그아웃 상태 %>
				<button id = loginButton value = "login" class = "loginButton border" style = cursor:pointer  >로그인을 해주세요.</button></a><br>
				<a href = "<%=request.getContextPath()%>/client/join.jsp" >회원가입</a><br>
					<%}else{//로그인 상태
						if(isSuper){//관리자 로그인%>
		관리자님 환영합니다.
				<form action = "<%=root%>/client/logout.kh" method = post>
		<button id = AdminloginButton value = "adminLogin" class = "loginButton bordr" style = cursor:pointer>관리메뉴</button><br>
					    <input type = submit  id = logoutButton value = "logout"  class= "loginButton" style = cursor:pointer >로그아웃<br>
		<img class="profile-img imgRound" src="https://dummyimage.com/50/<%=randomInt %>/ffffff&text=<%=ch %>" >
		</form>
		
				<%}else{//로그인 상태면서 관리자가 아닌경우, 즉 일반 회원 일 때 %>
		넌일반
		<form action = "<%=root%>/client/logout.kh" method = post>
				<img class="profile-img imgRound" src="https://dummyimage.com/50/<%=randomInt %>/ffffff&text=<%=ch %>" >
			    <input type = submit  id = logoutButton value = "logout"  class= "loginButton" style = cursor:pointer >로그아웃
</form>
			    		<%} %>
	<%} %>
	
</div>
			
<!-- 			메뉴를 띄울 곳입니다. -->
		
		<div class="menu border">
		<span class="menu title"></span>

			<%
			BoardDao boardDao = new  BoardDao();
			BoardDto boardDto = new BoardDto();
			List<BoardDto> boardSuperList =  boardDao.showListBoardSuper();%>
			
			<%for(BoardDto boardDtoSuper : boardSuperList){%>
				<ul>
				<li class="boardSuper"><a href="board/postListTest.jsp?boardGroup=<%=boardDtoSuper.getBoardNo() %>"><%=boardDtoSuper.getBoardName()%></a>

						<ul>
							<%List<BoardDto> boardSubList =  boardDao.showListBoardSub(boardDtoSuper.getBoardNo()); %>
							<%for(BoardDto boardDtoSub : boardSubList){%>
							<li class="boardSub"><a href="<%=root%>/board/postList.jsp?boardNo=<%=boardDtoSub.getBoardNo()%>"><%=boardDtoSub.getBoardName()%></a></li>
							<%} %>
						</ul>
					</li>
				</ul>
			<%} %>
		</div>
		
		</div>

</html>
