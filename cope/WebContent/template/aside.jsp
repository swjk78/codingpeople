
<%@page import="cope.beans.board.BoardDto"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
.division{
float:left;
margin-left: auto;
margin-right: auto;		   
width : auto;
height : 800px;
display : block;
border : solid black;
position : static;
}
</style>
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


<!-- 왼쪽 화면 구현 -->
	<div class = division>
		<div class="sidemenu">
			<div id="mainlogo" class="text-center">
				<img src ="<%=root %>/image/example.png"  width="200" >
			</div>
		<hr>
		<div class="login-box">
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
				</div>
		</div>

</html>

<!-- <div class=menu> -->
<%-- 	<%BoardDao boardDao = new BoardDao(); %> --%>
<%-- 	<%List<BoardDto>boardSuperList = boardDao.showListBoardSuper();%> --%>
<%-- 	<%for(BoardDto boardDtoSuper : boardSuperList){ %> --%>
<!-- 	<ul> -->
<%-- 		<li class="menu-btn boardSuper"><%=boardDtoSuper.getBoardName() %> --%>
<!-- 		<ul> -->
<%-- 			<%List<BoardDto>boardSubList = boardDao.showListBoardSub(boardDtoSuper.getBoardNo()); %> --%>
<%-- 			<%for(BoardDto boardDtoSub : boardSubList){%> --%>
<!-- 				<li class="menu-btn boardSub"> -->
<%-- 					<a href="<%=root %>board/boardList.jsp?boardSuperNo=<%=boardDtoSub.getBoardSuperNo()%>&boardNo<%=boardDtoSub.getBoardNo() %>"> --%>
<%-- 					<%=boardDtoSub.getBoardName()%> --%>
<!-- 					</a> -->
<!-- 				</li> -->
<%-- 			<%} %> --%>
<!-- 		</ul> -->
<!-- 		</li> -->
<!-- 	</ul> -->
<!-- </div> -->
<%-- <%} %> --%>
