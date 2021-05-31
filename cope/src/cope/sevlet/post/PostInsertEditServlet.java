package cope.sevlet.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.post.PostDao;
import cope.beans.post.PostDto;

@WebServlet(urlPatterns = "/board/postForm.kh")
public class PostInsertEditServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		//
		req.setCharacterEncoding("UTF-8");
		PostDto postDto = new PostDto();
		postDto.set(req.getParameter("post"));
		
		//처리
		PostDao postDao = new PostDao();
		postDao.insert
		
		//출력
		
	}
	catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	
	}
}
