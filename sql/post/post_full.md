### post 관련 SQL문 테스트 시 사용한 테스트용 테이블 포함

```sql
drop table comments;
drop sequence comments_seq;
drop table post;
drop sequence post_seq;
drop table post_like;
drop table board;
drop sequence board_seq;
drop table client;
drop sequence client_seq;
-- 테스트용 회원 테이블, 시퀀스
create table client(
client_no number(19) primary key,
client_id varchar2(40) not null,
client_pw varchar2(32) not null,
client_nick varchar2(30) not null,
client_birth_year number(4) not null, -- java short type
client_grade varchar2(15) not null check(client_grade in ('일반', '관리자')),
client_unlock_date date default null
);
create sequence client_seq nocache;

-- 테스트용 게시판 테이블, 시퀀스
create table board(
board_no number(19) primary key,
board_name varchar2(30) not null, -- 크기 수정할 가능성 있음
board_group number(10) not null,
board_super_no references board(board_no) on delete set null
);
create sequence board_seq nocache;

-- 게시글 테이블, 시퀀스
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
create sequence post_seq nocache;

-- 테스트용 게시글 추천 테이블
create table post_like(
post_like_client_no references client(client_no),
post_like_post_no references post(post_no),
primary key(post_like_client_no, post_like_post_no)
);

-- 테스트용 댓글 테이블, 시퀀스
create table comments(
comments_no number(19) primary key,
comments_client_no references client(client_no) on delete set null,
comments_post_no references post(post_no) on delete cascade,
comments_contents varchar2(3000) not null,
comments_date date default sysdate not null,
comments_blind char(1) default 'F' not null check(comments_blind in ('T', 'F'))
);
create sequence comments_seq nocache;

-- 게시글 작성 SQL문
insert into post(post_no, post_client_no, post_board_no, post_title, post_contents)
values(post_seq.nextval, ?, ?, ?, ?);

-- 게시글 수정 SQL문
update post set post_board_no = ?, post_title = ?, post_contents = ?
where post_no = ?;

-- 게시글 삭제 SQL문
delete post where post_no = ?;

-- 게시글의 조회수 증가 SQL문
update post set post_view_count = post_view_count + 1 where post_no = ?;

-- 게시글의 도움됐어요 갱신 SQL문
update post
set post_like_count = (select count(*) from post_like where post_like_post_no = ?)
where post_no = ?;

-- 게시글의 댓글 갱신 SQL문
update post
set post_comments_count = (select count(*) from comments where comments_post_no = ?)
where post_no = ?;
```
