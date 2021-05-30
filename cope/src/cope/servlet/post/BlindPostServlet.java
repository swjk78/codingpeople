package cope.servlet.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.post.PostDaoTest;
import cope.beans.post.PostDtoTest;

@WebServlet(urlPatterns = "/manage/blindPost.kh")
public class BlindPostServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			int postNo = Integer.parseInt(req.getParameter("postNo"));
			String clientGrade = req.getParameter("clientGrade");
			
			PostDtoTest postDto = new PostDtoTest();
			postDto.setPostNo(postNo);
			postDto.setClientGrade(clientGrade);
			
			PostDaoTest postDao = new PostDaoTest();
			boolean result = postDao.blindPost(postDto);
			
			if (result) {
				resp.sendRedirect(req.getContextPath() + "/board/post?post_no=" + postNo);
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
