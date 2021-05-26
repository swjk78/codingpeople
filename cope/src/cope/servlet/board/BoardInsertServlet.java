package cope.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.BoardDao;
import cope.beans.BoardDto;

@WebServlet (urlPatterns = "/manage/createBoard.kh")
public class BoardInsertServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			//준비 2개(게시판 이름, 상위게시판을 의미 하는 0)
			req.setCharacterEncoding("UTF-8");
			BoardDto boardDto = new BoardDto();
			boardDto.setBoardName(req.getParameter("boardName"));
			boardDto.setBoardSuperNo(Integer.parseInt(req.getParameter("boardSuperNo")));
			
			//처리
			BoardDao boardDao = new BoardDao();
			boardDao.insertBoardSuper(boardDto);
			
			//출력
			resp.sendRedirect("manageBoard.jsp");

			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
