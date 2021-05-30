<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 페이지 하단에서 세션을 보기 위한 임시 페이지
	  create by JK
-->
세션 ID: <%=session.getId()%><br>
세션 회원번호: <%=session.getAttribute("clientNo")%><br>
세션 인증번호: <%=session.getAttribute("authNum")%><br>
세션 이메일: <%=session.getAttribute("inputEmail")%><br>
정지해제 날짜: <%=session.getAttribute("unlockDate")%>