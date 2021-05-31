<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
		<link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/join.css">
    <style>
   .mini-font{
   font-size: 14px;
   }
    .text-align-center{
    text-align: center; 
    }
    
    .box{
    width:30%;
    height:30%;
    padding-top: 25px;
    padding-bottom: 17px;
    display: inline-block;	
    }
    
    .hr{
    border: 0px;
    width: 400px;
    height:2px;
    background:#9A9EC2;
    }
    
  	</style>
  	
  	<body>
  <div class = "text-align-center mini-font">
  		<div class = "box">
  		<a href = "<%=request.getContextPath()%>/info.jsp" class = "border-none">
  			<label >Info</label></a>
  			<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
  			<span>Privacy Policy</span>	
  			<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
  			<span>Terms Of Use</span>
  			<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
  			<span>Contact Us</span>
  			<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
  			 <a href = "https://github.com/swjk78/codingpeople">
  			 <span>Git</span></a>
  			   			 <div>
  			<hr class = hr>
  			</div> 
		<div>© 2021. <strong>CODINGPEOPLE.</strong> All rights reserved.</div>
  		</div>
  </div>
	</body>
</html>