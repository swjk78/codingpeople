<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
		<link rel = "stylesheet" type = "text/css" href = "<%=request.getContextPath()%>/css/miniFooter.css">
		    <script src="https://code.jquery.com/jquery-latest.js"></script> 
    <style>
   
    .width-auto{
    width:auto;
    }
    
   .mini-font{
   font-size: 14px;
   }
   
    .hr{
    border: 0px;
    width: 70%;
    height:2px;
    background:#9A9EC2;
    }

.box1{
padding : 30px;
}

a.underline-bottom, a.underline-bottom:VISITED{
text-decoration:none; 
color: black;
cursor:pointer;
}

a.underline-bottom:hover{
text-decoration: underline;
}

  	</style>
  	
  		  			<span>&nbsp;</span>
  		  			<span>&nbsp;</span>
  	<div class = " inline-block">
	  <div class = " text-center mini-font text-left">
	  		<div class = "width-auto box1">
	  		<a href = "<%=request.getContextPath()%>/info.jsp" class = "text-decoration-none underline-bottom" >
	  			<label style ="cursor: pointer;">Info</label></a>
	  				  			<span>&nbsp;</span>
	  				  			<span>·</span>
	  			<span>&nbsp;</span>
    <a href="<%=request.getContextPath()%>/privacyPolicy.jsp" class="text-decoration-none underline-bottom">
    <span style ="cursor: pointer;">Privacy Policy</span>
    </a>
	  			<span>·</span>
	  			<span>&nbsp;</span>
    <a href="<%=request.getContextPath()%>/termsOfUse.jsp" class="text-decoration-none underline-bottom">
    <span style ="cursor: pointer;">Terms of Use</span>
    </a>
	  			<span>&nbsp;</span>
	  				  			<span>·</span>
	  			<span>&nbsp;</span>
    <a href="<%=request.getContextPath()%>/contactUs.jsp" class="text-decoration-none underline-bottom">
    <span style ="cursor: pointer;">Contact Us</span>
    </a>
	  			<span>&nbsp;</span>
	  				  			<span>·</span>
	  				  				  			<span>&nbsp;</span>
	  			 <a href = "https://github.com/swjk78/codingpeople" class = "text-decoration-none underline-bottom" >
	  			 <span style ="cursor: pointer;">Git</span></a>
	  			   			 <div>
	  			<hr class = hr>
	  			</div> 
			<span>© 2021. <strong>CODINGPEOPLE.</strong> All rights reserved.</span>
	  		</div>
	  		</div>
	  </div>
</html>