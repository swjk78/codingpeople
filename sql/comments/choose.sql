create table choose(
choose_no number(19) primary key ,
choose_post_no references post(post_no) not null unique,
choose_comments_no references comments(comments_no) not null
);

create sequence choose_seq nocache;