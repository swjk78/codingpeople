package cope.servlet.post;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.post.PostCodeDao;
import cope.beans.post.PostCodeDto;
import cope.beans.post.PostDao;
import cope.beans.post.PostDto;

@WebServlet(urlPatterns = "/board/postEdit.kh")
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
			
			//codeUrl이 있다면
			if(req.getParameter("codeUrl")!=null) {
				PostCodeDao postCodeDao = new PostCodeDao();
				PostCodeDto postCodeDto = new PostCodeDto();
				
				int postNo = Integer.parseInt(req.getParameter("postNo"));
				boolean isExist = postCodeDao.isExist(postNo);

				//이미 입력된 url이 있다면 update
				if(isExist) {
					postCodeDto.setCodePostNo(Integer.parseInt(req.getParameter("postNo")));
					postCodeDto.setCodeUrl(req.getParameter("codeUrl"));
					
					postCodeDao.update(postCodeDto);
					
				}else {//입력값이 없다면 (!isExist) insert
					postCodeDto.setCodePostNo(postNo);
					postCodeDto.setCodeUrl(req.getParameter("codeUrl"));
					
					postCodeDao.insert(postCodeDto);
				}
			}
			else {
			}
			
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
