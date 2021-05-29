package cope.servlet.client;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.client.JoinDao;
import cope.beans.client.JoinDto;

@WebServlet(urlPatterns = "/client/join.kh")
public class JoinServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			req.setCharacterEncoding("UTF-8");
			JoinDto joinDto = new JoinDto();
			joinDto.setClientId(req.getParameter("clientId"));
			joinDto.setClientPw(req.getParameter("clientPw"));
			joinDto.setClientEmail(req.getParameter("clientEmail"));			
			joinDto.setClientNick(req.getParameter("clientNick"));
			joinDto.setClientBirthYear(Short.parseShort(req.getParameter("clientBirthYear")));
			
			JoinDao joinDao = new JoinDao();
			joinDao.regist(joinDto);
			
			resp.sendRedirect("joinSuccess.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}


