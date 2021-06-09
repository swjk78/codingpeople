-- 삭제 구문
drop table code;
drop sequence code_seq;

-- 코드URL 테이블, 시퀀스
create table code(
code_no number(19) primary key,
code_post_no references post(post_no) unique,
code_url varchar2(255)
);

create sequence code_seq;