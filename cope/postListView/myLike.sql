
--내가좋아요한글 뷰생성
create view my_like as 
select
 post_no,post_title,client_no, 
 post_comments_count,post_view_count,post_like_count,post_date,post_blind
 from 
 post_like pl 
              left outer join client c on pl.post_like_client_no = c.client_no
              left outer join post p on pl.post_like_post_no = p.post_no;