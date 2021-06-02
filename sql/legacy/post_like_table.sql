create table post_like(
post_like_client_no number(19) references client(client_no) on delete set null,
post_like_post_no number(19) references post(post_no) on delete cascade,
post_like_time date default sysdate not null,
primary key(post_like_client_no,post_like_post_no)
);

--내가 좋아요 한 글 목록
create view my_like as 
select
 post_no, post_title, post_comments_count, client_nick, post_view_count--테스트
 from 
 post_like pl 
              left outer join client c on pl.post_like_client_no = c.client_no
              left outer join post p on pl.post_like_post_no = p.post_no
              where pl.client_no = ?;
 
 --인기글 top10
create view top_like as              
select * from(
    select tmp.*,rownum rn from(
        select 
                post_no, post_title, post_comments_count, client_nick, post_view_count --테스트
        from post order by post_like desc )tmp
             )where rn between 1 and 10;