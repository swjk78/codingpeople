package cope.servlet.client;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.ClientDaoTest;
import cope.beans.SendEmail;

@WebServlet(urlPatterns = "/client/findId.kh")
public class FindIdServlet extends HttpServlet {
	public final String SENDERMAIL = "codingpeople7@gmail.com";
	public final String SENDERPW = "tpal1whdla";
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			String inputEmail = req.getParameter("inputEmail");
			ClientDaoTest clientDao = new ClientDaoTest();
			String clientId = clientDao.findId(inputEmail);
			
			// 일치하는 이메일이 없는 경우
			if (clientId == null) {
				throw new Exception(); // 다른 오류로 바꿀 예정
			}
			// 메일 전송
			else {
				SendEmail sendEmail = new SendEmail();
				sendEmail.setSenderEmail(SENDERMAIL);
				sendEmail.setSenderPw(SENDERPW);
				sendEmail.setReceiverEmail(inputEmail);
				sendEmail.setEmailSubject("찾으신 아이디입니다");
				sendEmail.setEmailContents("아이디: " + clientId);
				sendEmail.send();
				resp.sendRedirect("login.jsp");
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
