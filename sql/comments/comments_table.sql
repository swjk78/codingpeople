drop table comments;
drop sequence comments_seq;

create table comments(
comments_no number(19) primary key,
comments_client_no references client(client_no),
comments_post_no references post(post_no),
comments_contents varchar2(3000),
comments_date date default sysdate,
comments_blind char(1) default 'N' check(comments_blind in ('Y', 'N'))
);