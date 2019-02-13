unit addsertifikat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, DBDateTimePicker, Forms, Controls,
  Graphics, Dialogs, StdCtrls, DbCtrls, DBGrids, ComCtrls, ActnList, Menus,
  lclproc, LCLType, workbd, dateutils, LazUTF8;

type

  { TeditSert }

  TeditSert = class(TForm)
    Aadding: TAction;
    ActionList1: TActionList;
    ADeleting: TAction;
    Asaveing: TAction;
    AUpdating: TAction;
    Button5: TButton;
    Button8: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource7: TDataSource;
    DBDateTimePicker1: TDBDateTimePicker;
    DBDateTimePicker2: TDBDateTimePicker;
    DBDateTimePicker3: TDBDateTimePicker;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    ImageList1: TImageList;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    PageControl1: TPageControl;
    PopupMenu1: TPopupMenu;
    SQLQuery1: TSQLQuery;
    SQLQuery1DOP: TStringField;
    SQLQuery1DT: TDateField;
    SQLQuery1DTR: TDateTimeField;
    SQLQuery1DT_END: TDateField;
    SQLQuery1DT_START: TDateField;
    SQLQuery1ID: TLongintField;
    SQLQuery1ID_RAION: TLongintField;
    SQLQuery1ID_START_WORK: TLongintField;
    SQLQuery1ID_USER: TLongintField;
    SQLQuery1NAME: TStringField;
    SQLQuery2: TSQLQuery;
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
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure DBDateTimePicker1Exit(Sender: TObject);
    procedure DBDateTimePicker3Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    FChange:Boolean;
    Fconnector: TMyworkbd;
    FconnectorWrite:TMyworkbd;
    Fexit:boolean;
    function savechange(exiting:boolean=true):boolean;
    { private declarations }
  public
    { public declarations }
    function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
  end;

var
  editSert: TeditSert;

implementation
{uses  main;}
{$R *.lfm}

{ TeditSert }

procedure TeditSert.FormCreate(Sender: TObject);
begin
  {//button7.Caption:='смена'+lineending+'фамилии';
  for i:=0 to self.ComponentCount-1 do
  begin
  if (self.Components[i] is TSQLQuery)  then
  begin
    TSQLQuery(self.Components[i]).DataBase:=mainf.connector;
  end;
  if (self.Components[i] is TSQLTransaction)  then
  begin
    TSQLTransaction(self.Components[i]).DataBase:=mainf.connector;
  end;
  end;
  Fediting_id:=-1;
  id_j:=-1;
  sqlquery2.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery1.Open;
  sqlquery2.Open; }
  Fexit:=true;
  FChange:=false;
end;

procedure TeditSert.PageControl1Change(Sender: TObject);
begin
    if (sqlquery1.State=db.dsInsert)and(pagecontrol1.ActivePageIndex=1) then
  begin
    if MessageDlg  ('',
    'Для добавления документов'+lineending+'необходимо сохранить введеные данные.'+lineending+
    'Сохранить?', mtConfirmation, [mbYes,mbNo], 0)=mryes then
    begin
         if savechange(false) then
         begin
           pagecontrol1.ActivePageIndex:=1;
           sqlquery7.ParamByName('id_SERT').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
           sqlquery7.Open;
           if sqlquery1.State<>db.dsEdit then sqlquery1.Edit;
           exit;
         end;
    end;
    pagecontrol1.ActivePageIndex:=0;
  end;
end;

function TeditSert.savechange(exiting: boolean): boolean;
         procedure remove_probel;
         var
           i:integer;
           tempstring:string;
         begin
           tempstring:='';
           for i:=1 to utf8length(dbedit1.text) do
               if utf8copy(dbedit1.Text,i,1)<>' ' then
                  tempstring:=tempstring+utf8copy(dbedit1.Text,i,1);
           dbedit1.Text:=tempstring;
         end;
begin
  result:=false;
  try
         if FChange then
         begin
           FconnectorWrite.transaction.Commit;
           result:=true;
           exit;
         end;
         if not (sqlquery1.Modified) then exit;
           //------------------
         //Если добавление
          if (sqlquery1.State=db.dsInsert) then
          begin
               remove_probel;
              sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_SERT_ID', sqlquery1.DataBase);
              sqlquery1.FieldByName('id_raion').Value:=id_raion;
              sqlquery1.FieldByName('id_user').Value:=id_user;
              //exit;
          end;
          sqlquery1.Post;
          sqlquery1.ApplyUpdates;
          result:=true;
          FconnectorWrite.transaction.CommitRetaining;
          //подтверждаем и завершаем транзакцию
          if exiting then
          begin
            FconnectorWrite.transaction.Commit;
            result:=true;
          end else
            begin
              //редактирование
              //Заблокируем запись
              /////////////
              //--------
              //делаем холостой update
              try
                 SQLQuery1.Edit;
                 SQLQuery1.FieldByName('ID').AsInteger:=SQLQuery1.FieldByName('ID').AsInteger;
                 SQLQuery1.Post;
                 SQLQuery1.ApplyUpdates;
                 //И еще раз чтобы были изменения
                 SQLQuery1.Edit;
                 SQLQuery1.FieldByName('ID').AsInteger:=SQLQuery1.FieldByName('ID').AsInteger;
              except
                on E: Exception do
                begin
                     SQLQuery1.CancelUpdates;
                     if (pos('concurrent transaction number',lowercase( e.message))>0) then
                     begin
                       MessageDlg('Ошибка','запись уже редактируется' +lineending+
                       'попробуйте повторить попытку позже',mtError,[mbOK],0);
                     end else   MessageDlg('Ошибка',e.Message,mtError,[mbOK],0);
                     result:=false;
                     exit;
                end;
              end;
            end;
  except
    on E: Exception do
      begin
           result:=false;
           if (pos('sw_incorrect_operation',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','Нельзя дважды принять одного и того же'+lineending+
              'человека',mtInformation,[mbOK],0)
            end else
            if (pos('requi',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','Незаполненно обязательное поле',mtInformation,[mbOK],0)
            end else
            if (pos('unq1_sertifikats',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','такой сертификат уже есть',mtInformation,[mbOK],0)
            end else MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
      end;
  end;
end;

function TeditSert.SetConnect(connector: TMyworkbd; tipQuery: TDataSetState;
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
       //к словарям подключу читающую транзакцию, чтобы по refresh можно было обновить их
       SQLQuery2.Transaction:=self.Fconnector.transaction;
       sqlquery2.DataBase:=self.Fconnector.connector;
       SQLQuery7.Transaction:=self.Fconnector.transaction;
       sqlquery7.DataBase:=self.Fconnector.connector;
  end;
  //*****************

  //Откроем наборы
  //***************
  sqlquery2.ParamByName('id_raion').AsInteger:=id_raion;

  sqlquery1.Open;
  sqlquery2.Open;

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

  if not (tipQuery=dsInsert) then
  begin
    sqlquery7.ParamByName('id_SERT').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
    sqlquery7.Open;
  end;

  //Переведем набор в нужное состояние
  //***************
  case tipQuery of
  dsBrowse:
    begin
         //просмотр
         //Заблокируем все контролы
       for i:=0 to ComponentCount-1 do
       begin
            if (self.Components[i] is TDBEdit) then  TDBEdit(self.Components[i]).ReadOnly:=true;
            if (self.Components[i] is TDBMemo) then  TDBMemo(self.Components[i]).ReadOnly:=true;
            if (self.Components[i] is TDBLookupComboBox) or
            (self.Components[i] is TDBDateTimePicker) or
            (self.Components[i] is TCheckBox) then  TWinControl(self.Components[i]).Enabled:=false;
       end;
       for i:=0 to ComponentCount-1 do
       begin
            if ((self.Components[i] is Tbutton) or
            (Components[i] is TToolButton)) and
            (TControl(Components[i]).Name<>'Button8')and{
            (TControl(Components[i]).Name<>'ToolButton14')and}
            (TControl(Components[i]).Name<>'ToolButton15'){and
            (TControl(Components[i]).Name<>'ToolButton16')}then TControl(Components[i]).Enabled:=false;
       end;
       self.Caption:='просмотр сертификата';//Заголовок
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
           self.Caption:='редактирование сертификата';//Заголовок

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
           toolbutton14.Enabled:=true;
           toolbutton15.Enabled:=true;
           toolbutton16.Enabled:=true;
           dbmemo1.ReadOnly:=false;
           //*******************
    end;
  dsInsert:
    begin
         //Вставка
      self.Caption:='добавление сертификата';//Заголовок
         sqlquery1.Insert;
    end;
  end;
  //****************
  //Сдклаем активной первую вкладку
  pagecontrol1.ActivePage:=tabsheet1;
  result:=true;
end;

procedure TeditSert.Button5Click(Sender: TObject);
begin
  //showmessage(inttostr(utf8length(dbedit1.Text)));
  Fexit:= savechange;
end;

procedure TeditSert.AaddingExecute(Sender: TObject);
var od:topendialog;
  fname:string;
  qq:tsqlquery;
  //SCRIPT:TSQLScript;
  stmp:string;
  ms:TFileStream;
begin
  stmp:='';
  od:=topendialog.Create(self.Owner);
  od.Filter:='все|*.*|изображение|*.jpg;*gif;*tiff|документ|*.doc;*.docx;*.xls;*.xlsx;*.rtf;*.odt;*.ods';
  if not  od.Execute then exit;
  fname:=ExtractFileName(od.FileName);
  qq:=tsqlquery.Create(self);
  qq.DataBase:=sqlquery1.DataBase;
  qq.Transaction:=self.FconnectorWrite.transaction;
  qq.SQL.Clear;
  qq.SQL.Add('select * from SVIAZ_SERT_DOCS');
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
  tblobfield(qq.FieldByName('docs')).LoadFromFile('D:\TMP\111.ltmp');
  if not InputQuery('имя документа','Введите краткое'+
  lineending+'наименование документа',stmp) then
  begin
    qq.Free;
    od.Free;
    exit;
  end;
  qq.FieldByName('name').Value:=stmp;
  qq.FieldByName('namedocs').Value:=fname;
  qq.FieldByName('ID_SERT').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
  qq.Post;
  qq.ApplyUpdates;
  FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Refresh;
  qq.Free;
  od.Free;
  if fileexists('D:\TMP\111.ltmp') then  deletefile('D:\TMP\111.ltmp');
  FChange:=true;
end;

procedure TeditSert.ADeletingExecute(Sender: TObject);
var SCRIPT:TSQLScript;
begin
  if sqlquery7.IsEmpty then exit;
   script:=tsqlscript.Create(self);
  script.DataBase:=sqlquery1.DataBase;
  script.Transaction:=self.FconnectorWrite.transaction;
  script.CommentsInSQL:=false;
  script.UseSetTerm:=true;
  script.Script.Clear;
  script.Script.Add('delete from SVIAZ_SERT_DOCS where (ID='+sqlquery7.FieldByName('ID').AsString+');');
  script.Execute;
  self.FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Refresh;
  script.Free;
  FChange:=true;
end;

procedure TeditSert.AsaveingExecute(Sender: TObject);
var sd:tsavedialog;
begin
  if sqlquery7.IsEmpty then exit;
     sd:=tsavedialog.Create(self.Owner);
     sd.Filter:='|*.*';
     sd.FileName:=sqlquery7.FieldByName('nameDOCS').AsString;
  if not  sd.Execute then exit;
  tblobfield(sqlquery7.FieldByName('docs')).SaveToFile(sd.FileName);
  sd.Free;
end;

procedure TeditSert.Button8Click(Sender: TObject);
begin
  sqlquery1.Cancel;
end;

procedure TeditSert.DBDateTimePicker1Exit(Sender: TObject);
begin
  self.DBDateTimePicker2.Field.AsDateTime:=EncodeDateTime(yearof(DBDateTimePicker3.Field.AsDateTime)+1,monthof(DBDateTimePicker3.Field.AsDateTime),dayof(DBDateTimePicker3.Field.AsDateTime),0,0,0,0);
end;

procedure TeditSert.DBDateTimePicker3Exit(Sender: TObject);
begin
  self.DBDateTimePicker1.Field.AsDateTime:=self.DBDateTimePicker3.Field.AsDateTime;
end;

procedure TeditSert.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Commit;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TeditSert.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;
end.

