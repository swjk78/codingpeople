create table client(
client_no number(19) primary key,
client_id varchar2(40) not null unique,
client_pw varchar2(32) not null,
client_nick varchar2(30) not null unique,
client_birth number(5) not null, -- java short type
client_grade varchar2(15) default 일반,
--not null check(client_grade in ('일반', '관리자')),
client_unlock_date date default null
);
create sequence client_seq nocache;