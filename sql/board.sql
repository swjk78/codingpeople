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

-- 초기 데이터(NEXTVAL)
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'커뮤니티',1,0);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'공지사항',1,1);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'홍보게시판',1,1);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'자바',4,0);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'자유게시판',4,4);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'질문게시판',4,4);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'팁게시판',4,4);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'C++',8,0);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'자유게시판',8,8);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'질문게시판',8,8);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'팁게시판',8,8);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'파이썬',12,0);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'자유게시판',12,12);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'질문게시판',12,12);
Insert into BOARD (BOARD_NO,BOARD_NAME,BOARD_GROUP,BOARD_SUPER_NO) values (BOARD_SEQ.NEXTVAL,'팁게시판',12,12);