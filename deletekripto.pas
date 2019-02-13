unit deletekripto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, DBDateTimePicker, Forms, Controls,
  Graphics, Dialogs, StdCtrls, DbCtrls, DBGrids, ComCtrls, ActnList, Menus,
  lclproc, variants, workbd;

type

  { TdelKripto }

  TdelKripto = class(TForm)
    Aadding: TAction;
    ActionList1: TActionList;
    ADeleting: TAction;
    Asaveing: TAction;
    AUpdating: TAction;
    Button2: TButton;
    Button5: TButton;
    Button8: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource7: TDataSource;
    DBDateTimePicker1: TDBDateTimePicker;
    DBGrid1: TDBGrid;
    DBLookupComboBox4: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    PageControl1: TPageControl;
    PopupMenu1: TPopupMenu;
    SQLQuery1: TSQLQuery;
    SQLQuery1DOP: TStringField;
    SQLQuery1DT: TDateField;
    SQLQuery1DTR: TDateTimeField;
    SQLQuery1ID: TLongintField;
    SQLQuery1ID_KRIPTO: TLongintField;
    SQLQuery1ID_MOTIVE_DEL_KR: TLongintField;
    SQLQuery2: TSQLQuery;
    SQLQuery3: TSQLQuery;
    SQLQuery7: TSQLQuery;
    SQLQuery7DOCS: TBlobField;
    SQLQuery7ID: TLongintField;
    SQLQuery7NAME: TStringField;
    SQLQuery7NAMEDOCS: TStringField;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ToolBar5: TToolBar;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    procedure AaddingExecute(Sender: TObject);
    procedure ADeletingExecute(Sender: TObject);
    procedure AsaveingExecute(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
  private
    Fconnector: TMyworkbd;
    FconnectorWrite:TMyworkbd;
    Fexit:boolean;
    function savechange:boolean;
    { private declarations }
  public
    { public declarations }
    function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
  end;

var
  delKripto: TdelKripto;

implementation
uses  main;
{$R *.lfm}

{ TdelKripto }

procedure TdelKripto.FormCreate(Sender: TObject);
begin
  Fexit:=true;
end;

function TdelKripto.SetConnect(connector: TMyworkbd; tipQuery: TDataSetState;
  editing_id: integer): boolean;
var i:integer;
begin
  if (connector=nil)or(self.Fconnector<>nil)then exit;
  result:=false;
  self.Fconnector:=connector;
  //создадим подключение
  //*****************
     FconnectorWrite:=TMyworkbd.Create;
     self.Fconnector.copyParams(self,self.FconnectorWrite.connector);
     if (tipQuery=dsEdit)or(tipQuery=dsInsert)then
     FconnectorWrite.transaction.Params.Add('isc_tpb_nowait')
     else
       begin
         FconnectorWrite.transaction.Params.Add('isc_tpb_read');
         FconnectorWrite.transaction.Params.Add('isc_tpb_read_committed');
         FconnectorWrite.transaction.Params.Add('isc_tpb_nowait');
       end;
  //*****************

  //Подключим наборы к нашему подключению и транзакции
  //*****************
  if (tipQuery=dsBrowse) then
  begin
    for i:=0 to self.ComponentCount-1 do
    begin
         if (self.Components[i] is TSQLQuery)  then
         begin
           TSQLQuery(self.Components[i]).DataBase:=self.FconnectorWrite.connector;
         end;
         if (self.Components[i] is TSQLTransaction)  then
         begin
           TSQLTransaction(self.Components[i]).DataBase:=self.FconnectorWrite.connector;
         end;
    end;
  end else
  begin
       SQLQuery1.Transaction:=self.FconnectorWrite.transaction;
       sqlquery1.DataBase:=self.FconnectorWrite.connector;
       {SQLQuery4.Transaction:=self.FconnectorWrite.transaction;
       sqlquery4.DataBase:=self.FconnectorWrite.connector;}
       //к словарям подключу читающую транзакцию, чтобы по refresh можно было обновить их
       SQLQuery2.Transaction:=self.Fconnector.transaction;
       sqlquery2.DataBase:=self.Fconnector.connector;
       SQLQuery3.Transaction:=self.Fconnector.transaction;
       sqlquery3.DataBase:=self.Fconnector.connector;
       SQLQuery7.Transaction:=self.Fconnector.transaction;
       sqlquery7.DataBase:=self.Fconnector.connector;
  end;
  //*****************

  //Откроем наборы
  //***************
  sqlquery2.ParamByName('ID_KRIPTO').AsInteger:=editing_id;
  //sqlquery4.ParamByName('ID').AsInteger:=editing_id;
  sqlquery1.Open;
  sqlquery2.Open;
  sqlquery3.Open;
  //sqlquery4.Open;
  //***************

  //Позицируем набор если нужно
  //**********
  if (editing_id<>-1)
  and((tipQuery=dsBrowse)or(tipQuery=dsEdit))
  and(not sqlquery1.Locate('ID',editing_id,[])) then
  begin
    result:=false;
    self.FconnectorWrite.transaction.Rollback;
    exit;
  end;
  //**********

  // if not ((tipQuery=dsInsert)) then
 // begin
    sqlquery7.ParamByName('id_kripto').AsInteger:=editing_id;
    sqlquery7.Open;
  //end;

  //Переведем набор в нужное состояние
  //***************
  case tipQuery of
  dsBrowse:
    begin
         //просмотр
         //Заблокируем все контролы
       for i:=0 to self.ComponentCount-1 do
       begin
            if (self.Components[i] is TDBEdit) then  TDBEdit(self.Components[i]).ReadOnly:=true;
            if (self.Components[i] is TDBMemo) then  TDBMemo(self.Components[i]).ReadOnly:=true;
            if (self.Components[i] is TDBLookupComboBox) or
            (self.Components[i] is TDBDateTimePicker) or
            (self.Components[i] is TCheckBox) then  TWinControl(self.Components[i]).Enabled:=false;
       end;
       for i:=0 to self.ComponentCount-1 do
       begin
            if ((self.Components[i] is Tbutton) or
            (self.Components[i] is TToolButton)) and
            (TControl(self.Components[i]).Name<>'Button8')and
            (TControl(self.Components[i]).Name<>'ToolButton15')then TControl(self.Components[i]).Enabled:=false;
       end;
       self.Caption:='просмотр экземпляра криптосредства';//Заголовок
    end;
  dsEdit:
    begin
         //редактирование
           //Заблокируем запись
           /////////////
           //--------
           //делаем холостой update
           try
                  self.SQLQuery1.Edit;
                  self.SQLQuery1.FieldByName('ID').AsInteger:=self.SQLQuery1.FieldByName('ID').AsInteger;
                  self.SQLQuery1.Post;
                  self.SQLQuery1.ApplyUpdates;
           except
             on E: Exception do
             begin
                  self.SQLQuery1.CancelUpdates;
                  if (pos('concurrent transaction number',lowercase( e.message))>0) then
                  begin
                    MessageDlg('Ошибка','запись уже редактируется' +lineending+
                    'попробуйте повторить попытку позже',mtError,[mbOK],0);
                  end else   MessageDlg('Ошибка',e.Message,mtError,[mbOK],0);
                  result:=false;
                  exit;
             end;
           end;
           //--------
           /////////////
           sqlquery1.Edit;//Установим режим редактирования
           self.Caption:='редактирование экземпляра криптосредства';//Заголовок

           //Заблокируем все
           //**************
           for i:=0 to self.ComponentCount-1 do
           begin
                if (self.Components[i] is TDBEdit) then  TDBEdit(self.Components[i]).ReadOnly:=true;
                if (self.Components[i] is TDBMemo) then  TDBMemo(self.Components[i]).ReadOnly:=true;
                if (self.Components[i] is TDBLookupComboBox) or
                (self.Components[i] is TDBDateTimePicker) or
                (self.Components[i] is TCheckBox)or(self.Components[i] is Tbutton)or
                (self.Components[i] is TToolButton) then  TWinControl(self.Components[i]).Enabled:=false;
           end;
           //**************

           //Разблокируем только, то что нужно
           //******************
           button5.Enabled:=true;
           button8.Enabled:=true;
           toolbutton15.Enabled:=true;
           //*******************
    end;
  dsInsert:
    begin
         //Вставка
      self.Caption:='уничтожение экземпляра криптосредства';//Заголовок
      //Заблокируем возможность изменять присоединенные документы
      toolbutton14.Enabled:=false;
      toolbutton15.Enabled:=true;
      toolbutton16.Enabled:=false;
      dbmemo1.ReadOnly:=true;
      sqlquery1.Insert;
    end;
  end;
  //****************
  //Сдклаем активной первую вкладку
  pagecontrol1.ActivePage:=tabsheet1;
  result:=true;
end;

function TdelKripto.savechange: boolean;
var
  Q:TSQLQuery;
  T:TSQLTransaction;
  txtsert:string;
  del:boolean;
  ID_MOTIVE_DEL_KR:integer;
  DT:TDate;
  ID_MNI:string;
begin
  result:=false;
  del:=false;
  try
         if not (sqlquery1.Modified) then exit;
         //Проверим есть ли еще криптопро с такими хар-ми, но др. сертификатами
         Q:=TSQLQuery.Create(self);
         T:=TSQLTransaction.Create(self);
         Q.Transaction:=t;
         T.DataBase:=self.SQLQuery2.DataBase;
         Q.DataBase:=self.SQLQuery2.DataBase;
         Q.SQL.Clear;
         if sqlquery2.FieldByName('ID_MNI').IsNull then ID_MNI:='ID_MNI is NULL'
         else ID_MNI:='ID_MNI='+sqlquery2.FieldByName('ID_MNI').AsString;
         Q.SQL.Add('select COPY_KRIPTO.ID as ID,'+lineending+
         'SERTIFIKATS.NAME as sNAME from COPY_KRIPTO '+lineending+
         'left join SERTIFIKATS on (SERTIFIKATS.ID=COPY_KRIPTO.ID_SERTIFIKATS)'+lineending+
         'where (COPY_KRIPTO.ID<>'+sqlquery2.FieldByName('ID').AsString+')and('+
         ID_MNI+
         ')and(ID_KRIPTO='+sqlquery2.FieldByName('ID_KRIPTO').AsString+')and(COPY_KRIPTO.ID_START_WORK='+
         sqlquery2.FieldByName('ID_START_WORK').AsString+')and(COPY_KRIPTO.SERIAL='''+sqlquery2.FieldByName('SERIAL').AsString
         +''')and(ID_SB='+sqlquery2.FieldByName('ID_SB').AsString+')'+lineending+
         'and(not exists(select ID from DELETE_KRIPTO where (DELETE_KRIPTO.ID_KRIPTO=COPY_KRIPTO.ID)))');
         //showmessage(q.SQL.Text);
         Q.Open;
         if not q.IsEmpty then
         begin
           q.First;
           txtsert:='';
           while not q.EOF do
           begin
             txtsert:=txtsert+q.FieldByName('sNAME').AsString+lineending;
             q.Next;
           end;
           //q.First;q.Last;q.First;
           case QuestionDlg('удаление криптосредства',
           'Найдено еще '+inttostr(Q.RecordCount)+' криптосредств с такими же учетными'+lineending+
           'данными, отличающиеся только сертификатом! '+lineending+
           txtsert+lineending+
           'Их тоже удалить?'
           , mtConfirmation,[mrYes,'Удалить',mrNo,'Оставить','isdefault'],'') of
           mryes:
             begin
               del:=true;
             end;
           end;
         end;
         //exit;
         //-------------
           //------------------
         //Если добавление
          if (sqlquery1.State=db.dsInsert) then
          begin
              ID_MOTIVE_DEL_KR:=sqlquery1.FieldByName('ID_MOTIVE_DEL_KR').AsInteger;
              DT:=sqlquery1.FieldByName('DT').AsDateTime;
              sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_DEL_KRIPTO_ID', sqlquery1.DataBase);
              sqlquery1.FieldByName('id_kripto').AsInteger:=sqlquery2.FieldByName('ID').AsInteger;
              sqlquery1.Post;
              sqlquery1.ApplyUpdates;

              {if sqlquery4.Locate('ID',sqlquery2.FieldByName('ID').AsString,[]) then
              begin
                sqlquery4.Edit;
                sqlquery4.FieldByName('HIDE').AsBoolean:=(not sqlquery1.FieldByName('DT').IsNull);
                sqlquery4.Post;
                sqlquery4.ApplyUpdates;
              end;}

              if del then
              begin
                q.First;
                while not q.EOF do
                begin
                  sqlquery1.Insert;
                  sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_DEL_KRIPTO_ID', sqlquery1.DataBase);
                  sqlquery1.FieldByName('id_kripto').AsInteger:=q.FieldByName('ID').AsInteger;
                  sqlquery1.FieldByName('ID_MOTIVE_DEL_KR').AsInteger:=ID_MOTIVE_DEL_KR;
                  sqlquery1.FieldByName('DT').AsDateTime:=DT;
                  sqlquery1.Post;
                  sqlquery1.ApplyUpdates;
                     {if sqlquery4.Locate('ID',q.FieldByName('ID').AsString,[]) then
                     begin
                       sqlquery4.Edit;
                       sqlquery4.FieldByName('HIDE').AsBoolean:=true;
                       sqlquery4.Post;
                       sqlquery4.ApplyUpdates;
                     end;}
                  q.Next;
                end;
              end
          end;

          self.FconnectorWrite.transaction.Commit;
          result:=true;
  except
    on E: Exception do
      begin
           result:=false;
           if (pos('term_ck_incorrect_operation',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','Нельзя уничтожить раньше'+lineending+
              'чем зарегистрировано криптосредство',mtInformation,[mbOK],0)
            end else  MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
      end;
  end;
end;

procedure TdelKripto.Button5Click(Sender: TObject);
begin
  Fexit:= savechange;
end;

procedure TdelKripto.AaddingExecute(Sender: TObject);
var od:topendialog;
  fname:string;
  qq:tsqlquery;
  SCRIPT:TSQLScript;
  stmp:string;
  ms:TFileStream;
begin
  stmp:='';
  od:=topendialog.Create(self.Owner);
  od.Filter:='изображение|*.jpg;*gif;*tiff|документ|*.doc;*.docx;*.xls;*.xlsx;*.rtf;*.odt;*.ods';
  if not  od.Execute then exit;
  fname:=ExtractFileName(od.FileName);
  qq:=tsqlquery.Create(self);
  qq.DataBase:=sqlquery1.DataBase;
  qq.Transaction:=self.FconnectorWrite.transaction;
  qq.SQL.Clear;
  qq.SQL.Add('select * from SVIAZ_KRIPTO_DOCS');
  qq.Open;
  qq.Insert;
  qq.FieldByName('ID').Value :=CreateGUID('GEN_DOCS_ID', qq.DataBase);
   if DirectoryExists('D:\TMP') then
   begin
  if fileexists('D:\TMP\111.ltmp') then  deletefile('D:\TMP\111.ltmp');
   end  else
   begin
     CreateDir('D:\TMP');
   end;
  copyfile(od.FileName,'D:\TMP\111.ltmp',true);
  ms:=TFileStream.Create('D:\TMP\111.ltmp',fmopenread);
  if (ms.Size/(1048576))>2 then
  begin
    MessageDlg('Ошибка','Слишком большой размер файла',mtError,[mbOK],0);
    ms.Free;
    qq.Cancel;
    qq.Close;
    qq.Free;
    od.Free;
    exit;
  end else if (ms.Size/(1048576))>0.5 then
  begin
    MessageDlg('Предупреждение','рекомендуемый размер файлов до 0.5Мб',mtInformation,[mbOK],0);
  end;
  ms.Free;
  tblobfield(qq.FieldByName('docs')).LoadFromFile(od.FileName);
  if not InputQuery('имя документа','Введите краткое'+
  lineending+'наименование документа',stmp) then
  begin
    qq.Free;
    od.Free;
    exit;
  end;
  qq.FieldByName('name').Value:=stmp;
  qq.FieldByName('namedocs').Value:=fname;
  qq.FieldByName('ID_KRIPTO').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
  qq.Post;
  qq.ApplyUpdates;
  self.FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Refresh;
  qq.Free;
  od.Free;
  if fileexists('D:\TMP\111.ltmp') then  deletefile('D:\TMP\111.ltmp');
end;

procedure TdelKripto.ADeletingExecute(Sender: TObject);
var SCRIPT:TSQLScript;
begin
  if sqlquery7.IsEmpty then exit;
   script:=tsqlscript.Create(self);
  script.DataBase:=sqlquery1.DataBase;
  script.Transaction:=self.FconnectorWrite.transaction;
  script.CommentsInSQL:=false;
  script.UseSetTerm:=true;
  script.Script.Clear;
  script.Script.Add('delete from SVIAZ_KRIPTO_DOCS where (ID='+sqlquery7.FieldByName('ID').AsString+');');
  script.Script.Add('commit;');
  script.Execute;
  self.FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Refresh;
  script.Free;
end;

procedure TdelKripto.AsaveingExecute(Sender: TObject);
var sd:tsavedialog;
begin
  if sqlquery7.IsEmpty then exit;
     sd:=tsavedialog.Create(self.Owner);
     sd.Filter:='|*.*';
     sd.FileName:=sqlquery7.FieldByName('nameDOCS').AsString;
  if not  sd.Execute then exit;
  tblobfield(sqlquery7.FieldByName('DOCS')).SaveToFile(sd.FileName);
  sd.Free;
end;

procedure TdelKripto.Button2Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openMOTIVEDELKRIPTO(true);
   sqlquery3.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_MOTIVE_DEL_KR').AsInteger:=nRec;
end;

procedure TdelKripto.Button8Click(Sender: TObject);
begin
  sqlquery1.Cancel;
end;

procedure TdelKripto.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Commit;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TdelKripto.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

end.

