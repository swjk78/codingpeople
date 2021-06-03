<%@page import="cope.beans.post.PostDaoTest"%>
<%@page import="cope.beans.post.PostDtoTest"%>
<%@page import="cope.beans.post.PostDto"%>
<%@page import="cope.beans.utils.DateUtils"%>
<%@page import="cope.beans.board.PostListDto"%>
<%@page import="java.util.List"%>
<%@page import="cope.beans.board.PostListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/common.css">
<%
	request.setCharacterEncoding("UTF-8");
	//글목록 불러오기
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	
	 
	
	int pageNo;//페이지번호
	
	try{
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
		if(pageNo < 0){
			throw new Exception();
		}
	}
	catch(Exception e ){
		pageNo = 1;
	}
	
	int pageSize; //페이지에 보여줄 글 갯수
	try{
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
		if(pageSize<10){
			throw new Exception(); //10보다작을시 강제 예외처리
		}
		
	}
	catch(Exception e){
		pageSize = 20; //적어로 n개의 글을보여주도록 오류시 예외처리
	}
	
	int startRow = pageNo*pageSize-(pageSize-1);//1
	int endRow = pageNo*pageSize;//10
	
	
	
	PostListDao postListDao = new PostListDao();
	List<PostListDto> list;	
	
	boolean isSearch = type!=null && keyword!=null && !keyword.trim().equals("");
			
	if(isSearch){
		
		list = postListDao.searchList(type, keyword,startRow,endRow);//검색글목록
				
						
	}
	else{
		list = postListDao.postList(startRow,endRow);//글목록
	}
	
	int count;
	
	if(isSearch){
		count = postListDao.getCount(type,keyword);
	}
	else{
		count = postListDao.getCount();
	}
	
	int blockSize = 10;
	int startBlock = (pageNo-1)/blockSize*blockSize+1;
	int endBlock = startBlock + blockSize - 1;
	int lastBlock = (count-1)/pageSize+1;
	
	if (endBlock>lastBlock){
		endBlock = lastBlock;
	}

	
	//오늘날짜 구하기
	DateUtils dateUtils = new DateUtils();
	
	
// 	PostListDto postListDto = new PostListDto();
// 	postListDto.setPostNo(Integer.parseInt(request.getParameter("postNo")));
// 	postListDto.setBlind(request.getParameter("postBlind"));
	
	
%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<% if(isSearch){%>
<script>
	
	window.addEventListener("load",function(){
		var selectType = document.querySelector("select[name=type]");
		selectType.value = "<%=type%>"; <%--검색후 타입값고정 --%>
 		
		var selectInput = document.querySelector("input[name=keyword]");
		selectInput.value = "<%=keyword%>"; <%--검색후 키워드값고정 --%>
		
		var inputSize = document.querySelector("input[name=pageSize]");		
		inputSize.value = "<%=pageSize%>";	<%--검색후 페이지사이즈값고정 --%>
		
	});	
</script>
<%} %>

<script>
	window.addEventListener("load",function(){
		var pagination = document.querySelectorAll(".pagination>a");
		for(var i=0; i<pagination.length; i++){
			pagination[i].addEventListener("click",function(){
				var pageNo = this.textContent;
				var moveLink = document.querySelectorAll(".pagination>a:not(.move-link)");
				if(pageNo == "이전"){
					pageNo = parseInt(moveLink[0].textContent) - 1; 
															
				}
				else if(pageNo =="다음"){
					pageNo = parseInt(moveLink[moveLink.length-1].textContent)+1;
					
				}		
					document.querySelector("input[name=pageNo]").value = pageNo;
					document.querySelector(".form").submit();											
			});			
		}
	});
	
// 	$(function(){
// 		$(".pagination>a").click(function(){
// 			var pageNo = $(this).text();
// 			$("input[name=pageNo]").val(pageNo);
// 		});
// 	});

</script>


<script>
	window.addEventListener("load",function(){

		var formSize = document.querySelector(".form-size");
		formSize.addEventListener("change",function(){
			this.submit();
		});
		var selectPageSize = document.querySelector("select[name=pageSize]");
		selectPageSize.value = "<%=pageSize%>"
	});
</script>



<title>Insert title here</title>
</head>
<body>
			<H1>게시판이름</H1>
<%-- 			startRow = <%=startRow %> endRow = <%=endRow %> startBlock=<%=startBlock %> endBlock=<%=endBlock %> --%>
	<form action="postList.jsp" method="post" class="form-size">
	<select name="pageSize">
		<option value="10">10개씩</option>
		<option value="20">20개씩</option>
		<option value="30">30개씩</option>
	</select>
	<%if(type != null && keyword != null){ %>
	<input type="hidden" name="type" value ="<%=type%>">
	<input type="hidden" name="keyword" value ="<%=keyword%>">
	<%} %>
	</form>
	
	<hr>
	<table class="table table-border" >
		<thead>
		
			
			<tr>
				<th>글번호</th>
				<th width="50%">제목</th>							
				<th>글쓴이</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>좋아요</th>
				
			</tr>
		</thead>
		
		
		<tbody>
		<%for(PostListDto postListDto : list){ %>
			<tr>
				<div class=""></div>
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
				<td>
					<a href="<%=request.getContextPath()%>/client/profile.jsp"><%=postListDto.getClientNick() %></a>
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
	
	<div class ="pagination">
	<%if(startBlock>1){ %>
	<a class ="move-link">이전</a>
	<%} %>
	<%for(int i=startBlock; i<=endBlock; i++){ %>
		<%if(pageNo == i){%>
		<a class="on"><%=i %></a>
		
		<%} else{ %>		 
			<a><%=i %></a>
		<%} %>
	<%} %>
	<%if(endBlock < lastBlock){ %>
	<a class="move-link">다음</a>
	<%} %>
	</div>
	
	
	<a href="postList.jsp">목록</a>
	<a href="postForm">글쓰기</a>
	
	<form class ="form" action="postList.jsp" method="get">
	
	<input type="hidden" name ="pageNo">
	<input type="hidden" name = "pageSize" value="<%=pageSize%>" >
	
	
	<select name = "type">
		<option value="post_title">제목</option>
		<option value="post_contents">내용</option>
		<option value="client_nick">글쓴이</option>
	</select>
	<input type="text"  name ="keyword" placeholder="검색어를 입력하세요">	
	<input type="submit" value="검색">
	
	</form>
</body>
</html>