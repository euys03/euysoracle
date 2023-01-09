-- ## 집합 연산자
-- ∩(교집합), ∪(합집합), －(차집합) 등
-- ex) A = {1, 2, 4}, B = {2, 5, 7}
--     A ∩ B = { 2 } --------------> 교집합
--     A ∪ B = {1, 2, 4, 5, 7} ----> 합집합
--     A － B = {1, 4} -------------> 차집합  
--    =  A - A∩B = {1, 4}

-- 교집합 -> INTERSECT
-- 합집합 -> UNION, UNION ALL
-- 차집합 -> MINUS

-- ResultSet이란?
-- '집합연산자'를 사용하면 두 테이블을 집합연산 할 수 있다.
-- 그 때 각 테이블들(SELECT문)을 'ResultSet' 이라고 부른다.
-- # 1. INTERSECT 집합(교집합)
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;

-- # 2. UNION ALL 집합(합집합1) : 중복 허용
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;

-- # 2.1 UNION 집합(합집합2) : 중복 제거
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;

-- # 3. MINUS 집합(차집합): 31열에 갖고있는 데이터에서 34열의 데이터를 빼겠다.
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;



--## UNION의 조건 ##
-- 1. SELECT문의 컬럼 갯수가 반드시 같아야 함
-- ORA-01789: query block has incorrect number of result columns
SELECT EMP_NAME FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;

-- 2. 컬럼의 데이터 타입이 반드시 같거나 변환가능해야함 (ex. CHAR - VARCHAR2)
-- ORA-01790: expression must have same datatype as corresponding expression
-- EMP_NAME : 문자열, SALARY : 숫자 이므로 오류가 난다
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;



-- ## 조인문(JOIN)
----> 여러 테이블의 레코드를 조합하여 하나의 열로 표현한 것
----> 두 개 이상의 테이블에서 연관성을 가지고 있는 데이터들을 컬럼 기준으로 분류하여
--    새로운 가상의 테이블을 이용하여 출력함
--    다시말해, 서로 다른 테이블에서 각각의 공통값을 이용함으로서 필드를 조합함.

-- @예제1. 사원명과 부서명을 출력하세요.(JOIN문이 아닌 DECADE 함수 사용하였을 때.)
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.
SELECT EMP_NAME, DECODE(DEPT_CODE, 'D9', '총무부', 'D5', '해외영업1부', 'D6', '해외여행2부')
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6', 'D9');
SELECT * FROM DEPARTMENT;

SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE;
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;


-- # 조인문(JOIN) 작성
-- SELECT 컬럼명 FROM 테이블 JOIN 테이블 ON 컬럼명1 = 컬럼명2
-- JOIN 작성 후 JOIN하고자 하는 테이블명
-- SELECT + '*' => 두 개의 테이블이 JOIN으로 합쳐져 두 테이블이 하나의 가상의 테이블로 만들어진다.
-- 1. ANSI 표준구문 (어느 DB에서든 사용가능)
SELECT EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
-- 2. 오라클 전용 구문 (JOIN 대신 콤마(,) 사용, ON 대신 WHERE 사용 -> 오라클에서만 사용가능)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID;


-- ## JOIN의 종류1
-- 1. EQUI-JOIN : 일반적으로 사용, 'ON 컬럼명1 = 컬럼명2'에 의한 조인
-- 2. NON-Equi JOIN : 동등조건(=)이 아닌 BETWEEN AND, IS NULL, IS NOT NULL, IN, NOT IN 등으로 사용

-- @실습문제
--1. 부서명과 지역명을 출력하세요. DEPARTMENT, LOCATION 테이블 이용.
SELECT DEPT_TITLE, LOCATION_ID, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--2. 사원명과 직급명을 출력하세요. EMPLOYEE, JOB 테이블 이용
SELECT EMP_NAME, JOB_NAME
FROM EMPLOYEE JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- ORA-00918: column ambiguously defined
-- 모호한 것 해결방법1.
-- 컬럼명이 같으면 어떤 테이블의 컬럼명인지 모르므로 점(.)으로 테이블을 지정해주어 가상의 테이블을 만들어준다.

-- 모호한 것 해결방법2.
-- 별칭을 정해준다(E, J, EMP, JB, ...등 원하는 별칭)
SELECT EMP_NAME, JOB_NAME
FROM EMPLOYEE E JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;

-- 모호한 것 해결방법3.
-- USING 키워드 사용
SELECT EMP_NAME, JOB_NAME FROM EMPLOYEE JOIN JOB 
USING(JOB_CODE);

--SELECT EMP_NAME, JOB_NAME
--FROM EMPLOYEE E JOIN JOB J USING(JOB_CODE);

--3. 지역명과 국가명을 출력하세요. LOCATION, NATIONAL 테이블 이용
--    방법1. ON LOCATION.NATIONAL_CODE = NATIONAL.NATIONAL_CODE;
--    방법2. ON L.NATIONAL_CODE = N.NATIONAL_CODE;
-- [v]방법3. 두 테이블의 컬럼명이 'NATIONAL_CODE'로 동일하므로 USING키워드를 사용하여 JOIN해준다.
SELECT LOCAL_NAME AS 지역명, NATIONAL_NAME AS 국가명
FROM LOCATION JOIN NATIONAL USING(NATIONAL_CODE);

-- 지금까지의 코드는 INNER JOIN 중 'INNER EQUI_JOIN' 에 해당


-- ## JOIN의 종류2
-- INNER JOIN(내부조인) : 일반적으로 사용하는 조인(교집합, null이 아닌 데이터들만 출력)
-- OUTER JOIN(외부조인) : 합집합, 모두 출력
-- -> 1. LEFT (OUTER) JOIN
-- -> 2. RIGHT (OUTER) JOIN
-- -> 3. FULL (OUTER) JOIN
-- JOIN문에서 (INNER)와 (OUTER)는 생략하여 사용한다.

-- # INNER JOIN 내부조인 교집합 (두 컬럼이 같은 것만 나온다(ON 조건에 맞는 것))
-- 위에서 했던 JOIN문들은 사실 JOIN 앞에 (INNER)가 생략되어 있었던 것.
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE INNER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- # 1.(OUTER)LEFT JOIN 외부조인 합집합
-- (LEFT테이블(EMPLOYEE) 기준으로 전부출력, 같은 값이 없는 것도 '없다'하고 모두 출력된다)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- # 2.(OUTER)RIGHT JOIN 외부조인 합집합
-- (RIGHT테이블(DEPARTMENT)을 기준으로 전부출력, 없는 것은 없다고 나온다.)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- # 3.(OUTER)FULL JOIN 외부조인 합집합 (FULL은 왼쪽, 오른쪽 전부 나오는 것.)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

------------------------------------------------------------------
-- ## OUTER JOIN의 'ANSI 표준구문'과 '오라클 전용구문'
-- ANSI 표준 구문 (LEFT)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 오라클 전용 구문 (LEFT)
-- ('+'가 없는 쪽(DEPT_CODE)에 있는 테이블(EMPLOYEE)의 모든 데이터를 출력하는 것)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID(+);


-- ANSI 표준구문 (RIGHT)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 오라클 전용 구문 (RIGHT)
-- ('+'가 없는 쪽(DEPT_ID)에 있는 테이블(DEPARTMENT)의 모든 데이터를 출력하는 것)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE(+) = DEPT_ID;


-- ANSI 표준 구문만 존재 (FULL)
-- (FULL은 ANSI 표준구문만 존재하며, 오라클 전용 구문은 존재하지 않는다.)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
---------------------------------------------------------------------
-- EX) OUTER JOIN(외부조인)을 살펴보자
-- INNER JOIN의 경우 테이블을 JOIN하는 순서가 상관이 없었지만
-- OUTER JOIN의 경우 같은 LEFT일때, JOIN 앞에 있는 테이블을 기준으로 출력하므로 순서가 연관이 있다.
-- 아래 두 코드는 동일한 결과를 출력한다(동일한 코드)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

SELECT EMP_NAME, DEPT_TITLE
FROM DEPARTMENT RIGHT JOIN EMPLOYEE ON DEPT_ID = DEPT_CODE;



-- ## JOIN의 종류3
-- 1. 상호조인(CROSS JOIN)
-- 2. 셀프조인(SELF JOIN)
-- 3. 다중조인

-- # 1. 상호조인(CROSS JOIN)
-- 카테이션 곱(Cartensial Proudct) 라고도 함
-- 조인되는 테이블의 각 행들이 모두 매핑된 조인 방법
-- 다시말해 한 쪽 테이블의 모든 행과 다른 쪽 테이블의 모든 행을 조인 시킴
-- (1행 * (1열~10열), 2행*(1열~10열) 등 과 같은 방식)
-- 모든 경우의 수를 구하므로 결과는 두 테이블의 컬럼 수를 곱한 개수가 나옴.
-- 4 * 3 = ?
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE CROSS JOIN DEPARTMENT;

--@실습문제1. 아래처럼 나오도록 하세요. (모든 월급에 대해 평균월급을 나타내고싶을때)
----------------------------------------------------------------
-- 사원번호    사원명     월급    평균월급    월급-평균월급
----------------------------------------------------------------
    -- 스칼라서브쿼리로 풀어봄 (스칼라 서브쿼리로 쓸 필요 없고, CROSS JOIN으로 풀자.)
    -- (SELECT AVG(SALARY) FROM EMPLOYEE) AS 평균월급 -> 이것은 '스칼라 서브쿼리'이며, 원한 결과가 아님)
SELECT EMP_ID AS 사원번호, EMP_NAME AS 사원명, SALARY AS 월급
        ,(SELECT AVG(SALARY) FROM EMPLOYEE) AS 평균월급
        ,SALARY - AVG(SALARY) AS "월급-평균월급"
FROM EMPLOYEE;

    -- 상호조인VER.(굳이 스칼라서브쿼리(SELECT문 하나더)를 사용하여 SELECT문을 길게 쓸 필요없이
    -- 상호조인(CROSS JOIN)에 한번만 정의하여 AVG_SAL와 같은 별칭을 객체처럼 사용)
SELECT EMP_ID AS 사원번호, EMP_NAME AS 사원명, SALARY AS 월급
        , AVG_SAL AS 평균월급
        , SALARY - AVG_SAL AS "월급-평균월급"
FROM EMPLOYEE
CROSS JOIN (SELECT ROUND(AVG(SALARY)) "AVG_SAL" FROM EMPLOYEE);

    -- 월급-평균월급의 결과값 앞에 붙은 마이너스(-)를 '+'로 나타내고 싶은 경우 ('DECODE' OR 'CASE-THEN' 사용)
    -- DECODE와 CASE-END 의 차이점 : CASE-END는 범위를 지정할 수 있다(>,<,=>,=> 등)
SELECT EMP_ID AS 사원번호, EMP_NAME AS 사원명, SALARY AS 월급
        , AVG_SAL AS 평균월급
        , (CASE WHEN SALARY - AVG_SAL > 0 THEN '+' END) || (SALARY - AVG_SAL) AS "월급-평균월급"
FROM EMPLOYEE
CROSS JOIN (SELECT ROUND(AVG(SALARY)) "AVG_SAL" FROM EMPLOYEE);


-- # 2. 셀프조인(SELF JOIN)
-- 자기자신을 조인

--@실습문제1. 매니저가 있는 사원중에 월급이 전체사원 평균을 넘는 직원 사번,이름,매니저 이름, 월급을 구하시오.
SELECT EMP_ID AS 사번, EMP_NAME AS 이름
    ,(SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID) AS "매니저 이름"
    , SALARY AS 월급
FROM EMPLOYEE E
WHERE MANAGER_ID IS NOT NULL AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

-- 상관쿼리를 이용한 매니저 이름 구하기 결과 같은 것은 셀프 조인을 이용해서 구할 수 있음.
-- 똑같아서 셀프조인이라고 하는 것(EMPLOYEE테이블에 EMPLOYEE를 조인이므로 별칭이 중요)
SELECT E.EMP_ID, E.EMP_NAME, M.EMP_NAME, E.SALARY
FROM EMPOYEE E
JOIN EMPLOYEE M
ON M.EMP_ID = E.MANAGER_ID;

SELECT EMP_ID, EMP_NAME, MANAGER_ID FROM EMPLOYEE;


-- # 3. 다중조인
-- -> 여러 개의 조인문을 한번에 사용할 수 있음
-- -> (주의) JOIN하는 테이블들의 순서가 중요!
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--@실습문제1.
-- 1. 직급이 대리이면서, ASIA 지역에 근무하는 직원 조회
-- 사번, 이름 ,직급명, 부서명, 근무지역명, 급여를 조회하시오
-- EMPLOYEE, JOB, EMPLOYEE, SAL_GRADE, LOCATION
SELECT EMP_ID AS 사번, EMP_NAME AS 이름, JOB_NAME AS 직급명, DEPT_TITLE AS 부서명
    , LOCAL_NAME AS 근무지역명, SALARY AS 급여
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE JOB_NAME = '대리' AND LOCAL_NAME IN ('ASIA1', 'ASIA2', 'ASIA3');
--WHERE JOB_NAME = '대리' AND LOCAL_NAME LIKE 'ASIA%';
    


---------------------------------------------------------------------------------

--[JOIN 실습문제]
--1. 2022년 12월 25일이 무슨 요일인지 조회하시오. (JOIN문제 X)
SELECT TO_CHAR(TO_DATE(20221225), 'day') FROM DUAL;
--TO_DATE 사용하여 날짜형식으로 바꿔주고 원하는 데이터는 요일이므로 'day'를 사용한다.

--2. 주민번호가 1970년대 생이면서 성별이 여자이고, 성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
SELECT EMP_NAME AS 사원명, EMP_NO AS 주민번호, DEPT_TITLE AS 부서명, JOB_NAME AS 직급명
FROM EMPLOYEE E
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE (SUBSTR(EMP_NO,1,2)) BETWEEN '70' AND '79'
--WHERE SUBSTR(EMP_NO,1,2) BETWEEN 70 AND 79 -> 형변환되어 숫자에 따옴표('') 붙일 필요X
AND SUBSTR(EMP_NO, 8, 1) = '2'
AND EMP_NAME LIKE '전%';

--3. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.
SELECT EMP_ID AS 사번, EMP_NAME AS 사원명, DEPT_TITLE AS 부서명
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME LIKE '%형%';

--4. 해외영업부에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.
SELECT EMP_NAME AS 사원명, JOB_NAME AS 직급명, DEPT_CODE AS 부서코드, DEPT_TITLE AS 부서명
FROM EMPLOYEE
    JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
-- 2가지 표현방법 (_언더바, % 퍼센트)
WHERE DEPT_TITLE LIKE '해외영업_부';
--WHERE DEPT_TITLE LIKE '해외영업%';

--5. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.
SELECT EMP_NAME AS 사원명, NVL(BONUS,0) AS 보너스포인트, DEPT_TITLE AS 부서명, LOCAL_NAME AS 근무지역명
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON  LOCATION_ID = LOCAL_CODE
WHERE BONUS IS NOT NULL;

--6. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.
SELECT DEPT_CODE AS 부서코드, EMP_NAME AS 사원명, JOB_NAME AS 직급명, DEPT_TITLE AS 부서명, LOCAL_NAME AS 근무지역명
FROM EMPLOYEE E
    JOIN JOB USING(JOB_CODE)
    -- 방법2) JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE
    -- 방법3) JOIN JOB ON E.JOB_CODE = J.JOB_CODE -> 테이블명 뒤에 별칭(E, J, ..)붙여주기
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE DEPT_CODE = 'D2';
-- (주의) JOB_CODE의 경우 여러 테이블에 존재하는 컬럼이므로 조건절에 사용할 경우 오류가 날 수 있다.


--7. 급여등급테이블의 최대급여(MAX_SAL)보다 많이 받는 직원들의 사원명, 직급명, 급여, 연봉을 조회하시오.
-- (사원테이블과 급여등급테이블을 SAL_LEVEL컬럼기준으로 조인할 것)
--> 데이터가 존재하지않음. 식만 써보기
 

--8. 한국(KO)과 일본(JP)에 근무하는 직원들의 사원명, 부서명, 지역명, 국가명을 조회하시오.
SELECT EMP_NAME AS 사원명, DEPT_TITLE AS 부서명, LOCAL_NAME AS 지역명, NATIONAL_NAME AS 국가명
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION L ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE
--WHERE N.NATIONAL_CODE IN ('KO', 'JP')
WHERE NATIONAL_NAME IN ('한국', '일본')
ORDER BY 4 ASC;

--9. 보너스포인트가 없는 직원들 중에서 직급이 차장과 사원인 직원들의 사원명, 직급명, 급여를 조회하시오. 단, join과 IN 사용할 것
SELECT EMP_NAME AS 사원명, JOB_NAME AS 직급명, SALARY AS 급여
FROM EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE BONUS IS NULL AND JOB_NAME IN ('차장', '사원');

--10. 재직중인 직원과 퇴사한 직원의 수를 조회하시오.
SELECT DECODE(ENT_YN, 'Y','퇴직', 'N','재직') AS 퇴직여부, COUNT(*) AS 직원수
FROM EMPLOYEE
GROUP BY DECODE(ENT_YN, 'Y','퇴직', 'N','재직');

