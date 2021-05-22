# post 테이블 관련 SQL문 설명

## 파일 설명

-   post.sql : post 테이블 관련 SQL문 모음
-   post_full.sql : 위의 SQL문 테스트 시 사용한 테스트용 테이블 포함<br>

## 각 SQL문 설명

### 게시글 테이블, 시퀀스

create table post(<br>
post_no number(19) primary key,<br>
post_client_no references client(client_no) on delete set null,<br>
post_board_no references board(board_no) on delete set null,<br>
post_title varchar2(90) not null,<br>
post_contents varchar2(4000) not null,<br>
post_date date default sysdate not null,<br>
post_like_count number(10) default 0 not null,<br>
post_view_count number(10) default 0 not null,<br>
post_comments_count number(10) default 0 not null,<br>
post_blind char(1) default 'F' not null check(post_blind in ('T', 'F'))<br>
);

-   post_client_no의 외래키 옵션은 set null로 설정한 이유<br>
    : 무옵션으로 하면 작성한 게시글이 있는 한 회원탈퇴가 불가하고 다른 커뮤니티들을 보면 회원 탈퇴를 한다고 해서 작성한 게시글이 같이 사라지기 않기 때문
-   post_board_no의 외래키 옵션은 set null로 설정한 이유<br>
    : 무옵션으로 하면 게시글이 존재하는 게시판을 삭제할 수 없고 cascade로 하면 게시판 삭제 시 해당 게시판에 소속된 게시글도 같이 삭제되는데 데이터 보존을 위해 안 좋다 판단<br>
-   기본적으로 전부 데이터가 존재해야 하기 때문에 전부 not null 설정<br>

### 게시글 작성 SQL문

insert into post(post_no, post_client_no, post_board_no, post_title, post_contents)<br>
values(post_seq.nextval, ?, ?, ?, ?);<br>

-   insert문 작성 시 데이터를 넣을 속성을 지정하면 차후 테이블 속성 변경 시 관리하기 편하다 해서 위와 같이 작성<br>

### 게시글 수정 SQL문

update post set post_board_no = ?, post_title = ?, post_contents = ?<br>
where post_no = ?;

-   차후 관리자가 게시글을 수정하는 기능도 넣을 가능성이 있기 때문에 where문에서 회원번호를 보는 조건은 작성하지 않음<br>

### 게시글 삭제 SQL문

delete post where post_no = ?;

-   게시글 수정과 같은 이유로 where문에서 회워번호를 보는 조건은 작성하지 않음<br>

### 게시글의 조회수 증가 SQL문

update post set post_view_count = post_view_count + 1 where post_no = ?;

-   우리가 만드는 커뮤니티는 조회수가 중요한 사이트가 아니기 때문에 where문에서 회원번호를 보는 조건은 작성하지 않음
-   자신의 게시글을 볼 경우에도 조회수 증가 방지, 중복 조회수 증가 방지 기능은 불필요하다고 판단<br>

### 게시글의 도움됐어요 갱신 SQL문

update post<br>
set post_like_count = (select count(\*) from post_like where post_like_post_no = ?)<br>
where post_no = ?;<br>

### 게시글의 댓글 갱신 SQL문

update post<br>
set post_comments_count = (select count(\*) from comments where comments_post_no = ?)<br>
where post_no = ?;
