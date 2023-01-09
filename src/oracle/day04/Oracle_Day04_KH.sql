-- [오라클 함수]
-- 1)문자처리 함수  2)숫자처리 함수  3)날짜처리 함수  4)형변환 함수  5)그 외 함수

-- # 1. 문자 처리 함수
-- LENGTH(길이 구함), LENGTHB(길이 구함(BYTE로)), SUBSTR(문자 자름), INSTR(위치 구함),
-- LPAD, RPAD(문자의 길이를 정하고 원하는 문자로 채우는 것, 공백으로 채울 수도 있음),
-- CONCAT(문자 이어붙임), LTRIM, RTRIM(좌,우 제거), TRIM(양 옆 제거)

--@실습문제1. LTRIM(좌측제거) / RTRIM(우측제거) 
-- 다음 문자열에서 앞뒤 모든 숫자를 제거하세요.
-- '982341678934509hello89798739273402'
SELECT RTRIM(LTRIM('982341678934509hello89798739273402', '0123456789'), '0123456789')
FROM DUAL;
-- FROM DUAL : 해당 데이터를 바로 출력해서 볼 수 있는 '가상의 테이블' ***

--@실습문제2. SUBSTR(자르기)
-- 사원명에서 성만 중복없이 사전순으로 출력하세요.
SELECT SUBSTR(EMP_NAME, 1, 1) "EMP_NAME"
    -- EMP_NAME을 1번째 글자부터 1개만 잘라라.
FROM EMPLOYEE
--ORDER BY SUBSTR(EMP_NAME,1,1) ASC;
ORDER BY 1 ASC;   -- 사원명에서 성만 사전순으로 출력하세요 완성!
-- 중복없이 출력은 어떻게 하는 걸까? => DISTINCT 함수 사용
SELECT DISTINCT SUBSTR(EMP_NAME, 1, 1) "EMP_NAME"
FROM EMPLOYEE
ORDER BY 1 ASC; -- 이렇게 써도 문자 1개만 출력 가능

--@실습문제3. RPAD(붙이기), SUBSTR(자르기)
-- employee 테이블에서 남자만 사원번호, 사원명, 주민번호, 연봉을 나타내세요.
-- 주민번호의 뒷6자리는 *처리하세요.
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*'), SALARY*12
-- SUBSTR : 주민번호를 1번째부터 8번째까지 자르고,
-- RPAD : 자른 8자리 포함하여 문자열은 총 14자리이고, 8자리 이후는 '*'로 이어붙인다
-- => 14-8 = 6, 6개의 '*'이 이어서 찍힌다
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8,1) = '1' OR SUBSTR(EMP_NO,8,1) = '3';
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');

    -- '*' 6개 붙이는 방법1. 연결연산자(별 6개를 직접 입력)
SELECT EMP_ID, EMP_NAME, SUBSTR(EMP_NO,1,8) || '******', SALARY*12
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');

    -- '*' 6개 붙이는 방법2. CONCAT함수 사용(문자처리하는 함수)
SELECT EMP_ID, EMP_NAME, CONCAT(SUBSTR(EMP_NO,1,8),'******'), SALARY*12 || '원'
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');



-- # 2. 숫자 처리 함수
-- FLOOR함수(소수점 버리기), ROUND함수(반올림), CEIL함수(무조건 올림)
-- (참고) TRUNC : '몇 번째 자리에서' 버림, 반올림, 올림 할 것인지

--@실습문제1. EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오. 
--(SYSDATE를 사용하면 현재 시간 출력)
SELECT EMP_NAME, SYSDATE - HIRE_DATE "근무일수", FLOOR(SYSDATE - HIRE_DATE) "버림",
        ROUND(SYSDATE - HIRE_DATE) "반올림", CEIL(SYSDATE - HIRE_DATE) "올림"
FROM EMPLOYEE;



-- # 3. 날짜 처리 함수
-- SYSDATE(현재), MONTHS_BETWEEN(개월 차이수), ADD_MONTHS(개월 더하기)
-- NEXT_DAY(받은 요일의 날짜), LAST_DAY(해당 달의 마지막 날짜), EXTRACT(년,월,일 정보)

--@실습문제1. ADD_MONTHS 함수(개월 더하기)
-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 3개월이 된 날짜를 조회하시오.
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,3)
FROM EMPLOYEE;

DESC EMPLOYEE;

--@실습문제2. MONTHS_BETWEEN 함수 (반올림하여 깔끔하게 출력하기)
--EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 개월수를 조회하시오.
SELECT EMP_NAME, HIRE_DATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "PERIOD"
FROM EMPLOYEE;

--@실습문제3. LAST_DAY 함수
--ex) EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사월의 마지막날을 조회하세요.
SELECT EMP_NAME, HIRE_DATE "입사일", LAST_DAY(HIRE_DATE) "입사월의 마지막 날" 
FROM EMPLOYEE;

--@실습문제4. EXTRACT(YEAR, MONTH, DAY ... FROM ~) 함수
--          연결연산자(||) 사용하여 보기쉽게
--ex) EMPLOYEE 테이블에서 사원 이름, 입사 년도, 입사 월, 입사 일을 조회하시오.
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE)||'년' AS "입사 년도",
        EXTRACT(MONTH FROM HIRE_DATE)||'월' AS "입사 월",
        EXTRACT(DAY FROM HIRE_DATE)||'일' AS "입사 일"
FROM EMPLOYEE;

--@실습문제5.
/*
     오늘부로 일용자씨가 군대에 끌려갑니다.
     군복무 기간이 1년 6개월을 한다라고 가정하면
     첫번째, 제대일자를 구하시고,
     두번째, 제대일자까지 먹어야할 밥의 그룻수를 구합니다.
     (단, 1일 3끼를 먹는다고 한다.)
*/
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 18) "제대일자", 
    (ADD_MONTHS(SYSDATE, 18) - SYSDATE)*3 "그릇수"
FROM DUAL;



-- # 4. 형변환 처리 함수
-- TO_CHAR(날짜형OR숫자형 -> 문자형), TO_DATE(문자형 -> 날짜형), TO_NUMBER(문자형 -> 숫자형)
-- => TO + '변하고자하는 데이터타입'
-- [필기]
-- 컬럼은 '문자열'인데 날짜로 표현해야할 때 TO_CHAR.
-- 출력하고싶은 문자형태 ex)원화 및 ,(콤마) => TO_CHAR.
-- DATE형으로는 1111-22-33과 같이 '-'를 표현할 수 없다. => TO_CHAR.



-- # 5. 그 외 처리 함수
-- ***(중요) NVL(NULL처리함수 - NULL인 컬럼값을 숫자 혹은 문자로 변경)
-- DECODE(조건문, CASE식 또는 IF-THEN-ELSE문)


---------------------------------------------------------------------------------

-- [실습문제]
-- 함수(문자처리함수, 숫자처리함수, 날짜처리함수, 형변환함수, 그 외 처리함수)
-- 1. 직원명과 이메일, 이메일 길이를 출력하시오.
--        이름         이메일          이메일길이
-- ex)   홍길동,     hon@kh.or.kr        13
    -- #LENGTH, LENGTHB 함수 사용
    ---> EMAIL(영어-1바이트), EMP_NAME(한글-3바이트)
    ---> (EMAIL에 한글이 없어서 LENGTH와 LENGTHB의 길이(영어-1바이트)가 동일하게 나오는 것)
    ---> (EMP_NAME(이름)이 2글자였다면 LENGTH는 2이고, LENGTHB는 2*3='6'이다.)
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
    , LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;
    -- ex) 이메일의 길이가 15보다 적은 데이터를 검색해보시오.
    SELECT *
    FROM EMPLOYEE
    WHERE LENGTH(EMAIL) < 15;
    -- WHERE EMAIL = 'no_hc@kh.or.kr'; => 원래 이메일을 검색하는 방법
    --> 이제는 이메일의 길이(length)와 비교값(ex.13)을 비교하여 이메일을 조회한다
    
    
-- 2. 직원의 이름과 이메일 주소 중 아이디 부분만 출력하시오
--	ex) 노옹철	no_hc
--	ex) 정중하	jung_jh

-- #SUBSTRING 함수(자르기), #INSTR 함수(위치를 반환)
    -- > SUBSTR(컬럼명, 시작위치, 자르고싶은 개수)
    -- > INSTR(컬럼명, 찾고싶은 문자, 시작위치, 자르고싶은 개수)
-- 즉, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@', 1, 1)) 는 EMAIL의 첫번째부터,
--  (INSTR)EMAIL 중 @의 위치를 찾고 그 위치를 포함한 첫번째부터 1개(@를 찾는다는 뜻)의 위치번호를 반환하여
--  결과적으로 EMAIL의 첫번째 위치부터 @까지 잘라 출력하는 것을 말한다.
-- SUBSTR(EMAIL, 1, INSTR(EMAIL, '@', 1, 1)-1)과 같이 -1하면 @는 잘리고 아이디만 출력
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, 6), SUBSTR(EMAIL, 1, INSTR(EMAIL, '@', 1, 1))
FROM EMPLOYEE;
    -- INSTR 함수(@의 위치 반환)
SELECT EMAIL, INSTR(EMAIL, '@', 1, 1)
FROM EMPLOYEE;


--3. 60년대에 태어난 직원명과 년생, 보너스 값을 출력하시오. 그때 보너스 값이 null인 경우에는 0 이라고 출력 되게 만드시오
--	    직원명    년생      보너스
--	ex) 선동일	    1962	    0.3
--	ex) 송은희	    1963  	    0

    -- 문자 처리 함수 VER.(CONCAT 함수 사용)
    -- CONCAT함수 : 전달받은 두 개의 문자/문자열을 합친다.
SELECT EMP_NAME AS 이름, CONCAT(19, SUBSTR(EMP_NO,1,2)) AS 년생, BONUS AS 보너스
FROM EMPLOYEE
--WHERE BETWEEN(SUBSTR(EMP_NO,1,2) >= 60 AND SUBSTR(EMP_NO,1,2) < 70);
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 60 AND 69;

    -- 날짜 처리 VER.
    -- FROM 뒤에는 DATE, TO_DATE 뒤에는 날짜형식.
SELECT EXTRACT(YEAR FROM SYSDATE) FROM DUAL;
SELECT EXTRACT(YEAR FROM HIRE_DATE) FROM EMPLOYEE;
    -- 문자열 -> 
SELECT EXTRACT(YEAR FROM TO_DATE(EMP_NO)) FROM EMPLOYEE;
SELECT EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) FROM EMPLOYEE;
    --1. ORA-01861: literal does not match format string
    -- '660211-1012654'와 같은 형태는 바꿀 수 없다 -> 661201 (날짜형으로 바뀌어줘야 한다)
SELECT TO_DATE(SUBSTR(EMP_NO,1,2), 'RR') FROM EMPLOYEE);
    -- 2. ORA-30076 : invalid extract field for extract source
    -- '66' -> 너무 짧아
    -- 'RR'사용하여 1900년대인 것을 인식
    -- 'YY'는 2000년대, 'RR'은 1990년대를 의미


--4. '010' 핸드폰 번호를 쓰지 않는 사람의 수를 출력하시오 (뒤에 단위는 명을 붙이시오)
--	   인원
--	ex) 3명
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(PHONE, 1, 3) <> '010';


--5. 직원명과 입사년월을 출력하시오 
--	단, 아래와 같이 출력되도록 만들어 보시오
--	    직원명		입사년월
--	ex) 전형돈		2012년 12월
--	ex) 전지연		1997년 3월
SELECT EMP_NAME AS 직원명, EXTRACT(YEAR FROM HIRE_DATE)||'년'
||EXTRACT(MONTH FROM HIRE_DATE))||'월' AS 입사년월
FROM EMPLOYEE
ORDER BY 2;


--6. 직원명과 주민번호를 조회하시오
--	단, 주민번호 9번째 자리부터 끝까지는 '*' 문자로 채워서출력 하시오
--	ex) 홍길동 771120-1******
SELECT EMP_NAME AS 직원명, RPAD(SUBSTR(EMP_NO,1,8),14,'*') AS 주민번호
FROM EMPLOYEE;


--7. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME AS 직원명, JOB_CODE AS 직급코드
    , SALARY*12+SALARY*NVL(BONUS,0) AS "연봉(원)", NVL(BONUS, 0)
FROM EMPLOYEE;
    -- 특수문자와, 띄어쓰기 등의 컬럼명을 설정하려면 쌍따옴표("")로 표현해줘야 한다.
    -- NVL함수 사용(NULL을 원하는 데이터로 채워넣는다. -> 0)

    -- TO_CHAR로 문자열로 변경 + 999로 자릿수 표시(,) + 'L'을 붙여주면 자동으로 원화(W)가 표현된다.
SELECT TO_CHAR(SALARY, 'L999,999,999') FROM EMPLOYEE;
    -- 0으로 하면 어떻게 될까?
SELECT TO_CHAR(SALARY, '000,000,000') FROM EMPLOYEE;

-- 결론
SELECT EMP_NAME AS 직원명, JOB_CODE AS 직급코드
, TO_CHAR(SALARY*12+SALARY*NVL(BONUS,0), 'L999,999,999') AS "연봉(원)", NVL(BONUS, 0)
FROM EMPLOYEE;


--8. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 사번, 사원명, 부서코드, 입사일 조회함.
SELECT EMP_ID AS 사번, EMP_NAME AS 사원명, DEPT_CODE AS 부서코드
    , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS 입사일
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D9') AND EXTRACT(YEAR FROM HIRE_DATE) = 2004;


--9. 직원명, 입사일, 오늘까지의 근무일수 조회 
--	* 주말도 포함 , 소수점 아래는 버림
SELECT EMP_NAME AS 직원명, HIRE_DATE AS 입사일, FLOOR(SYSDATE - HIRE_DATE)||'일' AS 근무일수
FROM EMPLOYEE;


--10. 직원명, 부서코드, 생년월일, 나이(만) 조회
--   단, 생년월일은 주민번호에서 추출해서, 
--   ㅇㅇㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--   나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
--	* 주민번호가 이상한 사람들은 제외시키고 진행 하도록(200,201,214 번 제외)
--	* HINT : NOT IN 사용
SELECT EMP_NAME AS 직원명, DEPT_CODE AS 부서코드, '19'||SUBSTR(EMP_NO, 1, 2)||'년 '
    ||SUBSTR(EMP_NO, 3, 2)||'월 '||SUBSTR(EMP_NO, 5, 2)||'일' AS 생년월일
    -- > 문자 처리 함수
    , EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR'))
    ||'년 ' ||EXTRACT(MONTH FROM TO_DATE(SUBSTR(EMP_NO,3,2), 'MM'))
    ||'월 ' ||EXTRACT(DAY FROM TO_DATE(SUBSTR(EMP_NO,5,2), 'DD'))
    ||'일' AS 생년월일2
    -- 만나이, 2022(현재) - 1986(태어난년도) = 36
    -- 2022 - 1986 = 36
    -- > 날짜 처리 함수
    , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) AS "나이(만)"
    -- 날짜 처리 함수 : 숫자 + 문자 => TO_NUMBER로 문자를 숫자로 변경
    , EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(EMP_NO,1,2))) AS 나이
    -- 문자 처리 함수 : DECODE(디코드) 사용
    , EXTRACT(YEAR FROM SYSDATE) - (DECODE(SUBSTR(EMP_NO,8,1),'1',1900, '2',1900, '3',2000,'4',2000
    + TO_NUMBER(SUBSTR(EMP_NO,1,2))) AS 나이
FROM EMPLOYEE
WHERE EMP_ID NOT IN (200, 201, 214);

    -- 날짜 처리 함수 'DECODE함수'의 개념(1 또는 2의 값 출력)
SELECT 
    DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여','3','남','4','여')
FROM EMPLOYEE;


--11. 사원명과, 부서명을 출력하세요.
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.
SELECT EMP_NAME AS 사원명, DEPT_CODE AS 부서코드
    , DECODE(DEPT_CODE,'D5','총무부','D6','기획부','D9','영업부') AS 부서명1
    -- DECODE와 동일한 CASE-END 구문 (대소비교가 가능하다는 차이점과 장점이 있음)
    , CASE
        WHEN DEPT_CODE = 'D5' THEN '총무부'
        WHEN DEPT_CODE = 'D6' THEN '기획부'
        WHEN DEPT_CODE = 'D9' THEN '영업부'
    END AS 부서명2
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D9')
ORDER BY 2 ASC;





-- [최종 실습 문제]
-- 문제1. 
-- 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하여라
SELECT EMP_NAME AS 이름, EMP_NO AS 주민번호, SALARY AS 급여, HIRE_DATE AS 입사일
FROM EMPLOYEE
WHERE CEIL((SYSDATE-HIRE_DATE)/365) BETWEEN 5 AND 10;

DESC EMPLOYEE;

-- 문제2.
-- 재직중이 아닌 직원의 이름,부서코드, 고용일, 근무기간, 퇴직일을 검색하여라 
--(퇴사 여부 : ENT_YN -> Y이면 퇴직한 것.)
SELECT EMP_NAME AS 이름, DEPT_CODE AS 부서코드, HIRE_DATE AS 고용일
    ,(ENT_DATE-HIRE_DATE) AS 근무기간, ENT_DATE AS 퇴직일
FROM EMPLOYEE
WHERE ENT_YN != 'N'; 

-- 문제3.
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하여라
-- 단, 급여는 50% 인상된 급여로 출력되도록 하여라.
SELECT EMP_NAME AS 이름, SALARY*0.5 AS 급여, CEIL((SYSDATE-HIRE_DATE)/365) AS 근속년수
FROM EMPLOYEE
WHERE CEIL((SYSDATE-HIRE_DATE)/365) >= 10
--ORDER BY CEIL((SYSDATE-HIRE_DATE)/365) ASC;
ORDER BY 3 ASC;
    -- 근속년수 함수 쓰는 대신 컬럼의 위치(3번째)를 써도 가능

-- 문제4.
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하시오
SELECT EMP_NAME AS 이름, EMP_NO AS 주민번호, EMAIL AS 이메일, PHONE AS 전화번호, SALARY AS 급여
FROM EMPLOYEE
-- 날짜 형태여야 TO_DATE로 형변환해줄 수 있다.
WHERE (HIRE_DATE BETWEEN TO_DATE('99/01/01') AND TO_DATE('10/01/01'))
    AND SALARY <= 2000000;

DESC EMPLOYEE;

-- 문제5.
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하여라
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력 하여라.
SELECT EMP_NAME AS 이름, EMP_NO AS 주민번호, SALARY AS 급여, DEPT_CODE AS 부서코드
FROM EMPLOYEE
WHERE SALARY BETWEEN 200000 AND 3000000 AND SUBSTR(EMP_NO, 8, 1) = '2'
        AND SUBSTR(EMP_NO, 3, 2) = '04'
ORDER BY DEPT_CODE DESC;
-- 조건문한번에출력하는 방법
--AND EMP_NO LIKE '__04__-2%'
--ORDER BY DEPT_CODE DESC;

-- NULL 대신 '없음'으로 출력하는 방법 => NVL함수사용
SELECT EMP_NAME AS 이름, EMP_NO AS 주민번호, SALARY AS 급여, NVL(DEPT_CODE,'없음') AS 부서코드
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000 AND SUBSTR(EMP_NO, 8, 1) = '2'
        AND SUBSTR(EMP_NO, 3, 2) = '04'
ORDER BY DEPT_CODE DESC;


-- 문제6.
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다(소수점 제외) 
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하여라.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하여라.
SELECT EMP_NAME AS 이름, FLOOR((SYSDATE-HIRE_DATE)/1000)*0.1*SALARY AS "특별 보너스"
FROM EMPLOYEE
    -- 1.SUBSR 사용
--WHERE SUBSTR(EMP_NO, 8, 1) = 1 AND BONUS IS NULL
    -- 2. LIKE 사용
WHERE EMP_NO LIKE '%-1%' AND BONUS IS NULL
ORDER BY EMP_NUM ASC;


