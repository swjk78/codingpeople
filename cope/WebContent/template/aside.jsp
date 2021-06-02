
<%@page import="cope.beans.board.BoardDto"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<%
boolean isLogin = 1==1;
boolean isAdmin = 1==0;
%>
<meta charset="UTF-8">
<title>코딩 피플</title>

<%
//root
String root = request.getContextPath();%>
	<link rel="stylesheet" type="text/css" href="<%=root%>/css/aside.css">


</head>
<style>
* {
 	font-family: 'NanumSquare', sans-serif;
	box-sizing: border-box;
	color:white;
	}

.border{
border: 3px solid #5858A4;
}

.imgdiv{
padding-top: 5px;
	background-color: white;
	width: 100%;
	padding : none;
	margin : none;

}
.division{
	position: relative;
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
</style>

<!-- 왼쪽 화면 구현 -->

	<div class = "division">
		<div class="sidemenu border">
			<div id="mainlogo">
			<div class = "text-center imgcontainer imgdiv border">
			<a href= "<%=request.getContextPath()%>/index.jsp" >
				<img src ="<%=root %>/image/example.png" width= 200;>
				</a>
				</div>
				</div>
				<a href = "<%=request.getContextPath()%>/client/login.jsp" >
				<button id = button value = "login">로그인</button>
				</a>
		<div class="login-box border">
			<%if(isLogin){ %>
				<span><a href="<%=root%>/client/profile.jsp?clientNo=세션no"><img class ="v-align-center"  src ="https://via.placeholder.com/25/FFFF00/000000?Text=ProfileImage" ></a></span>
				<span class ="v-align-center">아이디...</span>
				<span><img class ="v-align-center" src="<%=root %>/image/alertBell.png"  height="25px" ></span>
				
					<%if(isAdmin){%>
					<span><a href = "<%=root%>/manage/reportList.jsp">관리페이지</a></span>
					<%}else{}%>
			<%}else{ %>
			<span><a class ="v-align-center" href = "<%=root%>/client/login.jsp" >로그인</a></span>
			<span><a class ="v-align-center" href = "<%=root%>/client/join.jsp">회원가입</a></span>
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

	</div>

</html>
