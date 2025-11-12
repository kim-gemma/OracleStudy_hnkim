--test계정에서 연습하기

--테이블확인
select * from tab;

--테이블생성..gibon
--primary key는 기본키: unique+not null
create table gibon (num number(5) primary key,name varchar2(20),score number(6,2),birth date);

--gibon테이블의 구조확인
desc gibon;

--테이블확인
select * from gibon;


--gibon테이블에 전체 데이타 insert하기
--두번삽입시 참조무결성오류나타남(기본키이므로 중복 불가능)
insert into gibon values(1,'이수연',68.4,'1987-01-01');
insert into gibon values(2,'이수연',68.4,'1987-01-01');
insert into gibon values(100,'홍길동',99.444,'1987-04-01');
insert into gibon values(110,'홍길동',999.544,'1987-04-01');

--gibon테이블에 일부 데이타 insert하기
insert into gibon (num,name) values (200,'김민지');

--gibon의 일부만 조회
select name,score from gibon;
select name,birth from gibon;

--sysdate  현재날짜
--두번넣으면 무조건 무결성 제약조건에 어긋나서 오류가 난다
insert into gibon values (25,'이태민',77.7,sysdate);

--컬럼을 추가..나이..초기값은 무조건 null
alter table gibon add age number(5);

--컬럼명을 추가..주소..기본값을 강남구
alter table gibon add addr varchar2(30) default '강남구';

--주소 컬럼을 30-->50으로 변경
alter table gibon modify addr varchar2(50);


--나이 varchar2(10)으로 변경 초기값 20으로 설정
--기존 null은 그대로 이고 새로 insert 하는것부터 초기값이 들어값
alter table gibon modify age varchar2(10) default '20';

--전체 insert
insert into gibon values (26,'민지혜',77.8,'2025-10-10','20','서울시 관약구');
--부분 insert -num name, addr .. 이때 나이는 초기값 준 20 이 둘어간다
insert into gibon (num, name, addr) values (28,'홍민지','경기도 성남시');

--num 의 오름차순 출력
select * from gibon order by num; --asc생략가능

--이름의 내림차순 출력
select * from gibon order by name desc;

--컬럼삭제하는 방법
--age삭제
alter table gibon drop COLUMN age;
--addr삭제
alter table gibon drop COLUMN addr;
--컬럼명 변경
--score-->jumsoo
alter table gibon rename COLUMN score to jomsoo;
--birth-->birthday
alter table gibon rename COLUMN birth to birthday;

--테이블 삭제
drop table gibon;
select * from gibon;


--[시퀀스]
--유일한 값 생성해주는 오라클객체
--기본키에 순차적으로 증가하는 컬럼을 자동생성
--증감숫자가 최대값에 도달하면 생성을 중단할지(nocycle) 아니면 처음부터 다시 생성할지(cycle) 
--메모리에 시퀀스를 미리 할당(cache) 혹은 할당하지 않음(nocache)

--시퀀스 기본으로 생성. 1부터 1씩 증가하는 시퀀스 생성됨
create SEQUENCE seql;

--전체시퀀스확인
select * from seq;

--시퀀스에서 다음시퀀스 발생해서 콘솔에 출력 ** 제일 많이 쓰게 됨 
select seql.nextval from dual;
--시퀀스에서 마지막에 발생한값
select seql.currval from dual;

--seql 시퀀스 삭제
drop SEQUENCE seql;

--10부터 5씩 증가하는 시퀀스를 생성- cache값은 없애기
create SEQUENCE seq1 start with 10 INCREMENT by 5 nocache;

--시퀀스 발생
select seq1.nextval from dual;
select seq1.currval from dual;
select * from seq;

--시퀀스 삭제
drop SEQUENCE seq1;

--seq1 :시작값 5 증가값 5 캐시 no
create SEQUENCE seq1 start with 5 INCREMENT by 5 NOCACHE;
select seq1.nextval from dual;

-- seq2 시작값 1 증가값 2 
create SEQUENCE seq2 INCREMENT by 2;
select seq2.nextval from dual;


--seq3 시작값1 증가값1캐시 no
create SEQUENCE seq3  NOCACHE;
select seq3.nextval from dual;

--1,2,3시퀀스 삭제
drop SEQUENCE seq1;
drop SEQUENCE seq2;
drop SEQUENCE seq3;


--시퀀스 생성후 테이블 생성하고 기본키 발생시킬때 시퀀스 적용해보기 
create SEQUENCE seq_test;

--테이블 생성
create table person(num number(5) primary key,name varchar2(20),job varchar(20),gender varchar2(20),age number(3), hp varchar2(20), birth date);

--구조확인
desc person;

--birth를 ipsaday로 바꿔보자
alter table person rename COLUMN birth to ipsaday;

--조회연습을 위해서 10개 이상 데이터 추가(시퀀스 추가)
insert into person VALUES(seq_test.nextval, '이영지','요리사','여자',20,'010-1111-2456','2025-01-12');
insert into person VALUES(seq_test.nextval, '김수환','교사','남자',23,'010-4587-2456','2025-06-12');
insert into person VALUES(seq_test.nextval, '김민지','개발자','여자',25,'010-2541-2456','2025-11-19');
insert into person VALUES(seq_test.nextval, '홍민지','요리사','여자',29,'010-1111-2456','2025-08-12');
insert into person VALUES(seq_test.nextval, '이영지','요리사','여자',25,'010-1111-2456','2025-01-12');
insert into person VALUES(seq_test.nextval, '이영자','교사','여자',29,'010-1248-2456','2024-01-12');
insert into person VALUES(seq_test.nextval, '허민','요리사','여자',33,'010-5555-2456','2024-11-12');
insert into person VALUES(seq_test.nextval, '이영지','요리사','남자',25,'010-1111-2456','2025-01-12');
insert into person VALUES(seq_test.nextval, '이영지','요리사','남자',25,'010-1111-2456','2025-01-12');
insert into person VALUES(seq_test.nextval, '홍유미','요리사','남자',25,'010-1111-2456','2025-01-12');

--최종저장 오라클은 커밋을반드시 해줘야됨 그래야 최종 저장이 되는것임!!!
commit;

--Q,
--인원수 확인
select count(*) from person;
--이름 오름차순 출력
select name 이름 from person order by name;
--나이의 역순 출력
select age 나이 from person order by age desc;
--셩별의 오름차순, 같을경우 이름의 오름차순
select * from person order by name,gender;
--중복되지 않게 직업의 종류만 출력
--select count(*), job from person GROUP by job;
--“중복 없이 종류만” → DISTINCT
--“종류별로 몇 명 있는지” → GROUP BY
select distict job from person;
--성이 이씨인 사람만 출력
select * from person where name like '이%';
--핸드폰이 010으로 시작하는 사람출력
select * from person where hp like '010%';
--입사월이 10월인 사람출력
select * from person where to_char(ipsaday,'mm')='10';
--입사년도가 2025년도만 출력
select * from person where to_char(ipsaday,'yy')='25';
--나이가 20~25세 사이(and)
select age,name from person where age>=20 and age<=25;
--나아기 20~25세 사이 (between)
select age,name from person where age between 20 and 25;
--직업이 교사이거나 개발자인 사람 (in)
select name,job from person where job in('개발자','교사');
--직업이 교사이거나 개발자인 사람 (or)
select name,job from person where job='개발자' or job='교사';
--직업이 교사,개발자를 제외한 직업을 가진 사람 조회
select * from person where job not in ('교사','개발자');
 


--update
--update 테이블명 set column=value where 조건;
-- ⚙️ 시퀀스로 조건을 주는 것이 안전한 이유
-- 동일한 데이터(예: 이름, 직업, 나이 등)는 변경될 가능성이 있으므로
-- WHERE 절에서 이런 값으로 조건을 걸면 정확한 데이터 식별이 어렵다.
-- 반면 시퀀스(NUM)는 유일하고, 한 번 생성되면 변하지 않는 고유값이므로
--**데이터 식별, 수정, 삭제 시에는 반드시 시퀀스로 조건을 주는 게 안전하다!!!!

--모든 컬럼변경
update person set job='간호사', age=33;
--시퀀스 3번만 바꾸기
update person set job='개그맨', age=33 where num=3;
--이씨이면서 요리사인 사람의 젠더를 남자로 수정해주기
update person set gender='남자' where name like '이%' and job='요리사';

--num이 8번인 사람의 직업을 교수, 입시일을 2025-01-02로 변경
update person set job='교수', ipsaday='2025-01-02' where num=8;

--삭제
--5번 삭제
delete from person where num=5;

--여자이면서 30세이상 모두 삭제
delete from person where gender='여자' and age>=30;

--DML에서 잘못수정된 데이터 원래대로 돌려놓기
rollback;

commit;

select * from person;



DELETE FROM person;
COMMIT;
DROP SEQUENCE seq_test;


--[과제물]
--시퀀스생성
create SEQUENCE seq4 start with 4 INCREMENT by 5;
drop SEQUENCE seeq4;
--seq_4  시작:5   증가:5

--테이블 생성
create table moim(no number(3) primary key, name varchar2(20), addr varchar2(30), hp varchar(20), job varchar(23),gaipday date);
--테이블명:  moim  
--no  number(3)  기본키:   seq값 
--name  varchar2(20)
--addr  varchar2(30)
--hp  varchar2(20)
--job   varchar2(30)
--gaipday   오늘날짜


--최소 10개 이상 넣어오세요(commit필수
INSERT INTO moim VALUES (seq4.nextval, '이영지', '서울 강남구', '010-1111-2222', '요리사', TO_DATE('2025-01-12','YYYY-MM-DD'));
INSERT INTO moim VALUES (seq4.nextval, '김수환', '경기 성남시', '010-2222-3333', '교사', TO_DATE('2025-02-15','YYYY-MM-DD'));
INSERT INTO moim VALUES (seq4.nextval, '강민지', '부산 해운대구', '010-3333-4444', '개발자', TO_DATE('2025-03-01','YYYY-MM-DD'));
INSERT INTO moim VALUES (seq4.nextval, '박소연', '서울 마포구', '010-4444-5555', '간호사', TO_DATE('2025-03-22','YYYY-MM-DD'));
INSERT INTO moim VALUES (seq4.nextval, '정윤호', '인천 미추홀구', '010-5555-6666', '디자이너', TO_DATE('2025-04-10','YYYY-MM-DD'));
INSERT INTO moim VALUES (seq4.nextval, '최은지', '대전 서구', '010-6666-7777', '마케터', TO_DATE('2025-04-30','YYYY-MM-DD'));
INSERT INTO moim VALUES (seq4.nextval, '한지민', '광주 북구', '010-7777-8888', '개발자', TO_DATE('2025-05-03','YYYY-MM-DD'));
INSERT INTO moim VALUES (seq4.nextval, '이도현', '서울 송파구', '010-8888-9999', '요리사', TO_DATE('2025-06-20','YYYY-MM-DD'));
INSERT INTO moim VALUES (seq4.nextval, '서지우', '경남 창원시', '010-9999-0000', '회계사', TO_DATE('2025-07-11','YYYY-MM-DD'));
INSERT INTO moim VALUES (seq4.nextval, '김하늘', '서울 종로구', '010-0000-1111', '교사', TO_DATE('2025-08-05','YYYY-MM-DD'));

select * from moim; 
commit;

