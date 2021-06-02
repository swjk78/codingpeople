package cope.servlet.client;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.client.ClientDao;
import cope.beans.client.ClientDto;

@WebServlet(urlPatterns="/client/editInfo.kh")
public class ClientChangeMyInfoServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			
			req.setCharacterEncoding("UTF-8");
			
			ClientDto clientDto = new ClientDto();
			clientDto.setClientNo((int)req.getSession().getAttribute("clientNo"));
			clientDto.setClientPw(req.getParameter("clientPw"));
			clientDto.setClientNick(req.getParameter("clientNick"));
			clientDto.setClientEmail(req.getParameter("clientEmail"));
			
			ClientDao clientDao = new ClientDao();
			boolean result = clientDao.chgMyInfo(clientDto);
			
			if(result) {
				resp.sendRedirect("profile.jsp");
			}
			else {
				resp.sendRedirect("editInfo.jsp?error");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
