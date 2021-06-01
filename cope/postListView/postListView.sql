create or replace view post_list as
select post_no,post_title,post_client_no,client_no,client_nick,post_contents 
							post_comments_count,post_view_count,post_like_count,post_date,post_blind
					from post p left outer join client c on p.post_client_no = c.client_no;

select * from post_list;