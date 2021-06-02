package cope.servlet.client;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.client.ClientDao;
import cope.beans.client.ClientDto;

@WebServlet(urlPatterns = "/client/join.kh")
public class JoinServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			req.setCharacterEncoding("UTF-8");
			ClientDto clientDto = new ClientDto();
			clientDto.setClientId(req.getParameter("clientId"));
			clientDto.setClientPw(req.getParameter("clientPw"));
			clientDto.setClientEmail(req.getParameter("clientEmail"));			
			clientDto.setClientNick(req.getParameter("clientNick"));
			clientDto.setClientBirthYear(Short.parseShort(req.getParameter("clientBirthYear")));
			
			ClientDao clientDao = new ClientDao();
			clientDao.regist(clientDto);
			
			resp.sendRedirect("joinSuccess.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}


