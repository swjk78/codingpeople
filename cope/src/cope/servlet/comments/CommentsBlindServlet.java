package cope.servlet.comments;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.comments.CommentsDao;
import cope.beans.comments.CommentsDto;

@WebServlet(urlPatterns = "/board/commentsBlind.kh")
public class CommentsBlindServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 - 세 개 commentsNo commentsBlind | postNo 
			
			CommentsDto commentsDto = new CommentsDto();
			commentsDto.setCommentsNo(Integer.parseInt(req.getParameter("commentsNo")));
			commentsDto.setCommentsBlind(req.getParameter("commentsBlind"));
			
			int PostNo = Integer.parseInt(req.getParameter("postNo"));// 이건 돌아가기 위한 용도
			
			//처리
			CommentsDao commentsDao = new CommentsDao();
			commentsDao.blind(commentsDto);
			
			//출력
			resp.sendRedirect("post.jsp?postNo="+PostNo);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
