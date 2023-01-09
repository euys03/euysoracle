-- [����Ŭ �Լ�]
-- 1)����ó�� �Լ�  2)����ó�� �Լ�  3)��¥ó�� �Լ�  4)����ȯ �Լ�  5)�� �� �Լ�

-- # 1. ���� ó�� �Լ�
-- LENGTH(���� ����), LENGTHB(���� ����(BYTE��)), SUBSTR(���� �ڸ�), INSTR(��ġ ����),
-- LPAD, RPAD(������ ���̸� ���ϰ� ���ϴ� ���ڷ� ä��� ��, �������� ä�� ���� ����),
-- CONCAT(���� �̾����), LTRIM, RTRIM(��,�� ����), TRIM(�� �� ����)

--@�ǽ�����1. LTRIM(��������) / RTRIM(��������) 
-- ���� ���ڿ����� �յ� ��� ���ڸ� �����ϼ���.
-- '982341678934509hello89798739273402'
SELECT RTRIM(LTRIM('982341678934509hello89798739273402', '0123456789'), '0123456789')
FROM DUAL;
-- FROM DUAL : �ش� �����͸� �ٷ� ����ؼ� �� �� �ִ� '������ ���̺�' ***

--@�ǽ�����2. SUBSTR(�ڸ���)
-- ������� ���� �ߺ����� ���������� ����ϼ���.
SELECT SUBSTR(EMP_NAME, 1, 1) "EMP_NAME"
    -- EMP_NAME�� 1��° ���ں��� 1���� �߶��.
FROM EMPLOYEE
--ORDER BY SUBSTR(EMP_NAME,1,1) ASC;
ORDER BY 1 ASC;   -- ������� ���� ���������� ����ϼ��� �ϼ�!
-- �ߺ����� ����� ��� �ϴ� �ɱ�? => DISTINCT �Լ� ���
SELECT DISTINCT SUBSTR(EMP_NAME, 1, 1) "EMP_NAME"
FROM EMPLOYEE
ORDER BY 1 ASC; -- �̷��� �ᵵ ���� 1���� ��� ����

--@�ǽ�����3. RPAD(���̱�), SUBSTR(�ڸ���)
-- employee ���̺��� ���ڸ� �����ȣ, �����, �ֹι�ȣ, ������ ��Ÿ������.
-- �ֹι�ȣ�� ��6�ڸ��� *ó���ϼ���.
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*'), SALARY*12
-- SUBSTR : �ֹι�ȣ�� 1��°���� 8��°���� �ڸ���,
-- RPAD : �ڸ� 8�ڸ� �����Ͽ� ���ڿ��� �� 14�ڸ��̰�, 8�ڸ� ���Ĵ� '*'�� �̾���δ�
-- => 14-8 = 6, 6���� '*'�� �̾ ������
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8,1) = '1' OR SUBSTR(EMP_NO,8,1) = '3';
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');

    -- '*' 6�� ���̴� ���1. ���Ῥ����(�� 6���� ���� �Է�)
SELECT EMP_ID, EMP_NAME, SUBSTR(EMP_NO,1,8) || '******', SALARY*12
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');

    -- '*' 6�� ���̴� ���2. CONCAT�Լ� ���(����ó���ϴ� �Լ�)
SELECT EMP_ID, EMP_NAME, CONCAT(SUBSTR(EMP_NO,1,8),'******'), SALARY*12 || '��'
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');



-- # 2. ���� ó�� �Լ�
-- FLOOR�Լ�(�Ҽ��� ������), ROUND�Լ�(�ݿø�), CEIL�Լ�(������ �ø�)
-- (����) TRUNC : '�� ��° �ڸ�����' ����, �ݿø�, �ø� �� ������

--@�ǽ�����1. EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ��� ����غ��ÿ�. 
--(SYSDATE�� ����ϸ� ���� �ð� ���)
SELECT EMP_NAME, SYSDATE - HIRE_DATE "�ٹ��ϼ�", FLOOR(SYSDATE - HIRE_DATE) "����",
        ROUND(SYSDATE - HIRE_DATE) "�ݿø�", CEIL(SYSDATE - HIRE_DATE) "�ø�"
FROM EMPLOYEE;



-- # 3. ��¥ ó�� �Լ�
-- SYSDATE(����), MONTHS_BETWEEN(���� ���̼�), ADD_MONTHS(���� ���ϱ�)
-- NEXT_DAY(���� ������ ��¥), LAST_DAY(�ش� ���� ������ ��¥), EXTRACT(��,��,�� ����)

--@�ǽ�����1. ADD_MONTHS �Լ�(���� ���ϱ�)
-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի� �� 3������ �� ��¥�� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,3)
FROM EMPLOYEE;

DESC EMPLOYEE;

--@�ǽ�����2. MONTHS_BETWEEN �Լ� (�ݿø��Ͽ� ����ϰ� ����ϱ�)
--EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ� �������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, HIRE_DATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "PERIOD"
FROM EMPLOYEE;

--@�ǽ�����3. LAST_DAY �Լ�
--ex) EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի���� ���������� ��ȸ�ϼ���.
SELECT EMP_NAME, HIRE_DATE "�Ի���", LAST_DAY(HIRE_DATE) "�Ի���� ������ ��" 
FROM EMPLOYEE;

--@�ǽ�����4. EXTRACT(YEAR, MONTH, DAY ... FROM ~) �Լ�
--          ���Ῥ����(||) ����Ͽ� ���⽱��
--ex) EMPLOYEE ���̺��� ��� �̸�, �Ի� �⵵, �Ի� ��, �Ի� ���� ��ȸ�Ͻÿ�.
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE)||'��' AS "�Ի� �⵵",
        EXTRACT(MONTH FROM HIRE_DATE)||'��' AS "�Ի� ��",
        EXTRACT(DAY FROM HIRE_DATE)||'��' AS "�Ի� ��"
FROM EMPLOYEE;

--@�ǽ�����5.
/*
     ���úη� �Ͽ��ھ��� ���뿡 �������ϴ�.
     ������ �Ⱓ�� 1�� 6������ �Ѵٶ�� �����ϸ�
     ù��°, �������ڸ� ���Ͻð�,
     �ι�°, �������ڱ��� �Ծ���� ���� �׷���� ���մϴ�.
     (��, 1�� 3���� �Դ´ٰ� �Ѵ�.)
*/
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 18) "��������", 
    (ADD_MONTHS(SYSDATE, 18) - SYSDATE)*3 "�׸���"
FROM DUAL;



-- # 4. ����ȯ ó�� �Լ�
-- TO_CHAR(��¥��OR������ -> ������), TO_DATE(������ -> ��¥��), TO_NUMBER(������ -> ������)
-- => TO + '���ϰ����ϴ� ������Ÿ��'
-- [�ʱ�]
-- �÷��� '���ڿ�'�ε� ��¥�� ǥ���ؾ��� �� TO_CHAR.
-- ����ϰ���� �������� ex)��ȭ �� ,(�޸�) => TO_CHAR.
-- DATE�����δ� 1111-22-33�� ���� '-'�� ǥ���� �� ����. => TO_CHAR.



-- # 5. �� �� ó�� �Լ�
-- ***(�߿�) NVL(NULLó���Լ� - NULL�� �÷����� ���� Ȥ�� ���ڷ� ����)
-- DECODE(���ǹ�, CASE�� �Ǵ� IF-THEN-ELSE��)


---------------------------------------------------------------------------------

-- [�ǽ�����]
-- �Լ�(����ó���Լ�, ����ó���Լ�, ��¥ó���Լ�, ����ȯ�Լ�, �� �� ó���Լ�)
-- 1. ������� �̸���, �̸��� ���̸� ����Ͻÿ�.
--        �̸�         �̸���          �̸��ϱ���
-- ex)   ȫ�浿,     hon@kh.or.kr        13
    -- #LENGTH, LENGTHB �Լ� ���
    ---> EMAIL(����-1����Ʈ), EMP_NAME(�ѱ�-3����Ʈ)
    ---> (EMAIL�� �ѱ��� ��� LENGTH�� LENGTHB�� ����(����-1����Ʈ)�� �����ϰ� ������ ��)
    ---> (EMP_NAME(�̸�)�� 2���ڿ��ٸ� LENGTH�� 2�̰�, LENGTHB�� 2*3='6'�̴�.)
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
    , LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;
    -- ex) �̸����� ���̰� 15���� ���� �����͸� �˻��غ��ÿ�.
    SELECT *
    FROM EMPLOYEE
    WHERE LENGTH(EMAIL) < 15;
    -- WHERE EMAIL = 'no_hc@kh.or.kr'; => ���� �̸����� �˻��ϴ� ���
    --> ������ �̸����� ����(length)�� �񱳰�(ex.13)�� ���Ͽ� �̸����� ��ȸ�Ѵ�
    
    
-- 2. ������ �̸��� �̸��� �ּ� �� ���̵� �κи� ����Ͻÿ�
--	ex) ���ö	no_hc
--	ex) ������	jung_jh

-- #SUBSTRING �Լ�(�ڸ���), #INSTR �Լ�(��ġ�� ��ȯ)
    -- > SUBSTR(�÷���, ������ġ, �ڸ������ ����)
    -- > INSTR(�÷���, ã����� ����, ������ġ, �ڸ������ ����)
-- ��, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@', 1, 1)) �� EMAIL�� ù��°����,
--  (INSTR)EMAIL �� @�� ��ġ�� ã�� �� ��ġ�� ������ ù��°���� 1��(@�� ã�´ٴ� ��)�� ��ġ��ȣ�� ��ȯ�Ͽ�
--  ��������� EMAIL�� ù��° ��ġ���� @���� �߶� ����ϴ� ���� ���Ѵ�.
-- SUBSTR(EMAIL, 1, INSTR(EMAIL, '@', 1, 1)-1)�� ���� -1�ϸ� @�� �߸��� ���̵� ���
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, 6), SUBSTR(EMAIL, 1, INSTR(EMAIL, '@', 1, 1))
FROM EMPLOYEE;
    -- INSTR �Լ�(@�� ��ġ ��ȯ)
SELECT EMAIL, INSTR(EMAIL, '@', 1, 1)
FROM EMPLOYEE;


--3. 60��뿡 �¾ ������� ���, ���ʽ� ���� ����Ͻÿ�. �׶� ���ʽ� ���� null�� ��쿡�� 0 �̶�� ��� �ǰ� ����ÿ�
--	    ������    ���      ���ʽ�
--	ex) ������	    1962	    0.3
--	ex) ������	    1963  	    0

    -- ���� ó�� �Լ� VER.(CONCAT �Լ� ���)
    -- CONCAT�Լ� : ���޹��� �� ���� ����/���ڿ��� ��ģ��.
SELECT EMP_NAME AS �̸�, CONCAT(19, SUBSTR(EMP_NO,1,2)) AS ���, BONUS AS ���ʽ�
FROM EMPLOYEE
--WHERE BETWEEN(SUBSTR(EMP_NO,1,2) >= 60 AND SUBSTR(EMP_NO,1,2) < 70);
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 60 AND 69;

    -- ��¥ ó�� VER.
    -- FROM �ڿ��� DATE, TO_DATE �ڿ��� ��¥����.
SELECT EXTRACT(YEAR FROM SYSDATE) FROM DUAL;
SELECT EXTRACT(YEAR FROM HIRE_DATE) FROM EMPLOYEE;
    -- ���ڿ� -> 
SELECT EXTRACT(YEAR FROM TO_DATE(EMP_NO)) FROM EMPLOYEE;
SELECT EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) FROM EMPLOYEE;
    --1. ORA-01861: literal does not match format string
    -- '660211-1012654'�� ���� ���´� �ٲ� �� ���� -> 661201 (��¥������ �ٲ����� �Ѵ�)
SELECT TO_DATE(SUBSTR(EMP_NO,1,2), 'RR') FROM EMPLOYEE);
    -- 2. ORA-30076 : invalid extract field for extract source
    -- '66' -> �ʹ� ª��
    -- 'RR'����Ͽ� 1900����� ���� �ν�
    -- 'YY'�� 2000���, 'RR'�� 1990��븦 �ǹ�


--4. '010' �ڵ��� ��ȣ�� ���� �ʴ� ����� ���� ����Ͻÿ� (�ڿ� ������ ���� ���̽ÿ�)
--	   �ο�
--	ex) 3��
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(PHONE, 1, 3) <> '010';


--5. ������� �Ի����� ����Ͻÿ� 
--	��, �Ʒ��� ���� ��µǵ��� ����� ���ÿ�
--	    ������		�Ի���
--	ex) ������		2012�� 12��
--	ex) ������		1997�� 3��
SELECT EMP_NAME AS ������, EXTRACT(YEAR FROM HIRE_DATE)||'��'
||EXTRACT(MONTH FROM HIRE_DATE))||'��' AS �Ի���
FROM EMPLOYEE
ORDER BY 2;


--6. ������� �ֹι�ȣ�� ��ȸ�Ͻÿ�
--	��, �ֹι�ȣ 9��° �ڸ����� �������� '*' ���ڷ� ä������� �Ͻÿ�
--	ex) ȫ�浿 771120-1******
SELECT EMP_NAME AS ������, RPAD(SUBSTR(EMP_NO,1,8),14,'*') AS �ֹι�ȣ
FROM EMPLOYEE;


--7. ������, �����ڵ�, ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--     ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���
SELECT EMP_NAME AS ������, JOB_CODE AS �����ڵ�
    , SALARY*12+SALARY*NVL(BONUS,0) AS "����(��)", NVL(BONUS, 0)
FROM EMPLOYEE;
    -- Ư�����ڿ�, ���� ���� �÷����� �����Ϸ��� �ֵ���ǥ("")�� ǥ������� �Ѵ�.
    -- NVL�Լ� ���(NULL�� ���ϴ� �����ͷ� ä���ִ´�. -> 0)

    -- TO_CHAR�� ���ڿ��� ���� + 999�� �ڸ��� ǥ��(,) + 'L'�� �ٿ��ָ� �ڵ����� ��ȭ(W)�� ǥ���ȴ�.
SELECT TO_CHAR(SALARY, 'L999,999,999') FROM EMPLOYEE;
    -- 0���� �ϸ� ��� �ɱ�?
SELECT TO_CHAR(SALARY, '000,000,000') FROM EMPLOYEE;

-- ���
SELECT EMP_NAME AS ������, JOB_CODE AS �����ڵ�
, TO_CHAR(SALARY*12+SALARY*NVL(BONUS,0), 'L999,999,999') AS "����(��)", NVL(BONUS, 0)
FROM EMPLOYEE;


--8. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� ������ ���, �����, �μ��ڵ�, �Ի��� ��ȸ��.
SELECT EMP_ID AS ���, EMP_NAME AS �����, DEPT_CODE AS �μ��ڵ�
    , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS �Ի���
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D9') AND EXTRACT(YEAR FROM HIRE_DATE) = 2004;


--9. ������, �Ի���, ���ñ����� �ٹ��ϼ� ��ȸ 
--	* �ָ��� ���� , �Ҽ��� �Ʒ��� ����
SELECT EMP_NAME AS ������, HIRE_DATE AS �Ի���, FLOOR(SYSDATE - HIRE_DATE)||'��' AS �ٹ��ϼ�
FROM EMPLOYEE;


--10. ������, �μ��ڵ�, �������, ����(��) ��ȸ
--   ��, ��������� �ֹι�ȣ���� �����ؼ�, 
--   ���������� ������ �����Ϸ� ��µǰ� ��.
--   ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����
--	* �ֹι�ȣ�� �̻��� ������� ���ܽ�Ű�� ���� �ϵ���(200,201,214 �� ����)
--	* HINT : NOT IN ���
SELECT EMP_NAME AS ������, DEPT_CODE AS �μ��ڵ�, '19'||SUBSTR(EMP_NO, 1, 2)||'�� '
    ||SUBSTR(EMP_NO, 3, 2)||'�� '||SUBSTR(EMP_NO, 5, 2)||'��' AS �������
    -- > ���� ó�� �Լ�
    , EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR'))
    ||'�� ' ||EXTRACT(MONTH FROM TO_DATE(SUBSTR(EMP_NO,3,2), 'MM'))
    ||'�� ' ||EXTRACT(DAY FROM TO_DATE(SUBSTR(EMP_NO,5,2), 'DD'))
    ||'��' AS �������2
    -- ������, 2022(����) - 1986(�¾�⵵) = 36
    -- 2022 - 1986 = 36
    -- > ��¥ ó�� �Լ�
    , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) AS "����(��)"
    -- ��¥ ó�� �Լ� : ���� + ���� => TO_NUMBER�� ���ڸ� ���ڷ� ����
    , EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(EMP_NO,1,2))) AS ����
    -- ���� ó�� �Լ� : DECODE(���ڵ�) ���
    , EXTRACT(YEAR FROM SYSDATE) - (DECODE(SUBSTR(EMP_NO,8,1),'1',1900, '2',1900, '3',2000,'4',2000
    + TO_NUMBER(SUBSTR(EMP_NO,1,2))) AS ����
FROM EMPLOYEE
WHERE EMP_ID NOT IN (200, 201, 214);

    -- ��¥ ó�� �Լ� 'DECODE�Լ�'�� ����(1 �Ǵ� 2�� �� ���)
SELECT 
    DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��','3','��','4','��')
FROM EMPLOYEE;


--11. ������, �μ����� ����ϼ���.
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ�ϰ�, �μ��ڵ� �������� �������� ������.
SELECT EMP_NAME AS �����, DEPT_CODE AS �μ��ڵ�
    , DECODE(DEPT_CODE,'D5','�ѹ���','D6','��ȹ��','D9','������') AS �μ���1
    -- DECODE�� ������ CASE-END ���� (��Һ񱳰� �����ϴٴ� �������� ������ ����)
    , CASE
        WHEN DEPT_CODE = 'D5' THEN '�ѹ���'
        WHEN DEPT_CODE = 'D6' THEN '��ȹ��'
        WHEN DEPT_CODE = 'D9' THEN '������'
    END AS �μ���2
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D9')
ORDER BY 2 ASC;





-- [���� �ǽ� ����]
-- ����1. 
-- �Ի����� 5�� �̻�, 10�� ������ ������ �̸�,�ֹι�ȣ,�޿�,�Ի����� �˻��Ͽ���
SELECT EMP_NAME AS �̸�, EMP_NO AS �ֹι�ȣ, SALARY AS �޿�, HIRE_DATE AS �Ի���
FROM EMPLOYEE
WHERE CEIL((SYSDATE-HIRE_DATE)/365) BETWEEN 5 AND 10;

DESC EMPLOYEE;

-- ����2.
-- �������� �ƴ� ������ �̸�,�μ��ڵ�, �����, �ٹ��Ⱓ, �������� �˻��Ͽ��� 
--(��� ���� : ENT_YN -> Y�̸� ������ ��.)
SELECT EMP_NAME AS �̸�, DEPT_CODE AS �μ��ڵ�, HIRE_DATE AS �����
    ,(ENT_DATE-HIRE_DATE) AS �ٹ��Ⱓ, ENT_DATE AS ������
FROM EMPLOYEE
WHERE ENT_YN != 'N'; 

-- ����3.
-- �ټӳ���� 10�� �̻��� �������� �˻��Ͽ�
-- ��� ����� �̸�,�޿�,�ټӳ��(�Ҽ���X)�� �ټӳ���� ������������ �����Ͽ� ����Ͽ���
-- ��, �޿��� 50% �λ�� �޿��� ��µǵ��� �Ͽ���.
SELECT EMP_NAME AS �̸�, SALARY*0.5 AS �޿�, CEIL((SYSDATE-HIRE_DATE)/365) AS �ټӳ��
FROM EMPLOYEE
WHERE CEIL((SYSDATE-HIRE_DATE)/365) >= 10
--ORDER BY CEIL((SYSDATE-HIRE_DATE)/365) ASC;
ORDER BY 3 ASC;
    -- �ټӳ�� �Լ� ���� ��� �÷��� ��ġ(3��°)�� �ᵵ ����

-- ����4.
-- �Ի����� 99/01/01 ~ 10/01/01 �� ��� �߿��� �޿��� 2000000 �� ������ �����
-- �̸�,�ֹι�ȣ,�̸���,����ȣ,�޿��� �˻� �Ͻÿ�
SELECT EMP_NAME AS �̸�, EMP_NO AS �ֹι�ȣ, EMAIL AS �̸���, PHONE AS ��ȭ��ȣ, SALARY AS �޿�
FROM EMPLOYEE
-- ��¥ ���¿��� TO_DATE�� ����ȯ���� �� �ִ�.
WHERE (HIRE_DATE BETWEEN TO_DATE('99/01/01') AND TO_DATE('10/01/01'))
    AND SALARY <= 2000000;

DESC EMPLOYEE;

-- ����5.
-- �޿��� 2000000�� ~ 3000000�� �� ������ �߿��� 4�� �����ڸ� �˻��Ͽ� 
-- �̸�,�ֹι�ȣ,�޿�,�μ��ڵ带 �ֹι�ȣ ������(��������) ����Ͽ���
-- ��, �μ��ڵ尡 null�� ����� �μ��ڵ尡 '����' ���� ��� �Ͽ���.
SELECT EMP_NAME AS �̸�, EMP_NO AS �ֹι�ȣ, SALARY AS �޿�, DEPT_CODE AS �μ��ڵ�
FROM EMPLOYEE
WHERE SALARY BETWEEN 200000 AND 3000000 AND SUBSTR(EMP_NO, 8, 1) = '2'
        AND SUBSTR(EMP_NO, 3, 2) = '04'
ORDER BY DEPT_CODE DESC;
-- ���ǹ��ѹ�������ϴ� ���
--AND EMP_NO LIKE '__04__-2%'
--ORDER BY DEPT_CODE DESC;

-- NULL ��� '����'���� ����ϴ� ��� => NVL�Լ����
SELECT EMP_NAME AS �̸�, EMP_NO AS �ֹι�ȣ, SALARY AS �޿�, NVL(DEPT_CODE,'����') AS �μ��ڵ�
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000 AND SUBSTR(EMP_NO, 8, 1) = '2'
        AND SUBSTR(EMP_NO, 3, 2) = '04'
ORDER BY DEPT_CODE DESC;


-- ����6.
-- ���� ��� �� ���ʽ��� ���� ����� ���ñ��� �ٹ����� �����Ͽ� 
-- 1000�� ����(�Ҽ��� ����) 
-- �޿��� 10% ���ʽ��� ����Ͽ� �̸�,Ư�� ���ʽ� (��� �ݾ�) ����� ����Ͽ���.
-- ��, �̸� ������ ���� ���� �����Ͽ� ����Ͽ���.
SELECT EMP_NAME AS �̸�, FLOOR((SYSDATE-HIRE_DATE)/1000)*0.1*SALARY AS "Ư�� ���ʽ�"
FROM EMPLOYEE
    -- 1.SUBSR ���
--WHERE SUBSTR(EMP_NO, 8, 1) = 1 AND BONUS IS NULL
    -- 2. LIKE ���
WHERE EMP_NO LIKE '%-1%' AND BONUS IS NULL
ORDER BY EMP_NUM ASC;


