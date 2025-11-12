--[그룹함수 복습]
select sum(sal) 합계 from emp;
select sum(pay) 총급여 from professor;

--자리수,전체합계와 평균(소수점이하 한자리 반올림)
select sum(sal) 합계,round(avg(sal),1) 평균 from emp;
select sum(pay) 합계,round(avg(pay),2) 평균 from professor;

--최대급여 최소급여
select max(pay) 최대급여,min(pay) 최소급여 from professor;

--emp에서 입사월이 5월인 사람만 출력하시오(to_char)
select * from emp where to_char(hiredate,'MM')='05';--월을 숫자2자리로 출력
--입사년 81년 검색하시오(to_char)
select * from emp where to_char(hiredate,'YY')='81';

select * from emp where hiredate between '81/01/01' AND '81/12/31';
select * from emp where hiredate >= '81/01/01' AND hiredate <= '81/12/31';

--[특정조건으로 세부적인 그룹화하기-GROUP BY]
--select절에 사용된 그룹함수이외에 컬럼은 반드시 groub by절에 포함이 되야한다

--professor에서 학과별로 교수들의 평균급여를 출력하시오
select deptno,avg(NVL(pay,0)) "평균 급여"
from professor
group by deptno;

--학과별,직급별로 교수들의 평균급여를 조회
select deptno,position,avg(NVL(pay,0)) "평균 급여"
from professor
group by deptno,position;

--학생테이블에서 학년별 최고몸무게,평균키를 구하시오
select grade,max(weight),avg(height)
from student
group by grade;

--같은 직무를 가진 사원수 구하기(emp)
--MANAGER 4
select job 직무,count(empno) 사원수
from emp
group by job;

--직무별로 sal의 평균급여 구하시오
select job,round(avg(sal),2) from emp group by job;
--교수직급별로 최고급여와 최고보너스를 구하시오
select position,max(pay),max(bonus) from professor group by position;
--교수 직급별 인원수 구하시오
select position,count(*) 인원수 from professor group by position;
--학년별 인원수,평균키,평균몸무게 구하시오
select grade 학년,count(*) 인원수,avg(height) 평균키,avg(weight)몸무게 from student group by grade;


--[Having절은 Group by에 조건을 줄때 쓰인다]
--where --> group by --> having -->order by
--학과별 평균급여를 구하려면 groub by만 필요하다
--평균급여가 450 이상인 학과의 평균급여를 구하려면 having절이 필요

select deptno,avg(pay) 평균급여 from professor group by deptno ;--having절 제외할경우

--where 절은 그룹함수 비교조건으로 쓸수 없다
select deptno,avg(pay) 평균급여 from professor group by deptno having avg(pay)>=450; --having절 줄 경우


--emp에서 부서별로 평균급여를 구하되 2000이상만 조회하시오
select deptno,round(avg(sal),1) 평균급여 from emp group by deptno having avg(sal)>=2000;

--deptno가 10,20인 부서의 직무별 갯수는?
select job,count(*) from emp where deptno IN(10,20) group by job;

--deptno가 10,20인 부서의 직무별 갯수를 구하되 2명이상만 조회?
select job,count(*) from emp where deptno IN(10,20) group by job having count(*)>=2;

--직무별 인원수와 총급여를 구하되 인원이 2명이상이고 총급여가 6000이상인 직무만 표시해보세요
select job,count(*) 인원수,sum(sal) 총급여 from emp group by job having count(*)>=2 AND sum(sal)>=6000;

--모든 where 조건과 group by ,having,order by 다포함
select job,sum(sal) "급여합계"
from emp
where job not in ('MANAGER') --MANAGER는 제외
group by job --직무별로 그룹화
having sum(sal)>=5000  --급여합계 5000 이상만
order by 급여합계 desc;  --급여합계 내림차순

--[Rollup,cube]자동으로 소계/합계 구해주는 함수
--Rollup :  group by절에 주어진 조건으로 소계값구해준다

select deptno 학과번호,position 직위,sum(pay) 총급여
from professor
group by position,rollup(deptno);

select position 직위,count(*),sum(pay)
from professor
group by rollup(position);

--cube 소계 총계까지 맨위에 나옴
select deptno,position,count(*),sum(pay) from professor group by cube(deptno,position);


--WHERE : 그룹 전에 행 단위 조건
--HAVING : 그룹 후 집계 결과 조건
--GROUP BY : 그룹을 묶는 역할만
--GROUP BY	단순 그룹화
--ROLLUP(a,b)	a별 → a,b별 → 전체합
--CUBE(a,b)	a,b별 + a별 + b별 + 전체합
--ROLLUP	위에서 아래로 굴러가며 합계	“위→아래”
--CUBE	모든 방향으로 계산	“입체(모든 조합)”