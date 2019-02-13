unit workBD;
//Для работы с базой данных
//Основные процедуры и функции для работы с БД
{$mode objfpc}{$H+}

interface

uses
  fileutil, Classes, SysUtils, sqldb,ibconnection{, fbadmin}, Dialogs,db,
  menus,controls, Forms;
type
  PDostup=^TDostup;
  TDostup=record
    Role:string[20];
    User_ID:integer;
    Table:string[30];
    dostup:integer;
    Next:PDostup;
  end;
type
{ TMyMemQuery }




TMyMemQuery=class

  //Для хранения значений сполей
  type
  PMyList=^TMyList;
  TMyList=record
    atmp:array of variant;
    nameQuery:string;
    state: TDataSetState;
    next:PMyList;
  end;

  //Для хранения состояния наборов
  type
  PMyListQ=^TMyListQ;
  TMyListQ=record
    nameQuery:string;
    next:PMyListQ;
    end;

  private
    pHead, PCurrent:PMyList;
    PHeadQ, PCurrQ:PMyListQ;
    procedure ClearMemField;
  public
    procedure SaveMemField(Sender:TForm);//Сохранение значений полей
    procedure LoadMemField(Sender:TForm);//Восстановление значений полей
    procedure ActivateQuery(Sender:TForm);//Активация наборов, только тех которые были активны при DeActivateQuery
    procedure DeActivateQuery(Sender:TForm;rollbackTransaction:boolean=true);//Деактивация наборов
    destructor destroy;override;
end;

{ TMyworkbd }

TMyworkbd = class(Tobject)
private
       Fconnector:TSQLConnector;
       Ftransaction:TSQLTransaction;
public
      function connectBD:boolean;
      procedure copyParams(sender:TObject;outConn:TSQLConnector);
      constructor Create;
      destructor Destroy;override;
      //procedure InitializationClass;
      property connector:TSQLConnector read Fconnector write Fconnector;
      property transaction:TSQLTransaction read Ftransaction write Ftransaction;
end;

 function conconnBD(conn:tsqlconnector):boolean;
 function CreateGUID(generator: string; DB:TDataBase):integer;
 procedure SetGUID(generator: string; DB:TDataBase;NumberAkt:string);
 function GET_NUMBER_AKT(doc: string; DB:TDataBase):integer;
 function GET_NUMBER_AKT_CURR(doc: string; DB:TDataBase):integer;
 procedure Create_GEN_AKT(doc: string;DB: TDataBase);
 //procedure SET_GEN_AKT(doc: string;DB: TDataBase;NumberAkt:integer);
 procedure SET_NUMBER_AKT(doc: string; DB:TDataBase;NumberAkt:integer);
 procedure Zapolnenie(generator, IDPole:string;Q:TSQLQuery);
 procedure Zapolnenie2(generator, IDPole:string;Q:TSQLQuery);
 var //connector:tsqlconnector;
   id_raion,id_user:integer;
   rrrole:string;
   aDostup:array of TDostup;
   pHeadDostup,pCurrentDostup:PDostup;
implementation
//uses main;

//Пытаемся соединиться, при неудаче сигнализируем
function conconnBD(conn: tsqlconnector): boolean;
begin
     try
           conn.Connected:=true;
           result:=true;
     except
      on I: EIBDatabaseError do
      begin
         if  (I.ErrorCode=335544323) and (pos('is not a valid database',i.message)>0) then
         begin
              MessageDlg  ('','база данных повреждена!', mtWarning, [mbOk], 0);
         end;
         if  (I.ErrorCode=335544344) and (pos('I/O error',i.message)>0) then
         begin
              showmessage('база данных не может быть прочитана');
         end;
      end;
       on E: Exception do
       begin
        MessageDlg('Предупреждение','Ошибка'+lineending+
        'Exception: '+E.ClassName+': '+E.Message+LineEnding+
        'Операция отменена.', mtError, [mbOk],0);
        exit(false);
       end;
     end;
end;

function CreateGUID(generator: string; DB: TDataBase): integer;
var SQLQUERY:TSQLQuery;
  SQLTransaction:TSQLTransaction;
begin
     //Получим значение ID
  sqlquery:=tsqlquery.Create(nil);
  SQLTransaction:=tSQLTransaction.Create(nil);
  SQLTransaction.DataBase:=db;
  sqlquery.DataBase:=db;
  sqlquery.Transaction:=SQLTransaction;
  sqlquery.SQL.Clear;
  sqlquery.SQL.Add('select * from CreateID('''+generator+''')'); //GEN_ID_ - имя генератора
  sqlquery.Open;
  result:=sqlquery.Fields.Fields[0].AsInteger;
  sqlquery.Close;
  sqltransaction.Commit;
  sqltransaction.Free;
  sqlquery.Free;
end;

procedure SetGUID(generator: string; DB: TDataBase; NumberAkt: string);
var SQLQUERY:TSQLQuery;
  SQLTransaction:TSQLTransaction;
begin
     //Получим значение ID
  sqlquery:=tsqlquery.Create(nil);
  SQLTransaction:=tSQLTransaction.Create(nil);
  SQLTransaction.DataBase:=db;
  sqlquery.DataBase:=db;
  sqlquery.Transaction:=SQLTransaction;
  sqlquery.SQL.Clear;
  //sqlquery.SQL.Add('select GEN_ID('+generator+',-3) from rdb$database'); //GEN_ID_ - имя генератора
  sqlquery.SQL.Add('select GEN_ID('+generator+',-gen_id('+generator+',1)+'+NumberAkt+') from rdb$database'); //GEN_ID_ - имя генератора
  sqlquery.Open;
  //result:=sqlquery.Fields.Fields[0].AsInteger;
  sqlquery.Close;
  sqltransaction.Commit;
  sqltransaction.Free;
  sqlquery.Free;
end;

function GET_NUMBER_AKT(doc: string; DB: TDataBase): integer;
var SQLQUERY:TSQLQuery;
  SQLTransaction:TSQLTransaction;
  //NA:integer;
begin
     //Получим значение ID
  sqlquery:=tsqlquery.Create(nil);
  SQLTransaction:=tSQLTransaction.Create(nil);
  SQLTransaction.DataBase:=db;
  sqlquery.DataBase:=db;
  sqlquery.Transaction:=SQLTransaction;
  sqlquery.SQL.Clear;
  //sqlquery.SQL.Add('select 1 from rdb$database where exists(select * from NUMBER_AKT where (name='''+doc+''')and(ID_RAION='+inttostr(id_raion)+'))'); //doc - к какому документу номер
  sqlquery.SQL.Add('select gen_id(GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user)+',1) from rdb$database'); //doc - к какому документу номер, id_user - идетификатор пользователя
  try
  sqlquery.Open;
  except
    {on E: Exception do
    begin
     if (pos('concurrent transaction number',lowercase( e.message))>0) then
                  begin
                    MessageDlg('Ошибка','запись уже редактируется' +lineending+
                    'попробуйте повторить попытку позже',mtError,[mbOK],0);
                  end else   MessageDlg('Ошибка',e.Message,mtError,[mbOK],0);
    end;  }
    on I: EIBDatabaseError do
    begin
       if  (I.ErrorCode=335544343) and (pos('not defined',i.message)>0) then
       Create_GEN_AKT(doc,db);
       try
          sqltransaction.Rollback;
          sqlquery.Open;
       except
         messagedlg('ошибка','Не удалось создать генератор GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user),mtError,[mbok],0);
         application.Terminate;
         exit;
       end;
    end;
  end;
  result:=sqlquery.Fields.Fields[0].AsInteger;

  {if sqlquery.IsEmpty then
  begin
    create_number_akt(doc,db);
    NA:=0;
    sqltransaction.Commit;
  end else
  begin
    sqltransaction.Commit;
    sqlquery.SQL.Clear;
    sqlquery.SQL.Add('select NUMBER_AKT as NA from  NUMBER_AKT where ((name='''+doc+''')and(id_raion='+inttostr(id_raion)+'))'); //doc - к какому документу номер
    sqlquery.Open;
    //NA:=sqlquery.Fields.FieldByName('NA').AsInteger;
    NA:=sqlquery.Fields.Fields[0].AsInteger;
  end;
  sqlquery.SQL.Clear;
  sqlquery.SQL.Add('UPDATE NUMBER_AKT SET NUMBER_AKT.NUMBER_AKT='+inttostr(NA+1)+' WHERE (NAME='''+doc+''')and(ID_RAION='+inttostr(id_raion)+')' ); //doc - к какому документу номер
  {sqlquery.SQL.Add('UPDATE or insert into NUMBER_AKT(NUMBER_AKT,ID_RAION,NAME) values('+
  'NUMBER_AKT+1,'+inttostr(id_raion)+','''+doc+''') matching (ID_RAION,NAME) RETURNING NUMBER_AKT' ); //doc - к какому документу номер}
  //showmessage(sqlquery.SQL.Text);
  sqlquery.ExecSQL;
  result:=NA+1; }
  //sqlquery.Close;
  sqltransaction.Commit;
  sqltransaction.Free;
  sqlquery.Free;
end;

function GET_NUMBER_AKT_CURR(doc: string; DB: TDataBase): integer;
var SQLQUERY:TSQLQuery;
  SQLTransaction:TSQLTransaction;
begin
     //Получим значение ID
  sqlquery:=tsqlquery.Create(nil);
  SQLTransaction:=tSQLTransaction.Create(nil);
  SQLTransaction.DataBase:=db;
  sqlquery.DataBase:=db;
  sqlquery.Transaction:=SQLTransaction;
  sqlquery.SQL.Clear;
  sqlquery.SQL.Add('select gen_id(GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user)+',0) from rdb$database'); //doc - к какому документу номер, id_user - идетификатор пользователя
  try
  sqlquery.Open;
  except
    on I: EIBDatabaseError do
    begin
       if  (I.ErrorCode=335544343) and (pos('not defined',i.message)>0) then
       Create_GEN_AKT(doc,db);
       try
          sqltransaction.Rollback;
          sqlquery.Open;
       except
         messagedlg('ошибка','Не удалось создать генератор GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user),mtError,[mbok],0);
         application.Terminate;
         exit;
       end;
    end;
  end;
  result:=sqlquery.Fields.Fields[0].AsInteger+1;
  sqltransaction.Commit;
  sqltransaction.Free;
  sqlquery.Free;
end;

procedure Create_GEN_AKT(doc: string; DB: TDataBase);
var SCRIPT:TSQLScript;
  SQLTransaction:TSQLTransaction;
begin
  script:=tsqlscript.Create(nil);
  SQLTransaction:=tSQLTransaction.Create(nil);
  SQLTransaction.DataBase:=db;
  script.DataBase:=db;
  script.Transaction:=SQLTransaction;
  script.CommentsInSQL:=false;
  script.UseSetTerm:=true;
  script.Script.Clear;
  script.Script.Add('create generator GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user)+';');
  script.Script.Add('set generator GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user)+' to 0;');
  script.Execute;
  SQLTransaction.Commit;
end;

{procedure SET_GEN_AKT(doc: string; DB: TDataBase; NumberAkt: integer);
  var SCRIPT:TSQLScript;
  SQLTransaction:TSQLTransaction;
begin
  script:=tsqlscript.Create(nil);
  SQLTransaction:=tSQLTransaction.Create(nil);
  SQLTransaction.DataBase:=db;
  script.DataBase:=db;
  script.Transaction:=SQLTransaction;
  script.CommentsInSQL:=false;
  script.UseSetTerm:=true;
  script.Script.Clear;
  //script.Script.Add('create generator GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user)+';');
  try
     script.Script.Add('set generator GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user)+' to '+inttostr(NumberAkt)+';');
     script.Execute;
  except
    {on E: Exception do
    begin
     if (pos('concurrent transaction number',lowercase( e.message))>0) then
                  begin
                    MessageDlg('Ошибка','запись уже редактируется' +lineending+
                    'попробуйте повторить попытку позже',mtError,[mbOK],0);
                  end else   MessageDlg('Ошибка',e.Message,mtError,[mbOK],0);
    end;}
    on I: EIBDatabaseError do
    begin
     //showmessage(inttostr(I.GDSErrorcode));exit;
       if  (I.GDSErrorcode=335544343) and (pos('not defined',i.message)>0) then
       Create_GEN_AKT(doc,db);
       try
          script.Script.Add('set generator GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user)+' to '+inttostr(NumberAkt)+';');
          script.Execute
       except
         messagedlg('ошибка','Не удалось создать генератор GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user),mtError,[mbok],0);
         application.Terminate;
         exit;
       end;
    end;
  end;
  SQLTransaction.Commit;
end;  }

procedure SET_NUMBER_AKT(doc: string; DB: TDataBase; NumberAkt: integer);
  var SCRIPT:TSQLScript;
  SQLTransaction:TSQLTransaction;
begin
  script:=tsqlscript.Create(nil);
  SQLTransaction:=tSQLTransaction.Create(nil);
  SQLTransaction.DataBase:=db;
  script.DataBase:=db;
  script.Transaction:=SQLTransaction;
  script.CommentsInSQL:=false;
  script.UseSetTerm:=true;
  script.Script.Clear;
  //script.Script.Add('create generator GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user)+';');
  try
     script.Script.Add('set generator GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user)+' to '+inttostr(NumberAkt)+';');
     script.Execute;
  except
    {on E: Exception do
    begin
     if (pos('concurrent transaction number',lowercase( e.message))>0) then
                  begin
                    MessageDlg('Ошибка','запись уже редактируется' +lineending+
                    'попробуйте повторить попытку позже',mtError,[mbOK],0);
                  end else   MessageDlg('Ошибка',e.Message,mtError,[mbOK],0);
    end;}
    on I: EIBDatabaseError do
    begin
     //showmessage(inttostr(I.GDSErrorcode));exit;
       if  (I.ErrorCode=335544343) and (pos('not defined',i.message)>0) then
       Create_GEN_AKT(doc,db);
       try
          script.Script.Add('set generator GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user)+' to '+inttostr(NumberAkt)+';');
          script.Execute
       except
         messagedlg('ошибка','Не удалось создать генератор GEN_NUMBER_AKT_'+doc+'_user_'+inttostr(id_user),mtError,[mbok],0);
         application.Terminate;
         exit;
       end;
    end;
  end;
  SQLTransaction.Commit;
end;

procedure Zapolnenie(generator, IDPole: string; Q: TSQLQuery);
var
  Fld:TField;
  //i:integer;
begin
     Q.FieldByName(IDPole).AsInteger:= CreateGUID(generator,q.DataBase);
     //for i:=0 to q.Fields.Count do showmessage(q.Fields.Fields[i].Name);
     fld:=q.FindField('ID_USER');
     if fld<>nil then fld.AsInteger:=id_user;
     fld:=q.FindField('id_raion');
     if fld<>nil then fld.AsInteger:=id_raion;
end;

procedure Zapolnenie2(generator, IDPole: string; Q: TSQLQuery);
var //stmp:string;
  Fld:TField;
begin
     //stmp:=copy(IDPole,1, pos(',',IDPole)-1);
     Q.FieldByName(copy(IDPole,1, pos(',',IDPole)-1)).AsInteger:= CreateGUID(generator,q.DataBase);
     //showmessage(Q.SQL.Text);
     Q.FieldByName('ID_PEOPLE').AsInteger:=strtoint( copy(IDPole, pos(',',IDPole)+1,length(IDPole)-pos(',',IDPole)+1));
     fld:=q.FindField('id_user');
     if fld<>nil then fld.AsInteger:=id_user;
     fld:=q.FindField('id_raion');
     if fld<>nil then fld.AsInteger:=id_raion;
end;

{ TMyworkbd }

function TMyworkbd.connectBD: boolean;
begin
     try
           connector.Connected:=true;
           result:=true;
     except
      on I: EIBDatabaseError do
      begin
         if  (I.ErrorCode=335544323) and (pos('is not a valid database',i.message)>0) then
         begin
              MessageDlg  ('','база данных повреждена!', mtWarning, [mbOk], 0);
         end;
         if  (I.ErrorCode=335544344) and (pos('I/O error',i.message)>0) then
         begin
              showmessage('база данных не может быть прочитана');
         end;
         exit(false);
      end;
       on E: Exception do
       begin
        MessageDlg('Предупреждение','Ошибка'+lineending+
        'Exception: '+E.ClassName+': '+E.Message+LineEnding+
        'Операция отменена.', mtError, [mbOk],0);
        exit(false);
       end;
     end;
end;

procedure TMyworkbd.copyParams(sender: TObject; outConn: TSQLConnector);
begin
     outConn.CharSet:=self.Fconnector.CharSet;
     outConn.ConnectorType:=self.Fconnector.ConnectorType;
     outConn.HostName:=self.Fconnector.HostName;
     outConn.Options:=self.Fconnector.Options;
     outConn.Password:=self.Fconnector.Password;
     outConn.Role:=self.Fconnector.Role;
     outConn.UserName:=self.Fconnector.UserName;
     outConn.DatabaseName:=self.Fconnector.DatabaseName;
     outConn.Params:=self.Fconnector.Params;
     outConn.KeepConnection:=self.Fconnector.KeepConnection;
     outConn.LogEvents:=self.Fconnector.LogEvents;
     outConn.LoginPrompt:=self.Fconnector.LoginPrompt;
end;

constructor TMyworkbd.Create;
begin
  inherited Create;
  Ftransaction:=TSQLTransaction.Create(nil);
  Fconnector:=TSQLConnector.Create(nil);
  Fconnector.Transaction:=self.Ftransaction;
  Ftransaction.DataBase:=self.Fconnector;
end;

destructor TMyworkbd.Destroy;
begin
  Fconnector.Free;
  Ftransaction.Free;
  inherited Destroy;
end;

{procedure TMyworkbd.InitializationClass;
begin
  self.Fconnector.Transaction:=self.Ftransaction;
  self.Ftransaction.DataBase:=self.Fconnector;
end; }

{ TMyMemQuery }

procedure TMyMemQuery.ClearMemField;
begin
  while PHead<>nil do
  begin
       //Освободим память
         PHead^.atmp:=nil;
         finalize(PHead^.atmp);
         PCurrent:=PHead;
         PHead:=PHead^.next;
         dispose(PCurrent);
  end;
  PHead:=nil;
end;

procedure TMyMemQuery.SaveMemField(Sender: TForm);
var
  i, j:integer;
begin
  self.ClearMemField;
  PHead:=nil;PCurrent:=nil;
  //Сохраним состяния наборов
  //и значения полей, только тех который в состоянии редактирования
  //или состоянии вставки
  for i:=0 to Sender.ComponentCount-1 do
  begin
       if (Sender.Components[i] is TSQLQuery)and
       ((TSQLQuery(Sender.Components[i]).State=dsEdit)or
       (TSQLQuery(Sender.Components[i]).State=dsInsert))then
       begin
         //выделим память для хранения состояния и значений полей
         new(PCurrent);
         //сохраним указатель на следующий элемент списка
         PCurrent^.next:=PHead;
         //Сохраним состояние набора
         PCurrent^.state:=TSQLQuery(Sender.Components[i]).State;
         //Запомним имя набора
         PCurrent^.nameQuery:=TSQLQuery(Sender.Components[i]).Name;
         //Выделим память для динамического массива
         setlength(PCurrent^.atmp,TSQLQuery(Sender.Components[i]).Fields.Count);
         //Теперь сохраним значения полей
         for j:=0 to TSQLQuery(Sender.Components[i]).Fields.Count-1 do
         begin
           PCurrent^.atmp[j]:=TSQLQuery(Sender.Components[i]).Fields.Fields[j].Value;
         end;
         PHead:=PCurrent;
       end;
  end;
end;

procedure TMyMemQuery.LoadMemField(Sender: TForm);
var
  i, j:integer;
begin
  //восстановим состояние наборов данных
    for i:=Sender.ComponentCount-1 downto 0 do
    begin
      if (Sender.Components[i] is TSQLQuery)and(TSQLQuery(Sender.Components[i]).Name=PHead^.nameQuery) then
      begin
        //Откроем, если необходимо
        if TSQLQuery(Sender.Components[i]).State=dsInactive then TSQLQuery(Sender.Components[i]).Open;
        //восстановим состояние
        if (PHead^.state=dsEdit) then   TSQLQuery(Sender.Components[i]).Edit
        else TSQLQuery(Sender.Components[i]).Insert;
        //восстановим значение полей
        for j:=0 to TSQLQuery(Sender.Components[i]).Fields.Count-1 do
         begin
           TSQLQuery(Sender.Components[i]).Fields.Fields[j].Value:=PHead^.atmp[j];
         end;
        //Освободим память
         PHead^.atmp:=nil;
         finalize(PHead^.atmp);
         PCurrent:=PHead;
         PHead:=PHead^.next;
         dispose(PCurrent);
         PCurrent:=nil;
      end;
    end;
    PHead:=nil;
    //подчищаем на всякий случай
    self.ClearMemField;
end;

procedure TMyMemQuery.ActivateQuery(Sender: TForm);
var i:integer;
begin
  //Откроем наборы данных, только те, которые были открыты на момент выполнения  DeActivateQuery
  for i:=0 to Sender.ComponentCount-1 do
  begin
        if (Sender.Components[i] is TSQLQuery)and
       (not (TSQLQuery(Sender.Components[i]).State=dsInactive)) and
       (TSQLQuery(Sender.Components[i]).Name=PHead^.nameQuery) then
       begin
         TSQLQuery(Sender.Components[i]).Open;
         PCurrQ:=PHeadQ;
         PHeadQ:=PHeadQ^.next;
         //Освободим память
         dispose(PCurrQ);
       end;
  end;
  PCurrQ:=nil;
  PHeadQ:=nil;
end;

procedure TMyMemQuery.DeActivateQuery(Sender: TForm;
  rollbackTransaction: boolean);
var i:integer;
  pH:PMyListQ;
begin
  PHeadQ:=nil;PCurrQ:=nil;pH:=nil;
  //Отменим все операции в наборах и
  //Закроем все наборы
   for i:=0 to Sender.ComponentCount-1 do
  begin
   //Смотрим только не закрытые наборы
       if (Sender.Components[i] is TSQLQuery)and
       (not (TSQLQuery(Sender.Components[i]).State=dsInactive)) then
       begin
         //Запомним название набора
         //Выделим память для хранения названия и ссылки
         new(PCurrQ);
         if PHeadQ<>nil then PHeadQ^.next:=PCurrQ else pH:=PCurrQ;
         PCurrQ^.next:=nil;
         PCurrQ^.nameQuery:=TSQLQuery(Sender.Components[i]).Name;
         TSQLQuery(Sender.Components[i]).Cancel;
         TSQLQuery(Sender.Components[i]).Close;
         PHeadQ:=PCurrQ;
       end;
  end;
   PHeadQ:=pH;
  if rollbackTransaction then
  //Сделаем откат транзакций
  begin
    for i:=0 to Sender.ComponentCount-1 do
  begin
       if (Sender.Components[i] is TSQLtransaction)  then
       begin
         TSQLtransaction(Sender.Components[i]).Rollback;
       end;
  end;
  end;
end;

destructor TMyMemQuery.destroy;
begin
  inherited;
  ClearMemField;
end;

end.

