-- [�ý��۰���_����]
-- ����� ���� ����, ���� �ο� �� ����
-- (NOTE) "--"�� �ּ��� ���� �ǹ��̴�. (�ּ��� �Ϸĺ��� �ڵ� ���� �Ʒ��� ���´�)
--        ������ : ��� �����ư Ŭ��(Ctrl + Enter)
--        SQL���� String(���ڿ�)-> VALCHAR, int(����)-> NUMBER
--        �����ݷ�(;)�� �������� �ڵ� ����ȴ�

CREATE USER STUDENT IDENTIFIED BY sTUDENT; 
-- ��������(USER:STUDENT) �� ��й�ȣ ����(IDENTIFIED BY:sTUDENT)
-- ��й�ȣ�� '��ҹ��ڸ� �����Ѵ�' -> ��й�ȣ ����.

-- �׽�Ʈ ����: ���� ->(���ٱ����� ���)
-- ORA-01045: user STUDENT lacks CREATE SESSION privilege; logon denied
-- GRANT ~ TO ���̺�� : ���ٱ��� ���
GRANT CONNECT TO STUDENT;
-- Grant��(��) �����߽��ϴ�.
GRANT RESOURCE TO STUDENT;
-- Grant��(��) �����߽��ϴ�.

CREATE TABLE STUDENT_TBL(
    STUDENT_NAME VARCHAR(20),
    -- �ѱ��� ��� ���� �ϳ��� 3����Ʈ, ���ĺ��� ��� 1����Ʈ.
    STUDENT_AGE NUMBER,
    STUDENT_GRANDE NUMBER,
    STUDENT_ADDRESS VARCHAR(100)
);


-- ���Ӱ��� ���θ����
-- KH������ ����� �� ��й�ȣ�� KH�� ���ּ���
CREATE USER KH IDENTIFIED BY KH;

-- ������ �����ϰ� ���̺��� ������ �� �ֵ��� ���ּ���.
GRANT CONNECT, RESOURCE TO KH;

-- ���� �̸��� ����� �����غ�����.
-- > ����(+) > �����̸�:KH����, ������̸�:KH, ��й�ȣ:KH

