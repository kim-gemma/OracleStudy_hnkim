-- seq 시퀀스 생성
-- 1) 여러 테이블에서 공용 사용 가능
-- 2) 하지만 대부분 테이블마다 개별 시퀀스를 생성하는 것이 일반적(관리 용이)
create SEQUENCE seq4;

--테이블
create table hello(num number(3) primary key,
name VARCHAR2(20), age number(5), writeday date);

--insert
insert into hello VALUES(seq4.nextval, '홍길동', 33, sysdate);
-- INSERT 문 기본 규칙
-- 1) 문자 타입 컬럼에는 반드시 작은따옴표(' ')로 감싸서 입력해야 한다.
--    예) '홍길동', '서울시', 'A'
-- 2) 숫자 타입 컬럼은 숫자 그대로 입력하거나 문자로 입력해도 자동 변환된다.
--    예) 33 또는 '33' 모두 가능 (자동 형변환)
-- 3) 날짜 타입은 SYSDATE처럼 함수 사용 가능하며,
--    직접 입력할 때는 반드시 날짜 형식 변환 함수 사용
--    예) TO_DATE('2025-11-19','YYYY-MM-DD')
-- 4) 시퀀스(seq4.NEXTVAL)는 보통 기본키(PK)에 넣는다.

--delete
delete from hello where num=1;

--update
update hello set age=40 where num=2;
update hello set name='김흥민', age=42 where num=2;

select * from hello;

create table myclub (cno number(3) primary key, cname VARCHAR2(20),caddr VARCHAR2(20),cjob VARCHAR2(20), chp VARCHAR2(30));
alter table myclub add gaipday date;


--2번째 테이블  선생님 코드참고
--create table myclub(cno number(3) primary key,
--cname varchar2(20),
--caddr varchar2(30),
--cjob varchar2(20),
--chp varchar2(20),
--gaipday date);
select * from myclub;