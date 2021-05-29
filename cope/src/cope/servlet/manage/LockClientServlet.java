package cope.servlet.manage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.client.ClientDaoTest;

@WebServlet(urlPatterns = "/manage/lockClient.kh")
public class LockClientServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			int clientNo = Integer.parseInt(req.getParameter("clientNo"));
			int lockHour = Integer.parseInt(req.getParameter("lockHour"));
			ClientDaoTest clientDao = new ClientDaoTest();
			boolean result = clientDao.lockClient(clientNo, lockHour);
			
			if (result) {
				resp.sendRedirect("manageClient.jsp");
			}
			else if (lockHour > -1) {
				resp.sendRedirect("manageClient.jsp?error=lockfail");
			}
			else {
				resp.sendRedirect("manageClient.jsp?error=unlockfail");
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
