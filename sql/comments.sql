-- 삭제 구문
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


create table choose(
choose_no number(19) primary key ,
choose_post_no references post(post_no) not null unique,
choose_comments_no references comments(comments_no) not null
);

create sequence choose_seq nocache;
