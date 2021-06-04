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

@WebFilter (urlPatterns = {"/client/exitSuccess.jsp", "/client/findId.jsp", "/client/findPw.jsp", "/client/login.jsp", "/client/join.jsp", "/client/joinSuccess.jsp"})

//로그인 상태에서 들어갈 수 없는 곳
public class clientLoginStatus implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		//다운캐스팅을 해야한다.
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		request.setCharacterEncoding("UTF-8");
		Integer clientNo = (Integer) req.getSession().getAttribute("clientNo");
		
		if(clientNo!=null) {//로그인을 함!
			resp.sendRedirect(req.getContextPath()+"/index.jsp");
		}
		else {
			chain.doFilter(req, resp);
		}
	}

}
