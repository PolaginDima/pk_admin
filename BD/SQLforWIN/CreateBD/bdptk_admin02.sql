/*скрипт для создания базы данных*/
/*Здесь создаются таблицы, ограничения unique, изменения таблиц ALTER TABLE*/
/*Добавляются первичные ключи PRIMARY KEY*/

/*SET AUTODDL ON/OFF - авто подтверждение операторов*/
/*commit; - после каждой команды которая должна*/
/*выполниться, подтверждение операторов*/
/*последний commit; можно отменить с помощью rollback*/

/*------------------------------------*/
/*начало создания словарей*/
/*------------------------------------*/
/*СЛОВАРЬ ЛОКАЦИИ - КОМНАТЫ, КОРИДОРЫ И Т.Д., т.е. места где может находиться человек, компьютер или прибор какой-то*/
/*создаем таблицу LOCATIONS с первичным ключем ID*/
CREATE TABLE LOCATIONS (
ID    INTEGER NOT NULL CONSTRAINT ID_LOCATIONS_PRIMARY PRIMARY KEY,
/*NAME    VARCHAR(255) CHARACTER SET WIN1251 DEFAULT '-' NOT NULL COLLATE PXW_CYRL,*/
NAME    VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
ID_RAION INTEGER NOT NULL,
ID_USER INTEGER NOT NULL/*,
CONSTRAINT UNIQUE_LOCATIONS_NAME UNIQUE(NAME)*/
);

/*------------------------------------*/
/*СЛОВАРЬ цвет*/
/*создаем таблицу colors с первичным ключем ID*/
CREATE TABLE COLORS (
ID    INTEGER NOT NULL CONSTRAINT ID_COLORS_PRIMARY PRIMARY KEY,
NAME    VARCHAR(15) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_COLORS_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ TIP_MEMORY*/
/*создаем таблицу colors с первичным ключем ID*/
CREATE TABLE TIP_MEMORY (
ID    INTEGER NOT NULL CONSTRAINT ID_TIP_MEMORY_PRIMARY PRIMARY KEY,
NAME    VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_TIP_MEMORY_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ TIP_PROC*/
/*создаем таблицу colors с первичным ключем ID*/
CREATE TABLE TIP_PROC (
ID    INTEGER NOT NULL CONSTRAINT ID_TIP_PROC_PRIMARY PRIMARY KEY,
NAME    VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_TIP_PROC_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ NAME_OS*/
/*создаем таблицу название ОС с первичным ключем ID*/
CREATE TABLE NAME_OS (
ID    INTEGER NOT NULL CONSTRAINT ID_NAME_OS_PRIMARY PRIMARY KEY,
NAME    VARCHAR(100) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_NAME_OS_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ NAME_SB*/
/*создаем таблицу название ОС с первичным ключем ID*/
CREATE TABLE NAME_SB (
ID    INTEGER NOT NULL CONSTRAINT ID_NAME_SB_PRIMARY PRIMARY KEY,
NAME    VARCHAR(100) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_NAME_SB_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ PR_RASPR_SB*/
/*создаем таблицу PR_RASPR_SB с первичным ключем ID*/
CREATE TABLE PR_RASPR_SB (
ID    INTEGER NOT NULL CONSTRAINT ID_PR_RASPR_SB_PRIMARY PRIMARY KEY,
NAME    VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_PR_RASPR_SB_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ STIKER_SB*/
/*создаем таблицу СТИКЕР СИСТЕМНОГО БЛОКА с первичным ключем ID*/
CREATE TABLE STIKER_SB (
ID    INTEGER NOT NULL CONSTRAINT ID_STIKER_SB_PRIMARY PRIMARY KEY,
NAME    VARCHAR(30) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_STIKER_SB_NAME UNIQUE(NAME)
);


/*------------------------------------*/
/*СЛОВАРЬ TIP_LICENSE_OS*/
/*создаем таблицу тип лицензии ОС с первичным ключем ID*/
CREATE TABLE TIP_LICENSE_OS (
ID    INTEGER NOT NULL CONSTRAINT ID_TIP_LICENSE_OS_PRIMARY PRIMARY KEY,
NAME    VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_TIP_LICENSE_NAME_OS UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ TIP_WORK_SB*/
/*создаем таблицу направление использования с первичным ключем ID*/
CREATE TABLE TIP_WORK_SB (
ID    INTEGER NOT NULL CONSTRAINT ID_TIP_WORK_SB_PRIMARY PRIMARY KEY,
NAME    VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_TIP_WORK_SB UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ тип образования*/
/*создаем таблицу TIP_EDUCATION с первичным ключем ID*/
CREATE TABLE TIP_EDUCATION (
ID    INTEGER NOT NULL CONSTRAINT ID_TIP_EDUCATION_PRIMARY PRIMARY KEY,
/*NAME    VARCHAR(255) CHARACTER SET WIN1251 DEFAULT '-' NOT NULL COLLATE PXW_CYRL,*/
NAME    VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_TIP_EDUCATION_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ люди из них выбираются работники, служащие, начальники*/
/*создаем таблицу PEOPLES с первичным ключем ID*/
CREATE TABLE PEOPLES (
ID	INTEGER NOT NULL CONSTRAINT ID_PEOPLES_PRIMARY PRIMARY KEY,
FAM	FIO NOT NULL COLLATE PXW_CYRL,
NAM	FIO NOT NULL COLLATE PXW_CYRL,
OTCH	FIO NOT NULL COLLATE PXW_CYRL,
PASPORT VARCHAR(255) CHARACTER SET WIN1251   COLLATE PXW_CYRL,
SNILS VARCHAR(11) CHARACTER SET WIN1251   COLLATE PXW_CYRL,
INN VARCHAR(12) CHARACTER SET WIN1251   COLLATE PXW_CYRL,
id_SEX	SMALLINT NOT NULL,
DTB	DATE NOT NULL,/*дата рождения*/
PLB	VARCHAR(255) CHARACTER SET WIN1251  COLLATE PXW_CYRL,/*место рождения*/
REGISTRATION	VARCHAR(255) CHARACTER SET WIN1251  COLLATE PXW_CYRL,/*место жительства по паспорту*/
ID_RAION INTEGER NOT NULL,
ID_USER INTEGER NOT NULL,
phone_home VARCHAR(20) CHARACTER SET WIN1251  COLLATE PXW_CYRL,
phone_work VARCHAR(20) CHARACTER SET WIN1251  COLLATE PXW_CYRL,
phone_sote VARCHAR(20) CHARACTER SET WIN1251  COLLATE PXW_CYRL,
id_tip_education integer NOT NULL,
place_education VARCHAR(255) CHARACTER SET WIN1251 NOT NULL  COLLATE PXW_CYRL,/*Образование*/
CONSTRAINT UNIQUE_PEOPLES_FIO_BD UNIQUE(FAM,NAM,OTCH,DTB)
);

/*------------------------------------*/
/*СЛОВАРЬ люди из них выбираются работники, служащие, начальники*/
/*создаем таблицу CHILDRENS с первичным ключем ID*/
CREATE TABLE CHILDRENS (
ID	INTEGER NOT NULL CONSTRAINT ID_CHILDRENS_PRIMARY PRIMARY KEY,
FAM	FIO NOT NULL COLLATE PXW_CYRL,
NAM	FIO NOT NULL COLLATE PXW_CYRL,
OTCH	FIO NOT NULL COLLATE PXW_CYRL,
id_SEX	SMALLINT NOT NULL,
DTB	DATE NOT NULL,/*дата рождения*/
ID_PEOPLE INTEGER NOT NULL,
ID_RAION INTEGER NOT NULL,
ID_USER INTEGER NOT NULL,
CONSTRAINT UNIQUE_CHILDRENS_FIO_BD UNIQUE(FAM,NAM,OTCH,DTB)
);

/*------------------------------------*/
/*СЛОВАРЬ ПОЛ*/
/*создаем таблицу SEX с первичным ключем ID*/
CREATE TABLE SEX (
ID    SMALLINT NOT NULL CONSTRAINT ID_SEX_PRIMARY PRIMARY KEY,
NAME    VARCHAR(7) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_SEX_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ ПРИЗНАК РАСПРЕДЕЛЕНИЯ*/
/*создаем таблицу PR_RASPR_MNI с первичным ключем ID*/
CREATE TABLE PR_RASPR_MNI (
ID    SMALLINT NOT NULL CONSTRAINT ID_PR_RASPR_MNI_PRIMARY PRIMARY KEY,
NAME    VARCHAR(14) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_PR_RASPR_MNI_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ КЛЮЧЕВОЙ*/
/*создаем таблицу KEY_ с первичным ключем ID*/
CREATE TABLE KEY_ (
ID    SMALLINT NOT NULL CONSTRAINT ID_KEY__PRIMARY PRIMARY KEY,
NAME    VARCHAR(11) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_KEY__NAME UNIQUE(NAME)
);



/*------------------------------------*/
/*СЛОВАРЬ ДОЛЖНОСТИ*/
/*создаем таблицу POSTS с первичным ключем ID*/
CREATE TABLE POSTS (
ID    INTEGER NOT NULL CONSTRAINT ID_PLACE_PRIMARY PRIMARY KEY,
NAME    VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_POST_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ ГРУППЫ*/
/*создаем таблицу GROUPS с первичным ключем ID*/
CREATE TABLE GROUPS (
ID    INTEGER NOT NULL CONSTRAINT ID_GROUPS_PRIMARY PRIMARY KEY,
NAME    VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_GROUPS_NAME UNIQUE(NAME)
);

/*СЛОВАРЬ Криптосредства*/
/*создаем таблицу KRIPTO с первичным ключем ID*/
CREATE TABLE KRIPTO (
ID    INTEGER NOT NULL CONSTRAINT ID_KRIPTO_PRIMARY PRIMARY KEY,
NAME    VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_KRIPTO_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ РАЙОНЫ*/
/*создаем таблицу RAIONS с первичным ключем ID*/
CREATE TABLE RAIONS (
ID    INTEGER NOT NULL CONSTRAINT ID_RAIONS_PRIMARY PRIMARY KEY,
PREFIKS  VARCHAR(3) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,/*ПРЕФИКС РАЙОНА 34, 24, ...*/
NAME    VARCHAR(15) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL, /*НАИМЕНОВАНИЕ НАСЕЛЕННОГО ПУНКТА*/
SMALL_NAME  VARCHAR(255) CHARACTER SET WIN1251 COLLATE PXW_CYRL, /*КРАТКОЕ НАИМЕНОВАНИЕ ПО ДОКУМЕНТАМ*/
FULL_NAME    VARCHAR(255) CHARACTER SET WIN1251 COLLATE PXW_CYRL, /*ПОЛНОЕ НАИМЕНОВАНИЕ ПО ДОКУМЕНТАМ*/
ID_BOSS INTEGER,
ID_MAINBUH INTEGER,
ADDRESS VARCHAR(255) CHARACTER SET WIN1251 COLLATE PXW_CYRL,/*АДРЕС*/
FULL_KR_NAME VARCHAR(100) CHARACTER SET WIN1251 COLLATE PXW_CYRL,
INN VARCHAR(10) CHARACTER SET WIN1251 COLLATE PXW_CYRL,
OGRN VARCHAR(13) CHARACTER SET WIN1251 COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_RAIONS_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ ПРЕДЫДУЩИЕ МЕСТА РАБОТЫ*/
/*создаем таблицу WORKS с первичным ключем ID*/
CREATE TABLE WORKS (
ID    INTEGER NOT NULL CONSTRAINT ID_WORKS_PRIMARY PRIMARY KEY,
NAME    VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
ID_PEOPLES INTEGER NOT NULL,
/*ID_PROFESSION INTEGER NOT NULL,*/
CONSTRAINT UNIQUE_WORKS_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ ПРОФЕССИИ - НЕ ИСПОЛЬЗУЕТСЯ*/
/*создаем таблицу PROFESSIONS с первичным ключем ID*/
/*CREATE TABLE PROFESSIONS (*/
/*ID    INTEGER NOT NULL CONSTRAINT ID_PROFESSIONS_PRIMARY PRIMARY KEY,*/
/*NAME    VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,*/
/*CONSTRAINT UNIQUE_PROFESSIONS_NAME UNIQUE(NAME)*/
/*);*/

/*------------------------------------*/
/*СЛОВАРЬ ПОЛЬЗОВАТЕЛИ ПРОГРАММЫ*/
/*создаем таблицу ПОЛЬЗОВАТЕЛИ ПРОГРАММЫ с первичным ключем ID*/
CREATE TABLE USERS (
ID    INTEGER NOT NULL CONSTRAINT ID_USERS_PRIMARY PRIMARY KEY,
ID_RAION    INTEGER NOT NULL,
NAME    VARCHAR(10) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
RROLE  VARCHAR(20) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
FAM	FIO COLLATE PXW_CYRL,
NAM	FIO COLLATE PXW_CYRL,
OTCH FIO COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_USERS_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ модель МНИ*/
/*создаем таблицу модель МНИ с первичным ключем ID*/
CREATE TABLE MNI_MODEL (
ID    INTEGER NOT NULL CONSTRAINT ID_MNI_MODEL_PRIMARY PRIMARY KEY,
NAME VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_MNI_MODEL_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ тип МНИ*/
/*создаем таблицу тип МНИ с первичным ключем ID*/
CREATE TABLE MNI_TIP (
ID    INTEGER NOT NULL CONSTRAINT ID_MNI_TIP_PRIMARY PRIMARY KEY,
NAME VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_MNI_TIP_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ 	ПРИЧИНЫ УВОЛЬНЕНИЯ*/
/*создаем таблицу ПРИЧИНЫ УВОЛЬНЕНИЯ с первичным ключем ID*/
CREATE TABLE MOTIVE_DISCHARGE (
ID    INTEGER NOT NULL CONSTRAINT ID_MOTIVE_DISCHARGE_PRIMARY PRIMARY KEY,
NAME    VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_MOTIVE_DISCHARGE_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ 	ПРИЧИНЫ ВРЕМЕННОГО ПРЕКРАЩЕНИЯ ТР. ДЕЯТЕЛЬНОСТИ*/
/*создаем таблицу ПРИЧИНЫ ВРЕМЕННОГО ПРЕКРАЩЕНИЯ ТР. ДЕЯТЕЛЬНОСТИ с первичным ключем ID*/
CREATE TABLE MOTIVE_TMP_STOP_SW (
ID    INTEGER NOT NULL CONSTRAINT ID_MOTIVE_T_S_SW_PRIMARY PRIMARY KEY,
NAME    VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_MOTIVE_T_S_SW_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ 	УСЛОВИЯ ПРИЕМА НА РАБОТУ*/
/*создаем таблицу УСЛОВИЯ ПРИЕМА НА РАБОТУ с первичным ключем ID*/
CREATE TABLE COND_START_WORK (
ID    INTEGER NOT NULL CONSTRAINT ID_CONDITION_START_WORK_PRIMARY PRIMARY KEY,
NAME    VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_COND_START_WORK_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ 	ПРИЧИНЫ СНЯТИЯ С УЧЕТА МНИ*/
/*создаем таблицу ПРИЧИНЫ СНЯТИЯ С УЧЕТА МНИ с первичным ключем ID*/
CREATE TABLE MOTIVE_DELETE_MNI (
ID    INTEGER NOT NULL CONSTRAINT ID_MOTIVE_DELETE_MNI_PRIMARY PRIMARY KEY,
NAME    VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_MOTIVE_DELETE_MNI_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ 	ПРИЧИНЫ удаления КРИПТОСРЕДСТВА*/
/*создаем таблицу ПРИЧИНЫ удаления КРИПТОСРЕДСТВА с первичным ключем ID*/
CREATE TABLE MOTIVE_DEL_KRIPTO (
ID    INTEGER NOT NULL CONSTRAINT ID_MOTIVE_DEL_KR_PRIMARY PRIMARY KEY,
NAME    VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_MOTIVE_DEL_KR_NAME UNIQUE(NAME)
);


/*------------------------------------*/
/*СЛОВАРЬ 	ПРИЧИНЫ СНЯТИЯ С УЧЕТА СИСТЕМНОГО БЛОКА*/
/*создаем таблицу ПРИЧИНЫ СНЯТИЯ С УЧЕТА МНИ с первичным ключем ID*/
CREATE TABLE MOTIVE_DEL_SB (
ID    INTEGER NOT NULL CONSTRAINT ID_MOTIVE_DEL_SB_PRIMARY PRIMARY KEY,
NAME    VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_MOTIVE_DELETE_MNI_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ 	ПРИЧИНЫ ВРЕМЕННОГО ПРЕКРАЩЕНИЯ СИСТЕМНОГО БЛОКА*/
/*создаем таблицу ПРИЧИНЫ ВРЕМЕННОГО ПРЕКРАЩЕНИЯ ТР. ДЕЯТЕЛЬНОСТИ с первичным ключем ID*/
CREATE TABLE MOTIVE_TMP_STOP_SB (
ID    INTEGER NOT NULL CONSTRAINT ID_MOTIVE_T_S_SB_PRIMARY PRIMARY KEY,
NAME    VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_MOTIVE_T_S_SB_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ 	ПРИЧИНЫ ОТОЗВАННЫХ СЕРТИФИКАТОВ*/
/*создаем таблицу ПРИЧИНЫ ОТОЗВАННЫХ СЕРТИФИКАТОВ с первичным ключем ID*/
CREATE TABLE MOTIVE_STOP_SERTIFIKATS (
ID    INTEGER NOT NULL CONSTRAINT ID_MOTIVE_STOP_SERT_PRIMARY PRIMARY KEY,
NAME    VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_MOTIVE_STOP_SERT_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ 	ПРИЧИНЫ ПРИОСТАНОВЛЕННЫХ СЕРТИФИКАТОВ*/
/*создаем таблицу ПРИЧИНЫ ПРИОСТАНОВЛЕННЫХ СЕРТИФИКАТОВ с первичным ключем ID*/
CREATE TABLE MOTIVE_TMP_STOP_SERT (
ID    INTEGER NOT NULL CONSTRAINT ID_MOTIVE_T_S_SERT_PRIMARY PRIMARY KEY,
NAME    VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_MOTIVE_T_S_SERT_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ модель РАЗНОЕ*/
/*создаем таблицу модель МНИ с первичным ключем ID*/
CREATE TABLE RAZNOE_MODEL (
ID    INTEGER NOT NULL CONSTRAINT ID_RAZNOE_MODEL_PRIMARY PRIMARY KEY,
NAME VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_RAZNOE_MODEL_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ тип РАЗНОЕ*/
/*создаем таблицу тип МНИ с первичным ключем ID*/
CREATE TABLE RAZNOE_TIP (
ID    INTEGER NOT NULL CONSTRAINT ID_RAZNOE_TIP_PRIMARY PRIMARY KEY,
NAME VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_RAZNOE_TIP_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ ПРИЗНАК РАСПРЕДЕЛЕНИЯ*/
/*создаем таблицу PR_RASPR_RAZNOE с первичным ключем ID*/
CREATE TABLE PR_RASPR_RAZNOE (
ID    SMALLINT NOT NULL CONSTRAINT ID_PR_RASPR_RAZNOE_PRIMARY PRIMARY KEY,
NAME    VARCHAR(14) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_PR_RASPR_RAZNOE_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ 	НАИМЕНОВАНИЯ ПРИНТЕРОВ*/
/*создаем таблицу НАИМЕНОВАНИЯ ПРИНТЕРОВ с первичным ключем ID*/
CREATE TABLE PRINTER_NAME (
ID    INTEGER NOT NULL CONSTRAINT ID_PRINTER_NAME_PRIMARY PRIMARY KEY,
NAME    VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_PRINTER_NAME_NAME UNIQUE(NAME)
);

/*------------------------------------*/
/*СЛОВАРЬ 	НАИМЕНОВАНИЯ КАРТРИДЖЕЙ*/
/*создаем таблицу НАИМЕНОВАНИЯ КАРТРИДЖЕЙ с первичным ключем ID*/
CREATE TABLE KARTRIDJ_NAME (
ID    INTEGER NOT NULL CONSTRAINT ID_KARTRIDJ_NAME_PRIMARY PRIMARY KEY,
NAME  VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
DOP  VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_KARTRIDJ_NAME_NAME UNIQUE(NAME)
);
/*конец словарей*/
/*----------------------------------------------*/


/*начало создания журналов и связанных с ними таблиц*/
/*------------------------------------*/
/*СОТРУДНИКИ*/
/*ЖУРНАЛ ПРИНЯТЫХ СОТРУДНИКОВ*/
/*создаем таблицу ПРИНЯТЫХ СОТРУДНИКОВ с первичным ключем ID*/
CREATE TABLE START_WORK (
ID    INTEGER NOT NULL CONSTRAINT ID_START_WORK_PRIMARY PRIMARY KEY,
ID_RAION    INTEGER NOT NULL,
ID_USER INTEGER NOT NULL,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT DATE NOT NULL,
ID_LOCATION INTEGER NOT NULL,
ID_PEOPLE INTEGER NOT NULL,
ID_GROUP INTEGER,
ID_POST INTEGER NOT NULL,
ID_CONDITION INTEGER NOT NULL,
TABNOM VARCHAR(5) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
ID_DOP INTEGER,
CONSTRAINT UNIQUE_START_WORK_NAME UNIQUE(DT,ID_PEOPLE)
);

/*------------------------------------*/
/*ЖУРНАЛ УВОЛЕННЫХ СОТРУДНИКОВ*/
/*создаем таблицу УВОЛЕННЫХ СОТРУДНИКОВ с первичным ключем ID*/
CREATE TABLE DISCHARGE (
ID    INTEGER NOT NULL CONSTRAINT ID_DISCHARGE_PRIMARY PRIMARY KEY,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT DATE NOT NULL,
ID_START_WORK INTEGER NOT NULL,
ID_MOTIVE_DISCHARGE INTEGER NOT NULL,
CONSTRAINT UNIQUE_DISCHARGE_START_WORK UNIQUE(ID_START_WORK)
);

/*------------------------------------*/
/*ЖУРНАЛ ВРЕМЕННОГО ПРЕКРАЩЕНИЯ ТР. ДЕЯТЕЛЬНОСТИ(БОЛЬНИЧНЫЙ И ДР.) СОТРУДНИКОВ*/
/*создаем таблицу ВРЕМЕННОГО ПРЕКРАЩЕНИЯ ТР. ДЕЯТЕЛЬНОСТИ СОТРУДНИКОВ с первичным ключем ID*/
CREATE TABLE TMP_STOP_SW (
ID    INTEGER NOT NULL CONSTRAINT ID_TMP_STOP_SW_PRIMARY PRIMARY KEY,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT_START DATE NOT NULL,
DT_END DATE,
ID_START_WORK INTEGER NOT NULL,
ID_MOTIVE_TMP_STOP_SW INTEGER NOT NULL,
CONSTRAINT UNIQUE_TMP_STOP_SW UNIQUE(ID_START_WORK,ID_MOTIVE_TMP_STOP_SW, DT_START),
CONSTRAINT CORR_DT_END CHECK(DT_END>=DT_START)
);

/*------------------------------------*/
/*ЖУРНАЛ ИЗМЕНЕНИЙ СОТРУДНИКОВ*/
/*создаем таблицу ИЗМЕНЕНИЙ СОТРУДНИКОВ с первичным ключем ID*/
CREATE TABLE MOVE_EMPL (
ID    INTEGER NOT NULL CONSTRAINT ID_MOVE_EMPL_PRIMARY PRIMARY KEY,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ID_START_WORK INTEGER NOT NULL,
ID_LOCATION INTEGER NOT NULL,
ID_POST INTEGER NOT NULL,
ID_GROUP INTEGER,
FAM FIO NOT NULL
);

/*------------------------------------*/
/*создаем таблицу СВЯЗИ ПРИНЯТЫХ СОТРУДНИКОВ И ДОКУМЕНТОВ с первичным ключем ID*/
CREATE TABLE SVIAZ_SW_DOCS (
ID    INTEGER NOT NULL CONSTRAINT ID_SVIAZ_SW_DOCS_PRIMARY PRIMARY KEY,
ID_START_WORK INTEGER NOT NULL,
ID_DOCS INTEGER NOT NULL,
CONSTRAINT UNIQUE_SV_SW_DOCS UNIQUE(ID_START_WORK,ID_DOCS)
);

/*------------------------------------*/
/*ЖУРНАЛ СЕРТИФИКАТОВ*/
/*создаем таблицу СЕРТИФИКАТОВ с первичным ключем ID*/
CREATE TABLE SERTIFIKATS (
ID    INTEGER NOT NULL CONSTRAINT ID_SERTIFIKATS_PRIMARY PRIMARY KEY,
ID_RAION    INTEGER NOT NULL,
ID_USER INTEGER NOT NULL,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT DATE NOT NULL,
ID_START_WORK INTEGER NOT NULL,
NAME  VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
DT_START  DATE NOT NULL,
DT_END  DATE NOT NULL,
ID_DOP INTEGER,
CONSTRAINT UNIQUE_SERTIFIKATS_START_WORK UNIQUE(NAME, DT_START, DT_END,ID_START_WORK),
CONSTRAINT CORR_SERT_DT_STARTEND CHECK(DT_END>DT_START),
CONSTRAINT CORR_SERT_DT_DTEND CHECK(DT<DT_END)
);

/*------------------------------------*/
/*ЖУРНАЛ ОТОЗВАННЫХ СЕРТИФИКАТОВ*/
/*создаем таблицу ОТОЗВАННЫХ СЕРТИФИКАТОВ с первичным ключем ID*/
CREATE TABLE STOP_SERTIFIKATS (
ID    INTEGER NOT NULL CONSTRAINT ID_STOP_SERT_PRIMARY PRIMARY KEY,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT DATE NOT NULL,
ID_SERTIFIKATS INTEGER NOT NULL,
ID_MOTIVE_STOP_SERTIFIKATS INTEGER NOT NULL,
CONSTRAINT UNIQUE_STOP_SERTIFIKATS UNIQUE(ID_SERTIFIKATS)
);

/*------------------------------------*/
/*ЖУРНАЛ ПРИОСТАНОВЛЕННЫХ СЕРТИФИКАТОВ*/
/*создаем таблицу ПРИОСТАНОВЛЕННЫХ СЕРТИФИКАТОВ с первичным ключем ID*/
CREATE TABLE TMP_STOP_SERTIFIKATS (
ID    INTEGER NOT NULL CONSTRAINT ID_TMP_STOP_SERT_PRIMARY PRIMARY KEY,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT_START DATE NOT NULL,
DT_END DATE,
ID_SERTIFIKATS INTEGER NOT NULL,
ID_MOTIVE_TMP_STOP_SERT INTEGER NOT NULL,
CONSTRAINT UNIQUE_TMP_STOP_SERT UNIQUE(ID_SERTIFIKATS,ID_MOTIVE_TMP_STOP_SERT, DT_START),
CONSTRAINT CORR_DT_END_SERT CHECK(DT_END>=DT_START)
);

/*------------------------------------*/
/*создаем таблицу СВЯЗИ СЕРТИФИКАТОВ И ДОКУМЕНТОВ с первичным ключем ID*/
CREATE TABLE SVIAZ_SERT_DOCS (
ID    INTEGER NOT NULL CONSTRAINT ID_SVIAZ_SERT_DOCS_PRIMARY PRIMARY KEY,
ID_SERT INTEGER NOT NULL,
ID_DOCS INTEGER NOT NULL,
CONSTRAINT UNIQUE_SV_SERT_DOCS UNIQUE(ID_SERT,ID_DOCS)
);

/*------------------------------------*/
/*ЖУРНАЛ регистрации МНИ*/
/*создаем таблицу регистрации МНИ с первичным ключем ID*/
CREATE TABLE MNI (
ID    INTEGER NOT NULL CONSTRAINT ID_MNI_PRIMARY PRIMARY KEY,
ID_RAION    INTEGER NOT NULL,
ID_USER INTEGER NOT NULL,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT DATE NOT NULL,
ID_START_WORK INTEGER NOT NULL,
ID_MODEL INTEGER,
ID_TIP INTEGER NOT NULL,
SERIAL VARCHAR(100) CHARACTER SET WIN1251 COLLATE PXW_CYRL,
ID_KEY SMALLINT NOT NULL,
ID_SB INTEGER,    /*СИСТЕМНЫЙ БЛОК*/
SSIZE  DECIMAL(13,6) DEFAULT 0, /*GB*/
ID_PR_RASPR SMALLINT NOT NULL,
OTKUDA VARCHAR(100) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
UCHETN VARCHAR(100) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
ID_DOP INTEGER,
CONSTRAINT UNIQUE_MNI_UCHETN UNIQUE(UCHETN)
);

/*------------------------------------*/
/*ЖУРНАЛ СНЯТИЯ С УЧЕТА МНИ*/
/*создаем таблицу СНЯТИЯ С УЧЕТА МНИ с первичным ключем ID*/
CREATE TABLE DELETE_MNI (
ID    INTEGER NOT NULL CONSTRAINT ID_DELETE_MNI_PRIMARY PRIMARY KEY,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT DATE NOT NULL,
ID_MNI INTEGER NOT NULL,
ID_MOTIVE_DELETE_MNI INTEGER NOT NULL,
CONSTRAINT UNIQUE_DELETE_MNI_ID_MNI UNIQUE(ID_MNI)
);

/*------------------------------------*/
/*ЖУРНАЛ ИЗМЕНЕНИЙ MNI*/
/*создаем таблицу ИЗМЕНЕНИЙ MNI с первичным ключем ID*/
CREATE TABLE MOVE_MNI (
ID    INTEGER NOT NULL CONSTRAINT ID_MOVE_MNI_PRIMARY PRIMARY KEY,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ID_MNI INTEGER NOT NULL,
ID_KEY INTEGER NOT NULL,
ID_START_WORK INTEGER NOT NULL,
ID_PR_RASPR INTEGER NOT NULL,
ID_SB INTEGER,
UCHETN VARCHAR(100) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL
);

/*------------------------------------*/
/*создаем таблицу СВЯЗИ МНИ И ДОКУМЕНТОВ с первичным ключем ID*/
CREATE TABLE SVIAZ_MNI_DOCS (
ID    INTEGER NOT NULL CONSTRAINT ID_SVIAZ_MNI_DOCS_PRIMARY PRIMARY KEY,
ID_MNI INTEGER NOT NULL,
ID_DOCS INTEGER NOT NULL,
CONSTRAINT UNIQUE_SV_MNI_DOCS UNIQUE(ID_MNI,ID_DOCS)
);

/*------------------------------------*/
/*ЖУРНАЛ учета экземпляров криптосредств*/
/*создаем таблицу учета экземпляров криптосредств с первичным ключем ID*/
CREATE TABLE COPY_KRIPTO (
ID    INTEGER NOT NULL CONSTRAINT ID_COPY_KRIPTO_PRIMARY PRIMARY KEY,
ID_RAION    INTEGER NOT NULL,
ID_USER INTEGER NOT NULL,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT DATE NOT NULL,
ID_KRIPTO INTEGER NOT NULL,
ID_SB INTEGER NOT NULL,
ID_MNI INTEGER,
ID_START_WORK INTEGER NOT NULL,
NUMBER_COPY VARCHAR(100) CHARACTER SET WIN1251 COLLATE PXW_CYRL,
SERIAL VARCHAR(100) CHARACTER SET WIN1251 COLLATE PXW_CYRL,
OTKUDA VARCHAR(100) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
ID_DOP INTEGER,
ID_LOCATION INTEGER NOT NULL,
CONSTRAINT UNIQUE_COPY_KRIPTO_UCHETN UNIQUE(ID_KRIPTO, ID_MNI, ID_START_WORK, NUMBER_COPY, SERIAL, ID_SB, ID_LOCATION),
CONSTRAINT CORR_KRIPTO_VVOD CHECK((not (ID_MNI is null)) or (not (SERIAL is null))or(not (NUMBER_COPY is null)))
);

/*------------------------------------*/
/*ЖУРНАЛ ИЗЪЯТИЯ КРИПТОСРЕДСТВ*/
/*создаем таблицу ИЗЪЯТИЯ КРИПТОСРЕДСТВ с первичным ключем ID*/
CREATE TABLE DELETE_KRIPTO (
ID    INTEGER NOT NULL CONSTRAINT ID_DEL_KR_PRIMARY PRIMARY KEY,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT DATE NOT NULL,
ID_KRIPTO INTEGER NOT NULL,
ID_MOTIVE_DEL_KR INTEGER NOT NULL,
CONSTRAINT UNIQUE_DEL_KRIPTO UNIQUE(ID_KRIPTO)
);

/*------------------------------------*/
/*создаем таблицу СВЯЗИ ЭКЗЕМПЛЯРЫ КРИПТОСРЕДСТВ И ДОКУМЕНТОВ с первичным ключем ID*/
CREATE TABLE SVIAZ_COPY_KRIPTO_DOCS (
ID    INTEGER NOT NULL CONSTRAINT ID_SVIAZ_CK_DOCS_PRIMARY PRIMARY KEY,
ID_COPY_KRIPTO INTEGER NOT NULL,
ID_DOCS INTEGER NOT NULL,
CONSTRAINT UNIQUE_SV_CK_DOCS UNIQUE(ID_COPY_KRIPTO,ID_DOCS)
);

/*------------------------------------*/
/*ЖУРНАЛ регистрации СИСТЕМНЫЙ БЛОК*/
/*создаем таблицу регистрации МНИ с первичным ключем ID*/
CREATE TABLE SB (
ID    INTEGER NOT NULL CONSTRAINT ID_SB_PRIMARY PRIMARY KEY,
ID_RAION    INTEGER NOT NULL,
ID_USER INTEGER NOT NULL,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT DATE NOT NULL,
ID_DOP INTEGER,
 CPU_MHZ INTEGER DEFAULT 2000,
 COUNT_IADRA INTEGER DEFAULT 1,
 ID_TIP_PROC INTEGER,
 ID_TIP_MEMORY INTEGER,
 SIZE_MEMORY_MB INTEGER DEFAULT 2000,
 ID_NAME_SB INTEGER NOT NULL,
 ID_START_WORK INTEGER NOT NULL,
 ID_PR_RASPR SMALLINT NOT NULL,
 ID_NAME_OS SMALLINT,
 ID_LICENSE_OS SMALLINT,
 ID_WORK_SB SMALLINT,
 OTKUDA VARCHAR(100) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
 DTI DATE,
SERIAL  VARCHAR(50) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
INVENT  VARCHAR(30) CHARACTER SET WIN1251 COLLATE PXW_CYRL,
STIKER  VARCHAR(10) CHARACTER SET WIN1251 COLLATE PXW_CYRL,
CONSTRAINT UNIQUE_SB UNIQUE(ID_NAME_SB, SERIAL),
CONSTRAINT CORR_SB_DT_DTI CHECK(DT<DTI)
);

/*------------------------------------*/
/*ЖУРНАЛ СНЯТИЯ С УЧЕТА СИСТЕМНЫЙ БЛОК*/
/*создаем таблицу СНЯТИЯ С УЧЕТА МНИ с первичным ключем ID*/
CREATE TABLE DELETE_SB (
ID    INTEGER NOT NULL CONSTRAINT ID_DELETE_SB_PRIMARY PRIMARY KEY,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT DATE NOT NULL,
ID_SB INTEGER NOT NULL,
ID_MOTIVE_DELETE_SB INTEGER NOT NULL,
CONSTRAINT UNIQUE_DELETE_SB_ID_SB UNIQUE(ID_SB)
);

/*------------------------------------*/
/*ЖУРНАЛ ВРЕМЕННОЙ ПОЛОМКИ СИСТЕМНЫЙ БЛОК*/
/*создаем таблицу ВРЕМЕННОЙ ПОЛОМКИ СИСТЕМНЫЙ БЛОК с первичным ключем ID*/
CREATE TABLE TMP_STOP_SB (
ID    INTEGER NOT NULL CONSTRAINT ID_TMP_STOP_SB_PRIMARY PRIMARY KEY,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT_START DATE NOT NULL,
DT_END DATE,
ID_SB INTEGER NOT NULL,
ID_MOTIVE_TMP_STOP_SB INTEGER NOT NULL,
CONSTRAINT UNIQUE_TMP_STOP_SB UNIQUE(ID_SB,ID_MOTIVE_TMP_STOP_SB, DT_START),
CONSTRAINT CORR_DT_END_SB CHECK(DT_END>=DT_START)
);

/*------------------------------------*/
/*ЖУРНАЛ ИЗМЕНЕНИЙ SB*/
/*создаем таблицу ИЗМЕНЕНИЙ MNI с первичным ключем ID*/
CREATE TABLE MOVE_SB (
ID    INTEGER NOT NULL CONSTRAINT ID_MOVE_SB_PRIMARY PRIMARY KEY,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ID_SB INTEGER NOT NULL,
SIZE_MEMORY_MB INTEGER NOT NULL,
ID_START_WORK INTEGER NOT NULL,
ID_PR_RASPR INTEGER NOT NULL,
ID_NAME_OS INTEGER,
ID_WORK_SB INTEGER,
STIKER VARCHAR(10) CHARACTER SET WIN1251 COLLATE PXW_CYRL
);

/*------------------------------------*/
/*создаем таблицу СВЯЗИ ЭКЗЕМПЛЯРЫ КРИПТОСРЕДСТВ И ДОКУМЕНТОВ с первичным ключем ID*/
CREATE TABLE SVIAZ_SB_DOCS (
ID    INTEGER NOT NULL CONSTRAINT ID_SVIAZ_SB_DOCS_PRIMARY PRIMARY KEY,
ID_SB INTEGER NOT NULL,
ID_DOCS INTEGER NOT NULL,
CONSTRAINT UNIQUE_SB_DOCS UNIQUE(ID_SB,ID_DOCS)
);

/*------------------------------------*/
/*СЛОВАРЬ 	КОЛИЧЕСТВО КАРТРИДЖЕЙ*/
/*создаем таблицу КОЛИЧЕСТВО КАРТРИДЖЕЙ с первичным ключем ID*/
CREATE TABLE KARTRIDJ_COUNT (
ID    INTEGER NOT NULL CONSTRAINT ID_KARTRIDJ_COUNT_PRIMARY PRIMARY KEY,
ID_RAION INTEGER NOT NULL,
ID_USER INTEGER NOT NULL,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT DATE NOT NULL,
ID_START_WORK INTEGER NOT NULL,
COUNT_K INTEGER NOT NULL,
ID_KARTRIDJ INTEGER NOT NULL,
CONSTRAINT UNIQUE_KARTRIDJ_COUNT_NAME UNIQUE(DT, ID_KARTRIDJ, COUNT_K, ID_START_WORK),
CONSTRAINT CHECK_KARTRIDJ_COUNT CHECK((COUNT_K<>0))
);

/*------------------------------------*/
/*ЖУРНАЛ регистрации РАЗНОЕ*/
/*создаем таблицу регистрации РАЗНОЕ с первичным ключем ID*/
CREATE TABLE RAZNOE (
ID    INTEGER NOT NULL CONSTRAINT ID_RAZNOE_PRIMARY PRIMARY KEY,
ID_RAION    INTEGER NOT NULL,
ID_USER INTEGER NOT NULL,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
DT DATE NOT NULL,
ID_START_WORK INTEGER NOT NULL,
ID_MODEL INTEGER,
ID_TIP INTEGER NOT NULL,
SERIAL VARCHAR(100) CHARACTER SET WIN1251 COLLATE PXW_CYRL,
ID_SB INTEGER,    /*СИСТЕМНЫЙ БЛОК*/
ID_PR_RASPR SMALLINT NOT NULL,
OTKUDA VARCHAR(100) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
INVENT VARCHAR(30) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
ID_DOP INTEGER,
ID_LOCATION INTEGER,
CONSTRAINT UNIQUE_RAZNOE_UCHETN UNIQUE(INVENT)
);



/*------------------------------------*/
/*ОБОСНОВЫВАЮЩИЕ ДОКУМЕНТЫ*/
/*создаем таблицу ДОКУМЕНТЫ с первичным ключем ID*/
CREATE TABLE DOCS (
ID    INTEGER NOT NULL CONSTRAINT ID_DOCS_PRIMARY PRIMARY KEY,
DTR TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
/*DT DATE NOT NULL,*/
NAME VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
NAMEDOCS VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
DOCS BLOB/*,
CONSTRAINT UNIQUE_DOCS_NAME UNIQUE(NAME)*/
);

/*------------------------------------*/
/*ДОПОЛНИТЕЛЬНАЯ ИНФОРМАЦИЯ*/
/*создаем таблицу ДОПОЛНИТЕЛЬНАЯ ИНФОРМАЦИЯ с первичным ключем ID*/
CREATE TABLE DOP (
ID    INTEGER NOT NULL CONSTRAINT ID_DOP_PRIMARY PRIMARY KEY,
NAME VARCHAR(255) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL/*,
CONSTRAINT UNIQUE_DOP_NAME UNIQUE(NAME)*/
);
/*конец создания журналов*/
/*----------------------------------------------*/


COMMIT;
