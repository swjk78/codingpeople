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

<!-- <html> -->
<!-- <head> -->
<!-- <meta charset="UTF-8"> -->
<!-- <title>Insert title here</title> -->

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

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
		alert("올바른 문장이 아닙니다.");
		event.preventDefault();
	}
}

//하위게시판 정규표현식
function checkNameSub(){
	var inputName = document.querySelector("#subInput");
	var inputNameValue = inputName.value;
	var regex = /^[a-zA-Z\d가-힣+#/\-\(\)\*@!éö.:π′]{1,10}$/; //현존하는 모든 언어
	
	if(!regex.test(inputNameValue)){
		alert("올바른 문장이 아닙니다.");
        event.preventDefault();	
	}
}

//언더라인
function underline(id){
	var target = document.querySelector("#"+id);
	
	
	
}
</script>

<style>
* {
 	font-family: 'NanumSquare', sans-serif;
	box-sizing: border-box;
}
	
.main{
	position: relative;
    width: 1000px;
    margin-left: 210px;
    padding-left: 30px;
    padding-top: 20px;
}



.border{			
	width: 100%;
	border: 2px solid #B8BAD4;
	padding-top: 15px;
	padding-left : 30px;
	padding-right : 30px;
}
.row{
	width:100%;
	margin-top: 30px;
	margin-bottom : 30px;
}
.rowInput{
	width: 80%;
	margin-top: 30px;
	margin-bottom : 30px;
}
.rowBtn{
	width: auto;
}
.text-center{
			text-align:center;
}
.text-left{
			text-align:left;
			}
.container{ 
	width:600px;
	margin-left:auto;
	margin-right:auto;
}
.form-input{
	width : 100%;
	padding : 1;
	margin-top: 10px;
	outline: none;
}

.form-input.form-input-underline {
	border:none;
	border-bottom: 2px solid #E2E3ED;
}
.form-input.form-input-underline:focus {
	border-bottom-color: #9A9EC2;		
}

.form-input.form-input-inline,
.form-btn.form-btn-inline {
	width:auto;
}

.selectbox{
    width: 220px; /* 원하는 너비설정 */
    padding: .25em .25em; /* 여백으로 높이 설정 */
/*     background: url('이미지 경로') no-repeat 95% 50%; */
    border: 1px solid #999;
    border-radius: 0px; 
/*     -webkit-appearance: none; /* 네이티브 외형 감추기 */ */
/*     -moz-appearance: none; */
/*     appearance: none; */
}

.form-btn {
	border:none;
	float: right;
}
.form-btn.form-btn-normal {
	background-color: #9A9EC2;
	font-size: 15px;
	color:white;
	padding : 5px 20px 5px 20px;
}
.text-center{
	text-align: center;
}
.hr{
	border: 0px;
	height:2px;
	background:#9A9EC2;
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


<!-- </head> -->
<!-- <body> -->
<div class="main">
	<div class="container border">
<h2 class="text-center">게시판관리</h2>
	<br><br><br>

		<div>
			<form action="createBoard.kh" method="get" onsubmit="checkNameSuper();">
				<div class = "row text-left">	
					<label for="superInput">상위게시판 등록</label>
						<input type="text" id="superInput"  class ="form-input form-input-underline" name="boardName"  required>
						<input type="text" name="boardSuperNo"  value=0  hidden>
						<input type="submit" class="form-btn form-btn-normal" value="등록">
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
						<input type="submit" class="form-btn form-btn-normal" value="등록">
				
				
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
					<option onclick="returnBoardInfo(<%=boardDtoSub.getBoardNo() %>, '<%=boardDtoSub.getBoardName() %>', 2);">
					<%=boardDtoSub.getBoardName() %>
					</option>
				<%} %>
				</select>
		<%} %>
	
	
	
	
	<form action="deleteBoard.kh" method="get"  class="inline" >
		<input type="text" class="boardNo"  name ="boardNo"  hidden>
		<input type="text" class="boardName" hidden required>
		<input type="submit" class="form-btn form-btn-normal"  value="삭제">
	</form>

<form action="editBoard.kh" method="get"  onsubmit="checkName();">
	<input type="text" class="boardNo"  name = "boardNo" hidden>
	<input type="text" class="boardName form-input form-input-underline"   name = "boardName" required>
	<input type="submit" class="form-btn form-btn-normal"  value="수정">
</form>

<br><br><br>


		</div>
	</div>
</div>
</body>
</html>