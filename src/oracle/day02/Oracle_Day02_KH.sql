-- [��������] 1.NOT NULL ��������
INSERT INTO DEPARTMENT
VALUES(NULL, NULL, 'L1');

DESC DEPARTMENT;
-- ORA-01400: cannot insert NULL into ("KH"."DEPARTMENT"."DEPT_ID")
-- NOT NULL�� �߰��ϸ� NULL�� ���� �ʴ´ٴ� �����޽����� ���.(���������� �� �ɾ��ٴ� ��)
CREATE TABLE DEPARTMENT (
    DEPT_ID CHAR(2) NOT NULL,
    DEPT_TITLE VARCHAR2(35) NULL,
    LOCATION_ID CHAR(2) NOT NULL
);

-- �������� Ȯ��(VIEW)
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINS
WHERE TABLE_NAME = 'DEPARTMENT';
-- **CONSTRAINT TYPE
-- P : PRIMARY KEY
-- R : FOREIGN KEY
-- C : CHECK OR NOT NULL
-- U : UNIQUE

-- �������� ����
-- DEPARTMENT ���̺��� NOT NULL�� �����ϱ� ���� DROP
ALTER TABLE DEPARTMENT
DROP CONSTRAINT SYS_C007002;
-- Table DEPARTMENT��(��) ����Ǿ����ϴ�

-- �������� �߰�
-- DEPT
ALTER TABLE DEPARTMENT
ADD CONSTRAINT DEPARTMENT_PK PRIMARY KEY(DEPT_ID);
-- Table DEPARTMENT��(��) ����Ǿ����ϴ�.

-- �������Ǹ� ���� (DEPARTMENT_PK -> ID_PK)
ALTER TABLE DEPARTMENT
RENAME CONSTRAINT DEPARTMENT_PK TO DEPT_ID_PK;
-- Table DEPARTMENT��(��) ����Ǿ����ϴ�.

DROP TABLE DEPARTMENT;



-- [��������] 2.UNIQUE ��������
    -- �ߺ��� �Ǹ� �ȵŴ� JOB_CODE�� 'UNIQUE'�� �����Ѵ�
------------------------ <JOB TABLE> ----------------------------
CREATE TABLE JOB(
    JOB_CODE CHAR(2) UNIQUE,
    JOB_NAME VARCHAR2(35)
);
DROP TABLE JOB;

INSERT INTO JOB VALUES('J1', '��ǥ');
INSERT INTO JOB VALUES('J2', '�λ���');
INSERT INTO JOB VALUES('J3', '����');
INSERT INTO JOB VALUES('J4', '����');
INSERT INTO JOB VALUES('J5', '����');
INSERT INTO JOB VALUES('J6', '�븮');
INSERT INTO JOB VALUES('J7', '���');
-- ORA-00001: unique constraint (KH.SYS_C007004) violated
-- UNIQUE ���������� �ɷ��־� �ߺ��� 'J7'�� ���Ե��� �ʴ´�.
INSERT INTO JOB VALUES('J7', '���Ի��');
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")
-- PRIMARY KEY ��������
-- NULL�� ���� �ʰ� �ߺ��� ���� �ʵ��� �ϴ� ��������
-- �����ĺ��ڷν��� ������ �ϵ�����.
INSERT INTO JOB VALUES(NULL, '����');


-- [��������] 3.PRIMARY KEY ��������
-- NULL�� ���� �ʰ� �ߺ�(J7)�� ���� �ʰ��ϴ� ��Ȳ
-- 1.�����ĺ��ڷν��� ������ �ϵ��� ��.
-- ORA-01400: cannot insert NULL into ("KH"."JOB"."JOB_CODE")
-- 2. NULL ���� �Ұ��� "NULL�Ұ�"
-- ORA-00001: unique constraint (KH.SYS_C007005) violated
-- 3. UNIQUE�� ���� "�ߺ��Ұ�"
-- �������Ǹ� ���� : CONSTRAINT ���
CREATE TABLE JOB(
    JOB_CODE CHAR(2) CONSTRAINT JOB_PK PRIMARY KEY,
    -- �������Ǹ� ���� ex.JOB_PK
    JOB_NAME VARCHAR2(35)
);
DROP TABLE JOB;

INSERT INTO JOB VALUES('J1', '��ǥ');
INSERT INTO JOB VALUES('J2', '�λ���');
INSERT INTO JOB VALUES('J3', '����');
INSERT INTO JOB VALUES('J4', '����');
INSERT INTO JOB VALUES('J5', '����');
INSERT INTO JOB VALUES('J6', '�븮');
INSERT INTO JOB VALUES('J7', '���');
INSERT INTO JOB VALUES('J7', '���Ի��');
INSERT INTO JOB VALUES(NULL, '����');

-----------------------------------------------------------------

-- COMMENT �߰�(���̺��� Ȯ��)
COMMENT ON COLUMN DEPARTMENT.DEPT_ID IS '�μ��ڵ�';
COMMENT ON COLUMN DEPARTMENT.DEPT_TITLE IS '�μ���';
COMMENT ON COLUMN DEPARTMENT.LOCATION_ID IS '�����ڵ�';

-- ���� ��� (DESC)
DESC DEPARTMENT;

-- ���� ����(�÷��� ���� : RENAME)
ALTER TABLE DEPARTMENT
RENAME COLUMN DEPT_CODE TO DEPT_ID;
-- Table DEPARTMENT��(��) ����Ǿ����ϴ�.

-- ���̺�� ����, DEPARTMENT -> DEPARTMENT2 -> DEPARTMENT
-- 1. (���̺��) ù��° ���
ALTER TABLE DEPARTMENT
RENAME TO DEPARTMENT2;
-- ('�������̺��'�� TO '�����̺��'��)
-- Table DEPARTMENT��(��) ����Ǿ����ϴ�.

-- 2. (���̺��)�ι�° ���
RENAME DEPARTMENT2 TO DEPARTMENT;
-- ���̺� �̸��� ����Ǿ����ϴ�.


-- �ڷ��� ���� ����(�÷� ������Ÿ�� ���� : MODIFY)
ALTER TABLE DEPARTMENT
MODIFY DEPT_TITLE VARCHAR(30);
DESC DEPARTMENT;

-- �÷� �߰� (ADD)
ALTER TABLE DEPARTMENT
ADD (DEPT_NAME VARCHAR2(30));
-- Table DEPARTMENT��(��) ����Ǿ����ϴ�.

-- �÷� ���� (DROP)
ALTER TABLE DEPARTMENT
DROP COLUMN DEPT_NAME;


