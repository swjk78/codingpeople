<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			<h2>죄송합니다.</h2>
			<h2>페이지를 볼 수 있는 권한이 없습니다</h2>
			<div class="content">
				<p>
					이 페이지는 등급이 관리자만 볼 수 있는 페이지 입니다.
				</p>
	
				<p>	관련 문의 사항은 고객센터로 전화주시면 친절하게 안내해 드리겠습니다. </p>
				<p>Tel.02-4848-4848</p>
			
			</div>
		</div>
		<div class="home">
			<p><a href="<%=request.getContextPath()%>/index.jsp">코딩피플 홈</a><p>
		</div>
	</div>
</body>
</html>
<jsp:include page="/template/miniFooter.jsp"></jsp:include>