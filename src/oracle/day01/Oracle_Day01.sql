-- [STUDENT����]
-- ORACLE�� �⺻ ����

-- [STUDENT_TBL ���̺�]
-- ORA-01031 : insufficient(�������) privileges(����)
-- > �ý��۰���_���� -> GRANT RESOURCE TO STUDENT; �Է�

-- 1. TABLE�� ������(CREATE)
CREATE TABLE STUDENT_TBL(
    STUDENT_NAME VARCHAR2(20),
    -- �ѱ��� ��� ���� �ϳ��� 3����Ʈ, ���ĺ��� ��� ���� �ϳ��� 1����Ʈ.
    STUDENT_AGE NUMBER,
    STUDENT_GRADE NUMBER,
    STUDENT_ADDRESS VARCHAR2(100)
);

-- ���� : ���� �� ����.
-- ���̺� ���� (��ü����)
-- ORA-00942: table or view does not exist (�� �� ���� �� ���� ���̺��� ���� ����)
DROP TABLE STUDENT_TBL;

-- 2. TABLE�� �����͸� �־��(Insert) -> ȸ������
INSERT INTO STUDENT_TBL(STUDENT_NAME, STUDENT_AGE, STUDENT_GRADE, STUDENT_ADDRESS)
VALUES('�Ͽ���', 11, 1, '����');
    -- DB������ ���ڿ��� Ȭ����ǥ('')�� ǥ���Ѵ�.

    -- �÷��� ���� ����!
INSERT INTO STUDENT_TBL
VALUES('�̿���', 22, 2, '�߱�');

    -- �Ϻ� �����͸� �ְ� ���� ���, NULL�� �Է�(��X)
    -- ' '�� ��� �����̶�� ���� �ִ� �� (��O)
INSERT INTO STUDENT_TBL
VALUES(' ', 33, 3, NULL);

INSERT INTO STUDENT_TBL VALUES('�Ͽ���', 11, 1, '����� �߱�');
INSERT INTO STUDENT_TBL VALUES('�̿���', 22, 2, '����� ���ι���');
INSERT INTO STUDENT_TBL VALUES('�����', 33, 3, '����� ���빮��');
INSERT INTO STUDENT_TBL VALUES('�����', 44, 4, '����� ���빮��');

-- 3. ������ ����(����WHERE ����)
UPDATE STUDENT_TBL
SET STUDENT_AGE = 99
WHERE STUDENT_GRADE = 2;

-- 4. ������ ����(����WHERE ����)
DELETE FROM STUDENT_TBL
WHERE STUDENT_AGE = 99;

-- 5. �����͸� �����غ���(Delete) -> ȸ��Ż��! (��ü����)
DELETE FROM STUDENT_TBL;

-------------------------------------------------------

-- [DATATYPE_TBL ���̺�]

-- �ڷ��� ���� (CHAR, VARCHAR, NUMBER, DATE, TIMESTAMP)
-- 1. ���̺� ����(CREATE)
CREATE TABLE DATATYPE_TBL (
    MOONJJA CHAR(10),   
    -- ���ĺ�:10����(1Byte*10), �ѱ�:3����(3Byte*3)
    MOONJJAYUL VARCHAR2 (100),
    SOOJJA NUMBER,
    NALJJA DATE,
    NALJJA2 TIMESTAMP
);
-- 2. ���̺� ���� �� ����� (���̺� �̸�����)
-- ��Ÿ�� �ִ� ���̺�(TEL)���� ��Ÿ ������ ���̺� �ٽ� ����
DROP TABLE DATATYPE_TEL;
INSERT INTO DATATYPE_TBL;

DESC DATATYPE_TBL;
    -- 'DESC ���̺��' �� ����Ͽ� �ش� ���̺��� �����Ϳ� �ڷ����� Ȯ���� �� �ִ�.
    -- ��ġ�� ��𿡼��� ��밡��, �������X, �ߺ����� -> Ȯ���� �ʿ��� ������ �ۼ� ����.
INSERT INTO DATATYPE_TBL
VALUES('A', '���ڿ�', 15, SYSDATE, SYSTIMESTAMP);

-- 3. ���̺� ���� ����ϱ�
SELECT MOONJJA, MOONJJAYUL, SOOJJA, NALJJA, NALJJA2
FROM DATATYPE_TBL;

-- 4. ���̺� ���� �����ϱ�
INSERT INTO DATATYPE_TBL
VALUES('����2', '���ڿ�2', 33, SYSDATE, SYSTIMESTAMP);

-- 5(1). ���� ������ ���� �����ϱ�(����WHERE ����)
UPDATE DATATYPE_TBL
SET MOONJJAYUL = '����Ŭ�� ���� �������'
WHERE SOOJJA = 33;

-- 5(2). ���� ������ ���� �����ϱ�(����WHERE ����)
UPDATE DATATYPE_TBL
SET MOONJJA = '����1'
WHERE SOOJJA = 15;

-- 6. ���� ������ ���� (����WHERE ����)
DELETE FROM DATATYPE_TBL
WHERE SOOJJA = 15;

-- 7. ���� ������ ��ȸ (����WHERE ����)
-- FROM -> WHERE -> SELECT
SELECT STUDENT_NAME, STUDENT_AGE, STUDENT_GRADE, STUDENT_ADDRESS
FROM STUDENT_TBL
WHERE STUDENT_GRADE = 2;

