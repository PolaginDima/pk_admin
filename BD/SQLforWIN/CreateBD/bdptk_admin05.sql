/*скрипт для создания базы данных*/
/*Здесь создаются тригерры*/

/*SET AUTODDL ON/OFF - авто подтверждение операторов*/
/*commit; - после каждой команды которая должна*/
/*выполниться, подтверждение операторов*/
/*последний commit; можно отменить с помощью rollback*/

/*тригерр для генерации значений поля ID таблицы USERS*/
SET TERM ^;

CREATE TRIGGER USERS_BI1000
ACTIVE BEFORE INSERT POSITION 1000 ON USERS
AS
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID=GEN_ID(GEN_USERS_ID, 1);
END^

SET TERM ;^

/*тригерр для генерации значений поля ID таблицы SVIAZ_SW_DOCS*/
SET TERM ^;

CREATE TRIGGER SVIAZ_SW_DOCS_BI1000
ACTIVE BEFORE INSERT POSITION 1000 ON SVIAZ_SW_DOCS
AS
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID=GEN_ID(GEN_SVIAZ_ID, 1);
END^

SET TERM ;^

/*тригерр для генерации значений поля ID таблицы SVIAZ_MNI_DOCS*/
SET TERM ^;

CREATE TRIGGER SVIAZ_MNI_DOCS_BI1000
ACTIVE BEFORE INSERT POSITION 1000 ON SVIAZ_MNI_DOCS
AS
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID=GEN_ID(GEN_SVIAZ_ID, 1);
END^

SET TERM ;^

/*тригерр для проверки поля DT_START таблицы TMP_STOP_SW*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER TMP_STOP_SW_BI1000 FOR TMP_STOP_SW
ACTIVE BEFORE INSERT POSITION 0
AS
declare variable p smallint;
begin
  /* Trigger text */
  P=0;
  /*корректность даты начала нетрудоспособности-не должно попадать на период другой нетрудоспособности*/
  select 1 from rdb$database where (exists(select ID from TMP_STOP_SW
  where((new.dt_start>dt_start)and(new.dt_start<dt_end)and(NEW.ID_START_WORK=TMP_STOP_SW.ID_START_WORK))))
  OR(exists(select ID from START_WORK  where (START_WORK.ID=NEW.ID_START_WORK)and(NEW.DT_START<START_WORK.DT)))
  into :p;
  if (:p=1) then exception TMP_STOP_SW_INCORRECT_OPERATION;
  /*корректность даты окончания нетрудоспособности-не должно попадать на период другой нетрудоспособности*/
  select 1 from rdb$database where exists(select ID from TMP_STOP_SW
  where((new.dt_end>dt_start)and(new.dt_end<dt_end)and(NEW.ID_START_WORK=TMP_STOP_SW.ID_START_WORK))) into :p;
  if (:p=1) then exception TMP_STOP_SW_INCORRECT_OPERATION;

end
^

SET TERM ; ^

/*тригерр для проверки двойного приема таблицы START_WORK*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER START_WORK_BI1000 FOR START_WORK
ACTIVE BEFORE INSERT POSITION 0
AS
declare variable p smallint;
begin
  /* Trigger text */
  P=0;
  select 1 from rdb$database where
  exists(select  START_WORK.ID from START_WORK  where (NEW.ID_PEOPLE=START_WORK.ID_PEOPLE)and
  (not exists(select * from DISCHARGE where DISCHARGE.ID_START_WORK=START_WORK.ID)))
  into :p;
  if (:p=1) then exception SW_incorrect_operation;
end
^

SET TERM ; ^


/*тригерр для проверки двойного ввода экземпляра криптосредства таблицы COPY_KRIPTO*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER COPY_KRIPTO_BI1000 FOR COPY_KRIPTO
ACTIVE BEFORE INSERT POSITION 0
AS
declare variable p smallint;
begin
  /* Trigger text */
  P=0;
  select 1 from rdb$database where
  /*ID_KRIPTO, ID_MNI, ID_START_WORK, NUMBER_COPY, SERIAL*/
  exists(select  COPY_KRIPTO.ID from COPY_KRIPTO  where (NEW.ID_KRIPTO=COPY_KRIPTO.ID_KRIPTO)and
  (NEW.ID_MNI=COPY_KRIPTO.ID_MNI)and(NEW.ID_START_WORK=COPY_KRIPTO.ID_START_WORK)and
  (NEW.NUMBER_COPY=COPY_KRIPTO.NUMBER_COPY)and(NEW.SERIAL=COPY_KRIPTO.SERIAL)and
  (not exists(select * from DELETE_KRIPTO where DELETE_KRIPTO.ID_KRIPTO=COPY_KRIPTO.ID)))
  into :p;
  if (:p=1) then exception CK_incorrect_operation;
end
^

SET TERM ; ^

/*тригерр для проверки даты увольнения чтобы не раньше даты приема START_WORK*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER DISCHARGE_BI1000 FOR DISCHARGE
ACTIVE BEFORE INSERT POSITION 0
AS
declare variable p smallint;
begin
  /* Trigger text */
  P=0;
  select 1 from rdb$database where
  exists(select  START_WORK.ID from START_WORK  where (NEW.ID_START_WORK=START_WORK.ID)and(NEW.DT<START_WORK.DT))
  into :p;
  if (:p=1) then exception Uvoln_SW_incorrect_operation;
end
^

SET TERM ; ^

/*тригерр для проверки даты уничтожения криптосредства чтобы не раньше даты приема START_WORK*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER DELETE_MNI_BI1000 FOR DELETE_MNI
ACTIVE BEFORE INSERT POSITION 0
AS
declare variable p smallint;
begin
  /* Trigger text */
  P=0;
  select 1 from rdb$database where
  exists(select MNI.ID from MNI  where (NEW.ID_MNI=MNI.ID)and(NEW.DT<MNI.DT))
  into :p;
  if (:p=1) then exception del_mni_incorrect_operation;
end
^

SET TERM ; ^

/*тригерр для проверки даты уничтожения криптосредства чтобы не раньше даты приема START_WORK*/
SET TERM ^ ;

CREATE OR ALTER TRIGGER DELETE_KRIPTO_BI1000 FOR DELETE_KRIPTO
ACTIVE BEFORE INSERT POSITION 0
AS
declare variable p smallint;
begin
  /* Trigger text */
  P=0;
  select 1 from rdb$database where
  exists(select COPY_KRIPTO.ID from COPY_KRIPTO  where (NEW.ID_KRIPTO=COPY_KRIPTO.ID)and(NEW.DT<COPY_KRIPTO.DT))
  into :p;
  if (:p=1) then exception term_ck_incorrect_operation;
end
^

SET TERM ; ^


