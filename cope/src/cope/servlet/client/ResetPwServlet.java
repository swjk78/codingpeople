package cope.servlet.client;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.client.ClientDao;

// 비밀번호 재설정 서블릿
@WebServlet(urlPatterns = "/client/resetPw.kh")
public class ResetPwServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String inputPw = req.getParameter("inputPw");
			String inputEmail = (String) req.getSession().getAttribute("inputEmail");
			
			ClientDao clientDao = new ClientDao();
			boolean result = clientDao.resetPw(inputPw, inputEmail);
			if (result) {
				req.getSession().removeAttribute("inputEmail");
				resp.sendRedirect("login.jsp");
			}
			else {
				resp.sendRedirect("resetPw.jsp?fail");
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
