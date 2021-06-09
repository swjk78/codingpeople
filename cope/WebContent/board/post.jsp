<%@page import="cope.beans.post.PostCodeDto"%>
<%@page import="cope.beans.post.PostCodeDao"%>
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
	BoardDao boardDao = new BoardDao();
	int boardGroup = Integer.parseInt(request.getParameter("boardGroup"));
	String boardGroupName = boardDao.findBoardName(boardGroup);
	
	int postNo = Integer.parseInt(request.getParameter("postNo"));
	PostDao postDao = new PostDao();
	postDao.increaseViewCount(postNo);
	PostDto postDto = postDao.find(postNo);
	
	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.myInfo(postDto.getPostClientNo());
	
	// 이전글, 다음글 불러오기
	PostDto prevPostDto = postDao.getPrevious(boardGroup, postNo);
	PostDto nextPostDto = postDao.getNext(boardGroup, postNo);
	
	
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
	
	//프로필 사진 띄우는 구문
	String clientId = clientDto.getClientId(); //구문이 위에 다 준비 되어 있더군요
	char ch =  clientId.charAt(0);
	int no = (int)ch;
		
	int seed = 216823123;
	int randomInt= (seed/no)%1000000;
	
	//gist를 가져올 도구들
	PostCodeDao postCodeDao = new PostCodeDao();
	PostCodeDto postCodeDto = new PostCodeDto();
%>

<jsp:include page="/template/aside.jsp"></jsp:include>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/post.css">

<style>
	.imgRound {
	background-color: white;
	border: 1.5px solid #ffffff;
	border-radius: 50%;
	padding: 5px;
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<script>
	window.addEventListener('load', function() {
		// 중복 추천 방지
		if (<%=request.getParameter("alreadyLike") != null%>) {
			alert('이미 추천하셨습니다');
			history.replaceState({}, null, location.pathname);
		}
		
		// 삭제 버튼 클릭 시 경고창
		var deleteBtn = document.querySelectorAll('.btn-delete');
		for (var i = 0; i < deleteBtn.length; i++) {
			deleteBtn[i].addEventListener('click', function(e) {
				var check = confirm('정말 삭제하시겠습니까?');
				if (!check) {
					e.preventDefault();
				}
			});
		}
		
		// 비로그인 상태에서 추천 불가 경고창
		document.querySelector('.btn-like').addEventListener('click', function(e) {
			if (<%=!isLogin%>) {
				alert('비회원은 추천이 불가합니다.');
				e.preventDefault();
			}
		});
	});
</script>

<script>
	//댓글관련 기능
	function ShowCommentsEditArea(targetNo){
		var originDiv = document.querySelector("#commentsOriginNo-"+targetNo);
		var editDiv = document.querySelector("#commentsEditNo-"+targetNo);
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
<div class ="float-left padding-left-inter">
<!-- 게시글영역 -->
<div class="container-900 border">
	<div class="side-top text-left boardName-div">
		<a class="boardSuperName" href="<%=request.getContextPath()%>/board/postList.jsp?boardGroup=<%=boardGroup%>">
		<%=boardGroupName%></a>
		<span class="dir-sign"> > </span>
		<a class="boardSubName" href="<%=request.getContextPath()%>/board/postList.jsp?boardGroup=<%=boardGroup%>
		&boardNo=<%=postDto.getPostBoardNo()%>">(<%=boardDao.findBoardName(postDto.getPostBoardNo())%>)
		</a>

	</div>
	
	<div class="row text-left post-title-div margin-side-auto" >
		<%if (postDto.getPostBlind() == 'F') {%>
		<div class="post-title-area">
			<table class="post-title-box">
				<tr>
					<td>
						<span class=post-title><%=postDto.getPostTitle()%></span>
					</td>
				</tr>
			</table>
		</div>
		<%} else {%>
			<p class="blind-text">(블라인드된 게시글입니다.)</p>
		<%} %>
	</div>
	
	<div class="float-container etc-left-div">
		<table class="mini-profile-table writer-info post-writer left">
			<tr>
				<td rowspan="2">
					<img class="profile-img imgRound" src="https://dummyimage.com/35/<%=randomInt %>/ffffff&text=<%=ch %>" >		 	
				</td>
				<td>
					<a class="writer-name" href="<%=root%>/client/profile.jsp?clientNo=<%=postDto.getPostClientNo()%>">
					<%=clientDto.getClientNick()%></a>
				</td>
			</tr>
			<tr>
				<td>
					<div class=post-time><%=postDto.getPostDateString()%></div>
				</td>
			</tr>
		</table>

	<div class="float-container etc-right-div">
		<table class="post-info-table right">
			<tbody>
				<tr>
					<td><div class="right like-count">추천수 <%=postDto.getPostLikeCount()%></div></td>
					<td><div class="right read-count">조회수 <%=postDto.getPostViewCount()%></div></td>
				</tr>
			</tbody>
		</table>
	</div>
		
	</div>
		<div class="row text-left post-content" style="min-height:300px;">
			<%if (postDto.getPostBlind() == 'F') {%>
				<pre class="post-content word-break dd-border"><%=postDto.getPostContents()%></pre>
				
				<!-- 				깃허브지스트를 넣을 부분 -->
				<%if(postCodeDao.isExist(postNo)){//지스트URL이 있다면 %>
				<div class="github-gist-div">
					<div><p class=gist-title>작성자의 GithubGist</p>
							<%String url = postCodeDao.getToInput(postNo); %>
							<%=url%>
					</div>
				</div>
				<%} %>
				<!-- 				깃허브지스트 끝 -->

			<%} else {%>
				<pre class="blind-text">(블라인드된 게시글입니다.)</pre>
			<%} %>
		<div class="row text-center">
		<%if(isSuper){//관리자만 블라인드 버튼 %>
			<a href="<%=root%>/manage/postBlind.kh?boardGroup=<%=boardGroup%>
			&clientBlind=<%=postDto.getPostBlind()%>
			&postNo=<%=postNo%>" class="form-btn form-btn-normal blind-btn">블라인드</a>
		<%} %>
		<a href="postLike.kh?boardGroup=<%=boardGroup%>&postNo=<%=postNo%>"
		class="form-btn form-btn-normal btn-liketext-center">추천</a>
		</div>
</div>
<!-- 	게시글 영역 끝 -->

<!-- 버튼 영역 -->
	<div class="container-850 post-btn-area">
		<div class="row text-right">
		<!-- 	로그인한 사람이 원본글작성자일때-->
			<%if(clientNo==postDto.getPostClientNo()){%> 
			<a class="form-btn form-btn-normal" href="postForm.jsp?boardGroup=<%=boardGroup%>&postNo=<%=postNo%>">수정</a>
			<a class="form-btn form-btn-normal btn-delete" href="postDelete.kh?boardGroup=<%=boardGroup%>&postNo=<%=postNo%>">삭제</a>
			<%} %>
			<%if (isLogin) {%>
			<a class="form-btn form-btn-normal" href="postForm.jsp?boardGroup=<%=boardGroup%>&write">글쓰기</a>
			<%} %>
			<a class="form-btn form-btn-normal" href="postList.jsp?boardGroup=<%=boardGroup%>">목록</a>
		</div>
	</div>
<!-- 버튼영역 끝 -->


<!-- 댓글 영역 시작 -->	
<div class="comments-title-area">
	<p class="comments-title-area text">댓글</p>
</div>
	
<div class="comments-area container-850 border-comments">
	<div class=comments-view>
	<%for(CommentsViewDto commentsViewDto : commentsList){
		int commentsNo =commentsViewDto.getCommentsNo(); // 자주 쓰여서 변수로 담아 둡니다.%>

			<!-- 			각 댓글을 감싸고 있는 div는 서로 다른 id를 지니게 합니다.  -->
								<div class=writer-info>
						<table class="mini-profile-table writer-info left">
							<tr>
								<td rowspan="2">
									<img class="profile-img imgRound" src="https://dummyimage.com/35/<%=randomInt %>/ffffff&text=<%=ch %>" >		 	
								</td>
								<td>
									<a href="<%=root %>/client/profile.jsp?clientNo=<%=commentsViewDto.getCommentsClientNo()%>"class= "writer-info"><%=commentsViewDto.getClientNick() %></a><br>
								</td>
							</tr>
							<tr>
								<td>
									<%boolean isToday = dateUtils.isToday(commentsViewDto.getCommentsDate())==true;%>
										<%if(!isToday){ //왜 반대로 해야 제대로 될까요%>
										<div class=post-time>(오늘)<%=commentsViewDto.getCommentsDateToday()%></div>
										<%}else{//오늘이 아닌 것%>
										<div class=post-time><%=commentsViewDto.getCommentsDateString()%></div>
									<%}%>	
								</td>
							</tr>
						</table>
						
					</div>
				<div id="commentsOriginNo-<%=commentsNo%>" class="comments comments-box comments-box-border">
					<%
					//공교롭게도... 다시 "randomInt"를 뽑아내야하는... 이름이 길으니 구분은 잘 갈겁니다.
					ClientDto clientDtoUsingOnlyGetNick = clientDao.myInfo(commentsViewDto.getCommentsClientNo());
					clientId = clientDtoUsingOnlyGetNick.getClientId(); 
					ch =  clientId.charAt(0);
					no = (int)ch; //재정의
						
					seed = 216823123;
					randomInt= (seed/no)%1000000; //재정의
					 %>

					
					
					<div class="form-comments float-container border margin-top-0">
						<%if(commentsViewDto.getCommentsBlind().equals("F")){ //깨끗한 글%>
						<div class="left"><%=commentsViewDto.getCommentsContents() %></div>
							<%if(commentsNo==chooseNo){%>
								<img class="right right-75px" src="<%=root %>/image/choose.png" width="125">
							 <%}%>
						<%}else{//블라인드가 T라면%>
						<div class=blind-text>(블라인드된 댓글입니다.)</div>
						<%} %>				
					</div>
					
					<%if(isLogin){//로그인이어야 버튼들을 보여줍니다. %>					
					<div class="btn-area text-right">
						
<!-- 						//본인작성글이라면 수정이 보이게 -->
						<%if(clientNo==commentsViewDto.getCommentsClientNo()){%>
						<input class="form-btn form-btn-normal"  type="button" value="수정" onclick="ShowCommentsEditArea(<%=commentsViewDto.getCommentsNo()%>);">
						<%} %>
						
<!-- 						//본인이 작성한 댓글이면 삭제가 보이게 -->
						<%if(clientNo==commentsViewDto.getCommentsClientNo()){%>		
							<form action="commentsDelete.kh" method="get">
								<input type="hidden" name="commentsNo" value="<%=commentsViewDto.getCommentsNo()%>">
								<input type="hidden" name="boardGroup" value="<%=boardGroup %>">
								<input type="hidden" name="postNo" value="<%=postNo%>">
								<input class="form-btn form-btn-normal btn-delete" type="submit" value="삭제">
							</form>
						<%} %>
							
<!-- 						//채택된 글이 아니고 && 로그인한 사람이 원본글작성자이고 && 본인이 쓴 댓글이 아닐때 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ-->
						<%if(!commentsDao.isChoose(postNo) && clientNo==postDto.getPostClientNo() && clientNo!=commentsViewDto.getCommentsClientNo()){%> 
							<form action="commentsChoose.kh" method="get">
								<input type="hidden" name="commentsNo" value="<%=commentsViewDto.getCommentsNo()%>">
								<input type="hidden" name="boardGroup" value="<%=boardGroup %>">
								<input type="hidden" name="postNo" value="<%=postNo%>">
								<input class="form-btn form-btn-normal" type="submit" value="채택">
							</form>
						<%} %>
						
<!-- 						//관리자라면 블라인드버튼이 보이게-->
						<%if(clientNo==1){ // 작성자라면 %> 
							<form action="commentsBlind.kh" method="get">
								<input type="hidden" name="commentsNo" value="<%=commentsViewDto.getCommentsNo()%>">
								<input type="hidden" name="postNo" value="<%=postNo%>">
								<input type="hidden" name="boardGroup" value="<%=boardGroup %>">
								<input type="hidden" name="commentsBlind" value="<%=commentsViewDto.getCommentsBlind()%>">
								<input class="form-btn form-btn-normal" type="submit" value="블라인드/언블라인드">
							</form>
						<%} %>					
					</div><!-- 	버튼 영역끝 -->
					<%}else{//로그인이 아니면 %>
<!-- 					아무 버튼도 안보인다. -->
					<%} %>
				</div> <!-- 각 댓글의 마지막 -->
				<!-- 	댓글 수정창 -->
				<div id="commentsEditNo-<%=commentsViewDto.getCommentsNo()%>" class="comments-box comments-box-border display-none">
					<div class="commentsEditBox">
					<table class="mini-profile-table left writer-info">
						<tr>
							<td>
								<img class="profile-img imgRound" src="https://dummyimage.com/35/<%=randomInt %>/ffffff&text=<%=ch %>" >		 	
							</td>
							<td>
								<a class="writer-name" href="<%=root%>/client/profile.jsp?clientNo=<%=commentsViewDto.getCommentsClientNo()%>">
								<%=loginNick%></a>
							</td>
						</tr>
						<tr>
						</tr>					
					</table>
					<div class="commentsEdit-border">
						<form action="commentsForm.kh" method="post">
							<input type="hidden"  name=commentsNo value=<%=commentsViewDto.getCommentsNo()%>>
							<input type="hidden"  name="boardGroup" value=<%=boardGroup %>>
							<input type="hidden"  name="postNo" value="<%=postNo%>">
							<input type="hidden"  name=isNew value="F">
							<textarea class="commentsEditDiv form-comments commentsEditTextarea dd-border form-comments-textarea commentsEditTextarea-<%=commentsViewDto.getCommentsNo()%>"  style="width:100%;" 
							name="commentsContents" ><%=commentsViewDto.getCommentsContents() %></textarea>

							<input class="form-btn form-btn-normal"  type="submit" value="수정">
						</form>
					</div>
				</div>
			</div>

		<%} %><!-- 	반복문의 끝... -->
		</div>
	</div>
<!-- 코멘트s 에어리어 끝 -->

<!-- 댓글 에어리어 끝				 -->

<!-- 버튼 영역 -->
	<div class="container-850 post-btn-area">
		<div class="row text-right">
		<!-- 	로그인한 사람이 원본글작성자일때-->
			<%if(clientNo==postDto.getPostClientNo()){%> 
			<a class="form-btn form-btn-normal" href="postForm.jsp?boardGroup=<%=boardGroup%>&postNo=<%=postNo%>">수정</a>
			<a class="form-btn form-btn-normal btn-delete" href="postDelete.kh?boardGroup=<%=boardGroup%>&postNo=<%=postNo%>">삭제</a>
			<%} %>
			<%if (isLogin) {%>
			<a class="form-btn form-btn-normal" href="postForm.jsp?boardGroup=<%=boardGroup%>&write">글쓰기</a>
			<%} %>
			<a class="form-btn form-btn-normal" href="postList.jsp?boardGroup=<%=boardGroup%>">목록</a>
		</div>
	</div>
<!-- 버튼영역 끝 -->

<br>

<!-- 댓글 작성 -->
	<%if(isLogin){ %>
		<div class="comments-title-area">
			<p class="comments-title-area text">새 댓글 작성</p>
		</div>

		<div class="comments-write container-850 border">

		<div class="commentsWriteBox">
			<table class="mini-profile-table left writer-info">
				<%
				//또 다시
				ClientDto clientDtoGettingLoginNick = clientDao.myInfo(clientNo);
				clientId = clientDtoGettingLoginNick.getClientId(); 
				ch =  clientId.charAt(0);
				no = (int)ch; //재정의
					
				seed = 216823123;
				randomInt= (seed/no)%1000000; //재정의
				 %>
				<tr>
					<td>
						<img class="profile-img imgRound" src="https://dummyimage.com/35/<%=randomInt %>/ffffff&text=<%=ch %>" >		 	
					</td>
					<td>
						<a class="writer-name" href="<%=root%>/client/profile.jsp?clientNo=<%=clientNo%>">
						<%=loginNick%></a>
					</td>
				</tr>
				<tr>
				</tr>
			</table>
			<div class="commentsNew-border">
				<form action="commentsForm.kh" method="post">
					<input type="hidden"  name=postNo value=<%=postNo %>>
					<input type="hidden"  name=boardGroup value=<%=boardGroup %>>
					<input type="hidden"  name=isNew value="T">
					<textarea class="form-comments commentsNewDiv border form-comments-textarea"  style="width:100%;"name="commentsContents" ></textarea>
					<input class="form-btn form-btn-normal"  type="submit" value="작성">
				</form>
			</div>
		</div>
<%} %>
	</div>
	<!-- 댓글작성끝-->
	
	<!-- 이전글/다음글 영역 -->
	<div class="move-side-div">
		<div class="move-side row text-left">
			다음글 : 
			<% if (nextPostDto == null) {%>
			다음글이 없습니다.
			<% } else {%>
			<a href="post.jsp?boardGroup=<%=boardGroup%>&postNo=<%=nextPostDto.getPostNo()%>">
				<%=nextPostDto.getPostTitle()%>
			</a>
			<% }%>
		</div>
		<div class="move-side row text-left">
			이전글 : 
			<% if (prevPostDto == null) {%>
			이전글이 없습니다.
			<% } else {%>
			<a href="post.jsp?boardGroup=<%=boardGroup%>&postNo=<%=prevPostDto.getPostNo()%>">
				<%=prevPostDto.getPostTitle()%>
			</a>
			<% }%>
		</div>	
	</div>
</div>
</div>
	<!-- 이전글/다음글 영역 끝 -->
</body>
</html>
<jsp:include page="/template/footer.jsp"></jsp:include>