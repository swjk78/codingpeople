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

--초기 데이터
--Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (0,'전체게시판',0,null); -- 필수구문에서 이미 insert됨
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (1,'커뮤니티',1,0);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (2,'공지사항',1,1);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (3,'홍보게시판',1,1);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (4,'자바',4,0);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (5,'자유게시판',4,4);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (6,'질문게시판',4,4);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (7,'팁게시판',4,4);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (8,'c++',8,0);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (9,'자유게시판',8,8);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (10,'질문게시판',8,8);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (11,'팁게시판',8,8);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (12,'파이썬',12,0);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (13,'자유게시판',12,12);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (14,'질문게시판',12,12);
Insert into COPE.BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (15,'팁게시판',12,12);