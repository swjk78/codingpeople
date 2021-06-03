-- 삭제 구문
drop table board;
drop sequence board_seq;

-- 게시판 테이블
create table board(
board_no number(19) primary key,
board_name varchar2(30) not null,
board_group number(19) not null,
board_super_no references board(board_no) on delete set null
);

-- 게시판 시퀀스
create sequence board_seq;

-- 필수 구문
insert into board values(0, '전체게시판', 0 , null); --꼭 등록하셔야 상위게시판이 정상적으로 들어갑니다.