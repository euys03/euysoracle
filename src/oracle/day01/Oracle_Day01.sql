-- [STUDENT계정]
-- ORACLE의 기본 개념

-- [STUDENT_TBL 테이블]
-- ORA-01031 : insufficient(불충분한) privileges(권한)
-- > 시스템계정_주의 -> GRANT RESOURCE TO STUDENT; 입력

-- 1. TABLE을 만들어보자(CREATE)
CREATE TABLE STUDENT_TBL(
    STUDENT_NAME VARCHAR2(20),
    -- 한글의 경우 글자 하나에 3바이트, 알파벳의 경우 글자 하나에 1바이트.
    STUDENT_AGE NUMBER,
    STUDENT_GRADE NUMBER,
    STUDENT_ADDRESS VARCHAR2(100)
);

-- 수정 : 삭제 후 생성.
-- 테이블 삭제 (전체삭제)
-- ORA-00942: table or view does not exist (두 번 실행 시 지울 테이블이 없어 오류)
DROP TABLE STUDENT_TBL;

-- 2. TABLE에 데이터를 넣어보자(Insert) -> 회원가입
INSERT INTO STUDENT_TBL(STUDENT_NAME, STUDENT_AGE, STUDENT_GRADE, STUDENT_ADDRESS)
VALUES('일용자', 11, 1, '서울');
    -- DB에서는 문자열을 홑따옴표('')로 표현한다.

    -- 컬럼명 생략 가능!
INSERT INTO STUDENT_TBL
VALUES('이용자', 22, 2, '중구');

    -- 일부 데이터만 넣고 싶을 경우, NULL값 입력(값X)
    -- ' '의 경우 공백이라는 값이 있는 것 (값O)
INSERT INTO STUDENT_TBL
VALUES(' ', 33, 3, NULL);

INSERT INTO STUDENT_TBL VALUES('일용자', 11, 1, '서울시 중구');
INSERT INTO STUDENT_TBL VALUES('이용자', 22, 2, '서울시 종로문구');
INSERT INTO STUDENT_TBL VALUES('삼용자', 33, 3, '서울시 동대문구');
INSERT INTO STUDENT_TBL VALUES('사용자', 44, 4, '서울시 서대문구');

-- 3. 데이터 수정(조건WHERE 포함)
UPDATE STUDENT_TBL
SET STUDENT_AGE = 99
WHERE STUDENT_GRADE = 2;

-- 4. 데이터 삭제(조건WHERE 포함)
DELETE FROM STUDENT_TBL
WHERE STUDENT_AGE = 99;

-- 5. 데이터를 삭제해보자(Delete) -> 회원탈퇴! (전체삭제)
DELETE FROM STUDENT_TBL;

-------------------------------------------------------

-- [DATATYPE_TBL 테이블]

-- 자료형 종류 (CHAR, VARCHAR, NUMBER, DATE, TIMESTAMP)
-- 1. 테이블 생성(CREATE)
CREATE TABLE DATATYPE_TBL (
    MOONJJA CHAR(10),   
    -- 알파벳:10글자(1Byte*10), 한글:3글자(3Byte*3)
    MOONJJAYUL VARCHAR2 (100),
    SOOJJA NUMBER,
    NALJJA DATE,
    NALJJA2 TIMESTAMP
);
-- 2. 테이블 삭제 및 재생성 (테이블 이름변경)
-- 오타가 있는 테이블(TEL)에서 오타 수정한 테이블 다시 생성
DROP TABLE DATATYPE_TEL;
INSERT INTO DATATYPE_TBL;

DESC DATATYPE_TBL;
    -- 'DESC 테이블명' 을 사용하여 해당 테이블의 데이터와 자료형을 확인할 수 있다.
    -- 위치는 어디에서든 사용가능, 순서상관X, 중복가능 -> 확인이 필요한 곳마다 작성 가능.
INSERT INTO DATATYPE_TBL
VALUES('A', '문자열', 15, SYSDATE, SYSTIMESTAMP);

-- 3. 테이블 내용 출력하기
SELECT MOONJJA, MOONJJAYUL, SOOJJA, NALJJA, NALJJA2
FROM DATATYPE_TBL;

-- 4. 테이블에 내용 삽입하기
INSERT INTO DATATYPE_TBL
VALUES('문자2', '문자열2', 33, SYSDATE, SYSTIMESTAMP);

-- 5(1). 지정 데이터 내용 수정하기(조건WHERE 포함)
UPDATE DATATYPE_TBL
SET MOONJJAYUL = '오라클이 제일 쉬웠어요'
WHERE SOOJJA = 33;

-- 5(2). 지정 데이터 내용 수정하기(조건WHERE 포함)
UPDATE DATATYPE_TBL
SET MOONJJA = '문자1'
WHERE SOOJJA = 15;

-- 6. 지정 데이터 삭제 (조건WHERE 포함)
DELETE FROM DATATYPE_TBL
WHERE SOOJJA = 15;

-- 7. 지정 데이터 조회 (조건WHERE 포함)
-- FROM -> WHERE -> SELECT
SELECT STUDENT_NAME, STUDENT_AGE, STUDENT_GRADE, STUDENT_ADDRESS
FROM STUDENT_TBL
WHERE STUDENT_GRADE = 2;

