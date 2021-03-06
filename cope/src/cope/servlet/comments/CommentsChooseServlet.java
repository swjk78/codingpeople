package cope.servlet.comments;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.comments.CommentsChooseDto;
import cope.beans.comments.CommentsDao;

@WebServlet (urlPatterns = "/board/commentsChoose.kh")
public class CommentsChooseServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비3개
			CommentsChooseDto commentsChooseDto = new CommentsChooseDto();
			commentsChooseDto.setChoosePostNo(Integer.parseInt(req.getParameter("postNo")));
			commentsChooseDto.setChooseCommentsNo(Integer.parseInt(req.getParameter("commentsNo")));
			
			//돌아가기 위한 좌표
			int boardGroup = Integer.parseInt(req.getParameter("boardGroup"));
			int PostNo = Integer.parseInt(req.getParameter("postNo"));
			
			//처리
			CommentsDao commentsDao = new CommentsDao();
			commentsDao.choose(commentsChooseDto);
			
			//출럭
			resp.sendRedirect("post.jsp?boardGroup="+ boardGroup +"&postNo="+ PostNo);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
		
	}
}
