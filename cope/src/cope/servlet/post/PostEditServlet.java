package cope.servlet.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.board.BoardDao;
import cope.beans.board.BoardDto;
import cope.beans.post.PostDao;
import cope.beans.post.PostDto;

@WebServlet(urlPatterns = "/board/postForm.kh")
public class PostEditServlet extends HttpServlet{
	// 게시물 수정
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			PostDto postDto = new PostDto();
	
			postDto.setPostNo(Integer.parseInt(req.getParameter("postNo")));
			postDto.setPostBoardNo(Integer.parseInt(req.getParameter("postBoardNo")));
			postDto.setPostTitle(req.getParameter("postTitle"));
			postDto.setPostContents(req.getParameter("postContents"));
			
			PostDao postDao = new PostDao();
			boolean result = postDao.editPost(postDto);
			
			if (result) {
				resp.sendRedirect("post.jsp?boardGroup=" + req.getParameter("boardGroup")
				+ "&postNo=" + postDto.getPostNo());
			}
			else {
				// 미정
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}	
}
