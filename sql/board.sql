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

-- 초기 데이터(NEXTVAL 적용)
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'커뮤니티',1,0);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'공지사항',1,1);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'홍보게시판',1,1);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'자바',4,0);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'자유게시판',4,4);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'질문게시판',4,4);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'팁게시판',4,4);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'C++',8,0);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'자유게시판',8,8);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'질문게시판',8,8);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'팁게시판',8,8);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'파이썬',12,0);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'자유게시판',12,12);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'질문게시판',12,12);
Insert into board(board_no,board_name,board_group,board_super_no) values(board_seq.nextval,'팁게시판',12,12);