package cope.servlet.client;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.client.ClientDao;
import cope.beans.utils.SendEmail;

// 입력된 이메일로 회원 아이디를 찾아서 이메일로 전송하는 서블릿
@WebServlet(urlPatterns = "/client/findId.kh")
public class FindIdServlet extends HttpServlet {
	public final String SENDERMAIL = "codingpeople7@gmail.com";
	public final String SENDERPW = "tpal1whdla";
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			String inputEmail = req.getParameter("inputEmail");
			ClientDao clientDao = new ClientDao();
			String clientId = clientDao.findId(inputEmail);
			
			// 메일 전송
			if (clientId != null) {
				SendEmail sendEmail = new SendEmail();
				sendEmail.setSenderEmail(SENDERMAIL);
				sendEmail.setSenderPw(SENDERPW);
				sendEmail.setReceiverEmail(inputEmail);
				sendEmail.setEmailSubject("찾으신 아이디입니다");
				sendEmail.setEmailContents("아이디: " + clientId);
				
				sendEmail.send();
				
				resp.sendRedirect("loginTest.jsp?success");
			}
			// 일치하는 이메일이 없는 경우
			else {
				resp.sendRedirect("findId.jsp?fail");
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
