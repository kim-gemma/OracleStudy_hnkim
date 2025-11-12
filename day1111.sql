--조회연습하기 (별칭 alias)
select ename "사원명" from emp; --병칭을 띠어쓰고자 하면 반드시 **
select ename 사원명,sal as 급여 from emp; --as 별칭
select * from emp;

--emp에서 사원명과 직업을 조회하시오
select ename 사원명,job 직업 from emp;

--직업만 출력
select job from emp; 

--직업만 출력하는데 겹치는거 없이 한번만 할경우(중복제거)
select DISTINCT job from emp;

--표현식(컬럼외에 출력을 원하는 내욜을 select 구문뒤에 ' ' 사용)
--사원명뒤에 '오늘근무중'
SELECT ename 사원명, '오늘 근무중' from emp;

--문자끼리 더해서 출력해주는 연산자 ||
--emp 테이블에서 My name is SMITH !!!
select 'My name is '||ename||' !!!' from emp;
--emp에서 SMITH님의 직업은 CLERK입니다
select ename||'님의 직업은'||job||'입니다' from emp;

--profrssor에서 송강님은 평교수입니다
select name||'님은'||position||'입니다' from professor;

--정렬 오름차순 asc 내림차순 desc order by절은 맨마지막에 오도록 한다
select name 학생명,grade 학년, birthday 생년월일 from student order by name asc; --asc는 생략가능
select name 학생명,grade 학년, birthday 생년월일 from student order by name desc; --1은 1열을 의미

select name 학생명,grade 학년, birthday 생년월일 from student order by grade asc;

--emp에서 급여가 높은 순으로 사원명,급여를 조회하시오
select ename 사원명,sal 급여 from emp order by sal desc;

--조건절(where)
--select [원하는컬럼] from [table] where 원하는 조건;

--emp에서 deptno가 20번인 사원명과 부서번호를 출력하시오
select ename 사원명,deptno 부서번호 from emp where deptno=20;
--emp에서 급여가 3000만원 이상인 사원명과 급여를 조회하시오
select ename 사원명,sal 급여 from emp where sal>= 3000;
--smith의 모든 정보 조회하시오
select * from emp where ename='SMITH'; --무조건 글자 조회하려면 대소문자 맞춰서 조회하기
--문자와 날짜는 모두 ' ' 1985-10-29 / / 문자는 대소문자 구별 
select * from emp where hiredate>'1985/01/01';

--학생테이블에서 키가 180이상인 학생명과 신장을 조회해보세요
select name 학생명,height 신장 from student where height>=180;

--between A(작은거) and B(큰거)
--학생몸무게 60~80kg까지를 학생명과 몸무게열로 조회하시오
--select name 학생명, weight 몸무게 from student where weight between 60 and 80 order by weight;

--AND연산자
select name 학생명,weight 몸무게 from student where weight >=60 AND weight<=80;

--IN연산자
--부서번호가 20,30만 사원명 부서번호(기본으로 출력해야됨)출하라 // 부서번호는 기본으로 출력해야된다
select ename 사원명,deptno 부서번호 from emp where deptno IN(20,30);
--직업이 SALESMAN,MANAGER인 사람의 사원명과 직업을 출력하시오
select ename 사원명,job 직업 from emp where job IN('SALESMAN','MANAGER');

--OR연산자
select ename 사원명,deptno 부서번호 from emp where deptno=20 OR deptno=30;
select ename 사원명, job 직업 from emp where job='SALESMAN' OR job='MANAGER'; 

--ISNULL & IS NOT NULL
--보너스가 없는 사원명만 출력하기
select ename 사원명 from emp where comm is null;
--보너스 받는 사람의 사원명과 보너스금액을 조회
select ename 사원명,comm 보너스금액 from emp where comm is not null; 
-- IS NOT NULL : NULL이 아닌 데이터(즉, 보너스 컬럼에 값이 있는 행)만 조회
-- 단, comm이 0인 경우도 NULL이 아니므로 함께 조회됨
-- → 실제 보너스를 받는 사람만 보려면 "comm > 0" 조건을 추가해야 함

-- 예시) 보너스 금액이 0보다 큰 사원만 조회하려면 아래처럼 수정
-- SELECT ename AS 사원명, comm AS 보너스금액
-- FROM emp
-- WHERE comm > 0;


-- 기존 컬럼명을 다른 이름(별칭)으로 지정해 조회할 수 있다.
-- NVL(컬럼명, 대체값) 함수: 해당 컬럼 값이 NULL이면 지정한 대체값으로 바꿔준다.
-- NULL과의 연산 결과는 항상 NULL이므로,
-- 급여 + 보너스 계산 시 보너스(comm)가 NULL이면 총합이 NULL로 표시된다.
-- → 따라서 NVL 함수를 이용해 NULL을 0으로 바꾸어 계산해야 한다.

-- 예시 1) NULL 값 그대로 계산할 경우 (800 + NULL = NULL)
SELECT ename AS 사원명,
       sal   AS 급여,
       comm  AS 보너스,
       sal + comm AS 실제급여
FROM emp;

-- 예시 2) NVL 함수를 사용하여 NULL을 0으로 대체
SELECT ename AS 사원명,
       sal   AS 급여,
       NVL(comm, 0) AS 보너스,
       sal + NVL(comm, 0) AS 실제급여
FROM emp;
-- NVL(comm, 0): comm 컬럼 값이 NULL이면 0으로 바꿔 계산
-- 모든 사원의 실제 급여가 정확히 계산되어 조회됨

-- COUNT 함수
-- 1) COUNT(*) : 테이블의 전체 행(Row) 수를 계산한다. 
--               모든 컬럼을 대상으로 하며 NULL 값이 포함된 행도 카운트한다.
-- 2) COUNT(컬럼명) : 지정한 컬럼의 NULL이 아닌 값만 카운트한다. 
--                   즉, 해당 컬럼이 NULL이면 그 행은 제외된다.

-- 예시
SELECT COUNT(*)      -- 전체 행의 개수 (NULL 포함)
FROM emp;

SELECT COUNT(sal)    -- sal 컬럼에서 NULL이 아닌 데이터의 개수만 계산
FROM emp;

--emp에서 MGR이 7092,7690인 사원명과 MGR을 출력하시오 (단 IN)
select ename 사원명,mgr from emp where  MGR IN (7902,7690);  --mgr은 소문자도 상관없음

--사원명이 JAMES인 사람의 사원명 급여 총급여를 조회하시오
select ename 사원명,sal 급여, sal+NVL(comm,0) 총급여 from emp where ename='JAMES';

--professor 에서 정교수만 교수명 직급(졍교수)을 출력하시요(단 이름의 오름차순)
select name 교수명, position 직급 from professor where position='정교수' order by name asc;


--LKE 
--% 여러개의 문자를 대체해주고 _(언더바) 하나의 문자대체
--교수테이블에서 이씨만 조회
select name 교수명 from professor where name LIKE '김%'; -- 김씨로 시작하는 이름데이터 조회

--emp에서 사원명이 S로 시작하는 사원 조회
select ename 사원명 from emp WHERE ename LIKE 'S%';
--emp에서 사원명이 K로 끝나는 사원 조회
select ename 사원명 from emp WHERE ename LIKE '%K';
--emp에서 사원명의 세번째 글자가 R인사원 조회
select ename 사원명 from emp WHERE ename LIKE '__R%';
--job에 두번째 글자가 n인 사원명과 직업을 조회
select ename 사원명, job 직업 from emp where job LIKE '_N%';

-- 학생 테이블에서 이름에 '주'가 포함된 학생을 조회하는 쿼리
--'%주%' : '주'가 포함된 문자열 검색 (앞뒤 어떤 문자도 가능)
select name 이름 from student where name LIKE '%주%'; 


--사원번호 사원명 입사일을 조회하되 82년이후 입사했거나 직업이 MANAGER인 사람을 조회할것(or)
--WHERE hiredate >= '1982-01-01'  -- 1982년 1월 1일 이후 입사자 
select empno 사원번호, ename 사원명, hiredate 입사일 from emp where hiredate>='1982-01-01' or job='MANAGER';

--사원번호 사원명 총급여 출력하시오(단 sal*12+comm이 총급여임)
select ename 사원명, sal*12+NVL(comm,0) 총급여 from emp;

--사원명에 s가 들어이는 사람을 모두 출력하되 사원명, 입사일을 조회하시오(단 사원명의 오름차순)
select ename 사원명, hiredate 입사일 from emp where ename LIKE '%S%' order by 사원명  asc; --별칭으로 정렬됨

--급여가 3000만원 이상이고 직급은 ANNALYST인 사람을 사원명 급여로 조회하시오
select ename 사원명, sal 급여 from emp where sal>=3000 AND job='ANALYST';

--4학년 학생중에서 키가 180cm이상인 학생의 학생명 키를 조회하시오
select name 학생명,grade 학년, height 키 from student where grade=4 AND height>=180; --조건을 준 컬럼을 조회해주기


--2차정렬 (다중정렬)
select empno 사원번호, ename 사원명, sal 급여,  job 직업,hiredate 입사일 from emp order by job, sal; --직업으로 오름차순 후에 급여가 낮은순

--학생테이블  이름,학년, 키, 몸무게 출력 (단 학년 내림차순, 키 오름차순)
select name 이름, grade 학년, height 키, weight 몸무게 from student ORDER by grade desc, height asc; 

--Q
--emp에서 SMITH님의 급여는 800만원입니다 이런형식으로 조회할것

--dept2에서 지역을 중복제거후 조회하시오

--교수테이블에서 물리학과이면서 정교수인분만 조회하시오
--고객테이블에서 포인트가 5000000이상인 사람의 이름, 주민번호를 조회하시오
--학생테이블에서 서진수의 학년과 전화번호만 조회하시오
--학생테이블에서 deptno1이 101이거나 301인 학생의 이름과 주민번호를 조회하시오


*--SQL그룹함수
--COUNT(*)
--SUM(합계)
select count(bonus), sum(bonus) from professor;
--avg(평균)
select avg(bonus) from professor;
-- MAX MIN
select count(bonus),sum(bonus),avg(bonus),max(bonus),min(bonus) from professor;
select max(hiredate),min(hiredate) from emp;
--emp의 급여평균 소수점 2자리로 round
select round(avg(sal),2) from emp;
select round(avg(sal),1) from emp; --소수점 1자리
select round(avg(sal),0) from emp;--소수점 없이 반올림
select round(avg(sal),-1) from emp;--10단위로 반올림하여 출력 (일의 자리 0으로 표시)
select round(avg(sal),-2) from emp;--100단위로 반올림하여 출력 (십의 자리와 일의 자리 00으로 표시)
select * from professor;
select * from emp;

--콘솔에 출력
select sysdate from dual; --현재날짜
select sysdate+1 from dual; --내일날짜
select sysdate+7 from dual; --일주일뒤

--to_char함수통해서날짜및 수치데이터를 문자로 변화하기 위한 함수
select to_char(sysdate,'year') from dual; --영어로 나옴 twenty twenty-five
select to_char(sysdate,'yyyy') from dual; ---2025
select to_char(sysdate,'yy') from dual;  --25

--월만 추출
select to_char(sysdate,'month') from dual;--11월 
select to_char(sysdate,'mm') from dual; --11

--to_char 숫자에도 적용가능하다
select to_char(245879,'999,999,999')from dual; --숫자에 천단위 구분기호

--emp 사원번호 사원명 입사년도 만 조회하시오
select empno 사원번호,ename 사원명,to_char(hiredate,'yyyy') 입사년도 from emp;
--emp 사원번호 사원명 입사월 조회하시오
select empno 사원번호,ename 사원명,to_char(hiredate,'mm') 입사월 from emp;
--emp 급여표시
select empno 사원번호,ename 사원명,to_char(sal,'$999,999')  급여 from emp; 


--서브쿼리
--쿼리안에 또다른 쿼리담김
--Smith의 급여보다 많이 받는 사람은  2가지 질문?
--select 컬럼2,컬럼2
--from 테이블
--where조건연산자 (select컬럼명 from 테이블 where조건);
--메인쿼리(서브쿼리)
--서브쿼리가 먼저 수행되서 결과값을 메인쿼레에 전해주고 그값을 받아서 메인쿼리에 수행
--서브쿼리는 orderby는 못함 정렬 x

--평균연봉보다 더많이 받는 사람들의 목록을 조회하시오
select *from emp where sal >(select avg(sal) from emp);

--이름이 scott인 사람의 mgr과 같은 mgr을 가진 사람의 목록을 출력하시오
select *from emp where mgr =(select mgr from emp where ename='SCOTT');

--학생테이블에서 4학년 평균키보다 큰사람의 학생명,주민번호,키를 구하시오
select name 학생명, jumin 주민, height 키 from student where height > (select avg(height) from student where grade=4);

--james와 급여가 동일하거나 더많이 받는 사원명과 급여를 조회하시오
select ename 사원명, sal 급여 from emp where sal >=(select sal from emp where ename='JAMES');

--Q.
--1. emp에서 표현식을 이용하여 다음처럼 출력하시오   SMITH(CLERK)
select ename||'('||job||')' from emp;

--2.교수테이블에서 이름,급여,보너스,총급여를 구하시오
select name 이름,pay 급여,NVL(bonus,0) 보너스,pay+NVL(bonus,0) 총급여 from professor;

--3.고객테이블에서 포인트가 30~50만 사이인 사람의 이름과 포인트를 출력하시오
select gname 이름,point 포인트 from gogak where point between 300000 and 500000;

--4.교수테이블에서 성이 김씨인 사람의 이름,직위,전공과목을 조회하시오
select name 이름,position 직위,deptno 전공과목 from professor where name like '김%';

--5.emp에서 comm이 null인 사람의 이름과 급여를 출력하시오
select ename 이름,sal 급여 from emp where comm is null;

--6.학생테이블에서 4학년중에서 키가 170보다 작거나 몸무게가 60보다 큰학생의 이름,학년,키,몸무게를 조회하시오
select name 이름,grade 학년,height 키,weight 몸무게 from student where grade=4 and (height<170 or weight>60);

--7.emp에서 comm의 null을 0으로 바꾸어서 직업이 MANAGER인 사람만 이름과 보너스 출력하시오
select ename,NVL(comm,0) from emp where job='MANAGER';

--8.1학년 학생의 이름,키,몸무게 출력하시오 단 몸무게 많은순으로 정렬하세요
select name,height,weight from student where grade=1 order by weight desc;

--9.교수테이블에서 나한열의 pay와 같은 페이를 받은 교수명과 pay를 조회하시오
select name,pay from professor where pay=(select pay from professor where name='나한열');

--10.교수테이블에서 조인형의 직급과 같은 직급을 가진 사람의 이름 급여 직급을 조회하시오
select name,pay,position from professor where position=(select position from professor where name='조인형');











