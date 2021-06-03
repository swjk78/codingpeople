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
public class CommentsFormServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
				req.setCharacterEncoding("UTF-8");
				System.out.println("일단 들어옴");
				//판별 새글 or 수정
				boolean isNew = req.getParameter("isNew").equals("T");
				System.out.println("뉴판별");
				//돌아가기 위한 좌표
				int boardGroup = Integer.parseInt(req.getParameter("boardGroup"));
				System.out.println("그룹!");
				int PostNo = Integer.parseInt(req.getParameter("postNo"));
				System.out.println("넘버");
				if(isNew) { //새 댓글
					//준비 - 파라미터에서2개, 세션에서 1개

					CommentsDto commentsDto = new CommentsDto();
					System.out.println("Dto");
					commentsDto.setCommentsPostNo(Integer.parseInt(req.getParameter("postNo")));
					commentsDto.setCommentsContents(req.getParameter("commentsContents"));
					System.out.println("컨텐츠");
					
					int CommentsClientNo = (int)req.getSession().getAttribute("clientNo");
					commentsDto.setCommentsClientNo(CommentsClientNo);
					
					//처리
					CommentsDao commentsDao = new CommentsDao();
					commentsDao.insert(commentsDto);
					System.out.println("Dao");
					
					//출력
					resp.sendRedirect("post.jsp?boardGroup="+ boardGroup +"&postNo="+ PostNo);

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
					commentsDao.update(commentsDto);
						
					//출력
					resp.sendRedirect("post.jsp?boardGroup="+ boardGroup +"&postNo="+ PostNo);
				}
				

					

					
				
				
			} catch (Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
	}
}
