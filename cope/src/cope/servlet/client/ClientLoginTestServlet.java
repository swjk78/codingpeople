package cope.servlet.client;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.client.ClientDaoTest;
import cope.beans.client.ClientDtoTest;

// 활동정지된 회원의 로그인 방지를 위한 테스트 로그인 서블릿
// create by JK
@WebServlet(urlPatterns = "/client/loginTest.kh")
public class ClientLoginTestServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			ClientDtoTest clientDto = new ClientDtoTest();
			clientDto.setClientId(req.getParameter("clientId"));
			clientDto.setClientPw(req.getParameter("clientPw"));
			
			ClientDaoTest clientDao = new ClientDaoTest();
			ClientDtoTest find = clientDao.login(clientDto);
			if (find == null) {
				resp.sendRedirect("loginTest.jsp?error");
			}
			else if (find.getClientUnlockDate() != null) {
				req.getSession().setAttribute("unlockDate", find.getClientUnlockDateString());
				resp.sendRedirect("loginTest.jsp");
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
