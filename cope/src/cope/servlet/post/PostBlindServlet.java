package cope.servlet.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.post.PostDao;
import cope.beans.post.PostDto;

@WebServlet(urlPatterns = "/manage/postBlind.kh")
public class PostBlindServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int postNo = Integer.parseInt(req.getParameter("postNo"));
			char clientBlind = req.getParameter("clientBlind").charAt(0);

			PostDto postDto = new PostDto();
			postDto.setPostNo(postNo);
			postDto.setPostBlind(clientBlind);
			PostDao postDao = new PostDao();
			
			// 블라인드/언블라인드 처리
			boolean result = postDao.blindPost(postDto);
			
			// 블라인드/언블라인드 처리 후 페이지 이동
			if (result) {
				resp.sendRedirect(req.getContextPath() + "/board/post.jsp?boardGroup="
				+ req.getParameter("boardGroup") + "&postNo=" + postNo);
			}
			else {
				// 미정
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
