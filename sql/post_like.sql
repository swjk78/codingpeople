-- 삭제 구문
drop table post_like;

-- 게시글 추천 테이블
create table post_like(
post_like_client_no number(19) references client(client_no) on delete set null,
post_like_post_no number(19) references post(post_no) on delete cascade,
primary key(post_like_client_no, post_like_post_no)
);