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

//"로그아웃"이어야 들어갈 수 있는 곳 ->즉 로그인 상태에서 들어가면 "불가"정도는 아닌데 이상한 페이지나 서블릿도 포함입니다.
@WebFilter (urlPatterns = {"/client/exitSuccess.jsp", "/client/findId.jsp", "/client/findPw.jsp", "/client/login.jsp", "/client/join.jsp", "/client/joinSuccess.jsp", "/client/resetPw.jsp",  "/client/findId.kh", "/client/findPw.kh", "/client/join.kh", "/client/login.kh", "/client/resetPw.kh"})
//나중에 login.kh추가할 것

public class LogoutFilter implements Filter{

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
