/*Здесь в базу добавляются процедурыы*/
/*Процедура выводит все MNI*/

/*SET TERM ^ ;
CREATE OR ALTER PROCEDURE GET_SLOVAR_PEOPLES 
RETURNS (
    ID integer,
    FAM FIO,
    NAM FIO,
    OTCH FIO,
    DTB DATE,
    VOZR integer,
    PLB VARCHAR(255),
    REGISTRATION VARCHAR(255),
    LASTWORK integer)
AS
BEGIN

for select PEOPLES.ID as ID, PEOPLES.FAM as FAM, PEOPLES.NAM, PEOPLES.OTCH, PEOPLES.DTB as DTB, datediff(year from cast (DTB as date) to current_date) AS VOZR, PEOPLES.PLB as PLB, PEOPLES.REGISTRATION as REGISTRATION, count(WORKS.ID) as LASTWORK 
from  PEOPLES left join WORKS on (PEOPLES.ID=WORKS.ID_PEOPLES) group by ID, FAM, NAM, OTCH, DTB, VOZR, PLB, REGISTRATION order by PEOPLES.fam, PEOPLES.nam, PEOPLES.otch
into :ID, :FAM, :NAM, :OTCH, :DTB, :VOZR, :PLB, :REGISTRATION, :LASTWORK
DO SUSPEND;
END^
SET TERM ; ^
*/

/*Процедура создает роли*/
/*
SET TERM ^ ;
CREATE OR ALTER PROCEDURE CreateRole
AS
DECLARE VARIABLE STMP VARCHAR(255);
BEGIN
/*назначаем роли привелегии на процедуры*/
STMP='GRANT EXECUTE ON PROCEDURE GET_SLOVAR_PEOPLES TO administrator;';
EXECUTE STATEMENT STMP;
END^
SET TERM ; ^
*/                       
