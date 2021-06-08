create table code(
code_no number(19) primary key,
code_post_no references post(post_no) unique,
code_url varchar(255)
);

create sequence code_seq;