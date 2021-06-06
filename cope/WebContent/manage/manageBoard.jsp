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

<jsp:include page="/template/aside.jsp"></jsp:include>

 <html>
 <head>
 <meta charset="UTF-8">
<link rel = "stylesheet" type = "text/css" href = "<%=root%>/css/manage.css">
<script>
//하위게시판 보이는 기능(나머지는 숨기고)
function returnBoardInfo(boardNo, boardName, isSuper){
			var inputBoardNo = document.getElementsByClassName("boardNo");
			var inputBoardName = document.getElementsByClassName("boardName");
			
		if(boardNo!=-1){
			for(var i=0; i<inputBoardNo.length; i++){ 
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
		else{//"(상위게시판)", "(하위게시판)"을 선택한 경우 빈칸 출력
			for(var i=0; i<inputBoardNo.length; i++){ 
				inputBoardNo[i].setAttribute('value', "");
				inputBoardName[i].setAttribute('value', "");
				}
		}
}

//상위게시판 정규표현식
function checkNameSuper(){
	var inputName = document.querySelector("#superInput");
	var inputNameValue = inputName.value;
	var regex = /^[a-zA-Z\d가-힣+#/\-\(\)\*@!éö.:π′]{1,10}$/; //현존하는 모든 프로그래밍 언어
	
	if(!regex.test(inputNameValue)){
		alert("올바른 형식이 아닙니다. 프로그래밍 언어 이름을 10글자 이내로 적어주세요");
		event.preventDefault();
	}
}

//하위게시판 정규표현식
function checkNameSub(){
	var inputName = document.querySelector("#subInput");
	var inputNameValue = inputName.value;
	var regex = /^[a-zA-Z\d가-힣+#/\-\(\)\*@!éö.:π′]{1,10}$/; //현존하는 모든 언어
	
	if(!regex.test(inputNameValue)){
		alert("올바른 형식이 아닙니다. 프로그래밍 언어 이름을 10글자 이내로 적어주세요");
        event.preventDefault();	
	}
}

function checkDelete(){
msg = "정말로 삭제하시겠습니까?";
	if (confirm(msg)!=0) {
		//실행!     
	} else {
		event.preventDefault();	
	}
}

//언더라인
function underline(id){
	var target = document.querySelector("#"+id);
	
}
</script>

<!-- </head> -->
<!-- <body> -->
<out class = "float-left position-board">
<div class="main-board">
	<div class="container-600 border">
	<a href="manageCenter.jsp" class="backToCenter"><img class="backArrow" src="<%=root %>/image/backArrow.png">관리센터로 돌아가기</a>
<h2 class="text-center">게시판관리</h2>
	<br><br><br>

		<div>
			<form action="createBoard.kh" method="get" onsubmit="checkNameSuper();">
				<div class = "row text-left">	
					<label for="superInput">상위게시판 등록</label>
						<input type="text" id="superInput"  class ="form-input form-input-underline" name="boardName"  required>
						<input type="hidden" name="boardSuperNo"  value=0>
						<input type="submit" class="form-btn form-btn-normal float-right" value="등록">
				</div>
			</form>
			
			<br>
		
			<form action="createBoard.kh" method="get"  onsubmit="checkNameSub();">
				<div class= "row text-left">
					<label for="subInput">하위게시판 등록</label>
						<div>
							<select class="selectbox" name="boardSuperNo">
								<option>(상위게시판을 선택해주세요)</option>
								<%for(BoardDto boardDtoSuper : boardSuperList){ %>
								<option value="<%=boardDtoSuper.getBoardNo()%>"><%=boardDtoSuper.getBoardName() %></option>
							<%} %>
							</select>
						</div>
						<input type="text" id="subInput"  name="boardName"  class ="form-input form-input-underline"  required>
						<input type="submit" class="form-btn form-btn-normal float-right" value="등록">
				
				
				</div>
			</form>
	
		<br><br>

		<p>게시판 수정/삭제</p>
		<select id="boardSuperList" size="<%=countSuper+1 %>" name="boardNo"  class="inline selectbox" >
			<option onclick="returnBoardInfo(-1, 0, 0);">(상위게시판)</option>
			<%for(BoardDto boardDtoSuper : boardSuperList){ %>
			<option onclick="returnBoardInfo(<%=boardDtoSuper.getBoardNo() %>, '<%=boardDtoSuper.getBoardName() %>', 1);">
			<%=boardDtoSuper.getBoardName() %>
			</option>
			<%} %>
		</select>
		
		<%for(BoardDto boardDtoSuper : boardSuperList){ %>
			<%List<BoardDto>boardSubList = boardDao.showListBoardSub(boardDtoSuper.getBoardNo()); %>
				<select id="boardSubList<%=boardDtoSuper.getBoardNo() %>" size="<%=countSuper+1 %>" name="boardNo"  class="boardSubList selectbox">
				<option onclick="returnBoardInfo(-1, 0, 0)">(하위게시판)</option>
					<%for(BoardDto boardDtoSub : boardSubList){ %>
					<option onclick="returnBoardInfo(<%=boardDtoSub.getBoardNo() %>, '<%=boardDtoSub.getBoardName() %>', 2);" >
					<%=boardDtoSub.getBoardName() %>
					</option>
				<%} %>
				</select>
		<%} %>
	
	
	
	
	<form action="deleteBoard.kh" method="get"  class="inline"  onsubmit="checkDelete()">
		<input type="hidden" class="boardNo"  name ="boardNo" >
		<input type="hidden" class="boardName"  required>
		<input type="submit" class="form-btn form-btn-normal"   value="삭제" >
	</form>
	<br><br>

<form action="editBoard.kh" method="get"  onsubmit="checkName();">
	<input type="hidden" class="boardNo"  name = "boardNo">
	<input type="text" class="boardName form-input form-input-underline"   name = "boardName" required>
	<input type="submit" class="form-btn form-btn-normal float-right"  value="수정">
</form>

<br><br><br>


		</div>
	</div>
</div>
</out>
</body>
</html>
		<jsp:include page="/template/footer.jsp"></jsp:include>	