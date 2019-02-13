/*скрипт для создания базы данных*/
/*Здесь создается база, создаются домены,*/
/*создаются генераторы и исключения*/
/*SET AUTODDL ON/OFF - авто подтверждение операторов*/
/*commit; - после каждой команды которая должна*/
/*выполниться, подтверждение операторов*/
/*последний commit; можно отменить с помощью rollback*/

/*создаем базу данных ptk_admin.fdb*/
SET SQL DIALECT 3;
CREATE DATABASE  "/mnt/work1/MY_CODING/LAZARUS/WORK/EDIT/Project/PTK_ADMIN/BD/ptk_admin.fdb" USER "POLAGIN" PASSWORD "POLAGIN" PAGE_SIZE=8192 DEFAULT CHARACTER SET UTF8;
COMMIT;

/*подсоединяемся к базе*/
CONNECT "/mnt/work1/MY_CODING/LAZARUS/WORK/EDIT/Project/PTK_ADMIN/BD/ptk_admin.fdb" USER "POLAGIN" PASSWORD "POLAGIN";
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

/*создаем генератор для таблиц(справочников) USERS, USERS_DOLJN, USERS_GROUP и др. для поля ID*/
CREATE GENERATOR GEN_SLOVAR_ID;
COMMIT;
/*Установим начальное значение генератора*/
SET GENERATOR GEN_SLOVAR_ID TO 0;
COMMIT;

/*создаем генератор для таблицы USERS для поля ID*/
CREATE GENERATOR GEN_USERS_ID;
COMMIT;
/*Установим начальное значение генератора*/
SET GENERATOR GEN_USERS_ID TO 0;
COMMIT;

/*создаем генератор для таблицы ЖУРНАЛ ПРИНЯТЫХ СОТРУДНИКОВ для поля ID*/
CREATE GENERATOR GEN_START_WORK_ID;
COMMIT;
/*Установим начальное значение генератора*/
SET GENERATOR GEN_START_WORK_ID TO 0;
COMMIT;

/*создаем генератор для таблицы ЖУРНАЛ МНИ для поля ID*/
CREATE GENERATOR GEN_MNI_ID;
COMMIT;
/*Установим начальное значение генератора*/
SET GENERATOR GEN_MNI_ID TO 0;
COMMIT;

/*создаем генератор для таблицы ЖУРНАЛ УВОЛЕННЫХ СОТРУДНИКОВ для поля ID*/
CREATE GENERATOR GEN_DISCH_ID;
COMMIT;
/*Установим начальное значение генератора*/
SET GENERATOR GEN_DISCH_ID TO 0;
COMMIT;

/*создаем генератор для таблицы ЖУРНАЛ СПИСАННЫХ МНИ для поля ID*/
CREATE GENERATOR GEN_DEL_MNI_ID;
COMMIT;
/*Установим начальное значение генератора*/
SET GENERATOR GEN_DEL_MNI_ID TO 0;
COMMIT;

/*создаем генератор для таблицы ЖУРНАЛ ВРЕМЕННОГО ПРЕКРАЩЕНИЯ ТР. ДЕЯТЕЛЬНОСТИ(БОЛЬНИЧНЫЙ И ДР.) СОТРУДНИКОВ для поля ID*/
CREATE GENERATOR GEN_TMP_STOP_SW_ID;
COMMIT;
/*Установим начальное значение генератора*/
SET GENERATOR GEN_TMP_STOP_SW_ID TO 0;
COMMIT;

/*создаем генератор для таблицы ЖУРНАЛ изменений СОТРУДНИКОВ для поля ID*/
CREATE GENERATOR GEN_CHANGE_EMPL_ID;
COMMIT;
/*Установим начальное значение генератора*/
SET GENERATOR GEN_CHANGE_EMPL_ID TO 0;
COMMIT;

/*создаем генератор для таблицы ЖУРНАЛ изменений МНИ для поля ID*/
CREATE GENERATOR GEN_CHANGE_MNI_ID;
COMMIT;
/*Установим начальное значение генератора*/
SET GENERATOR GEN_CHANGE_MNI_ID TO 0;
COMMIT;

/*создаем генератор для таблицы ОБОСНОВЫВАЮЩИЕ ДОКУМЕНТЫ для поля ID*/
CREATE GENERATOR GEN_DOCS_ID;
COMMIT;
/*Установим начальное значение генератора*/
SET GENERATOR GEN_DOCS_ID TO 0;
COMMIT;

/*создаем генератор для таблиц СВЯЗИ для поля ID*/
CREATE GENERATOR GEN_SVIAZ_ID;
COMMIT;
/*Установим начальное значение генератора*/
SET GENERATOR GEN_SVIAZ_ID TO 0;
COMMIT;

/*Создаем исключения*/
/*создаем исключение для случая "не корректное временное прекращение тр. деятельности*/
CREATE EXCEPTION TMP_STOP_SW_incorrect_operation 'input correct date start';
COMMIT;

/*Создаем исключения*/
/*создаем исключение для случая "двойной прием сотрудника*/
CREATE EXCEPTION SW_incorrect_operation 'This is employee now working';
COMMIT;

/*Создаем исключения*/
/*создаем исключение для случая увольнение раньше чем принят на работу*/
CREATE EXCEPTION Uvoln_SW_incorrect_operation 'This is employee incorrect uvolen';
COMMIT;

/*Создаем исключения*/
/*создаем исключение для случая увольнение раньше чем принят на работу*/
CREATE EXCEPTION CK_incorrect_operation 'This is copy_kripto duble';
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



