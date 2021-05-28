
<%@page import="cope.beans.board.BoardDto"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%String root = request.getContextPath(); %>
<%BoardDao boardDao = new BoardDao(); %>
<%List<BoardDto>boardSuperList = boardDao.showListBoardSuper();%>
<%int countSuper = boardDao.countBoardSuper();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
function returnBoardInfo(boardNo, boardName, isSuper){
	var inputBoardNo = document.getElementsByClassName("boardNo");
	var inputBoardName = document.getElementsByClassName("boardName");
	
	for(var i=0; i<2; i++){
	inputBoardNo[i].setAttribute('value', boardNo);
	inputBoardName[i].setAttribute('value', boardName);
	}
	
	if(isSuper==1){
		//전체 게시판 목록을 선택하고 지웁니다. (반복문을 써야한다.)
		var allBoardSub = document.querySelectorAll(".boardSubList");
		for(var i=0; i < allBoardSub.length; i++){
			allBoardSub[i].style.display="none";
		}


	
	//선택된 게시판 목록
	var selectedBoardSuperNo = "boardSubList"+boardNo;
	var selectedBoard = document.getElementById(selectedBoardSuperNo);

	//선택된 게시판 목록을 드러낸다.
	selectedBoard.style.display="inline-block";
	}
}

function regexBoardName(){
	var inputBoardName = document.getElementById("superInput");
	var inputBoardNameVal = inputBoardName.value;
	var regex = /^[a-zA-Z\d가-힣+#/\-\(\)\*@!éö.:π′]{1,10}$/; //현존하는 모든 언어
	var failMassage = document.querySelector(".fail");
	if(!regex.test(inputBoardNameVal)){
		failMassage.style.display="inline-block";
	}
	else{
		failMassage.style.display="none";
	}
}

function checkName(){
	var inputName = document.querySelector("#superInput");
	var inputNameValue = inputName.value;
	var regex = /^[a-zA-Z\d가-힣+#/\-\(\)\*@!éö.:π′]{1,10}$/; //현존하는 모든 언어
	
	if(!regex.test(inputNameValue)){
		alert("안돼영")
       event.preventDefault();
	}
}

function checkName(){
	var inputName = document.querySelector("#subInput");
	var inputNameValue = inputName.value;
	var regex = /^[a-zA-Z\d가-힣+#/\-\(\)\*@!éö.:π′]{1,10}$/; //현존하는 모든 언어
	
	if(!regex.test(inputNameValue)){
		alert("안돼영")
       event.preventDefault();	
	}
}


</script>

<style>
.border{			
	width: 100%;
	border: 2px solid #B8BAD4;
	padding-top: 15px;
	padding-left : 30px;
	padding-right : 30px;
}
.container-600 { 
	width:600px;
	margin-left:auto;
	margin-right:auto;
}
.container-400 { 
	width:400px;
	margin-left:auto;
	margin-right:auto;
}

.text-center{
	text-align: center;
}

.display-none{
	display: none;
}
.inline{
	display: inline;
}
#boardDeleteList{
	-webkit-appearance: none; /* 화살표 없애기 for chrome*/
	-moz-appearance: none; /* 화살표 없애기 for firefox*/
	border: 1px solid #B8BAD4;
}


.boardSubList, .fail{
	display: none;
}


</style>


</head>
<body>
<div class="container-600 border">
<h2 class="text-center">게시판관리</h2>

	<div class="container-400">
	<br><br><br>
	
	
	
	
	
	<label for="superInput">상위게시판 등록</label>
	<form action="createBoard.kh" method="get" onsubmit="checkName();">
		<input id="superInput" type="text" name="boardName"  required oninput="regexBoardName();">
		<input type="text" name="boardSuperNo"  value=0  hidden>
		<input type="submit" value="등록">
<!-- 		<span class="fail" >게시판 이름은10글자로 적어주세요</span> -->
	</form>
	
	
	
	
	
	

	<label for="subInput">하위게시판 등록</label>
<form action="createBoard.kh" method="get"  onsubmit="checkName();">
	<select name="boardSuperNo">
		<%for(BoardDto boardDtoSuper : boardSuperList){ %>
		<option value="<%=boardDtoSuper.getBoardNo()%>"><%=boardDtoSuper.getBoardName() %></option>
		<%} %>
	</select>
	<input id="subInput" type="text" name="boardName" required>
	<input type="submit" value="등록">
	<!-- 		<span class="fail" >게시판 이름은10글자로 적어주세요</span> -->
</form>

<hr>

<p>게시판 수정/삭제</p>

	<select id="boardSuperList" size="<%=countSuper+1 %>" name="boardNo"  class="inline">
		<option>(상위게시판)</option>
		<%for(BoardDto boardDtoSuper : boardSuperList){ %>
			<option 
				onclick="returnBoardInfo(<%=boardDtoSuper.getBoardNo() %>, '<%=boardDtoSuper.getBoardName() %>', 1);">
			<%=boardDtoSuper.getBoardName() %>
			</option>
				<%} %>
	</select>
	
	
	<%for(BoardDto boardDtoSuper : boardSuperList){ %>
	<%List<BoardDto>boardSubList = boardDao.showListBoardSub(boardDtoSuper.getBoardNo()); %>
	<select class="boardSubList" id="boardSubList<%=boardDtoSuper.getBoardNo() %>" size="<%=countSuper+1 %>" name="boardNo" >
		<option>(하위게시판)</option>
		<%for(BoardDto boardDtoSub : boardSubList){ %>
			<option 
				onclick="returnBoardInfo(<%=boardDtoSub.getBoardNo() %>, '<%=boardDtoSub.getBoardName() %>', 2);">
			<%=boardDtoSub.getBoardName() %>
			</option>
				<%} %>
		</select>
	<%} %>
	
	
	
	
	<form action="deleteBoard.kh" method="get"  class="inline" >
		<input type="text" class="boardNo"  name ="boardNo" >
		<input type="text" class="boardName" hidden="hidden"  required>
		<input type="submit" value="삭제">
	</form>

<form action="editBoard.kh" method="get"  onsubmit="checkName();">
	<input type="text" class="boardNo"  name = "boardNo" >
	<input type="text" class="boardName"  name = "boardName" required>
	<input type="submit" value="수정">
</form>



	</div>
</div>
</body>
</html>