-- 삭제 구문
drop table choose;
drop sequence choose_seq;
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

-- 채택 테이블
create table choose(
choose_no number(19) primary key ,
choose_post_no references post(post_no) not null unique,
choose_comments_no references comments(comments_no) not null
);

create sequence choose_seq nocache;

-- 댓글 뷰 테이블
Create or replace view comments_view as
    select Cmt.comments_no, Cmt.comments_client_no, Cmt.comments_post_no, Cmt.comments_contents, Cmt.comments_date, Cmt.comments_blind, Cli.client_nick
    from comments Cmt left outer join client Cli on Cmt.comments_client_no = Cli.client_no;


-- 초기 데이터
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (1,2,1,'안녕하세요 오늘 가입했습니다.',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (2,4,1,'많이 배워가겠습니다',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (3,24,1,'열심히 활동 할게요',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (4,24,2,'KH정보교육원 추천합니다. 황인빈 강사님이 제일 좋아요!',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (9,1,1,'모두들 감사합니다',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (15,19,6,'감사합니다 도움이 되었습니다 ',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (13,5,5,'감사합니다 채택 할게요!',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (12,1,5,'출력문장을 반복문으로 하시면 될 거 같습니다.',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (14,34,6,'(부연설명)',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (16,21,7,'글쎄요',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (17,1,16,'else 이후에
chain.doFilter(req, resp);
을 입력하여서 통과시키게 하면 될 거 같습니다.',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (18,30,16,'팁을 하다 더 드리자면 url 에 "*"을 활용할 수도 있습니다.',to_date('21/06/06','RR/MM/DD'),'F');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (19,4,16,'멍청아!!',to_date('21/06/06','RR/MM/DD'),'T');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (20,11,16,'이완용 꺼져',to_date('21/06/06','RR/MM/DD'),'T');
Insert into COMMENTS (COMMENTS_NO,COMMENTS_CLIENT_NO,COMMENTS_POST_NO,COMMENTS_CONTENTS,COMMENTS_DATE,COMMENTS_BLIND) values (21,26,16,'감사합니다 저도 도움이 많이 되었습니다',to_date('21/06/06','RR/MM/DD'),'F');