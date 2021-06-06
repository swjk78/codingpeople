<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/join.css">
<style>
	*{
		box-sizing: border-box;
	}
	.img-center{
		margin-left:10%;
	}
	body{		    
   		 font: 12px/1.7em 굴림,Gulim,AppleGothic,sans-serif;   	 
	}
	
	.text-center{
		padding-top:30px;
		
	}

	.container{
		color:rgb(68,68,68);
		padding-top:20px;
		padding-bottom:20px;
		margin-top:40px;		
	}
	.content{
		padding-top:10px;
	}
	
	.home>p>a{
		text-decoration:none;
		
	}
	
	

</style>
</head>
<body>
	<div class="text-center width-auto">
		<div class="img-center">
			<a href= "<%=request.getContextPath()%>/index.jsp" class = "padding-img">
			<img src="<%=request.getContextPath()%>/image/example.png" class = "containerimg" max-width = 500px;>
			</a>
		</div>
		<div class="container border">
			<h2>존재하지 않는 회원의 프로필 페이지입니다.</h2>
		</div>
		<div class="home">
			<p><a href="<%=request.getContextPath()%>/index.jsp">코딩피플 홈</a><p>
		</div>
	</div>
</body>
</html>
<jsp:include page="/template/miniFooter.jsp"></jsp:include>
