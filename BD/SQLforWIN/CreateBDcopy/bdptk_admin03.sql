/*скрипт для создания базы данных*/
/*Здесь создаются связи и ограничения к ним FOREIGN KEY*/

/*SET AUTODDL ON/OFF - авто подтверждение операторов*/
/*commit; - после каждой команды которая должна*/
/*выполниться, подтверждение операторов*/
/*последний commit; можно отменить с помощью rollback*/

/*Создаем связь таблицы USERS(поле ID_GROUP) с таблицей USERS_GROUP (поле ID)*/
ALTER TABLE USERS
ADD CONSTRAINT FK_USERS_GROUP FOREIGN KEY(ID_GROUP) REFERENCES USERS_GROUP(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*Создаем связь таблицы USERS(поле ID_DOLJN) с таблицей USERS_DOLJN (поле ID)*/
ADD CONSTRAINT FK_USERS_DOLJN FOREIGN KEY(ID_DOLJN) REFERENCES USERS_DOLJN(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*Создаем связь таблицы USERS(поле ID_PLACE) с таблицей PLACE (поле ID)*/
ADD CONSTRAINT FK_USERS_PLACE FOREIGN KEY(ID_PLACE) REFERENCES PLACE(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

/*Создаем связь таблицы SB(поле ID_COLOR) с таблицей COLOR (поле ID)*/
ALTER TABLE SB
ADD CONSTRAINT FK_SB_COLOR FOREIGN KEY(ID_COLOR) REFERENCES COLOR(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*Создаем связь таблицы SB(поле ID_MODEL) с таблицей SB_MODEL (поле ID)*/
ADD CONSTRAINT FK_SB_MODEL FOREIGN KEY(ID_MODEL) REFERENCES SB_MODEL(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*Создаем связь таблицы SB(поле ID_PROC) с таблицей PROC_TYP (поле ID)*/
ADD CONSTRAINT FK_SB_PROC FOREIGN KEY(ID_PROC) REFERENCES PROC_TYP(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*Создаем связь таблицы SB(поле ID_MEMORY) с таблицей MEMORY_TIP (поле ID)*/
ADD CONSTRAINT FK_SB_MEMORY FOREIGN KEY(ID_MEMORY) REFERENCES MEMORY_TIP(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*Создаем связь таблицы SB(поле ID_USER) с таблицей USERS (поле ID)*/
ADD CONSTRAINT FK_SB_USER FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

/*Создаем связь таблицы MNI(поле ID_MODEL) с таблицей MNI_MODEL (поле ID)*/
ALTER TABLE MNI
ADD CONSTRAINT FK_MNI_MODEL FOREIGN KEY(ID_MODEL) REFERENCES MNI_MODEL(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*Создаем связь таблицы MNI(поле ID_TIP) с таблицей MNI_TIP (поле ID)*/
ADD CONSTRAINT FK_MNI_TIP FOREIGN KEY(ID_TIP) REFERENCES MNI_TIP(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*Создаем связь таблицы MNI(поле ID_USER) с таблицей USERS (поле ID)*/
ADD CONSTRAINT FK_MNI_USER FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*Создаем связь таблицы MNI(поле ID_SB) с таблицей SB (поле ID)*/
ADD CONSTRAINT FK_MNI_SB FOREIGN KEY(ID_SB) REFERENCES SB(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

/*Создаем связь таблицы RAZNOE(поле ID_MODEL) с таблицей RAZNOE_MODEL (поле ID)*/
ALTER TABLE RAZNOE
ADD CONSTRAINT FK_RAZNOE_MODEL FOREIGN KEY(ID_MODEL) REFERENCES RAZNOE_MODEL(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*Создаем связь таблицы RAZNOE(поле ID_NAME) с таблицей RAZNOE_NAME (поле ID)*/
ADD CONSTRAINT FK_RAZNOE_NAME FOREIGN KEY(ID_NAME) REFERENCES RAZNOE_NAME(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*Создаем связь таблицы RAZNOE(поле ID_USER) с таблицей USER (поле ID)*/
ADD CONSTRAINT FK_RAZNOE_USER FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE NO ACTION ON UPDATE CASCADE;

/*Создаем связь таблицы KARTRIDJS(поле ID_KARTRIDJ) с таблицей KARTRIDJ_NAME (поле ID)*/
ALTER TABLE KARTRIDJS
ADD CONSTRAINT FK_KARTRIDJS_NAME FOREIGN KEY(ID_KARTRIDJ) REFERENCES KARTRIDJ_NAME(ID)
ON DELETE NO ACTION ON UPDATE CASCADE,
/*Создаем связь таблицы KARTRIDJS(поле ID_USER) с таблицей USERS (поле ID)*/
ADD CONSTRAINT FK_KARTRIDJS_USER FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE SET NULL ON UPDATE CASCADE;

/*Создаем связь таблицы USERS_MOVE_PL с таблицей USERS И PLACE (поле ID)*/
ALTER TABLE USERS_MOVE_PL
ADD CONSTRAINT FK_USERS_MOVE_PL_USER FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_USERS_MOVE_PL_PLACE FOREIGN KEY(ID_PLACE) REFERENCES PLACE(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

/*Создаем связь таблицы USERS_MOVE_GR с таблицей USERS И GROUP (поле ID)*/
ALTER TABLE USERS_MOVE_GR
ADD CONSTRAINT FK_USERS_MOVE_GR_GROUP FOREIGN KEY(ID_GROUP) REFERENCES USERS_GROUP(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_USERS_MOVE_GR_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

/*Создаем связь таблицы USERS_MOVE_DLJN с таблицей USERS И DOLJN (поле ID)*/
ALTER TABLE USERS_MOVE_DLJN
ADD CONSTRAINT FK_USERS_MOVE_DLJN_DOLJN FOREIGN KEY(ID_DOLJN) REFERENCES USERS_DOLJN(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_USERS_MOVE_DLJN_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

/*Создаем связь таблицы SB_MOVE_PL с таблицей SB И PLACE (поле ID)*/
ALTER TABLE SB_MOVE_PL
ADD CONSTRAINT FK_SB_MOVE_PL_PLACE FOREIGN KEY(ID_PLACE) REFERENCES PLACE(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_SB_MOVE_PL_SB FOREIGN KEY(ID_SB) REFERENCES SB(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

/*Создаем связь таблицы SB_MOVE с таблицей SB И PLACE (поле ID)*/
ALTER TABLE SB_MOVE
ADD CONSTRAINT FK_SB_MOVE_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_SB_MOVE_SB FOREIGN KEY(ID_SB) REFERENCES SB(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

/*Создаем связь таблицы MNI_MOVE с таблицей MNI И USERS (поле ID)*/
ALTER TABLE MNI_MOVE
ADD CONSTRAINT FK_MNI_MOVE_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_MNI_MOVE_MNI FOREIGN KEY(ID_MNI) REFERENCES MNI(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

/*Создаем связь таблицы MNI_MOVE с таблицей MNI И USERS (поле ID)*/
ALTER TABLE MNI_MOVE_SB
ADD CONSTRAINT FK_MNI_MOVE_SB_SB FOREIGN KEY(ID_SB) REFERENCES SB(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_MNI_MOVE_SB_MNI FOREIGN KEY(ID_MNI) REFERENCES MNI(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

/*Создаем связь таблицы RAZNOE_MOVE с таблицей RAZNOE И USERS (поле ID)*/
ALTER TABLE RAZNOE_MOVE
ADD CONSTRAINT FK_RAZNOE_MOVE_USERS FOREIGN KEY(ID_USER) REFERENCES USERS(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_RAZNOE_MOVE_RAZNOE FOREIGN KEY(ID_RAZNOE) REFERENCES RAZNOE(ID)
ON DELETE CASCADE ON UPDATE CASCADE;

/*Создаем связь таблицы RAZNOE_MOVE_PL с таблицей RAZNOE И PLACE (поле ID)*/
ALTER TABLE RAZNOE_MOVE_PL
ADD CONSTRAINT FK_RAZNOE_MOVE_PL_RAZNOE FOREIGN KEY(ID_RAZNOE) REFERENCES RAZNOE(ID)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT FK_RAZNOE_MOVE_PL_PLACE FOREIGN KEY(ID_PLACE) REFERENCES PLACE(ID)
ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

