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