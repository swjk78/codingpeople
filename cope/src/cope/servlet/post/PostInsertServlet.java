package cope.servlet.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.post.PostDao;
import cope.beans.post.PostDto;

@WebServlet(urlPatterns = "/board/postForm.kh")
public class PostInsertServlet extends HttpServlet{
	// 게시물 등록
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			PostDao postDao = new PostDao();
			PostDto postDto = new PostDto();
			int postNo = postDao.getSequence();
			int boardGroup = Integer.parseInt(req.getParameter("boardGroup"));

			postDto.setPostNo(postNo);
			postDto.setPostClientNo((int) req.getSession().getAttribute("clientNo"));
			postDto.setPostBoardNo(Integer.parseInt(req.getParameter("postBoardNo")));
			postDto.setPostTitle(req.getParameter("postTitle"));
			postDto.setPostContents(req.getParameter("postContents"));
			
			// 게시글 등록
			postDao.registPost(postDto);
			
			resp.sendRedirect("post.jsp?boardGroup=" + boardGroup + "&postNo=" + postNo);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}	
}
