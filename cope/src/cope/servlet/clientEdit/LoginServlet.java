package cope.servlet.clientEdit;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.client.ClientDao;
import cope.beans.client.ClientDto;



@WebServlet(urlPatterns="/client/login.kh")
public class LoginServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			req.setCharacterEncoding("UTF-8");
			ClientDto clientDto = new ClientDto();
			
			clientDto.setClientId(req.getParameter("clientId"));
			clientDto.setClientPw(req.getParameter("clientPw"));
			
			ClientDao clientDao = new ClientDao();
			ClientDto result = clientDao.login(clientDto);
			
			if(result != null) {
				req.getSession().setAttribute("clientNo", result.getClientNo());
				resp.sendRedirect(req.getContextPath());
				
			}
			else {
				req.getSession().setAttribute("errorCheck", "notFound");
				resp.sendRedirect("Loginso.jsp");
				
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
