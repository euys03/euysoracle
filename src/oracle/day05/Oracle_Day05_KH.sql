-- ## �׷��Լ�(Group)
-- ���� ���� ���� ���� �� ���� ����� ������ �Լ�
-- *** SUM, AVG, COUNT, MAX, MIN ***

--@�ǽ�����
--1. [EMPLOYEE] ���̺��� ���� ����� �޿� �� ���� ���
--SELECT SUM(SALARY)
    -- �޸�(,) �� ǥ���غ���
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999,999') "�޿� �� ��"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

--2. [EMPLOYEE]���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ������ ���
    -- BONUS���� NULL�� ���ԵǾ������� NULL�� 0���� ǥ��
--SELECT SUM(SALARY*12 + SALARY*NVL(BONUS,0))
    -- �޸�(,) �� ǥ���غ���
SELECT TO_CHAR(SUM(SALARY*12 + SALARY*NVL(BONUS,0)), 'L999,999,999,999') "����"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--3. [EMPLOYEE] ���̺��� �� ����� ���ʽ� ����� �Ҽ� ��°¥������ �ݿø��Ͽ� ���Ͽ���
    -- BONUS���� NULL�� ���ԵǾ������� NULL�� 0���� ǥ��
    -- ROUND(�ø�) ����Ͽ� 2° �ڸ����� �ø�
SELECT ROUND(AVG(NVL(BONUS, 0)),2)
FROM EMPLOYEE;

--4. [EMPLOYEE] ���̺��� D5 �μ��� ���� �ִ� ����� ���� ��ȸ
    -- COUNT�� '*'�� ������ �ӵ��� ���� �� ��������
SELECT COUNT(EMP_NAME) "����� ��", COUNT(*) "����"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';
-- ex) EMPLOYEE ���̺� ����� �������� ���� ���Ͻÿ�
SELECT COUNT(*)
FROM EMPLOYEE;

--5. [EMPLOYEE] ���̺��� ������� �����ִ� �μ��� ���� ��ȸ (NULL�� ���ܵ�)
    -- NULL ���� -> IS NOT NULL;
    -- �μ��� '��' = �ߺ����� -> DISTINCT �Լ�
SELECT COUNT(DISTINCT(DEPT_CODE))
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

--6. [EMPLOYEE] ���̺��� ��� �� ���� ���� �޿��� ���� ���� �޿��� ��ȸ
SELECT MAX(SALARY), MIN(SALARY) FROM EMPLOYEE;

--7. [EMPLOYEE] ���̺��� ���� ������ �Ի��ϰ� ���� �ֱ� �Ի����� ��ȸ�Ͻÿ�
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE) FROM EMPLOYEE;




-- ## GROUP BY ��
-- ������ �׷� �������� ����� �׷��Լ��� �� �Ѱ��� ������� �����ϱ� ������
-- �׷��Լ��� �̿��Ͽ� � ���� ������� �����ϱ� ���ؼ���
-- �׷��Լ��� ����� �׷��� ������ 'GROUP BY��'�� ����Ͽ� ����ؾ� ��.
-- ex1) �μ��� �޿��հ踦 ���غ�����
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE;

-- ex2)���޺� �޿��հ踦 ���غ�����.
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

-- ex3) [EMPLOYEE]���̺��� �μ��ڵ� �׷캰 �޿��� �հ�, �׷캰 �޿��� ���(����ó��)
--      , �ο����� ��ȸ�ϰ�, �μ��ڵ� ������ ����
SELECT DEPT_CODE, TO_CHAR(SUM(SALARY), 'L999,999,999'), TO_CHAR(AVG(SALARY),'L999,999,999')
, COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE;

-- ex4) [EMPLOYEE]���̺��� �μ��ڵ� �׷캰, ���ʽ��� ���޹޴� ��� ���� ��ȸ�ϰ� �μ��ڵ� ������ ����
-- BONUS�÷��� ���� �����Ѵٸ�, �� ���� 1�� ī����.
-- ���ʽ��� ���޹޴� ����� ���� �μ��� ����.
SELECT DEPT_CODE, COUNT(BONUS), COUNT(*)
    -- COUNT(*)�� NULL�� ���� ��� ��ȸ�Ѵ�
FROM EMPLOYEE
--WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE 
ORDER BY DEPT_CODE ASC;
--> FROM -> WHERE -> GROUP BY -> SELECT -> ORDER BY


--@�ǽ�����
--1. EMPLOYEE ���̺��� ������ J1�� �����ϰ�, ���޺� ����� �� ��ձ޿��� ����ϼ���.
SELECT JOB_CODE AS ����, COUNT(EMP_ID) AS "���޺� ��� ��", TO_CHAR(AVG(SALARY), 'L999,999,999') AS ��ձ޿�
FROM EMPLOYEE
WHERE JOB_CODE <> 'J1'
-- �����ϴ� ���� '!='�� ���������� '<>' �� ǥ���Ѵ�.
GROUP BY JOB_CODE;

--2. EMPLOYEE���̺��� ������ J1�� �����ϰ�,  �Ի�⵵�� �ο����� ��ȸ�ؼ�, �Ի�� �������� �������� �����ϼ���.
SELECT EXTRACT(YEAR FROM HIRE_DATE)||'��' AS �Ի�⵵, COUNT(*) AS �����
--SELECT EXTRACT(YEAR FROM HIRE_DATE)||'��' AS �Ի�⵵, COUNT(EMP_ID)||'��' AS "��� ��"
FROM EMPLOYEE
WHERE JOB_CODE <> 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY EXTRACT(YEAR FROM HIRE_DATE) ASC;

--3. [EMPLOYEE] ���̺��� EMP_NO�� 8��° �ڸ��� 1, 3 �̸� '��', 2, 4 �̸� '��'�� ����� ��ȸ�ϰ�,
-- ������ �޿��� ���(����ó��), �޿��� �հ�, �ο����� ��ȸ�� �� �ο����� ���������� ���� �Ͻÿ�
SELECT DECODE(SUBSTR(EMP_NO, 8,1),'1','��','2','��','3','��','4','��') AS ����
        , FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*) AS "�ο� ��"
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8,1),'1','��','2','��','3','��','4','��')
ORDER BY COUNT(*) DESC;

--4. �μ��� ���� �ο����� ���ϼ���.
SELECT DECODE(SUBSTR(EMP_NO, 8,1),'1','��','2','��','3','��','4','��') AS ����, COUNT(*) AS �ο���
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8,1),'1','��','2','��','3','��','4','��');

--5. �μ��� �޿� ����� 3,000,000��(��������) �̻���  �μ��鿡 ���ؼ� �μ���, �޿������ ����ϼ���.
SELECT DEPT_CODE, TO_CHAR(FLOOR(AVG(SALARY)),'L999,999,999')
FROM EMPLOYEE
--WHERE FLOOR(AVG(SALARY)) >= 3000000
-- ���� ���Ⱚ�� �����̹Ƿ� SELECT���� ������ �ƴ� GROUP BY�� ���ǹ��� �ȴ�. => HAVING���
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) >= 3000000;




-- ## HAVING��
-- �׷��Լ��� ���� ���ؿ� �׷쿡 ���� ������ ������ ���� HAVING���� ����� !
-- (WHERE���� ��� �Ұ�!)

--@�ǽ�����
--1. �μ��� �ο��� 5���� ���� �μ��� �ο����� ����ϼ���.
SELECT DEPT_CODE AS �μ�, COUNT(*) AS �ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) > 5;

--2. �μ��� �� ���޺� �ο����� 3���̻��� ������ �μ��ڵ�, �����ڵ�, �ο����� ����ϼ���.
SELECT DEPT_CODE AS �μ��ڵ�, JOB_CODE AS �����ڵ�, COUNT(*) AS �ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
-- �������� GROUP�� �����Ϸ��� �ش� �÷����� ,(�޸�)�� �̾� �����ش�.
HAVING COUNT(*) >= 3
ORDER BY 1 ASC;

--3. �Ŵ����� �����ϴ� ����� 2�� �̻��� �Ŵ��� ���̵�� �����ϴ� ��� ���� ����ϼ���.
SELECT MANAGER_ID, COUNT(*)
FROM EMPLOYEE
GROUP BY MANAGER_ID
HAVING COUNT(*) >= 2 AND MANAGER_ID IS NOT NULL
ORDER BY 1;




-- ## ROLLUP�� CUBE
-- �� �Լ� ��� '��ü�հ�'�� ����ϴ� �Լ�.
-- �÷��� ���� 2�� �̻��� �� ROLLUP�� CUBE�� ���̸� �� �� �ִ�.
-- CUBE�� ��� �� ���� �� ����.

-- # ROLLUP(��ü�հ踦 ���1)
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;

-- # CUBE(��ü�հ踦 ���2)
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY 1;

-- [ROLLUP�� CUBE�� ����]
--@����1. ROLLUP �Լ� ��� (�� �μ��ڵ庰 �հ� + ��ü�հ踦 Ȯ���� �� �ִ�.)
-- �μ� �� ���޺� �޿� �հ踦 ���Ͻÿ�.
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
-- �μ��� �޿� �հ�(NULL�÷� ����), ��ü �հ踦 Ȯ���� �� �ִ�.
ORDER BY 1;

--@����2. CUBE �Լ� ��� (�� �μ��ڵ庰 �հ� + �� ���޺� �޿��հ�, ��ü�հ踦 Ȯ���� �� �ִ�.)
-- �μ� �� ���޺� �޿� �հ踦 ���Ͻÿ�.
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
-- �μ��� �޿��հ�(NULL�÷� ����), ���޺� �޿��հ�, ��ü �հ踦 Ȯ���� �� �ִ�.
-- CUBE�� ROLLUP���� ����� ����.
ORDER BY 1;
