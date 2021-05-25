package cope.board.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.BoardDao;

@WebServlet(urlPatterns = "/manage/deleteBoard.kh")
public class BoardDeleteServlet extends HttpServlet {
		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
				//준비 : 게시판 번호
				int boardNo = Integer.parseInt(req.getParameter("boardNo"));
				
				//처리
				BoardDao boardDao = new BoardDao();
				boardDao.deleteBoard(boardNo);
				
				//출력
				resp.sendRedirect("manageBoard.jsp");
				
			} catch (Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
		}
}
