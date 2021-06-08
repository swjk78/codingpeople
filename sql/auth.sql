-- 삭제 구문
drop table auth;

-- 인증 테이블
create table auth(
auth_email varchar2(40) primary key,
auth_date date default sysdate not null,
auth_num number(6) not null
);