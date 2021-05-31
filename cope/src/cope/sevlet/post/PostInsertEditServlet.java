package cope.sevlet.post;

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
public class PostInsertEditServlet extends HttpServlet{
	
//게시물 등록
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		//
		req.setCharacterEncoding("UTF-8");
		PostDto postDto = new PostDto();
		
		//if(값이 없다면) -등록-
		postDto.setPostTitle(req.getParameter("postTitle"));
		postDto.setPostContents(req.getParameter("postContents"));
		//(값이 있다면) -수정-(기존 내용 + 수정내용 추가)
		
		
		//처리
		PostDao postDao = new PostDao();
		postDao.registPost(postDto);
		
		//출력
		resp.sendRedirect("post.jsp");
	}
	catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	
	}	
}
