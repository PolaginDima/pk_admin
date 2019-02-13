/*������ ��� �������� ���� ������*/
/*����� ��������� ��� ������������� �������*/

/*SET AUTODDL ON/OFF - ���� ������������� ����������*/
/*commit; - ����� ������ ������� ������� ������*/
/*�����������, ������������� ����������*/
/*��������� commit; ����� �������� � ������� rollback*/

/*������� USERS*/

/*��������� �������� ��� ������� SEX*/
INSERT INTO SEX(ID,NAME) VALUES(1,'���');
INSERT INTO SEX(ID,NAME) VALUES(2,'���');

/*��������� �������� ��� ������� PR_RASPR_MNI*/
INSERT INTO PR_RASPR_MNI(ID,NAME) VALUES(1,'�����������');
INSERT INTO PR_RASPR_MNI(ID,NAME) VALUES(2,'�� �����������');

/*��������� �������� ��� ������� PR_RASPR_SB*/
INSERT INTO PR_RASPR_SB(ID,NAME) VALUES(1,'�����������');
INSERT INTO PR_RASPR_SB(ID,NAME) VALUES(2,'�� �����������');

/*��������� �������� ��� ������� TIP_EDUCATION*/
INSERT INTO TIP_EDUCATION(ID,NAME) VALUES(1,'������');
INSERT INTO TIP_EDUCATION(ID,NAME) VALUES(2,'������ ����������');
INSERT INTO TIP_EDUCATION(ID,NAME) VALUES(3,'������� ����������������');
INSERT INTO TIP_EDUCATION(ID,NAME) VALUES(4,'��������� � ����������������');
INSERT INTO TIP_EDUCATION(ID,NAME) VALUES(5,'������� �����');
INSERT INTO TIP_EDUCATION(ID,NAME) VALUES(6,'������� �����������');

/*��������� �������� ��� ������� KEY_*/
INSERT INTO KEY_(ID,NAME) VALUES(1,'��������');
INSERT INTO KEY_(ID,NAME) VALUES(2,'�� ��������');

/*��������� �������� ��� ������� ������*/
INSERT INTO RAIONS(ID,PREFIKS,NAME) VALUES(1,'34','������������');
INSERT INTO RAIONS(ID,PREFIKS,NAME) VALUES(2,'24','���������');

/*��������� �������� ��� ������� ������������ ���������*/
INSERT INTO USERS(ID,ID_RAION,NAME,RROLE) VALUES(1,1,'u03408001','ADMINISTRATOR');
INSERT INTO USERS(ID,ID_RAION,NAME,RROLE) VALUES(2,2,'u02408001','ADMINISTRATOR');

/*��������� �������� ��� ������� MNI_MODEL*/
/*INSERT INTO MNI_MODEL(ID,NAME) VALUES(1,'SAMSUNG');*/
/*INSERT INTO MNI_MODEL(ID,NAME) VALUES(2,'HITACHI');*/

/*��������� �������� ��� ������� MNI_TIP*/
/*INSERT INTO MNI_TIP(ID,NAME) VALUES(1,'����');*/
/*INSERT INTO MNI_TIP(ID,NAME) VALUES(2,'���');*/

/*��������� �������� ��� ������� CONDITION_START_WORK*/
/*INSERT INTO COND_START_WORK(ID,NAME) VALUES(1,'���������� �������');*/
/*INSERT INTO COND_START_WORK(ID,NAME) VALUES(2,'������� �������');*/

/*��������� �������� ��� ������� PEOPLES*/
/*INSERT INTO PEOPLES(ID,ID_USER,ID_RAION,ID_SEX, FAM, NAM, OTCH,DTB) VALUES(1,1,1,1,'�������', '�������', '�������������', '1979-10-26');*/
/*INSERT INTO PEOPLES(ID,ID_USER,ID_RAION,ID_SEX, FAM, NAM, OTCH,DTB) VALUES(2,1,1,2,'��������', '��������', '����������', '1976-01-18');*/
/*INSERT INTO PEOPLES(ID,ID_USER,ID_RAION,ID_SEX, FAM, NAM, OTCH,DTB) VALUES(3,2,2,1,'�������', '������', '����������', '1976-01-18');*/

/*��������� �������� ��� ������� GROUPS*/
/*INSERT INTO GROUPS(ID,NAME) VALUES(1,'��� �����������');*/
/*INSERT INTO GROUPS(ID,NAME) VALUES(2,'���� � �����');*/
/*INSERT INTO GROUPS(ID,NAME) VALUES(3,'��');*/

/*��������� �������� ��� ������� POSTS*/
/*INSERT INTO POSTS(ID,NAME) VALUES(1,'������� ���������� (�� �������������)');*/
/*INSERT INTO POSTS(ID,NAME) VALUES(2,'������������ ������');*/
/*INSERT INTO POSTS(ID,NAME) VALUES(3,'����������-�������');*/

/*��������� �������� ��� ������� LOCATIONS*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(1,1,1,'���������');*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(2,1,1,'������������');*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(3,1,1,'����');*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(4,1,1,'������� �7');*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(5,2,2,'��������� � �');*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(6,2,2,'������������ � �');*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(7,2,2,'���� � �');*/

/*��������� �������� ��� ������� MOTIVE_DISCHARGE*/
/*INSERT INTO MOTIVE_DISCHARGE(ID,NAME) VALUES(1,'������');*/
/*INSERT INTO MOTIVE_DISCHARGE(ID,NAME) VALUES(2,'�������');*/

/*��������� �������� ��� ������� MOTIVE_TMP_STOP_SW*/
/*INSERT INTO MOTIVE_TMP_STOP_SW(ID,NAME) VALUES(1,'����������');*/
/*INSERT INTO MOTIVE_TMP_STOP_SW(ID,NAME) VALUES(2,'������');*/
/*INSERT INTO MOTIVE_TMP_STOP_SW(ID,NAME) VALUES(3,'���������');*/

/*��������� �������� ��� ������� MOTIVE_DELETE_MNI*/
/*INSERT INTO MOTIVE_DELETE_MNI(ID,NAME) VALUES(1,'�������������');*/
/*INSERT INTO MOTIVE_DELETE_MNI(ID,NAME) VALUES(2,'��������');*/
/*INSERT INTO MOTIVE_DELETE_MNI(ID,NAME) VALUES(3,'���������');*/

/*��������� �������� ��� ������� START_WORK*/
/*INSERT INTO START_WORK(ID,ID_RAION,ID_USER,DT,TABNOM,ID_PEOPLE,ID_POST,ID_CONDITION,ID_LOCATION) VALUES(1,1,1,'2005-11-01','12',1,1,1,2);*/
/*INSERT INTO START_WORK(ID,ID_RAION,ID_USER,DT,TABNOM,ID_PEOPLE,ID_GROUP,ID_POST,ID_CONDITION,ID_LOCATION) VALUES(2,1,1,'2000-07-13','23',2,3,2,1,4);*/
/*INSERT INTO START_WORK(ID,ID_RAION,ID_USER,DT,TABNOM,ID_PEOPLE,ID_POST,ID_CONDITION,ID_LOCATION) VALUES(3,2,1,'2000-07-13','23',3,1,1,5);*/

/*������� ���� � ��������� �� ����������*/
execute procedure CreateRole;

