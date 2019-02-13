unit uvolnenieEmployee;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, DBDateTimePicker, Forms, Controls,
  Graphics, Dialogs, StdCtrls, DbCtrls, DBGrids, ComCtrls, ActnList, Menus,
  lclproc, workbd;

type

  { TuvolnEmpl }

  TuvolnEmpl = class(TForm)
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
    ImageList1: TImageList;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    PageControl1: TPageControl;
    PopupMenu1: TPopupMenu;
    SQLQuery1: TSQLQuery;
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
    FconnectorWrite:TMyworkbd;
    Fconnector: TMyworkbd;
    Fexit:boolean;
    function savechange:boolean;
    function Check_(id:integer):integer;
    function CheckDel(id_sw:integer):boolean;
    { private declarations }
  public
    { public declarations }
    function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
  end;

var
  uvolnEmpl: TuvolnEmpl;

implementation
uses  main;
{$R *.lfm}

{ TuvolnEmpl }

procedure TuvolnEmpl.FormCreate(Sender: TObject);
begin
  Fexit:=true;
end;

function TuvolnEmpl.savechange: boolean;
begin
  result:=false;
  try
     if not (sqlquery1.Modified) then exit;
           //------------------
         //Если добавление
          if (sqlquery1.State=db.dsInsert) then
          begin
              sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_DISCH_ID', sqlquery1.DataBase);
              sqlquery1.FieldByName('id_START_WORK').AsInteger:=sqlquery2.FieldByName('ID_SW').AsInteger;
              {sqlquery1.FieldByName('id_raion').Value:=id_raion;
              sqlquery1.FieldByName('id_user').Value:=id_user; }
          end;
          {sqlquery4.Edit;
          sqlquery4.FieldByName('HIDE').AsBoolean:=(not sqlquery1.FieldByName('DT').IsNull);}
          sqlquery1.Post;
          sqlquery1.ApplyUpdates;
          {sqlquery4.Post;
          sqlquery4.ApplyUpdates;}
          result:=true;
          self.FconnectorWrite.transaction.Commit;
  except
    on E: Exception do
      begin
           result:=false;
           if (pos('uvoln_sw_incorrect_operation',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','Нельзя уволить раньше'+lineending+
              'чем принят на работу',mtInformation,[mbOK],0)
            end else  MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
      end;
  end;
end;

function TuvolnEmpl.Check_(id: integer): integer;
var qq:TSQLQuery;
begin
  result:=-1;
  qq:=tsqlquery.Create(self);
  qq.DataBase:=sqlquery1.DataBase;
  qq.Transaction:=self.Fconnector.transaction;
  qq.SQL.Clear;
  qq.SQL.Add('select * from check_sw('+inttostr(id)+')');
  qq.Open;
  if not qq.IsEmpty then
  result:=qq.FieldByName('EXISTS_RESULT').AsInteger;
  qq.Close;
  qq.Free;
end;

function TuvolnEmpl.CheckDel(id_sw: integer): boolean;
var res:integer;
  sMsg:string;
begin
  res:=self.Check_(id_sw);
  sMsg:='';
  result:=(res<=0);
  if res>=8 then
   begin
     sMsg:=sMsg+'За сотрудником числится оборудование см. раздел РАЗНОЕ';
     res:=res-8;
   end;
  if res>=4 then
   begin
     if length(sMsg)>0 then sMsg:=sMsg+lineending;
     sMsg:=sMsg+'За сотрудником числится системный блок';
     res:=res-4;
   end;
  if res>=2 then
   begin
     if length(sMsg)>0 then sMsg:=sMsg+lineending;
     sMsg:=sMsg+'За сотрудником числится МНИ';
     res:=res-2;
   end;
  if res>=1 then
   begin
     if length(sMsg)>0 then sMsg:=sMsg+lineending;
     sMsg:=sMsg+'За сотрудником числится криптосредство';
     res:=res-1;
   end;
  if length(sMsg)>0 then
   begin
     if length(sMsg)>0 then sMsg:=sMsg+lineending;
     sMsg:='Сотрудник не может быть уволен:'+lineending+sMsg ;
     messagedlg('увольнение сотрудника',sMsg,mtWarning, [mbok],0);
   end;
end;

function TuvolnEmpl.SetConnect(connector: TMyworkbd; tipQuery: TDataSetState;
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

  //Проверим можно ли удалять сотрудника
  //*****************
  if (not CheckDel(editing_id))then
   begin
     result:=false ;
     exit;
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
       //showmessage(self.Fconnector.transaction.Params.Text);
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
  sqlquery2.ParamByName('ID_SW').AsInteger:=editing_id;
  //sqlquery4.ParamByName('ID').AsInteger:=editing_id;
  sqlquery1.Open;
  sqlquery2.Open;
  sqlquery3.Open;
  //sqlquery4.Open;
  //if not ((tipQuery=dsInsert)) then
  //begin
    sqlquery7.ParamByName('id_sw').AsInteger:=editing_id;
    sqlquery7.Open;
  //end;
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
       self.Caption:='просмотр увольнения сотрудника';//Заголовок
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
           self.Caption:='редактирование увольнения сотрудника';//Заголовок

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
      self.Caption:='Увольнение сотрудника';//Заголовок
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

procedure TuvolnEmpl.Button5Click(Sender: TObject);
begin
  Fexit:= savechange;
end;

procedure TuvolnEmpl.AaddingExecute(Sender: TObject);
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
  qq.SQL.Add('select * from SVIAZ_SW_DOCS');
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
  qq.FieldByName('ID_START_WORK').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
  qq.Post;
  qq.ApplyUpdates;
  self.FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Refresh;
  qq.Free;
  od.Free;
  if fileexists('D:\TMP\111.ltmp') then  deletefile('D:\TMP\111.ltmp');
end;

procedure TuvolnEmpl.ADeletingExecute(Sender: TObject);
var SCRIPT:TSQLScript;
begin
  if sqlquery7.IsEmpty then exit;
   script:=tsqlscript.Create(self);
  script.DataBase:=sqlquery1.DataBase;
  script.Transaction:=self.FconnectorWrite.transaction;
  script.CommentsInSQL:=false;
  script.UseSetTerm:=true;
  script.Script.Clear;
  script.Script.Add('delete from SVIAZ_SW_DOCS where (ID='+sqlquery7.FieldByName('ID').AsString+');');
  script.Script.Add('commit;');
  script.Execute;
  self.FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Refresh;
  script.Free;
end;

procedure TuvolnEmpl.AsaveingExecute(Sender: TObject);
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

procedure TuvolnEmpl.Button2Click(Sender: TObject);
var
  nRec, i:integer;
begin
   nRec:=-1;
   nRec:=mainf.openMOTIVEUVOLNENIE(true);
   {i:=self.SQLQuery1.FieldByName('ID_MOTIVE_DISCHARGE').AsInteger;
   sqlquery3.Close;
   sqlquery3.Open;
   self.SQLQuery1.FieldByName('ID_MOTIVE_DISCHARGE').AsInteger:=i;  }
   sqlquery3.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_MOTIVE_DISCHARGE').AsInteger:=nRec;
end;

procedure TuvolnEmpl.Button8Click(Sender: TObject);
begin
  sqlquery1.Cancel;
end;

procedure TuvolnEmpl.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Commit;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TuvolnEmpl.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

end.

