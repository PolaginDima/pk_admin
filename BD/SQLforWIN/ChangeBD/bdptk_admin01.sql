/*скрипт для создания базы данных*/
/*Здесь создается база, создаются домены,*/
/*создаются генераторы и исключения*/
/*SET AUTODDL ON/OFF - авто подтверждение операторов*/
/*commit; - после каждой команды которая должна*/
/*выполниться, подтверждение операторов*/
/*последний commit; можно отменить с помощью rollback*/

/*создаем базу данных ptk_admin.fdb*/
/*подсоединяемся к базе*/
CONNECT "/mnt/work1/MY_CODING/LAZARUS/WORK/EDIT/Project/PTK_ADMIN/BD/PTK_ADMIN.FDB" USER "POLAGIN" PASSWORD "POLAGIN";
COMMIT;
