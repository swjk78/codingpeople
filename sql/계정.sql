-- 계정 생성 및 권한 부여 구문
create user kh71 identified by kh71;
grant connect, resource, create view to kh71;

-- 계정 삭제 구문
drop user kh71 cascade;