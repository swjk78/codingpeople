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

//"Login"이어야 들어갈 수 있는 곳
@WebFilter (urlPatterns = {"client/editInfo.jsp", "/client/editPw.jsp", "client/exit.jsp",
		"/client/exit.jsp", "client/postForm.jsp", "/client/editInfo.kh", "/client/editPw.kh", "/client/exit.kh", "/client/logout.kh", 
		"/board/commentsChoose.kh", "/board/commentsDelete.kh",  "/board/commentsForm.kh", "/board/postDelete.kh", 
		"/board/postEdit.kh", "/board/postInsert.kh", "/board/postLike.kh"})
public class LoginFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		//다운캐스팅을 해야한다.
				HttpServletRequest req = (HttpServletRequest) request;
				HttpServletResponse resp = (HttpServletResponse) response;
				
				request.setCharacterEncoding("UTF-8");
				Integer clientNo = (Integer) req.getSession().getAttribute("clientNo");
				
				if(clientNo==null) {//로그인을 안했다!
					resp.sendRedirect(req.getContextPath()+"/client/login.jsp");
				}
				else {//로그인을 했다!
					chain.doFilter(req, resp);
				}
	}

}
