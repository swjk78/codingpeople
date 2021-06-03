<%@page import="cope.beans.utils.DateUtils"%>
<%@page import="cope.beans.comments.CommentsDao"%>
<%@page import="cope.beans.comments.CommentsViewDto"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.post.PostDto"%>
<%@page import="cope.beans.client.ClientDto"%>
<%@page import="cope.beans.client.ClientDao"%>
<%@page import="cope.beans.post.PostDao"%>
<%@page import="cope.beans.board.BoardDao"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%
	// +기호를 파라미터로 인식할 수 있게 처리
// 	String boardGroupName;
// 	int valueLen = 15;
// 	if (request.getQueryString().substring(valueLen).contains("+")) {
// 		boardGroupName = request.getQueryString().substring(valueLen);
// 		int separator = boardGroupName.indexOf("&");
// 		boardGroupName = boardGroupName.substring(0, separator);
// 	}
// 	else {
// 		boardGroupName = request.getParameter("boardGroupName");
// 	}

	BoardDao boardDao = new BoardDao();
	int boardGroup = Integer.parseInt(request.getParameter("boardGroup"));
	request.getSession().setAttribute("boardGroup", boardGroup);
	String boardGroupName = boardDao.findBoardName(boardGroup);
	
	int postNo = Integer.parseInt(request.getParameter("postNo"));
	PostDao postDao = new PostDao();
	postDao.increaseViewCount(postNo);
	PostDto postDto = postDao.find(postNo);
	
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.myInfo(postDto.getPostClientNo());
	
	//석현
	String root= request.getContextPath();
	boolean isLogin;
	boolean isSuper= false;
	int clientNo= 0;
	String loginNick =null;
	if(session.getAttribute("clientNo")!=null){//로그인을 했다면
		isLogin = true;
		clientNo = (int)session.getAttribute("clientNo");	
		isSuper= clientDao.isSuper(clientNo);
		loginNick = clientDao.myInfo(clientNo).getClientNick();
	}
	else{
		isLogin = false;
	}
	
	
	CommentsDao commentsDao = new CommentsDao();
	DateUtils dateUtils = new DateUtils();
	
	 //채택된 댓글 번호 불러오기
	 int chooseNo = commentsDao.getChooseNo(postNo);
	List<CommentsViewDto> commentsList = commentsDao.showList(postNo);
%>

<%-- <jsp:include page="/template/aside.jsp"></jsp:include> --%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">

<!-- 임시 테두리 -->
<style>
	main,
	header,
	nav,
	section,
	article,
	aside,
	footer,
	div,
	span,
	p,
	label {
	    border: 1px dotted lightgray;
	}
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title></title>

<script>
	window.addEventListener('load', function() {
		document.querySelector('.delete-btn').addEventListener('click', function(e) {
			var check = confirm('정말 삭제하시겠습니까?');
			if (!check) {
				e.preventDefault();
			}
		});
	});
</script>

<script>
//댓글관련 기능
function ShowCommentsEditArea(targetNo){
	console.log(targetNo+"번글을 수정합니다");
	var originDiv = document.querySelector("#commentsOriginNo-"+targetNo);
	var editDiv = document.querySelector("#commentsEditNo-"+targetNo);
	console.log(editDiv);	
	originDiv.style.display="none";
	editDiv.style.display="block";
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

</head>
<body>
<div class="container-900">
	<div class="row text-left">
		<h2><a href="<%=request.getContextPath()%>/board/postListTest.jsp?boardGroup=<%=boardGroup%>">
	<%=boardGroupName%></a></h2>
	</div>
	<div class="row text-left">
		<a href="<%=request.getContextPath()%>/board/postListTest.jsp?boardGroup=<%=boardGroup%>
				&boardNo=<%=postDto.getPostBoardNo()%>">
				<%=boardDao.findBoardName(postDto.getPostBoardNo())%>
		</a>
	</div>
	<div class="row text-left">
		<%=postDto.getPostTitle()%>
	</div>
	<div class="row float-container">
		<div class="left">
			<%=clientDto.getClientNick()%>
		</div>
		<div class="right">
			조회수 <%=postDto.getPostViewCount()%>
			좋아요 <%=postDto.getPostLikeCount()%>
		</div>		
		<div class="right">
			<%=postDto.getPostDateString()%>
		</div>
		<div class="row text-left" style="min-height:300px;">
			<pre><%=postDto.getPostContents()%></pre>
		</div>
	</div>
	
	<!-- 댓글 영역 시작 -->

	
<div class="comments-area">

	<div class="comments-area comments-area-title">
		<h5 class="comments comments-title">댓글</h5>
	</div>
	
	<div class=comments-view>
	<%for(CommentsViewDto commentsViewDto : commentsList){
		int commentsNo =commentsViewDto.getCommentsNo(); // 자주 쓰여서 변수로 담아 둡니다.%>

			<!-- 			각 댓글을 감싸고 있는 div는 서로 다른 id를 지니게 합니다.  -->
				<div id="commentsOriginNo-<%=commentsNo%>" class="comments comments-box">

					<div class=writer-info>
						<!-- 			이미지 -->
					<a href="<%=root %>/client/profile.jsp?otherNo=<%=commentsNo %>"><%=commentsViewDto.getClientNick() %></a><br>
					</div>
					
					<div class=write-time>
						<%boolean isToday = dateUtils.isToday(commentsViewDto.getCommentsDate())==true;%>
						<%if(!isToday){ //왜 반대로 해야 제대로 될까요%>
						<span>(오늘)<%=commentsViewDto.getCommentsDateToday() %></span>
						<%}else{//오늘이 아닌 것%>
						<span><%=commentsViewDto.getCommentsDate()%></span><br>
						<%}%>
					</div>
					
					<div class="writen-contents">
						<%if(commentsViewDto.getCommentsBlind().equals("F")){ //깨끗한 글%>
						<div><%=commentsViewDto.getCommentsContents() %></div>
						<%}else{//블라인드가 T라면%>
						<div class=blind-contents>(블라인드된 댓글입니다.)</div>
						<%} %>
						
					</div>
					
					<%if(isLogin){//로그인이어야 버튼들을 보여줍니다. %>					
					<div class="btn-area">
						
<!-- 						//본인작성글이라면 수정이 보이게 -->
						<%if(clientNo==commentsViewDto.getCommentsClientNo()){%>
						<input type="button" value="수정" onclick="ShowCommentsEditArea(<%=commentsViewDto.getCommentsNo()%>);">
						<%} %>
						
<!-- 						//본인이 작성한 댓글이거나 || 관리자라면 삭제가 보이게 -->
						<%if(clientNo==commentsViewDto.getCommentsClientNo() || isSuper){%>		
							<form action="commentsDelete.kh" method="get">
								<input type="text"  name="commentsNo" value="<%=commentsViewDto.getCommentsNo()%>" hidden>
								<input type="text"  name="boardGroup" value=<%=boardGroup %> hidden>
								<input type="text"  name="postNo" value="<%=postNo%>" hidden>
								<input type="submit" value="삭제">
							</form>
						<%} %>
							
<!-- 						//채택된 글이 아니고 && 로그인한 사람이 원본글작성자이고 && 본인이 쓴 댓글이 아닐때 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ-->
						<%if(!commentsDao.isChoose(postNo) && clientNo==commentsDao.getPostWriter(postNo) && clientNo!=commentsViewDto.getCommentsClientNo()){%> 
							<form action="commentsChoose.kh" method="get">
								<input type="text"  name="commentsNo" value="<%=commentsViewDto.getCommentsNo()%>" hidden>
								<input type="text"  name="boardGroup" value=<%=boardGroup %> hidden>
								<input type="text"  name="postNo" value="<%=postNo%>" hidden>
								<input type="submit" value="채택">
							</form>
						<%} %>
						
<!-- 						//관리자라면 블라인드버튼이 보이게-->
						<%if(clientNo==1){ // 작성자라면 %> 
							<form action="commentsBlind.kh" method="get">
								<input type="text"  name="commentsNo" value="<%=commentsViewDto.getCommentsNo()%>" hidden>
								<input type="text"  name="postNo" value="<%=postNo%>" hidden>
								<input type="text"  name="boardGroup" value=<%=boardGroup %> hidden>
								<input type="text"  name="commentsBlind" value="<%=commentsViewDto.getCommentsBlind()%>" hidden>
								<input type="submit" value="블라인드/언블라인드">
							</form>
						<%} %>					
					</div><!-- 	버튼 영역끝 -->
					<%}else{//로그인이 아니면 %>
<!-- 					아무 버튼도 안보인다. -->
					<%} %>
				</div> <!-- 각 댓글의 마지막 -->
				<!-- 	댓글 수정창 -->
				
				<div id="commentsEditNo-<%=commentsViewDto.getCommentsNo()%>" style="display:none">
					<div class="commentsEditBox">
						<div class="writer-info">
						<%=commentsViewDto.getClientNick() %>
						</div>
						<div class="edit-comment">
							<form action="commentsForm.kh" method="post">
								<input type="text"  name=commentsNo value=<%=commentsViewDto.getCommentsNo()%> hidden>
								<input type="text"  name="boardGroup" value=<%=boardGroup %> hidden>
								<input type="text"  name="postNo" value="<%=postNo%>" hidden>
								<input type="text"  name=isNew value="F" hidden>
								<div class="commentsEditDiv commentsEditDiv-<%=commentsViewDto.getCommentsNo()%>" contenteditable="true"  oninput="copytextEdit(<%=commentsViewDto.getCommentsNo()%>);"></div>
								<textarea class="commentsEditTextarea commentsEditTextarea-<%=commentsViewDto.getCommentsNo()%>" name="commentsContents"  hidden></textarea>
								<input type="submit" value="수정">
							</form>
						</div>
					</div>
				</div>
				
				
				
				
				
		<%} %><!-- 	반복문의 끝... -->
		</div>
</div>
<!-- 코멘트s 에어리어 끝 -->

			
	




				
				
				


</div>
<!-- 댓글 에어리어 끝				 -->
<br><br>
	-
	<%if(clientNo>0){ %>
		<div class="commentsWriteBox">
			<div class="writer-info">
			<%=loginNick %>
			</div>
			<div class="commentsNew-border">
				<form action="commentsForm.kh" method="post">
					<input type="text"  name=postNo value=<%=postNo %> hidden>
					<input type="text"  name=boardGroup value=<%=boardGroup %> hidden>
					<input type="text"  name=isNew value="T" hidden>
					<div class="commentsNewDiv" contenteditable="true"  oninput="copytextNew();"></div>
					<input type="submit" value="작성">
					<textarea class="commentsNewTextarea" name="commentsContents"  hidden></textarea>
				</form>
			</div>
		</div>
		<%} %>

	
	
	<!-- 댓글영역 끝 -->

	<!-- 버튼 영역 -->
	<div class="row text-right">
		<a href="postForm.jsp?boardGroup=<%=boardGroup%>&postNo=<%=postNo%>" class="link-btn">수정</a>
		<a href="postDelete.kh?boardGroup=<%=boardGroup%>&postNo=<%=postNo%>" class="link-btn delete-btn">삭제</a>
		<a href="postForm.jsp?boardGroup=<%=boardGroup%>&write" class="link-btn">글쓰기</a>
		<a href="postListTest.jsp?boardGroup=<%=boardGroup%>" class="link-btn">목록</a>
	</div>
	
<!-- 	<div class="row text-left"> -->
<!-- 		다음글 :  -->
<%-- 		<% if (nextPostDto == null) {%> --%>
<!-- 		다음글이 없습니다. -->
<%-- 		<% } else {%> --%>
<%-- 		<a href="postDetail.jsp?postNo=<%=nextPostDto.getPostNo()%>"> --%>
<%-- 			<%=nextPostDto.getPostTitle()%> --%>
<!-- 		</a> -->
<%-- 		<% }%> --%>
<!-- 	</div> -->
<!-- 	<div class="row text-left"> -->
<!-- 		이전글 :  -->
<%-- 		<% if (prevPostDto == null) {%> --%>
<!-- 		이전글이 없습니다. -->
<%-- 		<% } else {%> --%>
<%-- 		<a href="postDetail.jsp?postNo=<%=prevPostDto.getPostNo()%>"> --%>
<%-- 			<%=prevPostDto.getPostTitle()%> --%>
<!-- 		</a> -->
<%-- 		<% }%> --%>
<!-- 	</div> -->
</div>
</body>
</html>
