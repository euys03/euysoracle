-- ## ���� ������
-- ��(������), ��(������), ��(������) ��
-- ex) A = {1, 2, 4}, B = {2, 5, 7}
--     A �� B = { 2 } --------------> ������
--     A �� B = {1, 2, 4, 5, 7} ----> ������
--     A �� B = {1, 4} -------------> ������  
--    =  A - A��B = {1, 4}

-- ������ -> INTERSECT
-- ������ -> UNION, UNION ALL
-- ������ -> MINUS

-- ResultSet�̶�?
-- '���տ�����'�� ����ϸ� �� ���̺��� ���տ��� �� �� �ִ�.
-- �� �� �� ���̺��(SELECT��)�� 'ResultSet' �̶�� �θ���.
-- # 1. INTERSECT ����(������)
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;

-- # 2. UNION ALL ����(������1) : �ߺ� ���
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;

-- # 2.1 UNION ����(������2) : �ߺ� ����
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;

-- # 3. MINUS ����(������): 31���� �����ִ� �����Ϳ��� 34���� �����͸� ���ڴ�.
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;



--## UNION�� ���� ##
-- 1. SELECT���� �÷� ������ �ݵ�� ���ƾ� ��
-- ORA-01789: query block has incorrect number of result columns
SELECT EMP_NAME FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;

-- 2. �÷��� ������ Ÿ���� �ݵ�� ���ų� ��ȯ�����ؾ��� (ex. CHAR - VARCHAR2)
-- ORA-01790: expression must have same datatype as corresponding expression
-- EMP_NAME : ���ڿ�, SALARY : ���� �̹Ƿ� ������ ����
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;



-- ## ���ι�(JOIN)
----> ���� ���̺��� ���ڵ带 �����Ͽ� �ϳ��� ���� ǥ���� ��
----> �� �� �̻��� ���̺��� �������� ������ �ִ� �����͵��� �÷� �������� �з��Ͽ�
--    ���ο� ������ ���̺��� �̿��Ͽ� �����
--    �ٽø���, ���� �ٸ� ���̺��� ������ ���밪�� �̿������μ� �ʵ带 ������.

-- @����1. ������ �μ����� ����ϼ���.(JOIN���� �ƴ� DECADE �Լ� ����Ͽ��� ��.)
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ�ϰ�, �μ��ڵ� �������� �������� ������.
SELECT EMP_NAME, DECODE(DEPT_CODE, 'D9', '�ѹ���', 'D5', '�ؿܿ���1��', 'D6', '�ؿܿ���2��')
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6', 'D9');
SELECT * FROM DEPARTMENT;

SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE;
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;


-- # ���ι�(JOIN) �ۼ�
-- SELECT �÷��� FROM ���̺� JOIN ���̺� ON �÷���1 = �÷���2
-- JOIN �ۼ� �� JOIN�ϰ��� �ϴ� ���̺��
-- SELECT + '*' => �� ���� ���̺��� JOIN���� ������ �� ���̺��� �ϳ��� ������ ���̺�� ���������.
-- 1. ANSI ǥ�ر��� (��� DB������ ��밡��)
SELECT EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
-- 2. ����Ŭ ���� ���� (JOIN ��� �޸�(,) ���, ON ��� WHERE ��� -> ����Ŭ������ ��밡��)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID;


-- ## JOIN�� ����1
-- 1. EQUI-JOIN : �Ϲ������� ���, 'ON �÷���1 = �÷���2'�� ���� ����
-- 2. NON-Equi JOIN : ��������(=)�� �ƴ� BETWEEN AND, IS NULL, IS NOT NULL, IN, NOT IN ������ ���

-- @�ǽ�����
--1. �μ���� �������� ����ϼ���. DEPARTMENT, LOCATION ���̺� �̿�.
SELECT DEPT_TITLE, LOCATION_ID, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--2. ������ ���޸��� ����ϼ���. EMPLOYEE, JOB ���̺� �̿�
SELECT EMP_NAME, JOB_NAME
FROM EMPLOYEE JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- ORA-00918: column ambiguously defined
-- ��ȣ�� �� �ذ���1.
-- �÷����� ������ � ���̺��� �÷������� �𸣹Ƿ� ��(.)���� ���̺��� �������־� ������ ���̺��� ������ش�.

-- ��ȣ�� �� �ذ���2.
-- ��Ī�� �����ش�(E, J, EMP, JB, ...�� ���ϴ� ��Ī)
SELECT EMP_NAME, JOB_NAME
FROM EMPLOYEE E JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;

-- ��ȣ�� �� �ذ���3.
-- USING Ű���� ���
SELECT EMP_NAME, JOB_NAME FROM EMPLOYEE JOIN JOB 
USING(JOB_CODE);

--SELECT EMP_NAME, JOB_NAME
--FROM EMPLOYEE E JOIN JOB J USING(JOB_CODE);

--3. ������� �������� ����ϼ���. LOCATION, NATIONAL ���̺� �̿�
--    ���1. ON LOCATION.NATIONAL_CODE = NATIONAL.NATIONAL_CODE;
--    ���2. ON L.NATIONAL_CODE = N.NATIONAL_CODE;
-- [v]���3. �� ���̺��� �÷����� 'NATIONAL_CODE'�� �����ϹǷ� USINGŰ���带 ����Ͽ� JOIN���ش�.
SELECT LOCAL_NAME AS ������, NATIONAL_NAME AS ������
FROM LOCATION JOIN NATIONAL USING(NATIONAL_CODE);

-- ���ݱ����� �ڵ�� INNER JOIN �� 'INNER EQUI_JOIN' �� �ش�


-- ## JOIN�� ����2
-- INNER JOIN(��������) : �Ϲ������� ����ϴ� ����(������, null�� �ƴ� �����͵鸸 ���)
-- OUTER JOIN(�ܺ�����) : ������, ��� ���
-- -> 1. LEFT (OUTER) JOIN
-- -> 2. RIGHT (OUTER) JOIN
-- -> 3. FULL (OUTER) JOIN
-- JOIN������ (INNER)�� (OUTER)�� �����Ͽ� ����Ѵ�.

-- # INNER JOIN �������� ������ (�� �÷��� ���� �͸� ���´�(ON ���ǿ� �´� ��))
-- ������ �ߴ� JOIN������ ��� JOIN �տ� (INNER)�� �����Ǿ� �־��� ��.
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE INNER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- # 1.(OUTER)LEFT JOIN �ܺ����� ������
-- (LEFT���̺�(EMPLOYEE) �������� �������, ���� ���� ���� �͵� '����'�ϰ� ��� ��µȴ�)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- # 2.(OUTER)RIGHT JOIN �ܺ����� ������
-- (RIGHT���̺�(DEPARTMENT)�� �������� �������, ���� ���� ���ٰ� ���´�.)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- # 3.(OUTER)FULL JOIN �ܺ����� ������ (FULL�� ����, ������ ���� ������ ��.)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

------------------------------------------------------------------
-- ## OUTER JOIN�� 'ANSI ǥ�ر���'�� '����Ŭ ���뱸��'
-- ANSI ǥ�� ���� (LEFT)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ����Ŭ ���� ���� (LEFT)
-- ('+'�� ���� ��(DEPT_CODE)�� �ִ� ���̺�(EMPLOYEE)�� ��� �����͸� ����ϴ� ��)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID(+);


-- ANSI ǥ�ر��� (RIGHT)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ����Ŭ ���� ���� (RIGHT)
-- ('+'�� ���� ��(DEPT_ID)�� �ִ� ���̺�(DEPARTMENT)�� ��� �����͸� ����ϴ� ��)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE(+) = DEPT_ID;


-- ANSI ǥ�� ������ ���� (FULL)
-- (FULL�� ANSI ǥ�ر����� �����ϸ�, ����Ŭ ���� ������ �������� �ʴ´�.)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
---------------------------------------------------------------------
-- EX) OUTER JOIN(�ܺ�����)�� ���캸��
-- INNER JOIN�� ��� ���̺��� JOIN�ϴ� ������ ����� ��������
-- OUTER JOIN�� ��� ���� LEFT�϶�, JOIN �տ� �ִ� ���̺��� �������� ����ϹǷ� ������ ������ �ִ�.
-- �Ʒ� �� �ڵ�� ������ ����� ����Ѵ�(������ �ڵ�)
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

SELECT EMP_NAME, DEPT_TITLE
FROM DEPARTMENT RIGHT JOIN EMPLOYEE ON DEPT_ID = DEPT_CODE;



-- ## JOIN�� ����3
-- 1. ��ȣ����(CROSS JOIN)
-- 2. ��������(SELF JOIN)
-- 3. ��������

-- # 1. ��ȣ����(CROSS JOIN)
-- ī���̼� ��(Cartensial Proudct) ��� ��
-- ���εǴ� ���̺��� �� ����� ��� ���ε� ���� ���
-- �ٽø��� �� �� ���̺��� ��� ��� �ٸ� �� ���̺��� ��� ���� ���� ��Ŵ
-- (1�� * (1��~10��), 2��*(1��~10��) �� �� ���� ���)
-- ��� ����� ���� ���ϹǷ� ����� �� ���̺��� �÷� ���� ���� ������ ����.
-- 4 * 3 = ?
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE CROSS JOIN DEPARTMENT;

--@�ǽ�����1. �Ʒ�ó�� �������� �ϼ���. (��� ���޿� ���� ��տ����� ��Ÿ���������)
----------------------------------------------------------------
-- �����ȣ    �����     ����    ��տ���    ����-��տ���
----------------------------------------------------------------
    -- ��Į�󼭺������� Ǯ� (��Į�� ���������� �� �ʿ� ����, CROSS JOIN���� Ǯ��.)
    -- (SELECT AVG(SALARY) FROM EMPLOYEE) AS ��տ��� -> �̰��� '��Į�� ��������'�̸�, ���� ����� �ƴ�)
SELECT EMP_ID AS �����ȣ, EMP_NAME AS �����, SALARY AS ����
        ,(SELECT AVG(SALARY) FROM EMPLOYEE) AS ��տ���
        ,SALARY - AVG(SALARY) AS "����-��տ���"
FROM EMPLOYEE;

    -- ��ȣ����VER.(���� ��Į�󼭺�����(SELECT�� �ϳ���)�� ����Ͽ� SELECT���� ��� �� �ʿ����
    -- ��ȣ����(CROSS JOIN)�� �ѹ��� �����Ͽ� AVG_SAL�� ���� ��Ī�� ��üó�� ���)
SELECT EMP_ID AS �����ȣ, EMP_NAME AS �����, SALARY AS ����
        , AVG_SAL AS ��տ���
        , SALARY - AVG_SAL AS "����-��տ���"
FROM EMPLOYEE
CROSS JOIN (SELECT ROUND(AVG(SALARY)) "AVG_SAL" FROM EMPLOYEE);

    -- ����-��տ����� ����� �տ� ���� ���̳ʽ�(-)�� '+'�� ��Ÿ���� ���� ��� ('DECODE' OR 'CASE-THEN' ���)
    -- DECODE�� CASE-END �� ������ : CASE-END�� ������ ������ �� �ִ�(>,<,=>,=> ��)
SELECT EMP_ID AS �����ȣ, EMP_NAME AS �����, SALARY AS ����
        , AVG_SAL AS ��տ���
        , (CASE WHEN SALARY - AVG_SAL > 0 THEN '+' END) || (SALARY - AVG_SAL) AS "����-��տ���"
FROM EMPLOYEE
CROSS JOIN (SELECT ROUND(AVG(SALARY)) "AVG_SAL" FROM EMPLOYEE);


-- # 2. ��������(SELF JOIN)
-- �ڱ��ڽ��� ����

--@�ǽ�����1. �Ŵ����� �ִ� ����߿� ������ ��ü��� ����� �Ѵ� ���� ���,�̸�,�Ŵ��� �̸�, ������ ���Ͻÿ�.
SELECT EMP_ID AS ���, EMP_NAME AS �̸�
    ,(SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID) AS "�Ŵ��� �̸�"
    , SALARY AS ����
FROM EMPLOYEE E
WHERE MANAGER_ID IS NOT NULL AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);

-- ��������� �̿��� �Ŵ��� �̸� ���ϱ� ��� ���� ���� ���� ������ �̿��ؼ� ���� �� ����.
-- �Ȱ��Ƽ� ���������̶�� �ϴ� ��(EMPLOYEE���̺� EMPLOYEE�� �����̹Ƿ� ��Ī�� �߿�)
SELECT E.EMP_ID, E.EMP_NAME, M.EMP_NAME, E.SALARY
FROM EMPOYEE E
JOIN EMPLOYEE M
ON M.EMP_ID = E.MANAGER_ID;

SELECT EMP_ID, EMP_NAME, MANAGER_ID FROM EMPLOYEE;


-- # 3. ��������
-- -> ���� ���� ���ι��� �ѹ��� ����� �� ����
-- -> (����) JOIN�ϴ� ���̺���� ������ �߿�!
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--@�ǽ�����1.
-- 1. ������ �븮�̸鼭, ASIA ������ �ٹ��ϴ� ���� ��ȸ
-- ���, �̸� ,���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
-- EMPLOYEE, JOB, EMPLOYEE, SAL_GRADE, LOCATION
SELECT EMP_ID AS ���, EMP_NAME AS �̸�, JOB_NAME AS ���޸�, DEPT_TITLE AS �μ���
    , LOCAL_NAME AS �ٹ�������, SALARY AS �޿�
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE JOB_NAME = '�븮' AND LOCAL_NAME IN ('ASIA1', 'ASIA2', 'ASIA3');
--WHERE JOB_NAME = '�븮' AND LOCAL_NAME LIKE 'ASIA%';
    


---------------------------------------------------------------------------------

--[JOIN �ǽ�����]
--1. 2022�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�. (JOIN���� X)
SELECT TO_CHAR(TO_DATE(20221225), 'day') FROM DUAL;
--TO_DATE ����Ͽ� ��¥�������� �ٲ��ְ� ���ϴ� �����ʹ� �����̹Ƿ� 'day'�� ����Ѵ�.

--2. �ֹι�ȣ�� 1970��� ���̸鼭 ������ �����̰�, ���� ������ �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.
SELECT EMP_NAME AS �����, EMP_NO AS �ֹι�ȣ, DEPT_TITLE AS �μ���, JOB_NAME AS ���޸�
FROM EMPLOYEE E
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE (SUBSTR(EMP_NO,1,2)) BETWEEN '70' AND '79'
--WHERE SUBSTR(EMP_NO,1,2) BETWEEN 70 AND 79 -> ����ȯ�Ǿ� ���ڿ� ����ǥ('') ���� �ʿ�X
AND SUBSTR(EMP_NO, 8, 1) = '2'
AND EMP_NAME LIKE '��%';

--3. �̸��� '��'�ڰ� ���� �������� ���, �����, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_ID AS ���, EMP_NAME AS �����, DEPT_TITLE AS �μ���
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME LIKE '%��%';

--4. �ؿܿ����ο� �ٹ��ϴ� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_NAME AS �����, JOB_NAME AS ���޸�, DEPT_CODE AS �μ��ڵ�, DEPT_TITLE AS �μ���
FROM EMPLOYEE
    JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
-- 2���� ǥ����� (_�����, % �ۼ�Ʈ)
WHERE DEPT_TITLE LIKE '�ؿܿ���_��';
--WHERE DEPT_TITLE LIKE '�ؿܿ���%';

--5. ���ʽ�����Ʈ�� �޴� �������� �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME AS �����, NVL(BONUS,0) AS ���ʽ�����Ʈ, DEPT_TITLE AS �μ���, LOCAL_NAME AS �ٹ�������
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON  LOCATION_ID = LOCAL_CODE
WHERE BONUS IS NOT NULL;

--6. �μ��ڵ尡 D2�� �������� �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT DEPT_CODE AS �μ��ڵ�, EMP_NAME AS �����, JOB_NAME AS ���޸�, DEPT_TITLE AS �μ���, LOCAL_NAME AS �ٹ�������
FROM EMPLOYEE E
    JOIN JOB USING(JOB_CODE)
    -- ���2) JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE
    -- ���3) JOIN JOB ON E.JOB_CODE = J.JOB_CODE -> ���̺�� �ڿ� ��Ī(E, J, ..)�ٿ��ֱ�
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE DEPT_CODE = 'D2';
-- (����) JOB_CODE�� ��� ���� ���̺� �����ϴ� �÷��̹Ƿ� �������� ����� ��� ������ �� �� �ִ�.


--7. �޿�������̺��� �ִ�޿�(MAX_SAL)���� ���� �޴� �������� �����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
-- (������̺�� �޿�������̺��� SAL_LEVEL�÷��������� ������ ��)
--> �����Ͱ� ������������. �ĸ� �Ẹ��
 

--8. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� �����, �μ���, ������, �������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME AS �����, DEPT_TITLE AS �μ���, LOCAL_NAME AS ������, NATIONAL_NAME AS ������
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION L ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE
--WHERE N.NATIONAL_CODE IN ('KO', 'JP')
WHERE NATIONAL_NAME IN ('�ѱ�', '�Ϻ�')
ORDER BY 4 ASC;

--9. ���ʽ�����Ʈ�� ���� ������ �߿��� ������ ����� ����� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�. ��, join�� IN ����� ��
SELECT EMP_NAME AS �����, JOB_NAME AS ���޸�, SALARY AS �޿�
FROM EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE BONUS IS NULL AND JOB_NAME IN ('����', '���');

--10. �������� ������ ����� ������ ���� ��ȸ�Ͻÿ�.
SELECT DECODE(ENT_YN, 'Y','����', 'N','����') AS ��������, COUNT(*) AS ������
FROM EMPLOYEE
GROUP BY DECODE(ENT_YN, 'Y','����', 'N','����');

