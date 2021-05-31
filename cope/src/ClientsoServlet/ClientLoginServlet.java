package ClientsoServlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.client.ClientsoDao;
import cope.beans.client.ClientsoDto;
@WebServlet(urlPatterns="/client/login.kh")
public class ClientLoginServlet extends HttpServlet{
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		req.setCharacterEncoding("UTF-8");
		ClientsoDto clientsoDto = new ClientsoDto();
		clientsoDto.setClientId(req.getParameter("clientId"));
		clientsoDto.setClientPw(req.getParameter("clientPw"));
		
		ClientsoDao clientDao = new ClientsoDao();
		ClientsoDto find =clientDao.login(clientsoDto);

		if(find!=null){//성공시메인페이지
		resp.sendRedirect(req.getContextPath());
	}
	else {//실패시로그인페이지
		resp.sendRedirect("login.jsp");
	}
	}
	catch(Exception e){
	e.printStackTrace();
	resp.sendError(500);

	}
	}
	}
//주석
