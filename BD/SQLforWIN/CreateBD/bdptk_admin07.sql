/*скрипт для создания базы данных*/
/*Здесь наполняем при необходимости таблицы*/

/*SET AUTODDL ON/OFF - авто подтверждение операторов*/
/*commit; - после каждой команды которая должна*/
/*выполниться, подтверждение операторов*/
/*последний commit; можно отменить с помощью rollback*/

/*таблица USERS*/

/*начальные значения для таблицы SEX*/
INSERT INTO SEX(ID,NAME) VALUES(1,'муж');
INSERT INTO SEX(ID,NAME) VALUES(2,'жен');

/*начальные значения для таблицы PR_RASPR_MNI*/
INSERT INTO PR_RASPR_MNI(ID,NAME) VALUES(1,'РАСПРЕДЕЛЕН');
INSERT INTO PR_RASPR_MNI(ID,NAME) VALUES(2,'НЕ РАСПРЕДЕЛЕН');

/*начальные значения для таблицы PR_RASPR_SB*/
INSERT INTO PR_RASPR_SB(ID,NAME) VALUES(1,'РАСПРЕДЕЛЕН');
INSERT INTO PR_RASPR_SB(ID,NAME) VALUES(2,'НЕ РАСПРЕДЕЛЕН');

/*начальные значения для таблицы TIP_EDUCATION*/
INSERT INTO TIP_EDUCATION(ID,NAME) VALUES(1,'высшее');
INSERT INTO TIP_EDUCATION(ID,NAME) VALUES(2,'высшее финансовое');
INSERT INTO TIP_EDUCATION(ID,NAME) VALUES(3,'среднее профессиональное');
INSERT INTO TIP_EDUCATION(ID,NAME) VALUES(4,'начальное – профессиональное');
INSERT INTO TIP_EDUCATION(ID,NAME) VALUES(5,'среднее общее');
INSERT INTO TIP_EDUCATION(ID,NAME) VALUES(6,'среднее специальное');

/*начальные значения для таблицы KEY_*/
INSERT INTO KEY_(ID,NAME) VALUES(1,'КЛЮЧЕВОЙ');
INSERT INTO KEY_(ID,NAME) VALUES(2,'НЕ КЛЮЧЕВОЙ');

/*начальные значения для таблицы районы*/
INSERT INTO RAIONS(ID,PREFIKS,NAME) VALUES(1,'34','СЕДЕЛЬНИКОВО');
INSERT INTO RAIONS(ID,PREFIKS,NAME) VALUES(2,'24','МУРОМЦЕВО');

/*начальные значения для таблицы пользователи программы*/
INSERT INTO USERS(ID,ID_RAION,NAME,RROLE) VALUES(1,1,'u03408001','ADMINISTRATOR');
INSERT INTO USERS(ID,ID_RAION,NAME,RROLE) VALUES(2,2,'u02408001','ADMINISTRATOR');

/*начальные значения для таблицы MNI_MODEL*/
/*INSERT INTO MNI_MODEL(ID,NAME) VALUES(1,'SAMSUNG');*/
/*INSERT INTO MNI_MODEL(ID,NAME) VALUES(2,'HITACHI');*/

/*начальные значения для таблицы MNI_TIP*/
/*INSERT INTO MNI_TIP(ID,NAME) VALUES(1,'НМЖД');*/
/*INSERT INTO MNI_TIP(ID,NAME) VALUES(2,'СНИ');*/

/*начальные значения для таблицы CONDITION_START_WORK*/
/*INSERT INTO COND_START_WORK(ID,NAME) VALUES(1,'безсрочный договор');*/
/*INSERT INTO COND_START_WORK(ID,NAME) VALUES(2,'срочный договор');*/

/*начальные значения для таблицы PEOPLES*/
/*INSERT INTO PEOPLES(ID,ID_USER,ID_RAION,ID_SEX, FAM, NAM, OTCH,DTB) VALUES(1,1,1,1,'Полагин', 'Дмитрий', 'Александрович', '1979-10-26');*/
/*INSERT INTO PEOPLES(ID,ID_USER,ID_RAION,ID_SEX, FAM, NAM, OTCH,DTB) VALUES(2,1,1,2,'Редькина', 'Светлана', 'Михайловна', '1976-01-18');*/
/*INSERT INTO PEOPLES(ID,ID_USER,ID_RAION,ID_SEX, FAM, NAM, OTCH,DTB) VALUES(3,2,2,1,'Батищев', 'Виктор', 'Николаевич', '1976-01-18');*/

/*начальные значения для таблицы GROUPS*/
/*INSERT INTO GROUPS(ID,NAME) VALUES(1,'ПРИ РУКОВОДСТВЕ');*/
/*INSERT INTO GROUPS(ID,NAME) VALUES(2,'НПВП И ОППЗЛ');*/
/*INSERT INTO GROUPS(ID,NAME) VALUES(3,'ПУ');*/

/*начальные значения для таблицы POSTS*/
/*INSERT INTO POSTS(ID,NAME) VALUES(1,'СТАРШИЙ СПЕЦИАЛИСТ (ПО АВТОМАТИЗАЦИИ)');*/
/*INSERT INTO POSTS(ID,NAME) VALUES(2,'РУКОВОДИТЕЛЬ ГРУППЫ');*/
/*INSERT INTO POSTS(ID,NAME) VALUES(3,'СПЕЦИАЛИСТ-ЭКСПЕРТ');*/

/*начальные значения для таблицы LOCATIONS*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(1,1,1,'СЕРВЕРНАЯ');*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(2,1,1,'МЕТОДКАБИНЕТ');*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(3,1,1,'ХОЛЛ');*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(4,1,1,'КАБИНЕТ №7');*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(5,2,2,'СЕРВЕРНАЯ в м');*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(6,2,2,'МЕТОДКАБИНЕТ в м');*/
/*INSERT INTO LOCATIONS(ID,ID_USER,ID_RAION,NAME) VALUES(7,2,2,'ХОЛЛ в м');*/

/*начальные значения для таблицы MOTIVE_DISCHARGE*/
/*INSERT INTO MOTIVE_DISCHARGE(ID,NAME) VALUES(1,'пьянка');*/
/*INSERT INTO MOTIVE_DISCHARGE(ID,NAME) VALUES(2,'прогулы');*/

/*начальные значения для таблицы MOTIVE_TMP_STOP_SW*/
/*INSERT INTO MOTIVE_TMP_STOP_SW(ID,NAME) VALUES(1,'больничный');*/
/*INSERT INTO MOTIVE_TMP_STOP_SW(ID,NAME) VALUES(2,'отпуск');*/
/*INSERT INTO MOTIVE_TMP_STOP_SW(ID,NAME) VALUES(3,'декретный');*/

/*начальные значения для таблицы MOTIVE_DELETE_MNI*/
/*INSERT INTO MOTIVE_DELETE_MNI(ID,NAME) VALUES(1,'неисправность');*/
/*INSERT INTO MOTIVE_DELETE_MNI(ID,NAME) VALUES(2,'передача');*/
/*INSERT INTO MOTIVE_DELETE_MNI(ID,NAME) VALUES(3,'декретный');*/

/*начальные значения для журнала START_WORK*/
/*INSERT INTO START_WORK(ID,ID_RAION,ID_USER,DT,TABNOM,ID_PEOPLE,ID_POST,ID_CONDITION,ID_LOCATION) VALUES(1,1,1,'2005-11-01','12',1,1,1,2);*/
/*INSERT INTO START_WORK(ID,ID_RAION,ID_USER,DT,TABNOM,ID_PEOPLE,ID_GROUP,ID_POST,ID_CONDITION,ID_LOCATION) VALUES(2,1,1,'2000-07-13','23',2,3,2,1,4);*/
/*INSERT INTO START_WORK(ID,ID_RAION,ID_USER,DT,TABNOM,ID_PEOPLE,ID_POST,ID_CONDITION,ID_LOCATION) VALUES(3,2,1,'2000-07-13','23',3,1,1,5);*/

/*создаем роли и назначаем им привелегии*/
execute procedure CreateRole;

