-- 계정 생성 및 권한 부여 구문
create user cope identified by cope;
grant connect, resource, create view to cope;

-- 계정 삭제 구문
drop user cope cascade;