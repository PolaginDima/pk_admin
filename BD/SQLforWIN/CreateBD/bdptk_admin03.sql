/*скрипт для создания базы данных*/
/*Здесь создаются связи и ограничения к ним FOREIGN KEY*/

/*SET AUTODDL ON/OFF - авто подтверждение операторов*/
/*commit; - после каждой команды которая должна*/
/*выполниться, подтверждение операторов*/
/*последний commit; можно отменить с помощью rollback*/

/*Словари*/
/*Создаем связь таблицы PEOPLES(поле ID_SEX) с таблицей SEX (поле ID)*/
ALTER TABLE PEOPLES
ADD CONSTRAINT FK_PEOPLES_SEX FOREIGN KEY(ID_SEX) REFERENCES SEX(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_PEOPLES_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_PEOPLES_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_PEOPLES_tip_education FOREIGN KEY(ID_tip_education) REFERENCES tip_education(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

/*Создаем связь таблицы WORKS(поле ID_PEOPLES) с таблицей PEOPLES (поле ID)*/
ALTER TABLE WORKS
ADD CONSTRAINT FK_WORKS_PEOPLES FOREIGN KEY(ID_PEOPLES) REFERENCES PEOPLES(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

/*Создаем связь таблицы USERS(поле ID_RAIONS) с таблицей RAIONS (поле ID)*/
ALTER TABLE USERS
ADD CONSTRAINT FK_USERS_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

/*Создаем связи таблиц словарей (поле ID_RAIONS и ID_USER) с таблицей RAIONS и USERS (поле ID)*/
ALTER TABLE LOCATIONS
ADD CONSTRAINT FK_LOCATIONS_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_LOCATIONS_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE CHILDRENS
ADD CONSTRAINT FK_CHILDRENS_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_CHILDRENS_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_CHILDRENS_PEOPLES FOREIGN KEY(ID_PEOPLE) REFERENCES PEOPLES(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

/*ALTER TABLE POSTS
ADD CONSTRAINT FK_POSTS_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_POSTS_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;*/

/*ALTER TABLE WORKS
ADD CONSTRAINT FK_WORKS_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_WORKS_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;*/

/*ALTER TABLE PROFESSIONS
ADD CONSTRAINT FK_PROFESSIONS_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_PROFESSIONS_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;*/

/*ALTER TABLE MOTIVE_DISCHARGE
ADD CONSTRAINT FK_MOTIVE_DISCHARGE_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_MOTIVE_DISCHARGE_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;*/

/*ALTER TABLE COND_START_WORK
ADD CONSTRAINT FK_COND_START_WORK_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_COND_START_WORK_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;*/

/*Журналы*/
ALTER TABLE START_WORK
ADD CONSTRAINT FK_START_WORK_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_START_WORK_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_START_WORK_PEOPLES FOREIGN KEY(ID_PEOPLE) REFERENCES PEOPLES(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_START_WORK_CONDITION FOREIGN KEY(ID_CONDITION) REFERENCES COND_START_WORK(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_START_WORK_GROUPS FOREIGN KEY(ID_GROUP) REFERENCES GROUPS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_START_WORK_DOP FOREIGN KEY(ID_DOP) REFERENCES DOP(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_START_WORK_POSTS FOREIGN KEY(ID_POST) REFERENCES POSTS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE DISCHARGE
ADD CONSTRAINT FK_DISCHARGE_START_WORK FOREIGN KEY(ID_START_WORK) REFERENCES START_WORK(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_DISCHARGE_MOTIVE_DISCHARGE FOREIGN KEY(ID_MOTIVE_DISCHARGE) REFERENCES MOTIVE_DISCHARGE(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE TMP_STOP_SW
ADD CONSTRAINT FK_T_S_SW_SW FOREIGN KEY(ID_START_WORK) REFERENCES START_WORK(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_T_S_SW_MOTIVE_T_S_SW FOREIGN KEY(ID_MOTIVE_TMP_STOP_SW) REFERENCES MOTIVE_TMP_STOP_SW(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE SERTIFIKATS
ADD CONSTRAINT FK_SERT_DOP FOREIGN KEY(ID_DOP) REFERENCES DOP(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_SERT_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_SERT_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_SERT_START_WORK FOREIGN KEY(ID_START_WORK) REFERENCES START_WORK(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE MNI
ADD CONSTRAINT FK_MNI_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_MNI_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_MNI_START_WORK FOREIGN KEY(ID_START_WORK) REFERENCES START_WORK(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_MNI_MODEL FOREIGN KEY(ID_MODEL) REFERENCES MNI_MODEL(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_MNI_TIP FOREIGN KEY(ID_TIP) REFERENCES MNI_TIP(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*ADD CONSTRAINT FK_MNI_SB FOREIGN KEY(ID_SB) REFERENCES SB(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,*/
ADD CONSTRAINT FK_MNI_KEY_ FOREIGN KEY(ID_KEY) REFERENCES KEY_(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_MNI_PR_RASPR_MNI FOREIGN KEY(ID_PR_RASPR) REFERENCES PR_RASPR_MNI(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_MNI_DOP FOREIGN KEY(ID_DOP) REFERENCES DOP(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE DELETE_MNI
ADD CONSTRAINT FK_DELETE_MNI_MNI FOREIGN KEY(ID_MNI) REFERENCES MNI(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_DELETE_MNI_MOTIVE FOREIGN KEY(ID_MOTIVE_DELETE_MNI) REFERENCES MOTIVE_DELETE_MNI(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;



ALTER TABLE COPY_KRIPTO
ADD CONSTRAINT FK_COPY_KRIPTO_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_COPY_KRIPTO_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_COPY_KRIPTO_KRIPTO FOREIGN KEY(ID_KRIPTO) REFERENCES KRIPTO(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*ADD CONSTRAINT FK_COPY_KRIPTO_SERT FOREIGN KEY(ID_SERT) REFERENCES SERTIFIKATS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,*/
/*ADD CONSTRAINT FK_COPY_KRIPTO_SB FOREIGN KEY(ID_SB) REFERENCES SB(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,*/
ADD CONSTRAINT FK_COPY_KRIPTO_MNI FOREIGN KEY(ID_MNI) REFERENCES MNI(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_COPY_KRIPTO_SW FOREIGN KEY(ID_START_WORK) REFERENCES START_WORK(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_COPY_KRIPTO_DOP FOREIGN KEY(ID_DOP) REFERENCES DOP(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_COPY_KRIPTO_LOCATIONS FOREIGN KEY(ID_LOCATION) REFERENCES LOCATIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE DELETE_KRIPTO
ADD CONSTRAINT FK_DELETE_KRIPTO_MNI FOREIGN KEY(ID_KRIPTO) REFERENCES COPY_KRIPTO(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_DELETE_KRIPTO_MOTIVE FOREIGN KEY(ID_MOTIVE_DEL_KR) REFERENCES MOTIVE_DEL_KRIPTO(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE SB
ADD CONSTRAINT FK_SB_DOP FOREIGN KEY(ID_DOP) REFERENCES DOP(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_SB_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_SB_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_SB_TIP_PROC FOREIGN KEY(ID_TIP_PROC) REFERENCES TIP_PROC(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_SB_TIP_MEMORY FOREIGN KEY(ID_TIP_MEMORY) REFERENCES TIP_MEMORY(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_SB_NAME_SB FOREIGN KEY(ID_NAME_SB) REFERENCES NAME_SB(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_SB_START_WORK FOREIGN KEY(ID_START_WORK) REFERENCES START_WORK(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_SB_PR_RASPR FOREIGN KEY(ID_PR_RASPR) REFERENCES PR_RASPR_SB(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_SB_NAME_OS FOREIGN KEY(ID_NAME_OS ) REFERENCES NAME_OS (ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_SB_LICENSE_OS FOREIGN KEY(ID_LICENSE_OS ) REFERENCES TIP_LICENSE_OS (ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_SB_WORK_SB FOREIGN KEY(ID_WORK_SB ) REFERENCES TIP_WORK_SB (ID)
ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*Промежуточные таблицы*/
ALTER TABLE SVIAZ_COPY_KRIPTO_DOCS
ADD CONSTRAINT FK_SVIAZ_KRIPTO_DOCS_KRIPTO FOREIGN KEY(ID_COPY_KRIPTO) REFERENCES COPY_KRIPTO(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_SVIAZ_KRIPTO_DOCS_DOCS FOREIGN KEY(ID_DOCS) REFERENCES DOCS(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

/*Промежуточные таблицы*/
ALTER TABLE SVIAZ_SW_DOCS
ADD CONSTRAINT FK_SVIAZ_SW_DOCS_SW FOREIGN KEY(ID_START_WORK) REFERENCES START_WORK(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_SVIAZ_SW_DOCS_DOCS FOREIGN KEY(ID_DOCS) REFERENCES DOCS(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE SVIAZ_MNI_DOCS
ADD CONSTRAINT FK_SV_MNI_DOCS_MNI_DOCS FOREIGN KEY(ID_MNI) REFERENCES MNI(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_SV_MNI_DOCS_DOCS FOREIGN KEY(ID_DOCS) REFERENCES DOCS(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE SVIAZ_SERT_DOCS
ADD CONSTRAINT FK_SV_SERT_DOCS_SERT FOREIGN KEY(ID_SERT) REFERENCES SERTIFIKATS(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_SV_SERT_DOCS_DOCS FOREIGN KEY(ID_DOCS) REFERENCES DOCS(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE SVIAZ_COPY_KRIPTO_DOCS
ADD CONSTRAINT FK_SV_CK_CK FOREIGN KEY(ID_COPY_KRIPTO) REFERENCES COPY_KRIPTO(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_SV_CK_DOCS FOREIGN KEY(ID_DOCS) REFERENCES DOCS(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

/*Журналы движения*/
ALTER TABLE MOVE_EMPL
ADD CONSTRAINT FK_MOVE_EMPL_GR FOREIGN KEY(ID_GROUP) REFERENCES GROUPS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_MOVE_EMPL_POST FOREIGN KEY(ID_POST) REFERENCES POSTS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_MOVE_EMPL_LOC FOREIGN KEY(ID_LOCATION) REFERENCES LOCATIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_MOVE_EMPL_SW FOREIGN KEY(ID_START_WORK) REFERENCES START_WORK(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE MOVE_MNI
ADD CONSTRAINT FK_MOVE_MNI_PR_RASPR FOREIGN KEY(ID_PR_RASPR) REFERENCES PR_RASPR_MNI(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_MOVE_MNI_KEY FOREIGN KEY(ID_KEY) REFERENCES KEY_(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_MOVE_MNI_SW FOREIGN KEY(ID_START_WORK) REFERENCES START_WORK(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_MOVE_MNI_MNI FOREIGN KEY(ID_MNI) REFERENCES MNI(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

ALTER TABLE RAZNOE
ADD CONSTRAINT FK_RAZNOE_DOP FOREIGN KEY(ID_DOP) REFERENCES DOP(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_RAZNOE_RAIONS FOREIGN KEY(ID_RAION) REFERENCES RAIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_RAZNOE_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_RAZNOE_START_WORK FOREIGN KEY(ID_START_WORK) REFERENCES START_WORK(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_RAZNOE_MODEL FOREIGN KEY(ID_MODEL) REFERENCES RAZNOE_MODEL(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_RAZNOE_TIP FOREIGN KEY(ID_TIP) REFERENCES RAZNOE_TIP(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_RAZNOE_SB FOREIGN KEY(ID_SB) REFERENCES SB(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_RAZNOE_PR_RASPR FOREIGN KEY(ID_PR_RASPR) REFERENCES PR_RASPR_RAZNOE(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT FK_RAZNOE_LOCATION FOREIGN KEY(ID_LOCATION) REFERENCES LOCATIONS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT;
