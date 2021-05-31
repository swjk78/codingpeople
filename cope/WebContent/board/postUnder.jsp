<%@page import="java.util.Date"%>
<%@page import="cope.beans.utils.DateUtils"%>
<%@page import="cope.beans.comments.CommentsViewDto"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.comments.CommentsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%String root= request.getContextPath(); %>
 
 <%		
 CommentsDao commentsDao = new  CommentsDao(); 
 %>
 
 <%
 //임시 세션속성
session.setAttribute("clientNo", 4); 
int clientNo = (int)session.getAttribute("clientNo");
 %>
 
 <%
 //임시 파라미터 속성
 int postNo = Integer.parseInt(request.getParameter("postNo"));
 %>
 
<%
 //임시 닉네임 불러오기
String clientNick = commentsDao.getNick(clientNo);
 %>
 
 <%
 //채택된 댓글 번호 불러오기
 int chooseNo = commentsDao.getChooseNo(postNo);
 %>
<!DOCTYPE html>
<html>
<head>

<script>
function ShowCommentsEditArea(targetNo){
	console.log(targetNo+"번글을 수정합니다");
	var originTarget = document.querySelector("#commentsOriginNo-"+targetNo);
	var editTarget = document.querySelector("#commentsEditNo-"+targetNo);
	console.log(editTarget);	
	originTarget.style.display="none";
	editTarget.style.display="block";
}

function copytextNew(){
	var targetDiv = document.querySelector(".commentsNewDiv");
	var targetDivVal = targetDiv.innerHTML;

	var targetTextarea =  document.querySelector(".commentsNewTextarea");
	targetTextarea.innerHTML=targetDivVal;
}

function copytextEdit(commentsNo){ 
	var inputDiv = document.querySelector(".commentsEditDiv-"+commentsNo);
	var inputDivVal = inputDiv.innerHTML;

	var inputTextarea =  document.querySelector(".commentsEditTextarea-"+commentsNo);
	inputTextarea.innerHTML=inputDivVal;
}
</script>



<style>
* {
	font-family: Neo Sans Pro , sans-serif;
	box-sizing: border-box;
}

.row {
	width:100%;
}

.inline{
	display: inline;
}

ul{
    display: block;
    list-style-type: none;
    margin-block-start: 0em;
    margin-block-end: 0em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 0px;
}
}
li{
	list-style: none;
} 

.comments{
	display : table;
	width:600px;
	border: 1px dotted black;
}

.comments .comments-title{
	background-color: #9A9EC2;
	padding: 5px;
}

.comments-blind{
	color: red;
}

.comments-choose{
	color: green;
}

.commentsNewBox{
	border:1px solid purple;
}
.commentsEditBox{
	border:1px solid red;
}

.commentsNew-border{
	border:1px solid purple;
}
.commentsEdit-border{
	border:1px solid red;
}

.commentsNewDiv{
	height:150px;
	overflow:auto;
	width:100%;
}

.commentsEditDiv{
	height:150px;
	overflow:auto;
	width:100%;
}

</style>


<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

-----------------------------------------
<br>

<div class="comments">
	<ul class="row">
		<li class="comments comments-title">댓글s</li>
	</ul>
	<ul>
	<%
		List<CommentsViewDto> commentsList = commentsDao.showList(postNo);
	%>
	
	<%for(CommentsViewDto commentsViewDto : commentsList){
		int commentsNo =commentsViewDto.getCommentsNo(); //너무 자주 쓰여서...  %>
			<%if(commentsNo==chooseNo){//채택된거라면%>
				<li id="commentsOriginNo-<%=commentsNo%>" class="comments comments-box comments-choose">	
			<%}else{ //그냥 댓글이라면%>
				<li id="commentsOriginNo-<%=commentsNo%>" class="comments comments-box">
			<%} %>
<!-- 					이미지가 들어갈 수 있겠죠			 -->
				<a href="<%=root %>/client/profile.jsp?clientNo=<%=commentsNo %>"><%=commentsViewDto.getClientNick() %></a><br>
				
				
				<%DateUtils dateUtils = new DateUtils();
				boolean isToday = dateUtils.isToday(commentsViewDto.getCommentsDate())==true;
				%>
				<%if(isToday){%>
				<span>(오늘)<%=commentsViewDto.getCommentsDateToday() %></span>
				<%}else{ %>
				<span><%=commentsViewDto.getCommentsDate()%></span><br>
				<%} System.out.println(commentsViewDto.getCommentsBlind());%>
				
		
				<%if(commentsViewDto.getCommentsBlind().equals("T")){ //블라인드 글이라면 수정, 삭제도 나오지 않는다.%>
					<p id="commentsOriginNo-<%=commentsNo%>" class="comments comments-box comments-blind">(블라인드된 댓글입니다.)</p>
				<%}else{//블라인드가 아니면 수정, 삭제가 나온다.%>
					<p><%=commentsViewDto.getCommentsContents() %></p>
					<%if(clientNo==commentsViewDto.getCommentsClientNo()){//본인이 작성한 댓글이라면 %>
						<input type="button" value="수정" onclick="ShowCommentsEditArea(<%=commentsViewDto.getCommentsNo()%>);">
					<%} %>
						<%if(clientNo==commentsViewDto.getCommentsClientNo() || clientNo==1){//본인이 작성한 댓글이라면 || 관리자가 로그인했다면 %>		
						<form action="commentsDelete.kh" method="get">
							<input type="text"  name="commentsNo" value="<%=commentsViewDto.getCommentsNo()%>" hidden>
							<input type="text"  name="postNo" value="<%=postNo%>" hidden>
							<input type="submit" value="삭제">
						</form>
						<%} %>
						<%if(!commentsDao.isChoose(postNo)){//아직 채택이 되지 않은 게시글이면서
							if(clientNo==commentsDao.getPostWriter(postNo) && clientNo!=commentsViewDto.getCommentsClientNo()){//게시글 작성자 본인댓글이 아닌 경우 %> 
							<form action="commentsChoose.kh" method="get">
								<input type="text"  name="commentsNo" value="<%=commentsViewDto.getCommentsNo()%>" hidden>
								<input type="text"  name="postNo" value="<%=postNo%>" hidden>
								<input type="submit" value="채택">
							</form>
						<%} %>
					<%} %>
				<%} %>
				
				<%if(clientNo==1){ // 작성자라면 %> 
					<form action="commentsBlind.kh" method="get">
						<input type="text"  name="commentsNo" value="<%=commentsViewDto.getCommentsNo()%>" hidden>
						<input type="text"  name="postNo" value="<%=postNo%>" hidden>
						<input type="text"  name="commentsBlind" value="<%=commentsViewDto.getCommentsBlind()%>" hidden>
						<input type="submit" value="블라인드/언블라인드">
					</form>
				<%} %>		

<!-- 			댓글 수정창 -->
		<li id="commentsEditNo-<%=commentsViewDto.getCommentsNo()%>" class=""  style="display:none">
			<div class="commentsEditBox">
				<div class="writer-info">
					<%=clientNick %>
				</div>
				<div class="commentsEdit-border">
					<form action="commentsForm.kh" method="post">
						<input type="text"  name=commentsNo value=<%=commentsViewDto.getCommentsNo()%> hidden>
						<input type="text"  name=isNew value="F" hidden>
						<div class="commentsEditDiv commentsEditDiv-<%=commentsViewDto.getCommentsNo()%>" contenteditable="true"  oninput="copytextEdit(<%=commentsViewDto.getCommentsNo()%>);"></div>
						<input type="submit" value="수정">
						<textarea class="commentsEditTextarea commentsEditTextarea-<%=commentsViewDto.getCommentsNo()%>" name="commentsContents"  hidden></textarea>
					</form>
				</div>
			</div>
		</li>
	<%}//반복분의 끝 %>
	</ul>

	<br><br>
	
<!-- 					이미지가 들어갈 수 있겠죠			 -->
	--댓글입력창--
	<%if(clientNo>0){ %>
		<div class="commentsNewBox">
			<div class="writer-info">
				<%=clientNick %>
			</div>
			<div class="commentsNew-border">
				<form action="commentsForm.kh" method="post">
					<input type="text"  name=commentsPostNo value=<%=postNo %> hidden>
					<input type="text"  name=isNew value="T" hidden>
					<div class="commentsNewDiv" contenteditable="true"  oninput="copytextNew();"></div>
					<input type="submit" value="작성">
					<textarea class="commentsNewTextarea" name="commentsContents"  hidden></textarea>
				</form>
			</div>
		</div>
		<%} %>
				
<br>
<br>
<br>
	


</body>
</html>