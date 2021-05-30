package cope.servlet.comments;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.comments.CommentsDao;

@WebServlet(urlPatterns = "/board/commentsDelete.kh")
public class CommentsDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 - 두개 commentsNo
			int commentsNo = Integer.parseInt(req.getParameter("commentsNo"));//이것만 DAO로 가고
			int PostNo = Integer.parseInt(req.getParameter("postNo"));// 이건 돌아가기 위한 용도
			
			//처리
			CommentsDao commentsDao = new CommentsDao();
			commentsDao.delete(commentsNo);
			
			//출력
			resp.sendRedirect("post.jsp?postNo="+PostNo);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
