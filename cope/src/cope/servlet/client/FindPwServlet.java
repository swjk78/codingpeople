package cope.servlet.client;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.auth.AuthDao;
import cope.beans.auth.AuthDto;
import cope.beans.client.ClientDao;
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
			ClientDao clientDao = new ClientDao();
			String clientId = clientDao.findId(inputEmail);
			
			if (clientId != null) {
				SendEmail sendEmail = new SendEmail();
				
				// 인증정보 등록
				AuthDao authDao = new AuthDao();
				AuthDto authDto = new AuthDto(inputEmail);
				int authNum = getAuthNum();
				authDto.setAuthNum(authNum);
				
				// 중복 체크(이전에 인증정보 등록하고 5분이 안 지났을 경우)
				if (authDao.findAuthNum(inputEmail) != -1) {
					 authDao.deleteAuth(inputEmail);
				}

				authDao.insertAuth(authDto);
				
				// 메일 전송
				sendEmail.setSenderEmail(SENDERMAIL);
				sendEmail.setSenderPw(SENDERPW);
				sendEmail.setReceiverEmail(inputEmail);
				sendEmail.setEmailSubject("비밀번호를 재설정 안내");
				sendEmail.setEmailContents("인증번호: " + authNum);
				
				sendEmail.send();
				
				resp.sendRedirect("resetPw.jsp?inputEmail=" + inputEmail);
			}
			// 일치하는 이메일이 없는 경우
			else {
				resp.sendRedirect("findPw.jsp?fail");
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
	// 인증번호 생성 기능
	public int getAuthNum() {
		Random ran = new Random();
		String authNum = "";
		int[] numArr = new int[6];
		
		numArr[0] = ran.nextInt(9) + 1;
		authNum += String.valueOf(numArr[0]);
		for (int i = 1; i < numArr.length; i++) {
			numArr[i] = ran.nextInt(10);
			authNum += String.valueOf(numArr[i]);
		}
		
		return Integer.parseInt(authNum);
	}
}
