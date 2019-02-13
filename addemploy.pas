unit addEmploy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, DBDateTimePicker, Forms,
  Controls, Graphics, Dialogs, StdCtrls, DbCtrls, DBGrids, ComCtrls, ActnList,
  Menus, {lclproc, }LCLType, MaskEdit, workBD, MyMaskEdit, lazfileutils;

type
  //запомним значения полей которые пишутся в журнал
      //для их дальнейшей проверки
      TMymemField=record
      ID_GROUP:string;
      ID_LOCATION:STRING;
      FFAM:STRING;
      ID_POST:string;
      end;

  { TeditEmploy }

  TeditEmploy = class(TForm)
    Aadding: TAction;
    ActionList1: TActionList;
    ADeleting: TAction;
    Asaveing: TAction;
    AUpdating: TAction;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    DataSource7: TDataSource;
    DataSource8: TDataSource;
    DBDateTimePicker1: TDBDateTimePicker;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    DBLookupComboBox5: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MaskEdit1: TMyMaskEdit;
    PageControl1: TPageControl;
    PopupMenu1: TPopupMenu;
    SQLQuery1: TSQLQuery;
    SQLQuery1DOP: TStringField;
    SQLQuery1DT: TDateField;
    SQLQuery1DTR: TDateTimeField;
    SQLQuery1ID: TLongintField;
    SQLQuery1ID_CONDITION: TLongintField;
    SQLQuery1ID_GROUP: TLongintField;
    SQLQuery1ID_LOCATION: TLongintField;
    SQLQuery1ID_PEOPLE: TLongintField;
    SQLQuery1ID_POST: TLongintField;
    SQLQuery1ID_RAION: TLongintField;
    SQLQuery1ID_USER: TLongintField;
    SQLQuery1NETNAME: TStringField;
    SQLQuery1TABNOM: TStringField;
    SQLQuery2: TSQLQuery;
    SQLQuery3: TSQLQuery;
    SQLQuery4: TSQLQuery;
    SQLQuery5: TSQLQuery;
    SQLQuery7: TSQLQuery;
    SQLQuery7DOCS: TBlobField;
    SQLQuery7ID: TLongintField;
    SQLQuery7NAME: TStringField;
    SQLQuery7NAMEDOCS: TStringField;
    SQLQuery8: TSQLQuery;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ToolBar5: TToolBar;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    procedure AaddingExecute(Sender: TObject);
    procedure ADeletingExecute(Sender: TObject);
    procedure AsaveingExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure DBEdit1UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure MaskEdit1Change(Sender: TObject);
    procedure MaskEdit1EditingDone(Sender: TObject);
    procedure MaskEdit1Exit(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    //запомним значения полей которые пишутся в журнал
    //для их дальнейшей проверки
    FmemFielf:TMymemField;
    Fconnector: TMyworkbd;
    FconnectorWrite:TMyworkbd;
    Fexit:boolean;
    function savechange(exiting:boolean=true):boolean;
    procedure memJournal;
    function checkjournal:boolean;
    procedure savejournal;
    { private declarations }
  public
    { public declarations }
    function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
  end;

var
  editEmploy: TeditEmploy;

implementation
uses  main;
{$R *.lfm}

{ TeditEmploy }

procedure TeditEmploy.FormCreate(Sender: TObject);
begin
  Fexit:=true;
end;

procedure TeditEmploy.MaskEdit1Change(Sender: TObject);
begin

end;

procedure TeditEmploy.MaskEdit1EditingDone(Sender: TObject);
begin

end;

procedure TeditEmploy.MaskEdit1Exit(Sender: TObject);
var
  strtmp:string;
begin
  strtmp:=TMaskEdit(Sender).EditMask;
  if length(TMaskEdit(Sender).Text)<=0 then
  begin
    TMaskEdit(Sender).EditMask:='';
    TMaskEdit(Sender).Clear;
    TMaskEdit(Sender).EditMask:=strtmp;
    exit;
  end;
  try
         TMaskEdit(Sender).ValidateEdit;
  except
    on E: Exception do
    begin
         if pos(lowercase('not match the specified'),e.Message)>0 then
         begin
           TMaskEdit(Sender).EditMask:='';
           TMaskEdit(Sender).Clear;
           TMaskEdit(Sender).EditMask:=strtmp;
         end else
         MessageDlg('Ошибка','неизвестная ошибка: '+e.Message,mtInformation,[mbOK],0);
    end;
  end;
end;

procedure TeditEmploy.PageControl1Change(Sender: TObject);
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
           sqlquery7.ParamByName('id_sw').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
           sqlquery7.Open;
           if sqlquery1.State<>db.dsEdit then sqlquery1.Edit;
           exit;
         end;
    end;
    pagecontrol1.ActivePageIndex:=0;
  end;
end;

function TeditEmploy.savechange(exiting: boolean): boolean;
begin
  result:=false;
  try
      if (not (sqlquery1.Modified))and(self.FmemFielf.FFAM <>sqlquery2.FieldByName('FAM').AsString) then exit;
      //showmessage(sqlquery1.FieldByName('NETNAME').AsString);
      if sqlquery1.FieldByName('NETNAME').AsString<>maskedit1.Text then
         sqlquery1.FieldByName('NETNAME').AsString:=maskedit1.Text;
         if sqlquery1.FieldByName('NETNAME').AsString=''{self.DBEdit7.Text=''} then sqlquery1.FieldByName('NETNAME').Value:=null;
     //------------------
         //Если добавление
          if (sqlquery1.State=db.dsInsert) then
          begin
              sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_START_WORK_ID', sqlquery1.DataBase);
              sqlquery1.FieldByName('id_raion').Value:=id_raion;
              sqlquery1.FieldByName('id_user').Value:=id_user;
          end;
          sqlquery1.Post;
          sqlquery1.ApplyUpdates;
          result:=true;
          self.FconnectorWrite.transaction.CommitRetaining;
          //Если редактирование прошло успешно, то добавляем запись в журнал
          //если есть изменения
          if checkjournal then  savejournal;
          //подтверждаем и завершаем транзакцию
          if exiting then self.FconnectorWrite.transaction.Commit
          else
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
            end else MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
      end;
  end;
end;

procedure TeditEmploy.memJournal;
begin
  //------------
  //запомним значения полей которые пишутся в журнал
  //для их дальнейшей проверки
  sqlquery2.Locate('id',sqlquery1.FieldByName('id_people').AsInteger,[]);
  FmemFielf.FFAM:=sqlquery2.FieldByName('fam').AsString;
  FmemFielf.ID_LOCATION:= sqlquery1.FieldByName('id_location').AsString;
  FmemFielf.ID_GROUP:=sqlquery1.FieldByName('id_group').AsString;
  FmemFielf.ID_POST:=sqlquery1.FieldByName('id_post').AsString;
  //-----------
end;

function TeditEmploy.checkjournal: boolean;
begin
  sqlquery2.Locate('id',sqlquery1.FieldByName('id_people').AsInteger,[]);
  result:=(sqlquery1.FieldByName('id_group').AsString<>self.FmemFielf.ID_GROUP) or
              (sqlquery1.FieldByName('id_post').AsString<>self.FmemFielf.ID_POST)or
              (sqlquery1.FieldByName('id_location').AsString<>self.FmemFielf.ID_LOCATION)or
              (sqlquery2.FieldByName('FAM').AsString<>self.FmemFielf.FFAM);
end;

procedure TeditEmploy.savejournal;
VAR SCRIPT:TSQLSCRIPT;
  stmp1:string;
begin
  try
    script:=TSQLSCRIPT.Create(self);
         script.DataBase:=sqlquery1.DataBase;
         script.Transaction:=self.FconnectorWrite.transaction;
         script.CommentsInSQL:=false;
         script.UseSetTerm:=true;
         script.Script.Clear;
         if not SQLQUERY2.Locate('id',sqlquery1.FieldByName('id_people').AsInteger,[]) then
         begin
           script.Free;
           exit;
         end;
         if sqlquery1.FieldByName('id_group').IsNull then stmp1:='null' else stmp1:=SQLQUERY1.FieldByName('ID_GROUP').AsString;
         if checkbox1.Checked then
         begin
           script.Script.Add('insert into MOVE_EMPL(ID,ID_START_WORK,ID_LOCATION,ID_POST,ID_GROUP,FAM) values('
           +INTTOSTR(CreateGUID('GEN_CHANGE_EMPL_ID', sqlquery1.DataBase))+','+
           SQLQUERY1.FieldByName('ID').AsString+','+
           SQLQUERY1.FieldByName('ID_LOCATION').AsString+','+
           SQLQUERY1.FieldByName('ID_POST').AsString+','+
           stmp1+','''+
           SQLQUERY2.FieldByName('FAM').AsString+''');');
           script.Script.Add('commit;');
         end ;
         script.Execute;
         script.Free;
  except
    on E: Exception do
      begin
              MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)   ;
      end;
  end;
end;

function TeditEmploy.SetConnect(connector: TMyworkbd; tipQuery: TDataSetState;
  editing_id: integer): boolean;
var i:integer;
begin
  if (connector=nil)or(Fconnector<>nil)then exit;
  result:=false;
  self.Fconnector:=connector;
  //создадим подключение
  //*****************
     FconnectorWrite:=TMyworkbd.Create;
     Fconnector.copyParams(self,FconnectorWrite.connector);
     if (tipQuery=dsEdit)or(tipQuery=dsInsert)then
            FconnectorWrite.transaction.Params.Add('isc_tpb_nowait')
     else
       begin
         FconnectorWrite.transaction.Params.Add('isc_tpb_read');
         //FconnectorWrite.transaction.Params.Add('isc_tpb_read_concurrency');
         FconnectorWrite.transaction.Params.Add('isc_tpb_read_committed');
         FconnectorWrite.transaction.Params.Add('isc_tpb_nowait');
       end;
  //*****************

  //Подключим наборы к нашему подключению и транзакции
  //*****************
  if (tipQuery=dsBrowse) then
  begin
    for i:=0 to ComponentCount-1 do
    begin
         if (Components[i] is TSQLQuery)  then
         begin
           TSQLQuery(Components[i]).DataBase:=FconnectorWrite.connector;
         end;
         if (Components[i] is TSQLTransaction)  then
         begin
           TSQLTransaction(self.Components[i]).DataBase:=FconnectorWrite.connector;
         end;
    end;
  end else
  begin
        SQLQuery1.Transaction:=self.FconnectorWrite.transaction;
        sqlquery1.DataBase:=self.FconnectorWrite.connector;
        //к словарям подключу читающую транзакцию, чтобы по refresh можно было обновить их
        SQLQuery2.Transaction:=self.Fconnector.transaction;
        sqlquery2.DataBase:=self.Fconnector.connector;
        SQLQuery3.Transaction:=self.Fconnector.transaction;
        sqlquery3.DataBase:=self.Fconnector.connector;
        SQLQuery4.Transaction:=self.Fconnector.transaction;
        sqlquery4.DataBase:=self.Fconnector.connector;
        SQLQuery5.Transaction:=self.Fconnector.transaction;
        sqlquery5.DataBase:=self.Fconnector.connector;
        SQLQuery7.Transaction:=self.Fconnector.transaction;
        sqlquery7.DataBase:=self.Fconnector.connector;
        SQLQuery8.Transaction:=self.Fconnector.transaction;
        sqlquery8.DataBase:=self.Fconnector.connector;
  end;
  //*****************

  //Откроем наборы
  //***************
  sqlquery2.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery8.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery1.Open;
  sqlquery2.Open;
  sqlquery3.Open;
  sqlquery4.Open;
  sqlquery5.Open;
  sqlquery8.Open;
  if not ((tipQuery=dsInsert)) then
  begin
    sqlquery7.ParamByName('id_sw').AsInteger:=editing_id;
    sqlquery7.Open;
  end;
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
       CheckBox1.Checked:=false;
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
       self.Caption:='просмотр сотрудника';//Заголовок
       maskedit1.Text:= sqlquery1.FieldByName('NETNAME').AsString;
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
           checkbox1.Enabled:=true;
           sqlquery1.Edit;//Установим режим редактирования
           self.Caption:='редактирование сотрудника';//Заголовок

           //Заблокируем все
           //**************
           for i:=0 to self.ComponentCount-1 do
           begin
                if (self.Components[i] is TDBEdit) then  TDBEdit(self.Components[i]).ReadOnly:=true;
                if (self.Components[i] is TDBMemo) then  TDBMemo(self.Components[i]).ReadOnly:=true;
                //if (self.Components[i] is Tmaskedit) then  Tmaskedit(self.Components[i]).ReadOnly:=true;
                if (self.Components[i] is TDBLookupComboBox) or
                (self.Components[i] is TDBDateTimePicker) or
                (self.Components[i] is TCheckBox)or(self.Components[i] is Tbutton)or
                (self.Components[i] is TToolButton)then  TWinControl(self.Components[i]).Enabled:=false;
           end;
           //**************

           //Разблокируем только, то что нужно
           //******************
           checkbox1.Enabled:=true;
           button2.Enabled:=true;
           button3.Enabled:=true;
           button5.Enabled:=true;
           button6.Enabled:=true;
           button7.Enabled:=true;
           button7.Visible:=true;
           button8.Enabled:=true;
           button9.Enabled:=true;
           dbedit1.ReadOnly:=false;
           toolbutton14.Enabled:=true;
           toolbutton15.Enabled:=true;
           toolbutton16.Enabled:=true;
           DBLookupComboBox2.Enabled:=true;
           DBLookupComboBox3.Enabled:=true;
           DBLookupComboBox5.Enabled:=true;
           dbmemo1.ReadOnly:=false;
           maskedit1.ReadOnly:=false;
           //*******************
           memJournal;//Запомним значения полей которые пишутся в журнал
           maskedit1.Text:= sqlquery1.FieldByName('NETNAME').AsString;
    end;
  dsInsert:
    begin
         //Вставка
       self.Caption:='добавление сотрудника';//Заголовок
         sqlquery1.Insert;
    end;
  end;
  //****************
  //Сдклаем активной первую вкладку
  pagecontrol1.ActivePage:=tabsheet1;
  result:=true;
end;

procedure TeditEmploy.Button5Click(Sender: TObject);
begin
  Fexit:= savechange;
end;

procedure TeditEmploy.Button6Click(Sender: TObject);
var
  nRec, i:integer;
begin
   nRec:=-1;
   nRec:=mainf.openLOCATION(true);
   i:=self.SQLQuery1.FieldByName('ID_LOCATION').AsInteger;
   sqlquery8.Close;
   sqlquery8.Open;
   self.SQLQuery1.FieldByName('ID_LOCATION').AsInteger:=i;
   sqlquery8.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_LOCATION').AsInteger:=nRec;
end;

procedure TeditEmploy.AaddingExecute(Sender: TObject);
var od:topendialog;
  fname:string;
  qq:tsqlquery;
  stmp:string;
  ms:TFileStream;
begin
  stmp:='';
  od:=topendialog.Create(self.Owner);
  od.Filter:='изображение|*.jpg;*gif;*tiff|документ|*.doc;*.docx;*.xls;*.xlsx;*.rtf;*.odt;*.ods';
  if not  od.Execute then
  begin
       od.Free;
       exit;
  end;
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
  qq.FieldByName('ID_START_WORK').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
  qq.Post;
  qq.ApplyUpdates;
  self.FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Refresh;
  qq.Free;
  od.Free;
  if fileexists('D:\TMP\111.ltmp') then  deletefile('D:\TMP\111.ltmp');
end;

procedure TeditEmploy.ADeletingExecute(Sender: TObject);
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
  script.Execute;
  self.FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Open;
  sqlquery7.Refresh;
  script.Free;
end;

procedure TeditEmploy.AsaveingExecute(Sender: TObject);
var sd:tsavedialog;
begin
  if sqlquery7.IsEmpty then exit;
     sd:=tsavedialog.Create(self.Owner);
     sd.Filter:='|*.*';
     sd.FileName:=sqlquery7.FieldByName('nameDOCS').AsString;
  if not  sd.Execute then exit;
  if DirectoryExists('D:\TMP') then
   begin
     if fileexists('D:\TMP\111.ltmp') then  deletefile('D:\TMP\111.ltmp');
   end  else
   begin
     CreateDir('D:\TMP');
   end;
  tblobfield(sqlquery7.FieldByName('docs')).SaveToFile('D:\TMP\111.ltmp');
  RenameFileUTF8('D:\TMP\111.ltmp', sd.FileName);
  sd.Free;
end;

procedure TeditEmploy.Button1Click(Sender: TObject);
var
  nRec, i:integer;
begin
   nRec:=-1;
   nRec:=mainf.openPEOPLE(true);
   i:=self.SQLQuery1.FieldByName('ID_PEOPLE').AsInteger;
   sqlquery2.Close;
   sqlquery2.Open;
   self.SQLQuery1.FieldByName('ID_PEOPLE').AsInteger:=i;
   sqlquery2.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_PEOPLE').AsInteger:=nRec;
end;

procedure TeditEmploy.Button2Click(Sender: TObject);
var
  nRec, i:integer;
begin
   nRec:=-1;
   nRec:=mainf.openPOST(true);
   i:=self.SQLQuery1.FieldByName('ID_POST').AsInteger;
   sqlquery3.Close;
   sqlquery3.Open;
   self.SQLQuery1.FieldByName('ID_POST').AsInteger:=i;
   sqlquery3.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_POST').AsInteger:=nRec;
end;

procedure TeditEmploy.Button3Click(Sender: TObject);
var
  nRec,i:integer;
begin
   nRec:=-1;
   nRec:=mainf.openGROUP(true);
   i:=self.SQLQuery1.FieldByName('ID_GROUP').AsInteger;
   sqlquery4.Close;
   sqlquery4.Open;
   self.SQLQuery1.FieldByName('ID_GROUP').AsInteger:=i;
   sqlquery4.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_GROUP').AsInteger:=nRec;
end;

procedure TeditEmploy.Button4Click(Sender: TObject);
var
  nRec, i:integer;
begin
   nRec:=-1;
   nRec:=mainf.openMOTIVESTARTWORK(true);
   i:=self.SQLQuery1.FieldByName('ID_CONDITION').AsInteger;
   sqlquery5.Close;
   sqlquery5.Open;
   self.SQLQuery1.FieldByName('ID_CONDITION').AsInteger:=i;
   sqlquery5.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_CONDITION').AsInteger:=nRec;
end;

procedure TeditEmploy.Button7Click(Sender: TObject);
var stmp:string;
begin
  stmp:=sqlquery2.FieldByName('FAM').AsString;
  stmp:=InputBox('смена фамилии','введите новую фамилию',stmp);
  //Если Фамилия не поменялась, то выходим из процедуры
  if sqlquery2.FieldByName('FAM').AsString=stmp then exit;
  sqlquery2.Locate('id',sqlquery1.FieldByName('id_people').AsInteger,[]);
  sqlquery2.Edit;
  sqlquery2.FieldByName('fam').AsString:=stmp;
  sqlquery2.Post;
  try
     sqlquery2.ApplyUpdates;
  except
    on E: Exception do
      begin
              MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)   ;
      end;
  end;
  end;

procedure TeditEmploy.Button8Click(Sender: TObject);
begin
  sqlquery1.Cancel;
end;

procedure TeditEmploy.Button9Click(Sender: TObject);
begin
  sqlquery1.FieldByName('id_group').Value:=null;
end;

procedure TeditEmploy.DBEdit1UTF8KeyPress(Sender: TObject;
  var UTF8Key: TUTF8Char);
begin
   if pos(UTF8Key,'0123456789')<=0 then UTF8Key:=#0;
end;

procedure TeditEmploy.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Rollback;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TeditEmploy.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

end.

