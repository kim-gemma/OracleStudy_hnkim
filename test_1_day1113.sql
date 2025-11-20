--[본인 첫번째 만든 계정]
--1.department테이블에 다음을 일부만 insert할것
--102 영어영문학과 
--103 유아교육학과
--201 사이버학과
--202 경제학부
insert into department (deptno,dname)values(102,'영어영문학과');
insert into department (deptno,dname)values(103,'유아교육학과');
insert into department (deptno,dname)values(201,'사이버학과');
insert into department (deptno,dname)values(202,'경제학부');

--2. professor테이블에 전체데이타 insert할것
--4008 홍길동 hong 조교수 440 85/01/01 100 103 hong@gmail.com http://hong.abc.com
insert into professor values(4008,'홍길동','hong','조교수',440,'85/01/01',100,103,'hong@gmail.com','http://hong.abc.com');


--3. professor테이블에서 김영조의 직급을 정교수로 변경하시오
update professor set position='정교수' where profno=2002;

--4. professor테이블에서 4005 바비님의 데이타를 삭제하시오
delete from professor where profno=4005;

--5.학생테이블에서 서진수의 담당교수를 2001로 수정하시오
update student set profno=2001 where studno=9411;

--어제 과제물 test계정 열어서 할것!!!!
--[과제물]
--시퀀스생성
--seq_4  시작:5   증가:5
create sequence seq_4 start with 5 increment by 5;

--select seq_4.nextval from dual;

--테이블 생성
--테이블명:  moim  
--no  number(3)  기본키:   seq값 
--name  varchar2(20)
--addr  varchar2(30)
--hp  varchar2(20)
--job   varchar2(30)
--gaipday   오늘날짜

create table moim (no number(3) primary key,name varchar2(20),addr varchar2(30),hp varchar2(20),job varchar2(30),gaipday date);


--최소 10개 이상 넣어오세요(commit필수)_바리스타,카페매니져,머신수리
insert into moim values(seq_4.nextval,'홍길동','서울시 강남구','010-222-3333','바리스타',sysdate);
insert into moim values(seq_4.nextval,'홍민지','대구시 대구동','010-111-5555','카페매니져',sysdate);
insert into moim values(seq_4.nextval,'윤선아','세종시 유남동','010-222-7458','바리스타',sysdate);
insert into moim values(seq_4.nextval,'김선아','서울시 관악구','010-555-1111','바리스타',sysdate);
insert into moim values(seq_4.nextval,'이태주','경기도 용인시','010-777-5269','머신수리',sysdate);
insert into moim values(seq_4.nextval,'박태민','서울시 강남구','010-999-8888','카페매니져',sysdate);
insert into moim values(seq_4.nextval,'송주영','서울시 강남구','010-111-3333','머신수리',sysdate);
insert into moim values(seq_4.nextval,'홍길동','서울시 강북구','010-555-9856','카페매니져',sysdate);
insert into moim values(seq_4.nextval,'이민지','서울시 강서구','010-333-5411','머신수리',sysdate);
insert into moim values(seq_4.nextval,'김유라','서울시 강남구','010-222-5879','카페매니져',sysdate);

--moim테이블에서 직업만 중복되지않게 조회하시오
select DISTINCT job from moim;

--이름이 홍씨인사람만 조회하시오
select * from moim where name like '홍%';

--40번의 직업을 카페대표로 수정하시오
update moim set job='카페대표' where no=40;

--카페매니져이거나 머신수리 인사람만 조회하시오(IN  or  Or)
select * from moim where job IN('카페매니져','머신수리');
select * from moim where job='카페매니져' or job='머신수리';

--카페매니져가 아닌사람들만 조회하시오
select * from moim where job not in('카페매니져');

--moim회원의 총인원수를 구하시오
select count(*) "총인원" from moim;




--[test계정에 테이블 생성]
--sawon 테이블을 만들어 제약조건을 공부해보자

create table sawon(num number(5) CONSTRAINT sawon_pk_num  primary key,
name VARCHAR2(20),gender VARCHAR2(20),
buseo varchar2(20) CONSTRAINT sawon_ck_buseo CHECK(buseo in('개발부','홍보부','디자인부')),
pay number(10) default 1000000,ipsa date);

--나중에 제약조건 alter로 추가해주어도 좋다 .성별은 남자 여자만 가능하게..
alter table sawon add CONSTRAINT sawon_ck_gender check(gender in('남자','여자'));

--새로운 시퀀스생성
create sequence seq_sawon;

--데이타추가
--체크 제약조건(TEST.SAWON_CK_GENDER)이 위배
--insert into sawon values(seq_sawon.nextval,'김흥수','여성','개발부',2500000,'2025-01-10');
insert into sawon values(seq_sawon.nextval,'김흥수','여자','개발부',2500000,'2025-01-10');

--체크 제약조건(TEST.SAWON_CK_BUSEO)이 위배
--insert into sawon values(seq_sawon.nextval,'김민희','여자','인사부',2700000,'2025-10-10');
insert into sawon values(seq_sawon.nextval,'김민희','여자','홍보부',2700000,'2025-10-10');

insert into sawon values(seq_sawon.nextval,'김수희','여자','디자인부',2900000,'2022-11-10');
insert into sawon values(seq_sawon.nextval,'홍수민','남자','홍보부',2800000,'2024-02-10');
insert into sawon values(seq_sawon.nextval,'김민희','여자','개발부',3200000,'2025-07-10');
insert into sawon values(seq_sawon.nextval,'김유라','여자','홍보부',2870000,'2024-10-10');
insert into sawon values(seq_sawon.nextval,'김선길','남자','홍보부',3300000,'2023-08-10');
insert into sawon values(seq_sawon.nextval,'노희숙','여자','디자인부',3500000,'2025-08-10');
insert into sawon values(seq_sawon.nextval,'김유민','남자','홍보부',2300000,'2025-10-10');
insert into sawon values(seq_sawon.nextval,'이수아','여자','디자인부',2700000,'2022-12-10');


--사원번호 5번의 성별을 남자(여자)로 변경하시오
update sawon set gender='남자' where num=5;

--10번의 입사일자를 2025-10-10일로 변경하시오
update sawon set ipsa='2025-10-10' where num=10;

--9번이 퇴사했으므로 삭제할것!!!
delete from sawon where num=9;

--그룹함수 연습   

--부서별 인원수 최고급여 최저급여 조회(제목도 별칭으로 나오게...)
select buseo 부서명,count(buseo) 인원수,max(pay) 최고급여,min(pay) 최저급여 from sawon group by buseo;

--위의 쿼리문에서 급여부분에 화폐단위 붙히고 3자리컴마도 나오도록....
select buseo 부서명,count(buseo) 인원수,to_char(max(pay),'L999,999,999') 최고급여,to_char(min(pay),'L999,999,999') 최저급여 from sawon group by buseo;

--위의 쿼리문에 인원수 2명 처럼 표기되게 수정
select buseo 부서명,count(buseo)||'명' 인원수,to_char(max(pay),'L999,999,999') 최고급여,to_char(min(pay),'L999,999,999') 최저급여 from sawon group by buseo;

--성별인원수와 평균급여,최고급여,최저급여를 구하시오(별칭,2명 포함...)
select gender 성별,count(gender) || '명' 인원수,to_char(avg(pay),'L999,999,999') 평균급여,to_char(max(pay),'L999,999,999') 최고급여,to_char(min(pay),'L999,999,999') 최저급여
from sawon group by gender;


--부서별인원,평균급여로 조회
--group by와 연결된 조건은 having..4명이상인경우만 출력 

select buseo 부서명,count(buseo) 인원수,round(avg(pay),1) 평균급여 
from sawon
group by buseo
HAVING count(buseo)>=3;

--제약조건 제거하기
--sawon테이블의 sawon_ck_buseo 를 제거해보세요
alter table sawon drop CONSTRAINT sawon_ck_buseo;

--다른부서 추가해보기(경영지원부)
insert into sawon values (seq_sawon.nextval,'김수현','남자','경영지원부',3300000,'2025-10-17');



--[조인]

--emp dept _ deptno
--사원명 부서명
select e.ename,d.dname --e,d는 테이블의 약어
from emp e,dept d
where e.deptno=d.deptno;


--사원명 회사위치
select emp.ename,dept.loc  --약어를 지정하지 않으면 테이블명.컬럼명으로 하기도함
from emp,dept
where emp.deptno=dept.deptno;

--사원명 회사위치
select ename,loc  --해당테이블에 유일하게 존재하면 테이블명 생략가능
from emp,dept
where emp.deptno=dept.deptno;

--student,department이용해서 다음과같이 출력할것
--학생명 학년 학과명
--서진수  4  컴퓨터공학과
select s.name,s.grade,d.dname
from student s,department d
where s.deptno1=d.deptno;

--student,professor
--학생명   담당교수
--이미경   나한열 교수
select s.name 학생명,p.name || '교수' "담당 교수명"
from student s,professor p
where s.profno=p.profno;


--product, panmae
--과자명  판매가  판매개수  총금액
--새우깡    800      3      2400
select p_name,p_price,p_qty,p_total
from product pr,panmae pa
where pr.p_code=pa.p_code;

--emp1  dept1
--사원명   부서    근무지
--안영희   총무부   서울
select e.name 사원명 ,d.name 부서명 ,loc 근무지
from emp1 e,dept1 d
where e.dno=d.dno;

--student   professor,department
--학번   학생명     부전공   담당교수명
-- 9514  구유미     컴퓨터공학과     허은
--(+)연산자 표시하면 null이거나 없는 데이타도 처리가능

select studno 학번,s.name 학생명,NVL(dname,'없음') 부전공과목,p.name 담당교수명
from student s,department d,professor p
where s.deptno2=d.deptno(+) and s.profno=p.profno;

--1.먼저 비정규화된 테이블만들어서 데이타 넣고 조회연습
--거래처회사,직원 테이블:  companysawon
--회사명:company문자열
--회사주소: addr 문자열
--회사전화:phone
--직원명:sawon_name
--직급: position
--이메일:email
--휴대폰:hp
create table companysawon(company varchar2(20),addr varchar2(30),phone varchar2(20),
sawon_name varchar2(20),position varchar2(20),email varchar2(20),hp varchar2(20));

--insert==>직원을 추가시마다 거래처회사에 대한 정보가 중복된다 메모리낭비가 심하다..그러므로 정규화된 테이블이 필요
insert into companysawon values('삼성','서울 강남구','02-111-2222','홍길동','과장','aaa@naver.com','010-222-3333');
insert into companysawon values('삼성','서울 강남구','02-111-2222','이수연','과장','lll@naver.com','010-555-3333');
insert into companysawon values('KT','서울 강남구','02-333-2222','이동수','부장','kkk@naver.com','010-777-8888');
insert into companysawon values('LG','서울 강동구','02-222-2222','윤계상','과장','bbb@naver.com','010-222-9999');
insert into companysawon values('KT','서울 강남구','02-333-2222','윤미라','부장','ccc@naver.com','010-1111-3333');


--2.위의 테이블을 2개로 나우어서 외부키를 이용해서 연결해보자
--회사아이디: 기본키
--회사명
--회사주소
--회사전화
create table company(company_id number(5)primary key,company varchar2(20),addr varchar2(30),phone varchar2(20));

--insert
insert into company values(10,'LG','서울 강동구','02-222-2222');
insert into company values(20,'삼성','서울 강남구','02-333-3333');
insert into company values(30,'KT','서울 강남구','02-333-2222');


--거래처 직원테이블:c_sawon
--직원명,직급,이메일,핸드폰
create table c_sawon(company_id number(5),sawon_name varchar2(20),position varchar2(20),email varchar2(20),hp varchar2(20));
--10번 거래처 회사의 직원들 2명만 추가
insert into c_sawon values(10,'홍길동','과장','hhh@gmail.com','010-214-2548');
insert into c_sawon values(10,'김수환','부장','ggg@gmail.com','010-111-2222');
insert into c_sawon values(10,'김나나','대리','jjj@gmail.com','010-555-4152');


--조인을 이용해서 한번에 출력
--회사명  회사주소   회사대표번호    거래처사원     직위   이메일    휴대전화
select company 회사명,addr 회사주소,phone 회사대표번호,sawon_name 거래처사원 ,position 직위 ,email 이메일,hp 핸드폰
from company c,c_sawon s
where c.company_id=s.company_id;


commit;