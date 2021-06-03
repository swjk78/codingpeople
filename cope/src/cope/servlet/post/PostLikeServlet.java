package cope.servlet.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.post.PostDao;
import cope.beans.post.PostLikeDao;
import cope.beans.post.PostLikeDto;

@WebServlet(urlPatterns = "/board/postLike.kh")
public class PostLikeServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int postNo = Integer.parseInt(req.getParameter("postNo"));
			
			PostLikeDao postLikeDao = new PostLikeDao();
			PostLikeDto postLikeDto = new PostLikeDto();
			postLikeDto.setPostLikeClientNo((int) req.getSession().getAttribute("clientNo"));
			postLikeDto.setPostLikePostNo(postNo);
			
			boolean checkLike = postLikeDao.checkPostLike(postLikeDto);
			if (!checkLike) {
				postLikeDao.insertPostLike(postLikeDto);
				PostDao postDao = new PostDao();
				postDao.refreshLikeCount(postNo);
				resp.sendRedirect("post.jsp?boardGroup=" + req.getParameter("boardGroup")
				+ "&postNo=" + postNo);
			}
			else {
				resp.sendRedirect("post.jsp?boardGroup=" + req.getParameter("boardGroup")
				+ "&postNo=" + postNo + "&alreadyLike");
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
