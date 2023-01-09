-- ## 그룹함수(Group)
-- 여러 개의 값이 들어가서 한 행의 결과만 나오는 함수
-- *** SUM, AVG, COUNT, MAX, MIN ***

--@실습예제
--1. [EMPLOYEE] 테이블에서 남자 사원의 급여 총 합을 계산
--SELECT SUM(SALARY)
    -- 콤마(,) 찍어서 표현해보기
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999,999') "급여 총 합"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

--2. [EMPLOYEE]테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉을 계산
    -- BONUS에는 NULL이 포함되어있으니 NULL은 0으로 표현
--SELECT SUM(SALARY*12 + SALARY*NVL(BONUS,0))
    -- 콤마(,) 찍어서 표현해보기
SELECT TO_CHAR(SUM(SALARY*12 + SALARY*NVL(BONUS,0)), 'L999,999,999,999') "연봉"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--3. [EMPLOYEE] 테이블에서 전 사원의 보너스 평균을 소수 둘째짜리에서 반올림하여 구하여라
    -- BONUS에는 NULL이 포함되어있으니 NULL은 0으로 표현
    -- ROUND(올림) 사용하여 2째 자리에서 올림
SELECT ROUND(AVG(NVL(BONUS, 0)),2)
FROM EMPLOYEE;

--4. [EMPLOYEE] 테이블에서 D5 부서에 속해 있는 사원의 수를 조회
    -- COUNT에 '*'을 넣으면 속도가 조금 더 빨라진다
SELECT COUNT(EMP_NAME) "사원의 수", COUNT(*) "빠름"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';
-- ex) EMPLOYEE 테이블에 저장된 데이터의 수를 구하시오
SELECT COUNT(*)
FROM EMPLOYEE;

--5. [EMPLOYEE] 테이블에서 사원들이 속해있는 부서의 수를 조회 (NULL은 제외됨)
    -- NULL 제외 -> IS NOT NULL;
    -- 부서의 '수' = 중복제거 -> DISTINCT 함수
SELECT COUNT(DISTINCT(DEPT_CODE))
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

--6. [EMPLOYEE] 테이블에서 사원 중 가장 높은 급여와 가장 낮은 급여를 조회
SELECT MAX(SALARY), MIN(SALARY) FROM EMPLOYEE;

--7. [EMPLOYEE] 테이블에서 가장 오래된 입사일과 가장 최근 입사일을 조회하시오
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE) FROM EMPLOYEE;




-- ## GROUP BY 절
-- 별도의 그룹 지정없이 사용한 그룹함수는 단 한개의 결과값만 산출하기 때문에
-- 그룹함수를 이용하여 어러 개의 결과값을 산출하기 위해서는
-- 그룹함수가 적용될 그룹의 기준을 'GROUP BY절'에 기술하여 사용해야 함.
-- ex1) 부서별 급여합계를 구해보세요
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE;

-- ex2)직급별 급여합계를 구해보세요.
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- ex3) [EMPLOYEE]테이블에서 부서코드 그룹별 급여의 합계, 그룹별 급여의 평균(정수처리)
--      , 인원수를 조회하고, 부서코드 순으로 정렬
SELECT DEPT_CODE, TO_CHAR(SUM(SALARY), 'L999,999,999'), TO_CHAR(AVG(SALARY),'L999,999,999')
, COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE;

-- ex4) [EMPLOYEE]테이블에서 부서코드 그룹별, 보너스를 지급받는 사원 수를 조회하고 부서코드 순으로 정렬
-- BONUS컬럼의 값이 존재한다면, 그 행을 1로 카운팅.
-- 보너스를 지급받는 사원이 없는 부서도 있음.
SELECT DEPT_CODE, COUNT(BONUS), COUNT(*)
    -- COUNT(*)은 NULL인 값도 모두 조회한다
FROM EMPLOYEE
--WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE 
ORDER BY DEPT_CODE ASC;
--> FROM -> WHERE -> GROUP BY -> SELECT -> ORDER BY


--@실습문제
--1. EMPLOYEE 테이블에서 직급이 J1을 제외하고, 직급별 사원수 및 평균급여를 출력하세요.
SELECT JOB_CODE AS 직급, COUNT(EMP_ID) AS "직급별 사원 수", TO_CHAR(AVG(SALARY), 'L999,999,999') AS 평균급여
FROM EMPLOYEE
WHERE JOB_CODE <> 'J1'
-- 제외하는 경우는 '!='도 가능하지만 '<>' 로 표현한다.
GROUP BY JOB_CODE;

--2. EMPLOYEE테이블에서 직급이 J1을 제외하고,  입사년도별 인원수를 조회해서, 입사년 기준으로 오름차순 정렬하세요.
SELECT EXTRACT(YEAR FROM HIRE_DATE)||'년' AS 입사년도, COUNT(*) AS 사원수
--SELECT EXTRACT(YEAR FROM HIRE_DATE)||'년' AS 입사년도, COUNT(EMP_ID)||'명' AS "사원 수"
FROM EMPLOYEE
WHERE JOB_CODE <> 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY EXTRACT(YEAR FROM HIRE_DATE) ASC;

--3. [EMPLOYEE] 테이블에서 EMP_NO의 8번째 자리가 1, 3 이면 '남', 2, 4 이면 '여'로 결과를 조회하고,
-- 성별별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬 하시오
SELECT DECODE(SUBSTR(EMP_NO, 8,1),'1','남','2','여','3','남','4','여') AS 성별
        , FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*) AS "인원 수"
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8,1),'1','남','2','여','3','남','4','여')
ORDER BY COUNT(*) DESC;

--4. 부서내 성별 인원수를 구하세요.
SELECT DECODE(SUBSTR(EMP_NO, 8,1),'1','남','2','여','3','남','4','여') AS 성별, COUNT(*) AS 인원수
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8,1),'1','남','2','여','3','남','4','여');

--5. 부서별 급여 평균이 3,000,000원(버림적용) 이상인  부서들에 대해서 부서명, 급여평균을 출력하세요.
SELECT DEPT_CODE, TO_CHAR(FLOOR(AVG(SALARY)),'L999,999,999')
FROM EMPLOYEE
--WHERE FLOOR(AVG(SALARY)) >= 3000000
-- 나온 산출값의 조건이므로 SELECT문의 조건이 아닌 GROUP BY의 조건문이 된다. => HAVING사용
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000;




-- ## HAVING절
-- 그룹함수로 값을 구해온 그룹에 대해 조건을 설정할 때는 HAVING절에 기술함 !
-- (WHERE절은 사용 불가!)

--@실습문제
--1. 부서별 인원이 5명보다 많은 부서와 인원수를 출력하세요.
SELECT DEPT_CODE AS 부서, COUNT(*) AS 인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) > 5;

--2. 부서별 내 직급별 인원수가 3명이상인 직급의 부서코드, 직급코드, 인원수를 출력하세요.
SELECT DEPT_CODE AS 부서코드, JOB_CODE AS 직급코드, COUNT(*) AS 인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
-- 여러개의 GROUP을 지정하려면 해당 컬럼들을 ,(콤마)로 이어 적어준다.
HAVING COUNT(*) >= 3
ORDER BY 1 ASC;

--3. 매니저가 관리하는 사원이 2명 이상인 매니저 아이디와 관리하는 사원 수를 출력하세요.
SELECT MANAGER_ID, COUNT(*)
FROM EMPLOYEE
GROUP BY MANAGER_ID
HAVING COUNT(*) >= 2 AND MANAGER_ID IS NOT NULL
ORDER BY 1;




-- ## ROLLUP과 CUBE
-- 두 함수 모두 '전체합계'를 출력하는 함수.
-- 컬럼의 수가 2개 이상일 때 ROLLUP과 CUBE의 차이를 알 수 있다.
-- CUBE가 출력 행 수가 더 많다.

-- # ROLLUP(전체합계를 출력1)
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;

-- # CUBE(전체합계를 출력2)
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY 1;

-- [ROLLUP과 CUBE의 차이]
--@예제1. ROLLUP 함수 사용 (각 부서코드별 합계 + 전체합계를 확인할 수 있다.)
-- 부서 내 직급별 급여 합계를 구하시오.
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
-- 부서별 급여 합계(NULL컬럼 포함), 전체 합계를 확인할 수 있다.
ORDER BY 1;

--@예제2. CUBE 함수 사용 (각 부서코드별 합계 + 각 직급별 급여합계, 전체합계를 확인할 수 있다.)
-- 부서 내 직급별 급여 합계를 구하시오.
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
-- 부서별 급여합계(NULL컬럼 포함), 직급별 급여합계, 전체 합계를 확인할 수 있다.
-- CUBE가 ROLLUP보다 출력이 많다.
ORDER BY 1;
