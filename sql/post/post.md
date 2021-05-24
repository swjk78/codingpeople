### post 테이블 관련 SQL문 모음

```sql
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
