package cope.servlet.client;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet(urlPatterns="/client/logout.kh")
public class ClientLogoutServlet extends HttpServlet{
	@Override

	//로그아웃 기능
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		req.setCharacterEncoding("UTF-8");
		req.getSession().removeAttribute("clientNo");
		resp.sendRedirect("login.jsp");
	}
	catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	}
	}
//주석
