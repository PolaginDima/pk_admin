/*скрипт для создания базы данных*/
/*Здесь создается база, создаются домены,*/
/*создаются генераторы и исключения*/
/*SET AUTODDL ON/OFF - авто подтверждение операторов*/
/*commit; - после каждой команды которая должна*/
/*выполниться, подтверждение операторов*/
/*последний commit; можно отменить с помощью rollback*/

/*создаем базу данных ptk_admin.fdb*/
SET SQL DIALECT 3;
CREATE DATABASE  "D:\MY_PROGRAMS\Project\PTK_ADMIN\BD\ptk_admin.fdb" USER "POLAGIN" PASSWORD "POLAGIN" PAGE_SIZE=8192 DEFAULT CHARACTER SET UTF8;
COMMIT;

/*подсоединяемся к базе*/
CONNECT "D:\MY_PROGRAMS\Project\PTK_ADMIN\BD\ptk_admin.fdb" USER "POLAGIN" PASSWORD "POLAGIN";
COMMIT;

/*Создаем домены*/
/*Создадим домен для ввода фамилий*/
CREATE DOMAIN FIO AS VARCHAR(30) CHARACTER SET WIN1251  DEFAULT 'HET' CHECK(CHAR_LENGTH(TRIM(TRAILING FROM VALUE))>1);
COMMIT;

/*Создадим домен для ввода даты рождения и смерти*/
/*CREATE DOMAIN DTB AS DATE DEFAULT CURRENT_DATE;*/
/*COMMIT;*/

/*Создадим домен для дополнительной таблицы для полей ID_FROM, ID_TO*/
/*CREATE DOMAIN ID_SVIAZI AS INTEGER CHECK(VALUE > 0);*/
/*COMMIT;*/

/*Создадим домен для для ввода пола (w/m)*/
CREATE DOMAIN SEX_USER AS CHAR(1) default 'm' CHECK(VALUE IN('w','m'));
COMMIT;

/*Создадим домен для логических значений (0/1)*/
CREATE DOMAIN TRUE_FALSE AS SMALLINT default '0' CHECK(VALUE IN(0,1));
COMMIT;

/*Создаем и настраиваем генераторы*/
/*создаем генератор для таблицы SB и USERS для поля ID*/
/*CREATE GENERATOR GEN_USERS_SB_ID;*/
/*COMMIT;*/
/*Установим начальное значение генератора*/
/*SET GENERATOR GEN_USERS_SB_ID TO 60;*/

/*создаем генератор для таблиц SB_MODEL, SB_MOVE, SB_MOVE_PL  для поля ID*/
/*CREATE GENERATOR GEN_SB_ALL_ID;*/
/*COMMIT;*/
/*Установим начальное значение генератора*/
/*SET GENERATOR GEN_SB_ALL_ID TO 0;*/

/*создаем генератор для таблиц SB_STIKER  для поля ID*/
/*CREATE GENERATOR GEN_SB_STIKER_ID;*/
/*COMMIT;*/
/*Установим начальное значение генератора*/
/*SET GENERATOR GEN_SB_STIKER_ID TO 0;*/


/*создаем генератор для таблицы MNI для поля ID*/
/*CREATE GENERATOR GEN_MNI_ID;*/
/*COMMIT;*/
/*Установим начальное значение генератора*/
/*SET GENERATOR GEN_MNI_ID TO 250;*/

/*создаем генератор для таблиц(справочников) USERS, USERS_DOLJN, USERS_GROUP и др. для поля ID*/
CREATE GENERATOR GEN_SLOVAR_ID;
COMMIT;
/*Установим начальное значение генератора*/
SET GENERATOR GEN_SLOVAR_ID TO 0;
COMMIT;

/*создаем генератор для таблиц USERS_MOVE_PL, USERS_MOVE_GR, USERS_MOVE_DLJ для поля ID*/
/*CREATE GENERATOR GEN_USER_MOVE_ID;*/
/*COMMIT;*/
/*Установим начальное значение генератора*/
/*SET GENERATOR GEN_USER_MOVE_ID TO 0;*/
/*COMMIT;*/

/*создаем генератор для таблиц SB_MOVE_PL, SB_MOVE для поля ID*/
/*CREATE GENERATOR GEN_SB_MOVE_ID;*/
/*COMMIT;*/
/*Установим начальное значение генератора*/
/*SET GENERATOR GEN_SB_MOVE_ID TO 0;*/
/*COMMIT;*/

/*создаем генератор для таблиц MNI_MOVE_SB, MNI_MOVE для поля ID*/
/*CREATE GENERATOR GEN_MNI_MOVE_ID;*/
/*COMMIT;*/
/*Установим начальное значение генератора*/
/*SET GENERATOR GEN_MNI_MOVE_ID TO 0;*/
/*COMMIT;*/

/*создаем генератор для таблиц RAZNOE_MOVE_PL, RAZNOE_MOVE для поля ID*/
/*CREATE GENERATOR GEN_RAZNOE_MOVE_ID;*/
/*COMMIT;*/
/*Установим начальное значение генератора*/
/*SET GENERATOR GEN_RAZNOE_MOVE_ID TO 0;*/

/*создаем генератор для таблицы RAZNOE для поля ID*/
/*CREATE GENERATOR GEN_RAZNOE_ID;*/
/*COMMIT;*/
/*Установим начальное значение генератора*/
/*SET GENERATOR GEN_RAZNOE_ID TO 250;*/
/*COMMIT;*/
/*Создаем исключения*/
/*создаем исключение для случая "зацикливания" дерева*/
/*CREATE EXCEPTION TREE_E_INCORRECT_OPERATION 'ЗАЦИКЛИВАНИЕ';*/
/*COMMIT;*/


