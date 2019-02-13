/*скрипт для создания базы данных*/
/*Здесь создается база, создаются домены,*/
/*создаются генераторы и исключения*/
/*SET AUTODDL ON/OFF - авто подтверждение операторов*/
/*commit; - после каждой команды которая должна*/
/*выполниться, подтверждение операторов*/
/*последний commit; можно отменить с помощью rollback*/

/*создаем базу данных ptk_admin.fdb*/

/*подсоединяемся к базе*/
CONNECT "D:\MY_PROGRAMS\Project\PTK_ADMIN\BD\ptk_admin.fdb" USER "POLAGIN" PASSWORD "POLAGIN";
COMMIT;

/*создаем генератор для таблицы ЖУРНАЛ изменений МНИ для поля ID*/
/*CREATE GENERATOR GEN_CHANGE_SB_ID;
COMMIT;*/
/*Установим начальное значение генератора*/
/*SET GENERATOR GEN_CHANGE_SB_ID TO 0;
COMMIT;*/
/*Создаем исключения*/
/*создаем исключение для случая увольнение раньше чем принят на работу*/
CREATE EXCEPTION CK_incorrect_operation 'This is copy_kripto duble';
COMMIT;