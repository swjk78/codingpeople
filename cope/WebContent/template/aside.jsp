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

String clientId;
char ch='e';
int no;
	
int seed;
int randomInt=0;

if(clientNo!=null){	
clientDto = clientDao.myInfo(clientNo);

clientId = clientDto.getClientId();
ch =  clientId.charAt(0);
no = (int)ch;
	
seed = 216823123;
randomInt= (seed/no)%1000000;
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
	
.font-size{
font-size: 18px;
}
.font-sizemini{
font-size: 1px;
}
.text-center{
	text-align: center;
}

.text-left{
			text-align:left;
			}

.white{
color:white;

}
.border{
border: 4px solid #5A5F94;
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
width:180px;
height: 40px;
background-color: #5A5F94;
font-size: 15px;
color:white;
border: none;
}

.imgRound {
width: 100px;
height:100px;
background: white;
	border: 10px solid #ffffff;
	border-radius: 100%;
	padding: 10px;
}

.button-padding{
overflow: hidden;
}

.text-align-right{
text-align: right;
padding-right : 10px;
}
.a-text-decoration{
font-size: 10px;
text-decoration: none;
color: white;
}

A:VISITED{text-decoration:none; color:white;};

A:HOVER{text-decoration:underline;};

.list-padding{
display : inline;
padding-auto: 2px;
}
.padding-t{
padding-top : 10px;
}
.padding-b{
padding-bottom: 20px;
}
.background{
	background-color: #9A9EC2;
	background-radius: 3px 5px 8px 10px;
}

.background-board{
	background-color: #5A5F94;
	border:  solid #5A5F94 10px;
	padding-left: 5px;
	padding-top: 3px;
}

.pre-wrap{
overflow: hidden;
}

.test {
  border-radius: 10px 10px 10px 10px;
}
.test1{
border-radius: 10px 10px 0px 0px;
}
.test2{
border-radius: 0px 0px 10px 10px;
}
.padding-left1{
padding-left: 5px;
padding-top: 5px;
}
</style>


<!-- 왼쪽 화면 구현 -->

		<div class="sidemenu white font-size padding-left1">
		<div class = "">
			<div class = "text-center imgcontainer imgdiv test border">
			<a href= "<%=request.getContextPath()%>/index.jsp" >
				<img src ="<%=root %>/image/example.png" width= 200;>
				</a>
				</div>
						<div class = "list-padding font-sizemini">&nsbs</div>
				<div class = "text-center border test background">
					<%if(!isLogin){//로그아웃 상태 %>
												<div>
												<br><br>
								<img class="profile-img imgRound" src="<%=request.getContextPath()%>/image/annonymous.png" ><br><br>
							<p class = "button-padding">로그인을 해주세요</p>
									<a href = "<%=request.getContextPath()%>/client/login.jsp" >
				<button id = loginButton value = "login" class = "loginButton border" style = cursor:pointer  ><strong>CODING PEOPLE 로그인</strong></button></a><br>
				<div class = "text-align-right padding-t padding-b">
				<a href = "<%=request.getContextPath()%>/client/join.jsp" class = "a-text-decoration">회원가입</a>
				</div>
				</div>
					<%}else{//로그인 상태
						if(isSuper){//관리자 로그인%>
						<br><br>
								<img class="profile-img imgRound" src="https://dummyimage.com/50/<%=randomInt %>/ffffff&text=<%=ch %>" >
								<br><br>
		<p class = button-padding><strong>관리자님 환영합니다.</strong><p>
				<form action = "<%=root%>/client/logout.kh" method = post>
				<a href = "<%=root%>/manage/manageCenter.jsp">
		<button id = AdminloginButton value = "adminLogin" class = "loginButton bordr" style = cursor:pointer>관리메뉴</button><br><br>
		</a>
					    <input type = submit  value =" 로그아웃" id = logoutButton class= "loginButton" style = cursor:pointer ><br><br>

		</form>

				<%}else{//로그인 상태면서 관리자가 아닌경우, 즉 일반 회원 일 때 %>
				<br><br>
						<a href = "<%=root %>/client/profile.jsp">
				<img class="profile-img imgRound" src="https://dummyimage.com/50/<%=randomInt %>/ffffff&text=<%=ch %>" ><br><br><br>
				</a>
				<!--  일반회원 이름-->
						<div class = "nameOver button-padding pre-wrap" ><strong><%=clientDto.getClientNick()%></strong></div>
		<form action = "<%=root%>/client/logout.kh" method = post><br>
			    <input type = submit  id = logoutButton value = "로그아웃"  class= "loginButton" style = cursor:pointer ><br><br>
</form>
			    		<%} %>
	<%} %>
	</div>
</div>
			
<!-- 			메뉴를 띄울 곳입니다. -->
		<div class = "list-padding font-sizemini">&nsbs</div>
				<div class ="background-board test1">게시판</div>
		<div class="menu border background test2">

		<span class="menu title"></span>

			<%
			BoardDao boardDao = new  BoardDao();
			BoardDto boardDto = new BoardDto();
			List<BoardDto> boardSuperList =  boardDao.showListBoardSuper();%>
			
			<%for(BoardDto boardDtoSuper : boardSuperList){%>
				<ul class =a-text-decoration>
				<li class="boardSuper"><a href="board/postListTest.jsp?boardGroup=<%=boardDtoSuper.getBoardNo() %>"><%=boardDtoSuper.getBoardName()%></a>

						<ul class =a-text-decoration>
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
