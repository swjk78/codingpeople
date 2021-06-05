<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
  *{
box-sizing: border-box;
}

.border{
border: red solid 2px;
}
.float-left{
float:left;
}

.footer{
bottom : 0;
width: 100%;
height: 50px;
background-color : #858AB6; 
}

.footer-box{
font-size: 14px;
padding-top: 5px;
padding-right: 15px;
width: auto;
height: auto;
float: right;
color: white;
}

.footer-address{
font-size: 10px;
color: white;
padding-bottom:10px;
padding-right: 10px;
text-align : right;
height: auto;
float: right;
width: 100%;
background-color : #858AB6; 
}

a.underline-footer, a.underline-footer:VISITED{
text-decoration:none; 
color: white;
cursor:pointer;
}

a.underline-footer:hover{
text-decoration: underline;
}
<hr.footer{
width:1px;
height: 5px;
}
.whiteboard{
background-color : white; 
width:100%;
hegiht: 100 px;
}

</style>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>

</style>

<div class ="footer float-left">
<div class =" whiteboard"><br>
</div>
<div class= footer-box>
	  		<a href = "<%=request.getContextPath()%>/info.jsp" class = "text-decoration-none underline-footer" >
	  			<label style ="cursor: pointer;">Info</label></a>
	  				  				  			<span>&nbsp;</span>
	  				  			<span>·</span>
	  			<span>&nbsp;</span>
    <a href="<%=request.getContextPath()%>/privacyPolicy.jsp" class="text-decoration-none underline-footer">
    <span style ="cursor: pointer;">Privacy Policy</span>
	  			     </a>
	  			     <span>·</span>
	  			<span>&nbsp;</span>
    <a href="<%=request.getContextPath()%>/termsOfUse.jsp" class="text-decoration-none underline-footer">
    <span style ="cursor: pointer;">Terms of Use</span>
    </a>
	  			<span>&nbsp;</span>
	  				  			<span>·</span>
	  			<span>&nbsp;</span>
    <a href="<%=request.getContextPath()%>/contactUs.jsp" class="text-decoration-none underline-footer">
    <span style ="cursor: pointer;">Contact Us</span>
    </a>
	  			<span>&nbsp;</span>
	  				  				  			<span>·</span>
	  				  				  			<span>&nbsp;</span>
	  			 <a href = "https://github.com/swjk78/codingpeople" class = "text-decoration-none underline-footer" >
	  			 <span style ="cursor: pointer;">Git</span></a>
</div>
</div>
<div class = "footer-address">
			<span>© 2021. <strong>CODINGPEOPLE.</strong> All rights reserved.</span>


</div>
</html>
