<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
</section>
	<footer>
		<h5></h5>
		<hr>
			세션 ID : <%=session.getId()%> , 
			회원 번호 : <%=session.getAttribute("ClientNo")%>
		</footer>
	</main>
</body>
</html>