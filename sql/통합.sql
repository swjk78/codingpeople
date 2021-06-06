-- 삭제 구문
drop table choose;
drop sequence choose_seq;
drop table comments;
drop sequence comments_seq;
drop table post_like;
drop table post;
drop sequence post_seq;
drop table board;
drop sequence board_seq;
drop table client;
drop sequence client_seq;

-- 테이블 생성 구문
-- 회원 테이블, 시퀀스
create table client(
client_no number(19) primary key,
client_id varchar2(40) not null unique check(regexp_like(client_id, '^[a-zA-Z0-9]{8,20}$')),
client_pw varchar2(32) not null check(regexp_like(client_pw, '^[a-zA-Z0-9!@#$%^&*]{8,16}$')),
client_email varchar2(100) not null unique,
client_nick varchar2(30) not null unique check(regexp_like(client_nick, '^[가-힣a-zA-Z0-9!@#$%^&*]{1,10}$')),
client_birth_year number(4),
client_grade varchar(15) default 'normal' not null check(client_grade IN ('normal', 'super')),
client_unlock_date date
);
create sequence client_seq;

-- 게시판 테이블, 시퀀스, 필수 구문
create table board(
board_no number(19) primary key,
board_name varchar2(30) not null,
board_group number(19) not null,
board_super_no references board(board_no) on delete set null
);
create sequence board_seq;
insert into board values(0, '전체게시판', 0 , null); --꼭 등록하셔야 상위게시판이 정상적으로 들어갑니다.

-- 게시글 테이블, 시퀀스, 뷰
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
create sequence post_seq;
create or replace view post_list as
select post.*, client_nick, board_name, board_group from post
left outer join client on post_client_no = client_no
left outer join board on post_board_no = board_no;

-- 게시글 추천 테이블
create table post_like(
post_like_client_no number(19) references client(client_no) on delete set null,
post_like_post_no number(19) references post(post_no) on delete cascade,
post_like_date date default sysdate not null,
primary key(post_like_client_no, post_like_post_no)
);

-- 댓글 테이블, 시퀀스, 뷰
create table comments(
comments_no number(19) primary key,
comments_client_no references client(client_no) on delete set null,
comments_post_no references post(post_no) on delete cascade ,
comments_contents varchar2(3000) not null,
comments_date date default sysdate not null,
comments_blind char(1) default 'F' check(comments_blind in ('T', 'F'))  not null
);
create sequence comments_seq;
Create or replace view comments_view as
select Cmt.comments_no, Cmt.comments_client_no, Cmt.comments_post_no, Cmt.comments_contents, Cmt.comments_date, Cmt.comments_blind, Cli.client_nick
from comments Cmt left outer join client Cli on Cmt.comments_client_no = Cli.client_no;

-- 채택 테이블, 시퀀스
create table choose(
choose_no number(19) primary key ,
choose_post_no references post(post_no) not null unique,
choose_comments_no references comments(comments_no) not null
);
create sequence choose_seq nocache;

--회원 초기 데이터
insert into client values(client_seq.nextval, 'superadmin', 'superadmin', 'aaaa1111@naver.com', '광개토대왕', 1950, 'super', null);
insert into client values(client_seq.nextval, 'bbbb2222', 'bbbb2222', 'bbbb2222@naver.com', '세종대왕', 1952, 'normal', null);
insert into client values(client_seq.nextval, 'cccc3333', 'cccc3333', 'cccc3333@naver.com', '소수림왕', 1959, 'normal', null);
insert into client values(client_seq.nextval, 'dddd4444', 'dddd4444', 'dddd4444@naver.com', '이완용', 1961, 'normal', null);
insert into client values(client_seq.nextval, 'eeee5555', 'eeee5555', 'eeee5555@naver.com', '유관순', 1963, 'normal', null);

insert into client values(client_seq.nextval, 'ffff6666', 'ffff6666', 'ffff6666@naver.com', '윤봉길', 1964, 'normal', null);
insert into client values(client_seq.nextval, 'gggg7777', 'gggg7777', 'gggg7777@naver.com', '이수일', 1965, 'normal', null);
insert into client values(client_seq.nextval, 'hhhh8888', 'hhhh8888', 'hhhh8888@naver.com', '심순애', 1967, 'normal', null);
insert into client values(client_seq.nextval, 'iiii9999', 'iiii9999', 'iiii9999@naver.com', '김대행', 1975, 'normal', null);
insert into client values(client_seq.nextval, 'jjjj0000', 'jjjj0000', 'jjjj0000@naver.com', '강현화', 1977, 'normal', null);

insert into client values(client_seq.nextval, 'kkkk1111', 'kkkk1111', 'kkkk1111@naver.com', '촘스키', 1979, 'normal', null);
insert into client values(client_seq.nextval, 'llll2222', 'llll2222', 'llll2222@naver.com', '소쉬르', 1981, 'normal', null);
insert into client values(client_seq.nextval, 'nnnn3333', 'nnnn3333', 'nnnn3333@naver.com', '블룸필드', 1985, 'normal', null);
insert into client values(client_seq.nextval, 'mmmm4444', 'mmmm4444', 'mmmm4444@naver.com', '자끄', 1987, 'normal', null);
insert into client values(client_seq.nextval, 'oooo5555', 'oooo5555', 'oooo5555@naver.com', '라깡', 1989, 'normal', null);

insert into client values(client_seq.nextval, 'pppp6666', 'pppp6666', 'pppp6666@naver.com', '바흐찐', 1991, 'normal', null);
insert into client values(client_seq.nextval, 'qqqq7777', 'qqqq7777', 'qqqq7777@naver.com', '이글턴', 1992, 'normal', null);
insert into client values(client_seq.nextval, 'rrrr8888', 'rrrr8888', 'rrrr8888@naver.com', '프로이트', 1995, 'normal', null);
insert into client values(client_seq.nextval, 'ssss9999', 'ssss9999', 'ssss9999@naver.com', '스티븐', 1999, 'normal', null);
insert into client values(client_seq.nextval, 'tttt0000', 'tttt0000', 'tttt0000@naver.com', '빅또르', 2002, 'normal', null);

insert into client values(client_seq.nextval, 'uuuu1111', 'uuuu1111', 'uuuu1111@naver.com', '마르크스', 2003, 'normal', null);
insert into client values(client_seq.nextval, 'vvvv2222', 'vvvv2222', 'vvvv2222@naver.com', '니체', 2003, 'normal', null);
insert into client values(client_seq.nextval, 'wwww3333', 'wwww3333', 'wwww3333@naver.com', '푸코', 2004, 'normal', null);
insert into client values(client_seq.nextval, 'xxxx4444', 'xxxx4444', 'xxxx4444@naver.com', '데카르트', 2004, 'normal', null);
insert into client values(client_seq.nextval, 'yyyy5555', 'yyyy5555', 'yyyy5555@naver.com', '홉스', 2004, 'normal', null);

insert into client values(client_seq.nextval, 'A1111111', 'A1111111', 'A1111111@naver.com', '갈릴레이', 1960, 'normal', null);
insert into client values(client_seq.nextval, 'B2222222', 'B2222222', 'B2222222@naver.com', '다윈', 1965, 'normal', null);
insert into client values(client_seq.nextval, 'C3333333', 'C3333333', 'C3333333@naver.com', '코페르니쿠스', 1951, 'normal', null);
insert into client values(client_seq.nextval, 'D4444444', 'D4444444', 'D4444444@naver.com', '탈레스', 1951, 'normal', null);
insert into client values(client_seq.nextval, 'E5555555', 'E5555555', 'E5555555@naver.com', '피타고라스', 1953, 'normal', null);

insert into client values(client_seq.nextval, 'F6666666', 'F6666666', 'F6666666@naver.com', '퀴리', 1956, 'normal', null);
insert into client values(client_seq.nextval, 'G7777777', 'G7777777', 'G7777777@naver.com', '뢴트겐', 1956, 'normal', null);
insert into client values(client_seq.nextval, 'H8888888', 'H8888888', 'H8888888@naver.com', '에디슨', 1958, 'normal', null);
insert into client values(client_seq.nextval, 'I9999999', 'I9999999', 'I9999999@naver.com', '테슬라', 1960, 'normal', null);
insert into client values(client_seq.nextval, 'J0000000', 'J0000000', 'J0000000@naver.com', '노벨', 1951, 'normal', null);

insert into client values(client_seq.nextval, 'K1111111', 'K1111111', 'K1111111@naver.com', '영', 2015, 'normal', null);

-- 게시판 초기 데이터
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (1,'커뮤니티',1,0);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (2,'공지사항',1,1);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (3,'홍보게시판',1,1);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (4,'자바',4,0);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (5,'자유게시판',4,4);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (6,'질문게시판',4,4);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (7,'팁게시판',4,4);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (8,'C++',8,0);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (9,'자유게시판',8,8);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (10,'질문게시판',8,8);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (11,'팁게시판',8,8);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (12,'파이썬',12,0);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (13,'자유게시판',12,12);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (14,'질문게시판',12,12);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (15,'팁게시판',12,12);


-- 게시글 초기 데이터
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (1,1,2,'안녕하세요 코딩피플이 만들어졌습니다.','많은 사랑 부탁 드려요',to_date('21/06/06','RR/MM/DD'),1,38,4,'F');
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (2,4,6,'자바를 배우고 싶은데...','어디서 어떻게 시작해야할지 몰라서 고민입니다.',to_date('21/06/06','RR/MM/DD'),0,4,1,'F');
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (5,5,6,'마방진을 만드는 중인데','package MBG;

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

한 줄만 나오네요 ㅠㅠ',to_date('21/06/06','RR/MM/DD'),0,11,2,'F');
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (6,34,7,'자바에 대한 자잘한 팁','()',to_date('21/06/06','RR/MM/DD'),0,4,2,'F');
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (7,19,11,'c++이 좋을까 c#이 좋을까?','()',to_date('21/06/06','RR/MM/DD'),0,3,1,'F');
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (8,21,11,'에러가 나고 있네요 도와 주실 수 있으신가요?','()',to_date('21/06/06','RR/MM/DD'),0,1,0,'F');
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (9,1,13,'파이썬의 유래','()',to_date('21/06/06','RR/MM/DD'),0,3,0,'F');
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (10,23,14,'출력구문은 print() 뿐인가요?','(0',to_date('21/06/06','RR/MM/DD'),0,1,0,'F');
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (11,11,3,'자바 스터디그룹 모집합니다!','kkkk1111@naver.com로 메일 주세요!',to_date('21/06/06','RR/MM/DD'),0,1,0,'F');
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (12,11,5,'자바의 창시자 제임스 고슬링','(0',to_date('21/06/06','RR/MM/DD'),0,1,0,'F');
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (13,11,6,'이클립스 오류가 뜨네요 ㅠㅠㅠ','()',to_date('21/06/06','RR/MM/DD'),0,2,0,'F');
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (14,11,7,'자바 하면서 알아낸 몇가지 팁','1.2.3.4.5.',to_date('21/06/06','RR/MM/DD'),0,2,0,'F');
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (15,26,6,'너무 어려워요 도와주세요 ㅠㅠㅠ','()',to_date('21/06/06','RR/MM/DD'),0,3,0,'F');
Insert into POST (POST_NO,POST_CLIENT_NO,POST_BOARD_NO,POST_TITLE,POST_CONTENTS,POST_DATE,POST_LIKE_COUNT,POST_VIEW_COUNT,POST_COMMENTS_COUNT,POST_BLIND) values (16,11,6,'급합니다... 도와주세요!!','package filter;

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

필터를 만들고 있는데 다 막아버리네요 ㅠㅠ',to_date('21/06/06','RR/MM/DD'),1,15,5,'F');

-- 댓글 초기 데이터
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (1,2,1,'안녕하세요 오늘 가입했습니다.',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (2,4,1,'많이 배워가겠습니다',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (3,24,1,'열심히 활동 할게요',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (4,24,2,'KH정보교육원 추천합니다. 황인빈 강사님이 제일 좋아요!',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (9,1,1,'모두들 감사합니다',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (15,19,6,'감사합니다 도움이 되었습니다 ',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (13,5,5,'감사합니다 채택 할게요!',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (12,1,5,'출력문장을 반복문으로 하시면 될 거 같습니다.',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (14,34,6,'(부연설명)',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (16,21,7,'글쎄요',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (17,1,16,'else 이후에
chain.doFilter(req, resp);
을 입력하여서 통과시키게 하면 될 거 같습니다.',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (18,30,16,'팁을 하다 더 드리자면 url 에 "*"을 활용할 수도 있습니다.',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (19,4,16,'멍청아!!',to_date('21/06/06','RR/MM/DD'),'T');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (20,11,16,'이완용 꺼져',to_date('21/06/06','RR/MM/DD'),'T');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (21,26,16,'감사합니다 저도 도움이 많이 되었습니다',to_date('21/06/06','RR/MM/DD'),'F');