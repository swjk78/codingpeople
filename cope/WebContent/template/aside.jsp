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
font-size: 17px;
}
.font-sizemini{
font-size: 1px;
}
.font-join{
font-size: 13px;
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
.aside-border{
border: solid 3px #5A5F94;
}

.imgdiv{
padding-top: 5px;
	background-color: white;
	width: 100%;
}

.subsidemenudiv{
    padding: 0 20px;
}

.loginButton{
width:120px;
height: 35px;
background-color: #5A5F94;
font-size: 15px;
color:white;
border: none;
}

.imgRound {
width: 80px;
height:80px;
background: white;
	border: 3px solid #ffffff;
	border-radius: 100%;
	padding: 10px;
}

.button-padding{
overflow: hidden;
}

.text-align-right{
text-align: right;
padding-right : 20px;
}
.a-text-decoration{
font-size: 10px;
text-decoration: none;
color: white;
}

.padding-t{
padding-top : 10px;
}
.padding-b{
padding-bottom: 10px;
}
.background{
	background-color: #9A9EC2;
	background-radius: 5px 5px 5px 5px;
}

.background-board{
	background-color: #5A5F94;
	border:  solid #5A5F94 6px;
	padding-left: 5px;
}

.pre-wrap{
overflow: hidden;
}

.test {
  border-radius: 5px 5px 5px 5px;
}
.test1{
border-radius: 5px 5px 0px 0px;
}
.test2{
border-radius: 0px 0px 5px 5px;
}
.padding-left1{
padding-left: 5px;
padding-top: 5px;
}
.font-weight{
font-weight : 700;
}

.div-out{
padding-right : 110px;
padding-bottom : 20%;
float: left;
height:100%;
}
.float-left{
float:left;
}

</style>


<!-- 왼쪽 화면 구현 -->
<out class = "div-out">
		<div class="sidemenu white font-size padding-left1">
		<div class = "">
			<div class = "text-center imgcontainer imgdiv test1 aside-border">
			<a href= "<%=request.getContextPath()%>/index.jsp" >
				<img src ="<%=root %>/image/example.png" width = 140px;>
				</a>
				</div>

				<div class = "text-center aside-border test2 background">
					<%if(!isLogin){//로그아웃 상태 %>
												<div>
												<br><br>
								<img class="profile-img imgRound" src="<%=request.getContextPath()%>/image/annonymous.png" ><br><br>
							<p class = "button-padding">로그인을 해주세요</p>
									<a href = "<%=request.getContextPath()%>/client/login.jsp" >
				<button id = loginButton value = "login" class = "loginButton test aside-border font-weight" style = cursor:pointer  >로그인</button></a><br>
				<div class = "text-align-center padding-t padding-b ">
				<a href = "<%=request.getContextPath()%>/client/join.jsp" class = "underline font-join">회원가입</a><br>
				</div>
				</div>
					<%}else{//로그인 상태
						if(isSuper){//관리자 로그인%>
						<br><br>
								<img class="profile-img imgRound" src="https://dummyimage.com/50/<%=randomInt %>/ffffff&text=<%=ch %>" >
								<br><br>
		<p class = button-padding><strong>관리자님 환영합니다.</strong><p>
				<a href = "<%=root%>/manage/manageCenter.jsp">
		<button id = AdminloginButton value = "adminLogin" class = "loginButton test aside-border font-weight" style = cursor:pointer >관리메뉴</button>
		</a>
						<form action = "<%=root%>/client/logout.kh" method = post>
					    <input type = submit  value =" 로그아웃" id = logoutButton class= "loginButton test aside-border font-weight" style = cursor:pointer ><br><br>
					    </form>

				<%}else{//로그인 상태면서 관리자가 아닌경우, 즉 일반 회원 일 때 %>
				<br><br>
					
						<a href = "<%=root %>/client/profile.jsp?clientNo=<%=clientNo%>">
						<img class="profile-img imgRound" src="https://dummyimage.com/50/<%=randomInt %>/ffffff&text=<%=ch %>" ></a>
					
				<br><br><br>

				<!--  일반회원 이름-->
						<div class = "nameOver button-padding pre-wrap" ><strong><%=clientDto.getClientNick()%></strong></div>
		<form action = "<%=root%>/client/logout.kh" method = post><br>
			    <input type = submit  id = logoutButton value = "로그아웃"  class= "loginButton test aside-border font-weight" style = cursor:pointer ><br><br>
</form>
			    		<%} %>
	<%} %>
	</div>
</div>
			
<!-- 			메뉴를 띄울 곳입니다. -->
						<div class = "list-padding font-sizemini">&nsbs</div>
				<div class ="background-board test1">게시판</div>
		<div class="menu aside-border background test2">

			<%
			BoardDao boardDao = new  BoardDao();
			BoardDto boardDto = new BoardDto();
			List<BoardDto> boardSuperList =  boardDao.showListBoardSuper();%>
			
			<%for(BoardDto boardDtoSuper : boardSuperList){%>
				<ul class ="a-text-decoration aside-board">
				<li class="boardSuper aside-board"><a href="<%=root%>/board/postList.jsp?boardGroup=<%=boardDtoSuper.getBoardNo() %>" class = underline><%=boardDtoSuper.getBoardName()%></a>

						<ul class ="a-text-decoration aside-board">
							<%List<BoardDto> boardSubList =  boardDao.showListBoardSub(boardDtoSuper.getBoardNo()); %>
							<%for(BoardDto boardDtoSub : boardSubList){%>
							<li class="boardSub aside-board"><a href="<%=root%>
							/board/postList.jsp?boardGroup=<%=boardDtoSuper.getBoardNo()%>
							&boardNo=<%=boardDtoSub.getBoardNo()%>" class = "underline aside-sublist-font-size">
							<%=boardDtoSub.getBoardName()%></a>
							</li>
							<%} %>
						</ul>
					</li>
				</ul>
			<%} %>
		</div>
		
		</div>
</out>
</html>
