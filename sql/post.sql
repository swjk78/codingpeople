-- 삭제 구문
drop table post;
drop sequence post_seq;

-- 게시글 테이블
create table post(
post_no number(19) primary key,
post_client_no references client(client_no) on delete set null,
post_board_no references board(board_no) on delete set null,
post_title varchar2(90) not null,
post_contents varchar2(4000) not null,
post_date date default sysdate not null,
post_like_count number(10) default 0 not null check(post_like_count >= 0),
post_view_count number(10) default 0 not null check(post_view_count >= 0),
post_comments_count number(10) default 0 not null check(post_comments_count >= 0),
post_blind char(1) default 'F' not null check(post_blind in ('T', 'F'))
);

-- 게시글 시퀀스
create sequence post_seq;

-- 게시글 목록 나열 시 필요한 뷰
create or replace view post_list as
select post.*, client_nick, board_name, board_group from post
left outer join client on post_client_no = client_no
left outer join board on post_board_no = board_no;


-- 초기 데이터
Insert into post values(post_seq.nextval,1,2,'안녕하세요 코딩피플이 만들어졌습니다.','많은 사랑 부탁 드려요',to_date('20/04/06','RR/MM/DD'),15,38,0,'F');
Insert into post values(post_seq.nextval,4,6,'자바를 배우고 싶은데...','어디서 어떻게 시작해야할지 몰라서 고민입니다.',to_date('20/01/06','RR/MM/DD'),12,44,0,'F');
Insert into post values(post_seq.nextval,5,6,'마방진을 만드는 중인데','package MBG;

import java.io.IOException;
import java.util.Arrays;
import java.util.Scanner;

public class MBG04 {
	public static void main(String[] args) {

		//입력
		Scanner sc = new Scanner (System.in);

		System.out.println("한줄에 있는 칸 수를 입력해주세요(홀수)");
		int line = (sc.nextInt());

		int[] arr = new int[line*line];
		for (int i = 0; i < arr.length; i++) {
			arr[i] = i + 1;
		}

		//
		Integer[][] m = new Integer[line][line];

		int h = 0;
		int v = m.length / 2;

		for (int i = 0; i < arr.length; i++) {

			m[h][v] = arr[i]; // 하나씩 입력
			System.out.println("m[" + h + "] [" + v + "] = " + arr[i]);

			if (i % m.length == m.length - 1) { // 누군가 만났을 때
				h++;
				continue;
			} else {
				h--; // 반복문으로 안해도 된다.
				v++; // 이것도 그냥 증감
			}
			if (h == -1) {
				h = m.length - 1;
			} else if (v == m.length) {
				v = 0;
			} else {
				continue;
			}
		}


		System.out.println(Arrays.toString(m[i]));

	}
}

한 줄만 나오네요 ㅠㅠ',to_date('20/06/03','RR/MM/DD'),2,11,0,'F');
Insert into post values(post_seq.nextval,34,7,'자바에 대한 자잘한 팁','()',to_date('21/01/06','RR/MM/DD'),113,442,0,'F');
Insert into post values(post_seq.nextval,19,11,'c++이 좋을까 c#이 좋을까?','()',to_date('21/02/06','RR/MM/DD'),121,311,0,'F');
Insert into post values(post_seq.nextval,21,11,'에러가 나고 있네요 도와 주실 수 있으신가요?','()',to_date('21/04/06','RR/MM/DD'),100,111,0,'F');
Insert into post values(post_seq.nextval,1,13,'파이썬의 유래','()',to_date('21/07/05','RR/MM/DD'),10,31,0,'F');
Insert into post values(post_seq.nextval,23,14,'출력구문은 print() 뿐인가요?','(0',to_date('21/04/05','RR/MM/DD'),10,11,0,'F');
Insert into post values(post_seq.nextval,11,3,'자바 스터디그룹 모집합니다!','kkkk1111@naver.com로 메일 주세요!',to_date('21/06/06','RR/MM/DD'),40,51,0,'F');
Insert into post values(post_seq.nextval,11,5,'자바의 창시자 제임스 고슬링','(0',to_date('21/06/16','RR/MM/DD'),2,4,0,'F');
Insert into post values(post_seq.nextval,11,6,'이클립스 오류가 뜨네요 ㅠㅠㅠ','()',to_date('21/03/06','RR/MM/DD'),1,2,0,'F');
Insert into post values(post_seq.nextval,11,7,'자바 하면서 알아낸 몇가지 팁','1.2.3.4.5.',to_date('21/06/02','RR/MM/DD'),1,2,0,'F');
Insert into post values(post_seq.nextval,26,6,'너무 어려워요 도와주세요 ㅠㅠㅠ','()',to_date('21/06/04','RR/MM/DD'),1,3,0,'F');
Insert into post values(post_seq.nextval,1,6,'급합니다... 도와주세요!!','package filter;

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
			System.out.println("LogoutFilter에서 걸림!");
			resp.sendRedirect(req.getContextPath()+"/index.jsp");
		}
		else {
		}
	}

}

필터를 만들고 있는데 다 막아버리네요 ㅠㅠ',to_date('21/06/18','RR/MM/DD'),7,15,0,'F');