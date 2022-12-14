-- [시스템계정_주의]
-- 사용자 계정 생성, 권한 부여 및 해제
-- (NOTE) "--"는 주석과 같은 의미이다. (주석은 일렬보다 코드 위나 아래에 적는다)
--        실행방법 : 녹색 재생버튼 클릭(Ctrl + Enter)
--        SQL에서 String(문자열)-> VALCHAR, int(숫자)-> NUMBER
--        세미콜론(;)을 기준으로 코드 실행된다

CREATE USER STUDENT IDENTIFIED BY sTUDENT; 
-- 계정생성(USER:STUDENT) 및 비밀번호 설정(IDENTIFIED BY:sTUDENT)
-- 비밀번호는 '대소문자를 구분한다' -> 비밀번호 주의.

-- 테스트 상태: 실패 ->(접근권한이 없어서)
-- ORA-01045: user STUDENT lacks CREATE SESSION privilege; logon denied
-- GRANT ~ TO 테이블명 : 접근권한 허용
GRANT CONNECT TO STUDENT;
-- Grant을(를) 성공했습니다.
GRANT RESOURCE TO STUDENT;
-- Grant을(를) 성공했습니다.

CREATE TABLE STUDENT_TBL(
    STUDENT_NAME VARCHAR(20),
    -- 한글의 경우 글자 하나에 3바이트, 알파벳의 경우 1바이트.
    STUDENT_AGE NUMBER,
    STUDENT_GRANDE NUMBER,
    STUDENT_ADDRESS VARCHAR(100)
);


-- 접속계정 새로만들기
-- KH계정을 만들고 그 비밀번호는 KH로 해주세요
CREATE USER KH IDENTIFIED BY KH;

-- 접속이 가능하고 테이블이 생성할 수 있도록 해주세요.
GRANT CONNECT, RESOURCE TO KH;

-- 접속 이름을 만들어 접속해보세요.
-- > 접속(+) > 접속이름:KH계정, 사용자이름:KH, 비밀번호:KH

