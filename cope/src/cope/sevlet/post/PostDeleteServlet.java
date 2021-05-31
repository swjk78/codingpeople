package cope.sevlet.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.post.PostDao;

@WebServlet(urlPatterns = "/board/postDelete.kh")
public class PostDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
try {
	// 게시글 번호 호출
	int postNo = Integer.parseInt(req.getParameter("postNo"));
	
	//처리
	PostDao postDao = new PostDao();
	postDao.deletePost(postNo);
	
	//출력
	resp.sendRedirect("post.jsp");
}
	catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
}
	
	}
