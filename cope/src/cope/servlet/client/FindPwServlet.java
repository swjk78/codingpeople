package cope.servlet.client;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.client.ClientDaoTest;
import cope.beans.utils.SendEmail;

// 비밀번호 재설정을 위해 입력된 이메일로 인증번호를 전송하는 서블릿
@WebServlet(urlPatterns = "/client/findPw.kh")
public class FindPwServlet extends HttpServlet {
	public final String SENDERMAIL = "codingpeople7@gmail.com";
	public final String SENDERPW = "tpal1whdla";
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			String inputEmail = req.getParameter("inputEmail");
			ClientDaoTest clientDao = new ClientDaoTest();
			String clientId = clientDao.findId(inputEmail);
			
			// 메일 전송
			if (clientId != null) {
				SendEmail sendEmail = new SendEmail();
				String authNum = getAuthNum();
				req.getSession().setAttribute("authNum", authNum);
				req.getSession().setAttribute("inputEmail", inputEmail);
				
				sendEmail.setSenderEmail(SENDERMAIL);
				sendEmail.setSenderPw(SENDERPW);
				sendEmail.setReceiverEmail(inputEmail);
				sendEmail.setEmailSubject("비밀번호를 재설정 안내");
				sendEmail.setEmailContents("인증번호: " + authNum);
				
				sendEmail.send();
				
				resp.sendRedirect("resetPw.jsp");
			}
			// 일치하는 이메일이 없는 경우
			else {
				resp.sendRedirect("findPw.jsp?error");
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
	// 인증번호 생성 기능
	public String getAuthNum() {
		Random ran = new Random();
		String authNum = "";
		int[] numArr = new int[6];
		for (int i = 0; i < numArr.length; i++) {
			numArr[i] = ran.nextInt(10);
			authNum += String.valueOf(numArr[i]);
		}
		
		return authNum;
	}
}
