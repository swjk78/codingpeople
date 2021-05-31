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
	
//게시물 수정
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {

		req.setCharacterEncoding("UTF-8");
		PostDto postDto = new PostDto();

		postDto.setPostNo(Integer.parseInt(req.getParameter("postNo")));
		postDto.setPostTitle(req.getParameter("postTitle"));
		postDto.setPostContents(req.getParameter("postContents"));
		
		//처리
		PostDao postDao = new PostDao();
		
		//작성글 확인페이지로 이동을 위해 값 파라미터 불러오기

		int postNo = postDao.getSequence();
		postDto.setPostNo(postNo);
		
		//등록// 게시글 등록
		postDao.registPost(postDto);
		
		//출력
		resp.sendRedirect("post.jsp?postNo="+postNo);
	}
	catch(Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	
	}	
}
