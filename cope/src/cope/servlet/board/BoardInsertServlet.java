package cope.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cope.beans.board.BoardDao;
import cope.beans.board.BoardDto;

@WebServlet(urlPatterns = "/manage/createBoard.kh")
public class BoardInsertServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 준비 3개(게시판 이름, 그룹번호, 상위게시판번호 )
			req.setCharacterEncoding("UTF-8");
			BoardDto boardDto = new BoardDto();
			boardDto.setBoardName(req.getParameter("boardName"));
			boardDto.setBoardGroup(Integer.parseInt(req.getParameter("boardSuperNo")));// 상위는 Dao에서 자기 번호로 자동 변환
			boardDto.setBoardSuperNo(Integer.parseInt(req.getParameter("boardSuperNo")));

			// 처리 준비...
			BoardDao boardDao = new BoardDao();
			// 처리1 상위게시판
			if (Integer.parseInt(req.getParameter("boardSuperNo")) == 0
					&& !boardDao.checkSameBoardName(boardDto.getBoardName())) {
				boardDao.insertBoardSuper(boardDto);
				boardDao.insertDefaultBoard(boardDao.getCurrentSequence());
			} else {
				boardDao.insertBoardSub(boardDto);
			}

			resp.sendRedirect("manageBoard.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
