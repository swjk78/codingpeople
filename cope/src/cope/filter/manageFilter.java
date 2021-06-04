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

import cope.beans.client.ClientDao;

@WebFilter (urlPatterns = {"/manage/manageCenter.jsp", "/manage/manageClient", "/manage/manageBoard.jsp"}) //나중에 게시글 관리도 추가해야합니다. 테스트 후 "/manage/*"로 해버립시다
public class manageFilter implements Filter{
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		//다운캐스팅을 해야한다.
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		request.setCharacterEncoding("UTF-8");
		Integer clientNo = (Integer) req.getSession().getAttribute("clientNo");
		
		if(clientNo==null) {//로그인 조차 안 함
			resp.sendRedirect(req.getContextPath()+"/client/login.jsp");
		}
		else {
			int clientNoInt = clientNo.intValue();
			ClientDao clientDao = new ClientDao();
			try {
				boolean isSuper = clientDao.isSuper(clientNoInt);
				if(isSuper) {
					chain.doFilter(req, resp);
				}
				else {
					resp.sendError(401);
				}
			} catch (Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
			
			
		}
	}
}
