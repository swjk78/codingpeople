package cope.servlet.client;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.client.ClientDao;


@WebServlet(urlPatterns="/client/exit.kh")
public class ClientExitServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
	
		try {
			
			req.setCharacterEncoding("UTF-8");
			int clientNo = (int)req.getSession().getAttribute("clientNo");		
			String clientPw = req.getParameter("clientPw");
			
			
			//탈퇴처리
			ClientDao clientDao = new ClientDao();
			boolean result = clientDao.exit(clientNo, clientPw);
			
			
			
			if(result) {
				//올바르게 입력했으면 처리완료후 탈퇴성공페이지
				resp.sendRedirect("exitSuccess.jsp");
				//로그아웃처리
				req.getSession().removeAttribute("clientNo");
			}
			else {
				resp.sendRedirect("exit.jsp?error");
			}
			
			
			
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
