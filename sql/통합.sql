-- 삭제 구문
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
primary key(post_like_client_no, post_like_post_no)
);

-- 댓글 테이블, 시퀀스
create table comments(
comments_no number(19) primary key,
comments_client_no references client(client_no) on delete set null,
comments_post_no references post(post_no) on delete cascade ,
comments_contents varchar2(3000) not null,
comments_date date default sysdate not null,
comments_blind char(1) default 'F' check(comments_blind in ('T', 'F'))  not null
);
create sequence comments_seq;
