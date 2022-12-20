-- 부모테이블(PRIMARY KEY)
CREATE TABLE USER_GRADE (
    GRADE_CODE NUMBER PRIMARY KEY,
    GRAKE_NAME VARCHAR2(30) NOT NULL
);
-- Table USER_GRADE이(가) 생성되었습니다.

INSERT INTO USER_GRADE VALUES(10, '일반회원');
INSERT INTO USER_GRADE VALUES(20, '우수회원');
INSERT INTO USER_GRADE VALUES(30, '특별회원');

    -- 칼럼명 수정(GRADE_NAME -> GRAKE_NAME 으로 오타남)
ALTER TABLE USER_GRADE
RENAME COLUMN GRAKE_NAME TO GRADE_NAME;
-- Table USER_GRADE이(가) 변경되었습니다.

    -- 확인방법1
DESC USER_GRADE;
    -- 확인방법2
SELECT * FROM USER_GRADE;



-- 자식테이블(FOREIGN KEY)
CREATE TABLE USER_FOREIGNKEY(
    USER_NO NUMBER CONSTRAINT USER_NO_PK PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    EMAIL VARCHAR2(50),
    -- 부모테이블의 GRADE_CODE + 외래키 걸기(REFERENCES ~ 부모테이블명(컬럼명))
    GRADE_CODE NUMBER CONSTRAINT GRADE_CODE_FK REFERENCES USER_GRADE(GRADE_CODE)
);
-- Table USER_FOREIGNKEY이(가) 생성되었습니다.

-- SELECT로 확인방법
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'USER_FOREIGNKEY';
-- DESC로 찾기
DESC USER_FOREIGNKEY;

-- FOREIGN KEY 동작하는지 확인
INSERT INTO USER_FOREIGNKEY
VALUES(1, 'user01', 'pass01', '일용자', '남', 'user01@iei.com', 10);
INSERT INTO USER_FOREIGNKEY
VALUES(2, 'user02', 'pass02', '이용자', '남', 'user02@iei.com', 20);
INSERT INTO USER_FOREIGNKEY
VALUES(3, 'user03', 'pass03', '삼용자', '남', 'user03@iei.com', 30);
INSERT INTO USER_FOREIGNKEY
VALUES(4, 'user04', 'pass04', '사용자', '남', 'user04@iei.com', 40);
-- ORA-02291: integrity constraint (KH.GRADE_CODE_FK) violated - parent key not found
-- FOREIGN KEY에 40이라는 값은 존재하지 않으므로 오류가 난다. (부모테이블(PK)에 있는 값들만 사용가능)

-- SELECT문으로 데이터들 확인
SELECT GRADE_CODE, GRADE_NAME FROM USER_GRADE;

-----------------------------------------------------------------

-- 예제(KH.sql 파일 불러와서 실행 후)
SELECT EMP_NAME, SALARY, SALARY*12 "연봉(보너스 미포함)"
    , BONUS, (SALARY*BONUS + SALARY*12) AS "연봉(보너스 포함)"
FROM EMPLOYEE
WHERE SALARY > 3000000 OR EMP_NAME = '선동일'
ORDER BY BONUS ASC;
-- FROM -> WHERE -> SELECT -> ORDER BY
-- ORDER BY는 맨 마지막에 실행되는구나!
-- *NULL : ASC(오름차순)일 때는 맨 아래에, DESC(내림차순)일 때는 맨 앞에 출력된다


-- BETWEEN A AND B, 비교연산자
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SALARY > 2000000 AND SALARY < 6000000;
WHERE SALARY BETWEEN 2000000 AND 6000000;


-- IN 연산자
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8';
WHERE DEPT_CODE IN ('D6', 'D8');


-- IS NULL과 IS NOT NULL 연산자
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS IS NOT NULL;
WHERE BONUS IS NULL;


-- LIKE 연산자
-- 주의! LIKE 사용시 '%'를 사용하여야한다.
-- 와일드카드
-- 1. % : 0개 이상의 모든 문자를 매칭
-- 2. _(언더바) : 하나의 자리에 해당하는 모든 문자를 매칭

-- LIKE연산자 예제
-- 전씨 성을 가진 직원의 이름과 급여를 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- LIKE연산자 예제 (%)
-- EMPLOYEE 테이블에서 이름의 끝이 '연'으로 끝나는 사원의 이름을 출력하시오
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';


-- LIKE연산자 예제( _(언더바) )
-- 자릿수 지정 연산자
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_연';
-- '_'갯수만큼 글자를 읽어온다. EX) __연 -> '연' 앞에 두글자가 있는 문자





-- [실습문제]
--1. EMPLOYEE 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

--2. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를
--출력하시오
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

DESC EMPLOYEE;

--3. EMPLOYEE 테이블에서 메일주소의 's'가 들어가면서, DEPT_CODE가 D9 또는 D6이고
--고용일이 90/01/01 ~ 01/12/01이면서, 월급이 270만원이상인 사원의 전체 정보를 출력하시오
SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/12/01'
AND EMAIL LIKE '%S%'
AND SALARY >= 2700000
-- AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6');
    -- IN 연산자로 표현
AND DEPT_CODE IN ('D9', 'D6');

DESC EMPLOYEE;

--4. EMPLOYEE 테이블에서 EMAIL ID 중 @ 앞자리가 5자리인 직원을 조회한다면?
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%'; 

--5. EMPLOYEE 테이블에서 EMAIL ID 중 '_' 앞자리가 3자리인 직원을 조회한다면?
-- '_'언더바는 와일드카드로 사용되고있고, 문제에서 언더바(_)을 제외한 문자열을 출력해야한다.
-- _언더스코어의 기능말고 문자열로 사용할 수 있게 'ESCAPE'를 통해 문자열로 사용한다.
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';

--6. 관리자(MANAGER_ID)도 없고 부서 배치(DEPT_CODE)도 받지 않은  직원의 이름 조회
SELECT EMP_NAME FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--7. 부서배치를 받지 않았지만 보너스를 지급하는 직원 전체 정보 조회
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--8. EMPLOYEE 테이블에서 이름,연봉, 총수령액(보너스포함),
--   실수령액(총 수령액-(월급*세금 3%*12))가 출력되도록 하시오
SELECT EMP_NAME "이름", SALARY*12 "연봉", SALARY*12 + BONUS "총수령액(보너스포함)",
(SALARY*12 + BONUS)-(SALARY*0.03*12) "실수령액"
--SELECT EMP_NAME AN "이름", SALARY*12 AS 연봉, SALARY*12 + BONUS "총수령액(보너스포함)",
--(SALARY*12 + BONUS)-(SALARY*0.03*12) "실수령액"
-- AS + 쌍따옴표, AS + 따옴표X, 그냥 쌍따옴표 등 모두 가능
FROM EMPLOYEE;

DESC EMPLOYEE;

--9. EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오.
--   (SYSDATE를 사용하면 현재 시간 출력)
SELECT EMP_NAME "이름", HIRE_DATE "근무일수"
FROM EMPLOYEE;

--10. EMPLOYEE 테이블에서 20년 이상 근속자의 이름,월급,보너스율를 출력하시오.
SELECT EMP_NAME "이름", SALARY "월급", BONUS "보너스율", (SYSDATE - HIRE_DATE)/365 "근속년수"
FROM EMPLOYEE
WHERE (SYSDATE - HIRE_DATE)/365 >= 20;

DESC EMPLOYEE;

