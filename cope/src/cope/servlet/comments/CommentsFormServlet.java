package cope.servlet.comments;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.comments.CommentsDao;
import cope.beans.comments.CommentsDto;

@WebServlet (urlPatterns = "/board/commentsForm.kh")//패키지는 comments이지만 post.jsp에서 쓰이므로 "/board/"
public class CommentsInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
				req.setCharacterEncoding("UTF-8");
				
				//판별 새글 or 수정
				boolean isNew = req.getParameter("isNew").equals("T");
				
				
				if(isNew) { //새 댓글
					//준비 - 파라미터에서2개, 세션에서 1개

					CommentsDto commentsDto = new CommentsDto();
					
					commentsDto.setCommentsPostNo(Integer.parseInt(req.getParameter("commentsPostNo")));
					commentsDto.setCommentsContents(req.getParameter("commentsContents"));
					
					int CommentsClientNo = (int)req.getSession().getAttribute("clientNo");
					commentsDto.setCommentsClientNo(CommentsClientNo);
					
					//처리
					CommentsDao commentsDao = new CommentsDao();
					commentsDao.insert(commentsDto);
					
					//출력
					resp.sendRedirect("post.jsp?postNo="+commentsDto.getCommentsPostNo());//다시 가져오는 군요
				}
				
				else { //댓글 수정
					//준비 - 파라미터에서3개, 세션에서 1개
					req.setCharacterEncoding("UTF-8");
					CommentsDto commentsDto = new CommentsDto();
					commentsDto.setCommentsNo(Integer.parseInt(req.getParameter("commentsNo"))); //수정에선 PostNo대신 commentsNo를 가져옵니다
					commentsDto.setCommentsContents(req.getParameter("commentsContents"));
					
					int CommentsClientNo = (int)req.getSession().getAttribute("clientNo");
					commentsDto.setCommentsClientNo(CommentsClientNo);
					
					//처리
					CommentsDao commentsDao = new CommentsDao();
					System.out.println("이상무");
					commentsDao.update(commentsDto);
						
					//출력
					resp.sendRedirect("post.jsp?postNo="+commentsDto.getCommentsPostNo());
				}
				

					

					
				
				
			} catch (Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
	}
}
