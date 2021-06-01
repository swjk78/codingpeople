CREATE TABLE client(
client_no number(19) primary key,
client_id varchar2(40) NOT null UNIQUE,
client_pw varchar2(32) NOT null,
client_email varchar2(100) NOT null UNIQUE,
client_nick varchar2(30) NOT null UNIQUE,
client_birth_year number(4),
client_grade varchar(15)DEFAULT 'normal' NOT null CHECK(client_grade IN ('normal','super')),
client_unlock_date date DEFAULT null
);
CREATE SEQUENCE client_seq NOCACHE ;

