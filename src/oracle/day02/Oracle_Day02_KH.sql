-- [제약조건] 1.NOT NULL 제약조건
INSERT INTO DEPARTMENT
VALUES(NULL, NULL, 'L1');

DESC DEPARTMENT;
-- ORA-01400: cannot insert NULL into ("KH"."DEPARTMENT"."DEPT_ID")
-- NOT NULL을 추가하면 NULL이 들어가지 않는다는 오류메시지가 뜬다.(제약조건을 잘 걸었다는 뜻)
CREATE TABLE DEPARTMENT (
    DEPT_ID CHAR(2) NOT NULL,
    DEPT_TITLE VARCHAR2(35) NULL,
    LOCATION_ID CHAR(2) NOT NULL
);

-- 제약조건 확인(VIEW)
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINS
WHERE TABLE_NAME = 'DEPARTMENT';
-- **CONSTRAINT TYPE
-- P : PRIMARY KEY
-- R : FOREIGN KEY
-- C : CHECK OR NOT NULL
-- U : UNIQUE

-- 제약조건 삭제
-- DEPARTMENT 테이블의 NOT NULL을 삭제하기 위해 DROP
ALTER TABLE DEPARTMENT
DROP CONSTRAINT SYS_C007002;
-- Table DEPARTMENT이(가) 변경되었습니다

-- 제약조건 추가
-- DEPT
ALTER TABLE DEPARTMENT
ADD CONSTRAINT DEPARTMENT_PK PRIMARY KEY(DEPT_ID);
-- Table DEPARTMENT이(가) 변경되었습니다.

-- 제약조건명 수정 (DEPARTMENT_PK -> ID_PK)
ALTER TABLE DEPARTMENT
RENAME CONSTRAINT DEPARTMENT_PK TO DEPT_ID_PK;
-- Table DEPARTMENT이(가) 변경되었습니다.

DROP TABLE DEPARTMENT;



-- [제약조건] 2.UNIQUE 제약조건
    -- 중복이 되면 안돼는 JOB_CODE는 'UNIQUE'로 선언한다
------------------------ <JOB TABLE> ----------------------------
CREATE TABLE JOB(
    JOB_CODE CHAR(2) UNIQUE,
    JOB_NAME VARCHAR2(35)
);
DROP TABLE JOB;

INSERT INTO JOB VALUES('J1', '대표');
INSERT INTO JOB VALUES('J2', '부사장');
INSERT INTO JOB VALUES('J3', '부장');
INSERT INTO JOB VALUES('J4', '차장');
INSERT INTO JOB VALUES('J5', '과장');
INSERT INTO JOB VALUES('J6', '대리');
INSERT INTO JOB VALUES('J7', '사원');
-- ORA-00001: unique constraint (KH.SYS_C007004) violated
-- UNIQUE 제약조건이 걸려있어 중복인 'J7'이 삽입되지 않는다.
INSERT INTO JOB VALUES('J7', '신입사원');
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")
-- PRIMARY KEY 제약조건
-- NULL이 들어가지 않고 중복도 되지 않도록 하는 제약조건
-- 고유식별자로써의 역할을 하도록함.
INSERT INTO JOB VALUES(NULL, '주임');


-- [제약조건] 3.PRIMARY KEY 제약조건
-- NULL이 되지 않고 중복(J7)도 되지 않게하는 상황
-- 1.고유식별자로써의 역할을 하도록 함.
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")
-- 2. NULL 삽입 불가능 "NULL불가"
-- ORA-00001: unique constraint (KH.SYS_C007005) violated
-- 3. UNIQUE로 인해 "중복불가"
-- 제약조건명 설정 : CONSTRAINT 사용
CREATE TABLE JOB(
    JOB_CODE CHAR(2) CONSTRAINT JOB_PK PRIMARY KEY,
    -- 제약조건명 지정 ex.JOB_PK
    JOB_NAME VARCHAR2(35)
);
DROP TABLE JOB;

INSERT INTO JOB VALUES('J1', '대표');
INSERT INTO JOB VALUES('J2', '부사장');
INSERT INTO JOB VALUES('J3', '부장');
INSERT INTO JOB VALUES('J4', '차장');
INSERT INTO JOB VALUES('J5', '과장');
INSERT INTO JOB VALUES('J6', '대리');
INSERT INTO JOB VALUES('J7', '사원');
INSERT INTO JOB VALUES('J7', '신입사원');
INSERT INTO JOB VALUES(NULL, '주임');

-----------------------------------------------------------------

-- COMMENT 추가(테이블에서 확인)
COMMENT ON COLUMN DEPARTMENT.DEPT_ID IS '부서코드';
COMMENT ON COLUMN DEPARTMENT.DEPT_TITLE IS '부서명';
COMMENT ON COLUMN DEPARTMENT.LOCATION_ID IS '지역코드';

-- 유형 출력 (DESC)
DESC DEPARTMENT;

-- 내용 수정(컬럼명 수정 : RENAME)
ALTER TABLE DEPARTMENT
RENAME COLUMN DEPT_CODE TO DEPT_ID;
-- Table DEPARTMENT이(가) 변경되었습니다.

-- 테이블명 수정, DEPARTMENT -> DEPARTMENT2 -> DEPARTMENT
-- 1. (테이블명) 첫번째 방법
ALTER TABLE DEPARTMENT
RENAME TO DEPARTMENT2;
-- ('기존테이블명'를 TO '새테이블명'로)
-- Table DEPARTMENT이(가) 변경되었습니다.

-- 2. (테이블명)두번째 방법
RENAME DEPARTMENT2 TO DEPARTMENT;
-- 테이블 이름이 변경되었습니다.


-- 자료형 길이 수정(컬럼 데이터타입 수정 : MODIFY)
ALTER TABLE DEPARTMENT
MODIFY DEPT_TITLE VARCHAR(30);
DESC DEPARTMENT;

-- 컬럼 추가 (ADD)
ALTER TABLE DEPARTMENT
ADD (DEPT_NAME VARCHAR2(30));
-- Table DEPARTMENT이(가) 변경되었습니다.

-- 컬럼 삭제 (DROP)
ALTER TABLE DEPARTMENT
DROP COLUMN DEPT_NAME;


