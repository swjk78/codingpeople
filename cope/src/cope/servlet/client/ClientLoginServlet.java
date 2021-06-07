package cope.servlet.client;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.client.ClientDao;
import cope.beans.client.ClientDto;

@WebServlet(urlPatterns = "/client/login.kh")
public class ClientLoginServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			ClientDto clientDto = new ClientDto();
			clientDto.setClientId(req.getParameter("clientId"));
			clientDto.setClientPw(req.getParameter("clientPw"));
			
			ClientDao clientDao = new ClientDao();
			ClientDto find = clientDao.login(clientDto);
			if (find == null) {
				resp.sendRedirect("login.jsp?notFound");
			}
			else if (find.getClientUnlockDate() != null) {
				req.getSession().setAttribute("unlockDate", find.getClientUnlockDateString());
				resp.sendRedirect("login.jsp");
			}
			else {
				req.getSession().setAttribute("clientNo", find.getClientNo());
				resp.sendRedirect(req.getContextPath());
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
