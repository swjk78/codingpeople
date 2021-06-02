package cope.servlet.client;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.client.ClientDao;

@WebServlet(urlPatterns="/client/editPw.kh")
public class ClientChangePwServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			req.setCharacterEncoding("UTF-8");
			
			int clientNo = (int)req.getSession().getAttribute("clientNo");
			String originPw = req.getParameter("originPw");
			String chgPw = req.getParameter("chgPw");
			
			ClientDao clientDao = new ClientDao();
			boolean result = clientDao.chgPw(clientNo, originPw, chgPw);
					
			if(result) {
				resp.sendRedirect("profile.jsp");

			}
			else {
				resp.sendRedirect("editPw.jsp?error");
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
