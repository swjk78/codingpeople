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
client_id varchar2(40) not null unique,
client_pw varchar2(32) not null,
client_email varchar2(100) not null unique,
client_nick varchar2(30) not null unique,
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
post_like_count number(10) default 0 not null,
post_view_count number(10) default 0 not null,
post_comments_count number(10) default 0 not null,
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

--초기 데이터
insert into client values(client_seq.nextval, 'admin', 'admin', 'aaaa1111@naver.com', '광개토대왕', 1950, 'super', null);
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
