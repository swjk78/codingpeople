-- 삭제 구문
drop table choose;
drop sequence choose_seq;
drop table comments;
drop sequence comments_seq;

-- 댓글 테이블
create table comments(
comments_no number(19) primary key,
comments_client_no references client(client_no) on delete set null,
comments_post_no references post(post_no) on delete cascade ,
comments_contents varchar2(3000) not null,
comments_date date default sysdate not null,
comments_blind char(1) default 'F' check(comments_blind in ('T', 'F'))  not null
);

-- 댓글 시퀀스
create sequence comments_seq;

--채택 테이블
create table choose(
choose_no number(19) primary key ,
choose_post_no references post(post_no) not null unique,
choose_comments_no references comments(comments_no) not null
);

create sequence choose_seq nocache;

--댓글 뷰 테이블
Create or replace view comments_view as
    select Cmt.comments_no, Cmt.comments_client_no, Cmt.comments_post_no, Cmt.comments_contents, Cmt.comments_date, Cmt.comments_blind, Cli.client_nick
    from comments Cmt left outer join client Cli on Cmt.comments_client_no = Cli.client_no;
