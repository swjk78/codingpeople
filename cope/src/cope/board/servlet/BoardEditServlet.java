package cope.board.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.BoardDao;
import cope.beans.BoardDto;

@WebServlet (urlPatterns = "/manage/editBoard.kh")
public class BoardEditServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 게시판 번호, 바꿀게시판이름
			req.setCharacterEncoding("UTF-8");
			BoardDto boardDto = new BoardDto();
			boardDto.setBoardNo(Integer.parseInt(req.getParameter("boardNo")));
			boardDto.setBoardName(req.getParameter("boardName"));
			
			
			//처리
			BoardDao boardDao = new BoardDao();
			boardDao.editBoard(boardDto);
			
			//출력
			resp.sendRedirect("manageBoard.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
