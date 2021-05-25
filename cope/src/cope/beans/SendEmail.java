package cope.beans;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmail {
	private String senderEmail, senderPw, receiverEmail, mailSubject, mailContents;
	
	public SendEmail() {
		super();
	}

	public String getSenderEmail() {
		return senderEmail;
	}
	public void setSenderEmail(String senderEmail) {
		this.senderEmail = senderEmail;
	}
	public String getSenderPw() {
		return senderPw;
	}
	public void setSenderPw(String senderPw) {
		this.senderPw = senderPw;
	}
	public String getReceiverEmail() {
		return receiverEmail;
	}
	public void setReceiverEmail(String receiverEmail) {
		this.receiverEmail = receiverEmail;
	}
	public String getEmailSubject() {
		return mailSubject;
	}
	public void setEmailSubject(String mailSubject) {
		this.mailSubject = mailSubject;
	}
	public String getEmailContents() {
		return mailContents;
	}
	public void setEmailContents(String mailContents) {
		this.mailContents = mailContents;
	}

	public void send() {
		// SMTP 서버 정보 설정
		Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com"); // SMTP 서버
		prop.put("mail.smtp.port", 465); // SMTP 서버와 통신하는 포트 번호
		prop.put("mail.smtp.auth", "true"); // SMTP 서버 인증 사용
		prop.put("mail.smtp.ssl.enable", "true"); // 로그인 시 SSL 사용
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com"); // 인증 처리
		
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(senderEmail, senderPw);
			}
		});
		
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(senderEmail));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiverEmail));
			message.setSubject(mailSubject);
			message.setText(mailContents);

			Transport.send(message);
		}
		catch (AddressException e) {
			e.printStackTrace();
		}
		catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
