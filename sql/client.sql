-- 삭제 구문
drop table client;
drop sequence client_seq;

-- 회원 테이블
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

-- 회원 시퀀스
create sequence client_seq;