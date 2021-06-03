<%@page import="cope.beans.utils.DateUtils"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.board.PostListDao"%>
<%@page import="cope.beans.board.PostListDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/common.css">
<%
	request.setCharacterEncoding("UTF-8");
	DateUtils dateUtils = new DateUtils();
	

	int clientNo = (int)request.getSession().getAttribute("clientNo");
	
	int pageNo;
	try{
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
		if(pageNo<0){
			throw new Exception();
		}
	}
	catch(Exception e){
		pageNo=1;
	}
	
	int pageSize;
	try{
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
		if(pageSize < 10){
			throw new Exception();
		}
	}
	catch(Exception e){
		pageSize = 10;
	}
	
	int startRow = pageNo*pageSize-(pageSize-1);
	int endRow = pageNo*pageSize;
	
	PostListDao postListDao = new PostListDao();
	List<PostListDto> myLike = postListDao.myLike(clientNo, startRow, endRow);
	
	int count = postListDao.getCount(clientNo);
	
	int blockSize = 5;
	int startBlock = (pageNo-1)/blockSize*blockSize+1;
	int endBlock = startBlock + blockSize - 1;
	int lastBlock = (count-1)/pageSize+1;
	
	if (endBlock>lastBlock){
		endBlock = lastBlock;
	}
	
%>
<script>
	window.addEventListener("load",function(){
		var pagination = document.querySeletorAll(".pagination>a");
		for(var i=0; i<pagination.length;i++){
			pagination[i].addEventListener("click",function(){
				var pageNo = this.textContent;
				var notMove = document.querySelector(".pagination>a:not(.moveLink)");	
				if(pageNo == "이전"){
					pageNo = parseInt(notMove[0].textContent)-1;
				}
				else if(pageNo == "다음"){
					pageNo = parseInt(notMove[notMove.lenght-1].textContent)+1;
				}
				
				document.querySelector("input[name=pageNo]").value = pageNo;
				document.querySelector(".pageForm").submit();
			});
		}
	});

</script>

<title>Insert title here</title>
</head>
<body>
			<div><h1>내가 좋아요 한 글 </h1></div>
	<table class ="table table border">
		<thead>
			<tr>
				<th>글번호</th>
				<th width="50%">제목</th>											
				<th>작성일</th>
				<th>조회수</th>
				<th>좋아요</th>
				
			</tr>
		</thead>
		
		
		<tbody>
		<%for(PostListDto postListDto : myLike){ %>
			<tr>
				<td><%=postListDto.getPostNo() %></td>				
				
				<td>
				<% if(postListDto.getBlind() == 'F') {%>
				
					<a href="post.jsp"><%=postListDto.getPostTitle() %></a>
				
					<%if(postListDto.getPostCommentsCount()>0){ %>						
					[<%=postListDto.getPostCommentsCount()%>]
					
					<%}%>
				<%} else {%>
					블라인드된 게시글입니다.				
				<%} %>
				</td>
				
				
				<% boolean isToday = dateUtils.isToday(postListDto.getPostDate()) == true; %>
				<%if(isToday){ %>
					<td><%=postListDto.getPostDate()%></td>
					
				<%} else{%>
					<td><%=postListDto.getPostDateToday() %></td>
				<%} %>
				
				
				<td><%=postListDto.getPostViewCount() %></td>
				<td><%=postListDto.getPostLikeCount() %></td>
				
				
			</tr>
			<%} %>
		</tbody>
	</table>
	
	<div class="pagination">
		<%if(startBlock>1){ %>
				<a class="moveLink">이전</a>
		<%} %>
		<%for(int i=startBlock; i<=endBlock; i++){ %>
			<% if(pageNo == i){%>
				<a class="on"><%=i %></a>
			<%} else {%>
				<a><%=i %></a>
			<%} %>
		<%} %>	
		
		<%if(endBlock < lastBlock){ %>
			<a class="moveLink">다음</a>		
		<%} %>					
	</div>
	
	<form action="myLike.jsp" method="get" class="pageForm">
		<input type="hidden" name="pageNo">
	
	</form>
</body>
</html>