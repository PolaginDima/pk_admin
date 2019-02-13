/*скрипт для создания базы данных*/
/*Здесь создаются таблицы, ограничения unique, изменения таблиц ALTER TABLE*/
/*Добавляются первичные ключи PRIMARY KEY*/

/*SET AUTODDL ON/OFF - авто подтверждение операторов*/
/*commit; - после каждой команды которая должна*/
/*выполниться, подтверждение операторов*/
/*последний commit; можно отменить с помощью rollback*/
/*------------------------------------*/

/*------------------------------------*/
/*МЕСТА - КОМНАТЫ, КОРИДОРЫ И Т.Д., т.е. места где может находиться человек, компьютер или прибор какой-то*/
/*создаем таблицу PLACE с первичным ключем ID*/
CREATE TABLE PLACE (
ID    INTEGER NOT NULL CONSTRAINT ID_PLACE_PRIMARY PRIMARY KEY,
NAME    VARCHAR(100) CHARACTER SET WIN1251 DEFAULT '-' NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_PLACE UNIQUE(NAME)
);

/*------------------------------------*/
/*РАБОТНИКИ*/
/*создаем таблицу USERS с первичным ключем ID*/
CREATE TABLE USERS (
ID    INTEGER NOT NULL PRIMARY KEY,

FAM     FIO NOT NULL,
NAM     FIO NOT NULL,
OTCH    FIO NOT NULL,
DTB     DATE DEFAULT CURRENT_DATE NOT NULL, /* - дата рождения/*/

SEX     SEX_USER NOT NULL,
PLB   VARCHAR(255) CHARACTER SET WIN1251,
PLP   VARCHAR(255) CHARACTER SET WIN1251,

NET_NAME  VARCHAR(10) CHARACTER SET WIN1251 DEFAULT 'HET',

CONSTRAINT UNIQUE_EMPL UNIQUE(FAM,NAM,OTCH,DTB)
);
/*создаем таблицу USERS_DOLJN с первичным ключем ID*/
CREATE TABLE USERS_DOLJN (
ID    INTEGER NOT NULL PRIMARY KEY,
NAME    VARCHAR(150) CHARACTER SET WIN1251 DEFAULT 'НЕТ' NOT NULL,

CONSTRAINT UNIQUE_DOLJN UNIQUE(NAME)
);


/*создаем таблицу USERS_GROUP с первичным ключем ID*/
CREATE TABLE USERS_GROUP (
ID    INTEGER NOT NULL CONSTRAINT ID_GROUP_PRIMARY PRIMARY KEY,
NAME    VARCHAR(30) CHARACTER SET WIN1251 DEFAULT 'НЕТ' NOT NULL,

CONSTRAINT UNIQUE_GROUP UNIQUE(NAME)
);



COMMIT;

