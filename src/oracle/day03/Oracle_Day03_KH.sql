-- �θ����̺�(PRIMARY KEY)
CREATE TABLE USER_GRADE (
    GRADE_CODE NUMBER PRIMARY KEY,
    GRAKE_NAME VARCHAR2(30) NOT NULL
);
-- Table USER_GRADE��(��) �����Ǿ����ϴ�.

INSERT INTO USER_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE VALUES(30, 'Ư��ȸ��');

    -- Į���� ����(GRADE_NAME -> GRAKE_NAME ���� ��Ÿ��)
ALTER TABLE USER_GRADE
RENAME COLUMN GRAKE_NAME TO GRADE_NAME;
-- Table USER_GRADE��(��) ����Ǿ����ϴ�.

    -- Ȯ�ι��1
DESC USER_GRADE;
    -- Ȯ�ι��2
SELECT * FROM USER_GRADE;



-- �ڽ����̺�(FOREIGN KEY)
CREATE TABLE USER_FOREIGNKEY(
    USER_NO NUMBER CONSTRAINT USER_NO_PK PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    EMAIL VARCHAR2(50),
    -- �θ����̺��� GRADE_CODE + �ܷ�Ű �ɱ�(REFERENCES ~ �θ����̺��(�÷���))
    GRADE_CODE NUMBER CONSTRAINT GRADE_CODE_FK REFERENCES USER_GRADE(GRADE_CODE)
);
-- Table USER_FOREIGNKEY��(��) �����Ǿ����ϴ�.

-- SELECT�� Ȯ�ι��
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'USER_FOREIGNKEY';
-- DESC�� ã��
DESC USER_FOREIGNKEY;

-- FOREIGN KEY �����ϴ��� Ȯ��
INSERT INTO USER_FOREIGNKEY
VALUES(1, 'user01', 'pass01', '�Ͽ���', '��', 'user01@iei.com', 10);
INSERT INTO USER_FOREIGNKEY
VALUES(2, 'user02', 'pass02', '�̿���', '��', 'user02@iei.com', 20);
INSERT INTO USER_FOREIGNKEY
VALUES(3, 'user03', 'pass03', '�����', '��', 'user03@iei.com', 30);
INSERT INTO USER_FOREIGNKEY
VALUES(4, 'user04', 'pass04', '�����', '��', 'user04@iei.com', 40);
-- ORA-02291: integrity constraint (KH.GRADE_CODE_FK) violated - parent key not found
-- FOREIGN KEY�� 40�̶�� ���� �������� �����Ƿ� ������ ����. (�θ����̺�(PK)�� �ִ� ���鸸 ��밡��)

-- SELECT������ �����͵� Ȯ��
SELECT GRADE_CODE, GRADE_NAME FROM USER_GRADE;

-----------------------------------------------------------------

-- ����(KH.sql ���� �ҷ��ͼ� ���� ��)
SELECT EMP_NAME, SALARY, SALARY*12 "����(���ʽ� ������)"
    , BONUS, (SALARY*BONUS + SALARY*12) AS "����(���ʽ� ����)"
FROM EMPLOYEE
WHERE SALARY > 3000000 OR EMP_NAME = '������'
ORDER BY BONUS ASC;
-- FROM -> WHERE -> SELECT -> ORDER BY
-- ORDER BY�� �� �������� ����Ǵ±���!
-- *NULL : ASC(��������)�� ���� �� �Ʒ���, DESC(��������)�� ���� �� �տ� ��µȴ�


-- BETWEEN A AND B, �񱳿�����
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SALARY > 2000000 AND SALARY < 6000000;
WHERE SALARY BETWEEN 2000000 AND 6000000;


-- IN ������
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8';
WHERE DEPT_CODE IN ('D6', 'D8');


-- IS NULL�� IS NOT NULL ������
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS IS NOT NULL;
WHERE BONUS IS NULL;


-- LIKE ������
-- ����! LIKE ���� '%'�� ����Ͽ����Ѵ�.
-- ���ϵ�ī��
-- 1. % : 0�� �̻��� ��� ���ڸ� ��Ī
-- 2. _(�����) : �ϳ��� �ڸ��� �ش��ϴ� ��� ���ڸ� ��Ī

-- LIKE������ ����
-- ���� ���� ���� ������ �̸��� �޿��� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- LIKE������ ���� (%)
-- EMPLOYEE ���̺��� �̸��� ���� '��'���� ������ ����� �̸��� ����Ͻÿ�
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';


-- LIKE������ ����( _(�����) )
-- �ڸ��� ���� ������
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��';
-- '_'������ŭ ���ڸ� �о�´�. EX) __�� -> '��' �տ� �α��ڰ� �ִ� ����





-- [�ǽ�����]
--1. EMPLOYEE ���̺��� �̸� ���� ������ ������ ����� �̸��� ����Ͻÿ�
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

--2. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ��
--����Ͻÿ�
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

DESC EMPLOYEE;

--3. EMPLOYEE ���̺��� �����ּ��� 's'�� ���鼭, DEPT_CODE�� D9 �Ǵ� D6�̰�
--������� 90/01/01 ~ 01/12/01�̸鼭, ������ 270�����̻��� ����� ��ü ������ ����Ͻÿ�
SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/12/01'
AND EMAIL LIKE '%S%'
AND SALARY >= 2700000
-- AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6');
    -- IN �����ڷ� ǥ��
AND DEPT_CODE IN ('D9', 'D6');

DESC EMPLOYEE;

--4. EMPLOYEE ���̺��� EMAIL ID �� @ ���ڸ��� 5�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%'; 

--5. EMPLOYEE ���̺��� EMAIL ID �� '_' ���ڸ��� 3�ڸ��� ������ ��ȸ�Ѵٸ�?
-- '_'����ٴ� ���ϵ�ī��� ���ǰ��ְ�, �������� �����(_)�� ������ ���ڿ��� ����ؾ��Ѵ�.
-- _������ھ��� ��ɸ��� ���ڿ��� ����� �� �ְ� 'ESCAPE'�� ���� ���ڿ��� ����Ѵ�.
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';

--6. ������(MANAGER_ID)�� ���� �μ� ��ġ(DEPT_CODE)�� ���� ����  ������ �̸� ��ȸ
SELECT EMP_NAME FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--7. �μ���ġ�� ���� �ʾ����� ���ʽ��� �����ϴ� ���� ��ü ���� ��ȸ
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--8. EMPLOYEE ���̺��� �̸�,����, �Ѽ��ɾ�(���ʽ�����),
--   �Ǽ��ɾ�(�� ���ɾ�-(����*���� 3%*12))�� ��µǵ��� �Ͻÿ�
SELECT EMP_NAME "�̸�", SALARY*12 "����", SALARY*12 + BONUS "�Ѽ��ɾ�(���ʽ�����)",
(SALARY*12 + BONUS)-(SALARY*0.03*12) "�Ǽ��ɾ�"
--SELECT EMP_NAME AN "�̸�", SALARY*12 AS ����, SALARY*12 + BONUS "�Ѽ��ɾ�(���ʽ�����)",
--(SALARY*12 + BONUS)-(SALARY*0.03*12) "�Ǽ��ɾ�"
-- AS + �ֵ���ǥ, AS + ����ǥX, �׳� �ֵ���ǥ �� ��� ����
FROM EMPLOYEE;

DESC EMPLOYEE;

--9. EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ��� ����غ��ÿ�.
--   (SYSDATE�� ����ϸ� ���� �ð� ���)
SELECT EMP_NAME "�̸�", HIRE_DATE "�ٹ��ϼ�"
FROM EMPLOYEE;

--10. EMPLOYEE ���̺��� 20�� �̻� �ټ����� �̸�,����,���ʽ����� ����Ͻÿ�.
SELECT EMP_NAME "�̸�", SALARY "����", BONUS "���ʽ���", (SYSDATE - HIRE_DATE)/365 "�ټӳ��"
FROM EMPLOYEE
WHERE (SYSDATE - HIRE_DATE)/365 >= 20;

DESC EMPLOYEE;

