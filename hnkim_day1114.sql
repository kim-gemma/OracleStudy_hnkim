--company 와 c_sawon 
--조인테이블
--거래처회사    거래처사원    직위
--삼성          홍길동       과장
--방법1
select company 거래처회사,sawon_name 거래처사원,position 직위
from company,c_sawon
where company.company_id=c_sawon.company_id;

--방법2
select company 거래처회사,sawon_name 거래처사원,position 직위
from company c,c_sawon s
where c.company_id=s.company_id;

--방법3
select c.company 거래처회사,s.sawon_name 거래처사원,s.position 직위
from company c,c_sawon s
where c.company_id=s.company_id;

--emp
--사원명      부서명 
--smith     20번에 해당하는 실제부서명

select ename 사원명,dname 부서명
from emp,dept
where emp.deptno=dept.deptno;

--교수명         학과명
--이수연 교수    영어영문
select name ||'교수' 교수명,dname 학과명
from professor p,department d
where p.deptno=d.deptno;

CREATE TABLE sawon (
    num       NUMBER(5) PRIMARY KEY,
    name      VARCHAR2(20),
    buseo     VARCHAR2(20),   -- 부서
    pay       NUMBER(10)      -- 급여
);

CREATE SEQUENCE seq_sawon
START WITH 1
INCREMENT BY 1
NOCACHE;

INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '김철수', '영업부', 3500000);
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '박영희', '영업부', 4200000);
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '최민수', '영업부', 3900000);

INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '이서현', '개발부', 5000000);
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '정우성', '개발부', 6200000);
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '한지민', '개발부', 5800000);

INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '송중기', '인사부', 3100000);
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '김태리', '인사부', 3300000);
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '김성호', '인사부', 2900000);

DROP TABLE sawon CASCADE CONSTRAINTS;
DROP SEQUENCE seq_sawon;

CREATE TABLE sawon (
    num       NUMBER(5) PRIMARY KEY,
    name      VARCHAR2(20),
    buseo     VARCHAR2(20),     -- 부서
    pay       NUMBER(10),       -- 급여
    ipsa      DATE,             -- 입사일
    gender    VARCHAR2(10)      -- 성별 (M/F 또는 남/여)
);

CREATE SEQUENCE seq_sawon
START WITH 1
INCREMENT BY 1
NOCACHE;

-- 영업부
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '김철수', '영업부', 3500000, TO_DATE('2020-03-12','YYYY-MM-DD'), '남');
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '박영희', '영업부', 4200000, TO_DATE('2019-07-20','YYYY-MM-DD'), '여');
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '최민수', '영업부', 3900000, TO_DATE('2021-02-10','YYYY-MM-DD'), '남');

-- 개발부
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '이서현', '개발부', 5000000, TO_DATE('2018-11-03','YYYY-MM-DD'), '여');
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '정우성', '개발부', 6200000, TO_DATE('2017-06-18','YYYY-MM-DD'), '남');
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '한지민', '개발부', 5800000, TO_DATE('2019-09-25','YYYY-MM-DD'), '여');

-- 인사부
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '송중기', '인사부', 3100000, TO_DATE('2022-04-14','YYYY-MM-DD'), '남');
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '김태리', '인사부', 3300000, TO_DATE('2020-01-30','YYYY-MM-DD'), '여');
INSERT INTO sawon VALUES(seq_sawon.NEXTVAL, '김성호', '인사부', 2900000, TO_DATE('2023-05-09','YYYY-MM-DD'), '남');

COMMIT;


