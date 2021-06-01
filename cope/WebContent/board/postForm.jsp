<%@page import="cope.beans.board.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/template/aside.jsp"></jsp:include>
<html>
<link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/join.css">
		<head>
		<meta charset="UTF-8">
			<title>게시판 작성/수정</title>
			
			<style>
			.display-inline-block{
			border : solid black;
		   display:inline-block;
		   margin-left: auto;
		   margin-right: auto;		   
		   width : auto%;

			}
			
		   .layout{
		   padding : 100px;
			width:auto;
			hegith:auto;	
			}
			
			.box-contents{
			width : 1000px;
			height : 500px;
			}
			
			.box-title{
			width : 1000px;
			height : 25px;
			}
			
			.boardSubList, .fail{
	display: none;
}
			
			
			</style>

		</head>
		
<%
 BoardDao boardDao = new  BoardDao();
 List<BoardDto>boardSuperList = boardDao.showListBoardSuper();
 int countSuper = boardDao.countBoardSuper();
 %>
 <script>
 function showSubBoard(boardNo){
		
		var allBoardSub = document.querySelectorAll(".boardSubList");
		for(var i=0; i < allBoardSub.length; i++){
			allBoardSub[i].style.display="none";
		}
		
		var toShowSubBoard = document.querySelector("#boardSubList"+boardNo);
		toShowSubBoard.style.display="inline-block";
	}
 

</script>
		
		<div class = "display-inline-block text-center">
		<h3>글 작성하기</h3>
		<hr>

			<div class = display-inline-block>
	<form action = "postForm.kh" method = "post" class = layout>
				<label>작성 게시판</label>
	<select id="boardSuperList" size="<%=countSuper+1 %>" name="boardNo"  class="inline">
		<option>(상위게시판)</option>
		<%for(BoardDto boardDtoSuper : boardSuperList){ %>
			<option onclick="showSubBoard(<%=boardDtoSuper.getBoardNo()%>);">
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

			<div>
			<textarea id = postTitle placeholder = "제목을 입력하세요" class = box-title></textarea>
			</div>
			<div>
					<textarea id = postContents placeholder = "내용을 입력하세요" class = box-contents></textarea>
			</div>
			<input  type ="submit" value = "작성완료 " id ="submit">
	</form> 
</div>
</div>
</html>

<jsp:include page="/template/footer.jsp"></jsp:include>