package cope.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.board.BoardDao;

@WebFilter (urlPatterns = {"/board/post.jsp"})
public class PostFilter implements Filter {
	//post.jsp의 파라미터 boardGroup 값은 상위 게시판의 board_no이어야한다. 
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		//다운캐스팅을 해야한다.
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		request.setCharacterEncoding("UTF-8");
		int groupNoPARA = Integer.parseInt(req.getParameter("boardGroup"));
		BoardDao boardDao = new BoardDao();

		try {
			boolean isBoardSuper = boardDao.checkBoardSuper(groupNoPARA)==true;

			if(isBoardSuper) {
				chain.doFilter(req, resp);
			}
			else {
				resp.sendRedirect("404");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("500");
		}
		
		
	}

}
