unit addsb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, DBDateTimePicker, Forms, Controls,
  Graphics, Dialogs, StdCtrls, DbCtrls, DBGrids, ComCtrls, ActnList, Menus,
  lclproc, LCLType, MaskEdit, ExtCtrls{, PairSplitter}, fileprocs, variants, types;

type

  { TeditMNI }

  { TeditSB }

  TeditSB = class(TForm)
    Aadding: TAction;
    ActionList1: TActionList;
    ADeleting: TAction;
    Asaveing: TAction;
    AUpdating: TAction;
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    DataSource1: TDataSource;
    DataSource10: TDataSource;
    DataSource11: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    DataSource6: TDataSource;
    DataSource7: TDataSource;
    DataSource8: TDataSource;
    DataSource9: TDataSource;
    DBDateTimePicker1: TDBDateTimePicker;
    DBDateTimePicker2: TDBDateTimePicker;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    DBLookupComboBox5: TDBLookupComboBox;
    DBLookupComboBox6: TDBLookupComboBox;
    DBLookupComboBox7: TDBLookupComboBox;
    DBLookupComboBox8: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    GroupBox1: TGroupBox;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit3: TMaskEdit;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    PageControl1: TPageControl;
    PopupMenu1: TPopupMenu;
    SQLQuery1: TSQLQuery;
    SQLQuery10: TSQLQuery;
    SQLQuery11: TSQLQuery;
    SQLQuery1COUNT_IADRA: TLongintField;
    SQLQuery1CPU_MHZ: TLongintField;
    SQLQuery1DT: TDateField;
    SQLQuery1DTI: TDateField;
    SQLQuery1DTR: TDateTimeField;
    SQLQuery1ID: TLongintField;
    SQLQuery1ID_DOP: TLongintField;
    SQLQuery1ID_LICENSE_OS: TSmallintField;
    SQLQuery1ID_NAME_OS: TSmallintField;
    SQLQuery1ID_NAME_SB: TLongintField;
    SQLQuery1ID_PR_RASPR: TSmallintField;
    SQLQuery1ID_RAION: TLongintField;
    SQLQuery1ID_START_WORK: TLongintField;
    SQLQuery1ID_TIP_MEMORY: TLongintField;
    SQLQuery1ID_TIP_PROC: TLongintField;
    SQLQuery1ID_USER: TLongintField;
    SQLQuery1ID_WORK_SB: TSmallintField;
    SQLQuery1INVENT: TStringField;
    SQLQuery1OTKUDA: TStringField;
    SQLQuery1SERIAL: TStringField;
    SQLQuery1SIZE_MEMORY_MB: TLongintField;
    SQLQuery1STIKER: TStringField;
    SQLQuery2: TSQLQuery;
    SQLQuery3: TSQLQuery;
    SQLQuery4: TSQLQuery;
    SQLQuery5: TSQLQuery;
    SQLQuery6: TSQLQuery;
    SQLQuery7: TSQLQuery;
    SQLQuery7DOCS: TBlobField;
    SQLQuery7ID: TLongintField;
    SQLQuery7NAME: TStringField;
    SQLQuery7NAMEDOCS: TStringField;
    SQLQuery8: TSQLQuery;
    SQLQuery9: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    SQLTransaction2: TSQLTransaction;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ToolBar5: TToolBar;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    UpDown1: TUpDown;
    procedure AaddingExecute(Sender: TObject);
    procedure ADeletingExecute(Sender: TObject);
    procedure AsaveingExecute(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    //procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure DBEdit2UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
    procedure DBEdit6Change(Sender: TObject);
    procedure DBEdit6KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { private declarations }
    //------------
    //запомним значения полей которые пишутся в журнал
    //для их дальнейшей проверки
    id_start_work,ID_NAME_OS, ID_WORK_SB, ID_PR_RASPR, SIZE_MEMORY_MB, STIKER:string;
    //идентификатор записи в журнале для внесения
    //изменений
    id_j:integer;
    //-------------
    Fexit:boolean;
    Fediting_id: integer;
    Finserting: boolean;
    procedure Setediting_id(AValue: integer);
    procedure Setinserting(AValue: boolean);
    function savechange:boolean;
    procedure memJournal;
    function checkjournal:boolean;
    procedure savejournal;
    function FileNameToURL(FileName: string): variant;
  public
    { public declarations }
    property inserting:boolean read Finserting write Setinserting;
    property editing_id:integer read Fediting_id write Setediting_id;

  end;

var
  editSB: TeditSB;

implementation
uses workbd, main;
{$R *.lfm}

{ TeditSB }

procedure TeditSB.FormCreate(Sender: TObject);
var i:integer;
begin
  //button7.Caption:='смена'+lineending+'фамилии';
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
  sqlquery3.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery1.Open;
  sqlquery2.Open;
  sqlquery3.Open;
  sqlquery4.Open;
  sqlquery5.Open;
  sqlquery8.Open;
  sqlquery9.Open;
  sqlquery10.Open;
  sqlquery11.Open;
  Fexit:=true;
end;

procedure TeditSB.PageControl1Change(Sender: TObject);
begin
    if (sqlquery1.State=db.dsInsert)and(pagecontrol1.ActivePageIndex=1) then
  begin
    if MessageDlg  ('',
    'Для добавления документов'+lineending+'необходимо сохранить введеные данные.'+lineending+
    'Сохранить?', mtConfirmation, [mbYes,mbNo], 0)=mryes then
    begin
         if savechange then
         begin
           pagecontrol1.ActivePageIndex:=1;
           sqlquery7.ParamByName('id_sb').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
           sqlquery7.Open;
           if sqlquery1.State<>db.dsEdit then sqlquery1.Edit;
         end else pagecontrol1.ActivePageIndex:=0;;
    end;
  end;
end;

procedure TeditSB.Setinserting(AValue: boolean);
begin
  if Finserting=AValue then Exit;
  Finserting:=AValue;
  Fediting_id:=-1;
  if Finserting then
  begin
    sqlquery1.Insert;
    sqlquery6.Open;
    sqlquery6.Insert;
    pagecontrol1.ActivePage:=tabsheet1;
  end;
end;

function TeditSB.savechange: boolean;
var
  atmp:array of variant;
  i:integer;
  sost1,sost6: TDataSetState;
  stmp:string;
begin
  result:=false;
  try
         sost1:= sqlquery1.State;sost6:=sqlquery6.State;
         stmp:=sqlquery6.FieldByName('name').AsString;
         sqlquery1.FieldByName('CPU_MHZ').AsInteger:=strtoint(maskedit1.Text);
         sqlquery1.FieldByName('SIZE_MEMORY_MB').AsInteger:=strtoint(maskedit3.Text);
          if sqlquery1.State=db.dsInsert then
  begin
    if sqlquery6.Modified then
    begin
         if utf8length(dbmemo1.Text)>0 then
      begin
        sqlquery6.FieldByName('ID').Value :=CreateGUID('GEN_SLOVAR_ID');
        sqlquery6.Post;
        sqlquery6.ApplyUpdates;
        sqlquery1.FieldByName('ID_DOP').Value:= sqlquery6.FieldByName('ID').Value
      end else
      begin
        sqlquery1.FieldByName('ID_DOP').Value:=null;
      end;
      result:=true;
    end;
       if sqlquery1.Modified then
       begin
         sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_SB_ID');
         sqlquery1.FieldByName('id_raion').Value:=id_raion;
         sqlquery1.FieldByName('id_user').Value:=id_user;
         sqlquery1.Post;
         sqlquery1.ApplyUpdates;
         //Если вставка, то добавляем запись в журнал
         //и запоминаем значения полей
         savejournal;
         sqltransaction1.CommitRetaining;
         memJournal;
         result:=true;
       end;
  end;
  if (sqlquery1.State=db.dsEdit)then
  begin
    if sqlquery6.Modified then
    begin
         if utf8length(dbmemo1.Text)>0 then
         begin
           if sqlquery1.FieldByName('ID_DOP').IsNull then
           begin
             sqlquery6.FieldByName('ID').Value :=CreateGUID('GEN_SLOVAR_ID');
             sqlquery6.Post;
             sqlquery6.ApplyUpdates;
             sqlquery1.FieldByName('ID_DOP').Value:= sqlquery6.FieldByName('ID').Value
           end else
           begin
                      sqlquery6.Post;
                      sqlquery6.ApplyUpdates;
           end;
         end else
         begin
              if not sqlquery1.FieldByName('ID_DOP').IsNull then
              begin
                sqlquery1.FieldByName('ID_DOP').Value:=null;
                sqlquery6.Cancel;
                sqlquery6.Delete;
              end;
         end;
         result:=true;
    end;
    if sqlquery1.Modified then
       begin
         sqlquery1.Post;
         sqlquery1.ApplyUpdates;
         sqlquery6.ApplyUpdates;
              //исправляем запись в журнале
              //если есть изменения
              if checkjournal then  savejournal;
              sqltransaction1.CommitRetaining;
              result:=true;
       end;
  end;
  result:=true;
  except
    on E: Exception do
      begin
           result:=false;
           if (sqlquery1.State<>db.dsInsert) and(sqlquery1.State<>db.dsEdit)then
                 begin
                   setlength(atmp,sqlquery1.Fields.Count);
                   for i:=0 to self.sqlquery1.Fields.Count-1 do
                   begin
                        atmp[i]:=self.sqlquery1.Fields.Fields[i].Value;
                   end;
                   sqlquery1.CancelUpdates;
                 end;
          { if (pos('sw_incorrect_operation',UTF8lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','Нельзя дважды принять одного и того же'+lineending+
              'человека',mtInformation,[mbOK],0)
            end else } MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
            if (sqlquery1.State<>db.dsInsert) and(sqlquery1.State<>db.dsEdit)then
                 begin
                   if sost1=db.dsInsert then sqlquery1.Insert else sqlquery1.Edit;
                   if sost6=db.dsInsert then sqlquery6.Insert else sqlquery6.Edit;
                   for i:=0 to  self.sqlquery1.Fields.Count-1 do
                   begin
                        self.sqlquery1.Fields.Fields[i].Value:=atmp[i];
                   end;
                   sqlquery6.FieldByName('NAME').AsString:=stmp;
                 end;
      end;
  end;
end;

procedure TeditSB.memJournal;
begin
  //------------
  //запомним значения полей которые пишутся в журнал
  //для их дальнейшей проверки
  id_start_work:= sqlquery1.FieldByName('id_start_work').AsString;
  if sqlquery1.FieldByName('id_NAME_OS').IsNull then id_NAME_OS:='null' else
    id_NAME_OS:= sqlquery1.FieldByName('id_NAME_OS').AsString;
  if sqlquery1.FieldByName('ID_WORK_SB').IsNull then ID_WORK_SB:='null' else
    ID_WORK_SB:= sqlquery1.FieldByName('ID_WORK_SB').AsString;
  ID_PR_RASPR:=sqlquery1.FieldByName('ID_PR_RASPR').AsString;
  SIZE_MEMORY_MB:=sqlquery1.FieldByName('SIZE_MEMORY_MB').AsString;
  if sqlquery1.FieldByName('STIKER').IsNull then STIKER:='null' else
    STIKER:=sqlquery1.FieldByName('STIKER').AsString;
  //-----------
end;

function TeditSB.checkjournal: boolean;
var stmp1, stmp2, stmp3:string;
begin
  if sqlquery1.FieldByName('id_NAME_OS').IsNull then stmp1:='null' else
    stmp1:=sqlquery1.FieldByName('id_NAME_OS').AsString;
  if sqlquery1.FieldByName('ID_WORK_SB').IsNull then stmp2:='null' else
    stmp2:=sqlquery1.FieldByName('ID_WORK_SB').AsString;
  if sqlquery1.FieldByName('STIKER').IsNull then stmp3:='null' else
    stmp3:=sqlquery1.FieldByName('STIKER').AsString;
  result:=(sqlquery1.FieldByName('SIZE_MEMORY_MB').AsString<>SIZE_MEMORY_MB) or
              (sqlquery1.FieldByName('ID_PR_RASPR').AsString<>ID_PR_RASPR)or
              (sqlquery1.FieldByName('id_start_work').AsString<>id_start_work)or
              (stmp1<>id_NAME_OS)or(stmp2<>ID_WORK_SB)or(stmp3<>STIKER);
end;

procedure TeditSB.savejournal;
VAR SCRIPT:TSQLSCRIPT;
  stmp1, stmp2, stmp3:string;
begin
  try
    script:=TSQLSCRIPT.Create(self);
         script.DataBase:=sqlquery1.DataBase;
         script.Transaction:=sqltransaction1;
         script.CommentsInSQL:=false;
         script.UseSetTerm:=true;
         script.Script.Clear;
         if sqlquery1.FieldByName('ID_NAME_OS').IsNull then stmp1:='null' else stmp1:=SQLQUERY1.FieldByName('ID_NAME_OS').AsString;
         if sqlquery1.FieldByName('ID_WORK_SB').IsNull then stmp2:='null' else stmp2:=SQLQUERY1.FieldByName('ID_WORK_SB').AsString;
         if sqlquery1.FieldByName('STIKER').IsNull then stmp3:='null' else stmp3:=SQLQUERY1.FieldByName('STIKER').AsString;
         if checkbox1.Checked then
         begin
         if id_j=-1 then
         begin
           id_j:=CreateGUID('GEN_CHANGE_SB_ID');
           script.Script.Add('insert into MOVE_SB(ID,ID_SB,SIZE_MEMORY_MB,ID_START_WORK,ID_PR_RASPR, ID_NAME_OS, ID_WORK_SB, STIKER) values('
           +INTTOSTR(id_j)+','+
           SQLQUERY1.FieldByName('ID').AsString+','+
           SQLQUERY1.FieldByName('SIZE_MEMORY_MB').AsString+','+
           SQLQUERY1.FieldByName('ID_START_WORK').AsString+','+
           SQLQUERY1.FieldByName('ID_PR_RASPR').AsString+','+
           stmp1+','+
           stmp2+','+
           stmp3+');');
           //showmessage(script.Script.Text);
           script.Script.Add('commit;');
         end else
         begin
              script.Script.Add('update MOVE_SB set ID_SB='+
           SQLQUERY1.FieldByName('ID').AsString+',SIZE_MEMORY_MB='+
           SQLQUERY1.FieldByName('SIZE_MEMORY_MB').AsString+',ID_START_WORK='+
           SQLQUERY1.FieldByName('ID_START_WORK').AsString+',ID_PR_RASPR='+
           SQLQUERY1.FieldByName('ID_PR_RASPR').AsString+',ID_NAME_OS='+
           stmp1+',ID_WORK_SB='+
           stmp2+',STIKER='''+stmp3+
           ''' where ID='+INTTOSTR(id_j)+';');
           script.Script.Add('commit;');
         end;
         //showmessage('запись в журнал');
         end;
         script.Execute;
         script.Free;
  except
    on E: Exception do
      begin
              MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)   ;
      end;
  end;
end;

procedure TeditSB.Setediting_id(AValue: integer);
var i:integer;
begin
  if Fediting_id=AValue then Exit;
  Fediting_id:=AValue;
  Finserting:=false;
  if sqlquery1.Locate('ID',Fediting_id,[]) then
  begin
    checkbox1.Enabled:=true;
    sqlquery7.ParamByName('id_SB').AsInteger:=Fediting_id;
    sqlquery7.Open;
    if sqlquery1.FieldByName('id_dop').IsNull then
    begin
         sqlquery6.Open;
         sqlquery6.Insert;
    end else
    begin
         sqlquery6.Close;
         sqlquery6.SQL.Clear;
         sqlquery6.sql.Add('select * from DOP  where (id='+
         sqlquery1.FieldByName('id_dop').AsString+')');
         sqlquery6.Open;
         sqlquery6.First;
         sqlquery6.Edit;
    end;
    sqlquery1.Edit;
    self.Caption:='редактирование Системника';
       for i:=0 to self.ComponentCount-1 do
       begin
            if (self.Components[i] is TDBEdit) then  TDBEdit(self.Components[i]).ReadOnly:=true;
            if (self.Components[i] is TDBMemo) then  TDBMemo(self.Components[i]).ReadOnly:=true;
            if (self.Components[i] is Tmaskedit) then  Tmaskedit(self.Components[i]).ReadOnly:=true;
            if (self.Components[i] is TDBLookupComboBox) or
            (self.Components[i] is TDBDateTimePicker) or
            (self.Components[i] is TCheckBox)or(self.Components[i] is Tbutton)or
            (self.Components[i] is TToolButton) then  TWinControl(self.Components[i]).Enabled:=false;
       end;
    checkbox1.Enabled:=true;
    button5.Enabled:=true;
    button8.Enabled:=true;
    toolbutton14.Enabled:=true;
    toolbutton15.Enabled:=true;
    toolbutton16.Enabled:=true;
    DBLookupComboBox1.Enabled:=true;
    DBLookupComboBox2.Enabled:=true;
    DBLookupComboBox4.Enabled:=true;
    DBLookupComboBox5.Enabled:=true;
    DBLookupComboBox6.Enabled:=true;
    DBLookupComboBox7.Enabled:=true;
    DBLookupComboBox8.Enabled:=true;
    dbedit4.ReadOnly:=false;
    dbedit5.ReadOnly:=false;
    dbedit6.ReadOnly:=false;
    dbmemo1.ReadOnly:=false;
    maskedit1.ReadOnly:=false;
    maskedit3.ReadOnly:=false;
    memJournal;
    maskedit1.Text:= sqlquery1.FieldByName('CPU_MHZ').AsString;
    maskedit3.Text:= sqlquery1.FieldByName('SIZE_MEMORY_MB').AsString;
  end else
  begin
       exit;
       sqltransaction1.Rollback;sqltransaction2.Rollback;
       self.Close;
  end;
end;

procedure TeditSB.Button5Click(Sender: TObject);
begin
  Fexit:= savechange;
end;

procedure TeditSB.Button6Click(Sender: TObject);
var
  atmp:array of variant;
  i:integer;
  sost1,sost6: TDataSetState;
  stmp:string;
begin
  sost1:= sqlquery1.State;sost6:=sqlquery6.State;
  stmp:=sqlquery6.FieldByName('name').AsString;
  setlength(atmp,sqlquery1.Fields.Count);
  for i:=0 to self.sqlquery1.Fields.Count-1 do
  begin
       atmp[i]:=self.sqlquery1.Fields.Fields[i].Value;
  end;
  //завершим транзакции, чтобы получить обновленные данные
  sqltransaction1.Rollback;
  sqltransaction2.Rollback;
   //вызываем справочник
  mainf.openTIP_LICENSE_OS;
  //откроем наборы данных
   for i:=0 to self.ComponentCount-1 do
  begin
       if (self.Components[i] is TSQLQuery)  then
       begin
         TSQLQuery(self.Components[i]).Open;
       end;
  end;
  //восстанавливаем значения полей
  if sost1=db.dsInsert then sqlquery1.Insert else sqlquery1.Edit;
  if sost6=db.dsInsert then sqlquery6.Insert else sqlquery6.Edit;
  for i:=0 to  self.sqlquery1.Fields.Count-1 do
  begin
       self.sqlquery1.Fields.Fields[i].Value:=atmp[i];
  end;
  sqlquery6.FieldByName('NAME').AsString:=stmp;
end;

procedure TeditSB.Button7Click(Sender: TObject);
var
  atmp:array of variant;
  i:integer;
  sost1,sost6: TDataSetState;
  stmp:string;
begin
  sost1:= sqlquery1.State;sost6:=sqlquery6.State;
  stmp:=sqlquery6.FieldByName('name').AsString;
  setlength(atmp,sqlquery1.Fields.Count);
  for i:=0 to self.sqlquery1.Fields.Count-1 do
  begin
       atmp[i]:=self.sqlquery1.Fields.Fields[i].Value;
  end;
  //завершим транзакции, чтобы получить обновленные данные
  sqltransaction1.Rollback;
  sqltransaction2.Rollback;
   //вызываем справочник
  mainf.openTIP_MEMORY;
  //откроем наборы данных
   for i:=0 to self.ComponentCount-1 do
  begin
       if (self.Components[i] is TSQLQuery)  then
       begin
         TSQLQuery(self.Components[i]).Open;
       end;
  end;
  //восстанавливаем значения полей
  if sost1=db.dsInsert then sqlquery1.Insert else sqlquery1.Edit;
  if sost6=db.dsInsert then sqlquery6.Insert else sqlquery6.Edit;
  for i:=0 to  self.sqlquery1.Fields.Count-1 do
  begin
       self.sqlquery1.Fields.Fields[i].Value:=atmp[i];
  end;
  sqlquery6.FieldByName('NAME').AsString:=stmp;
end;

procedure TeditSB.AaddingExecute(Sender: TObject);
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
  qq.Transaction:=sqltransaction2;
  qq.SQL.Clear;
  qq.SQL.Add('select * from DOCS');
  qq.Open;
  qq.Insert;
  qq.FieldByName('ID').Value :=CreateGUID('GEN_DOCS_ID');
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
  qq.Post;
  qq.ApplyUpdates;
  script:=tsqlscript.Create(self);
  script.DataBase:=sqlquery1.DataBase;
  script.Transaction:=sqltransaction2;
  script.CommentsInSQL:=false;
  script.UseSetTerm:=true;
  script.Script.Clear;
  script.Script.Add('insert into SVIAZ_SB_DOCS(ID_MNI,ID_DOCS) values('
  +sqlquery1.FieldByName('ID').AsString +','+
  qq.FieldByName('ID').AsString+');');
  script.Script.Add('commit;');
  script.Execute;
  sqltransaction2.CommitRetaining;
  sqlquery7.Refresh;
  script.Free;
  qq.Free;
  od.Free;
  if fileexists('D:\TMP\111.ltmp') then  deletefile('D:\TMP\111.ltmp');
end;

procedure TeditSB.ADeletingExecute(Sender: TObject);
var SCRIPT:TSQLScript;
begin
  if sqlquery7.IsEmpty then exit;
   script:=tsqlscript.Create(self);
  script.DataBase:=sqlquery1.DataBase;
  script.Transaction:=sqltransaction2;
  script.CommentsInSQL:=false;
  script.UseSetTerm:=true;
  script.Script.Clear;
  script.Script.Add('delete from DOCS where (ID='+sqlquery7.FieldByName('ID').AsString+');');
  script.Script.Add('commit;');
  script.Execute;
  sqltransaction2.CommitRetaining;
  sqlquery7.Refresh;
  script.Free;
end;

procedure TeditSB.AsaveingExecute(Sender: TObject);
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

procedure TeditSB.Button13Click(Sender: TObject);
var
  atmp:array of variant;
  i:integer;
  sost1,sost6: TDataSetState;
  stmp:string;
begin
  sost1:= sqlquery1.State;sost6:=sqlquery6.State;
  stmp:=sqlquery6.FieldByName('name').AsString;
  setlength(atmp,sqlquery1.Fields.Count);
  for i:=0 to self.sqlquery1.Fields.Count-1 do
  begin
       atmp[i]:=self.sqlquery1.Fields.Fields[i].Value;
  end;
  //завершим транзакции, чтобы получить обновленные данные
  sqltransaction1.Rollback;
  sqltransaction2.Rollback;
   //вызываем справочник
  mainf.openTIP_PROC;
  //откроем наборы данных
   for i:=0 to self.ComponentCount-1 do
  begin
       if (self.Components[i] is TSQLQuery)  then
       begin
         TSQLQuery(self.Components[i]).Open;
       end;
  end;
  //восстанавливаем значения полей
  if sost1=db.dsInsert then sqlquery1.Insert else sqlquery1.Edit;
  if sost6=db.dsInsert then sqlquery6.Insert else sqlquery6.Edit;
  for i:=0 to  self.sqlquery1.Fields.Count-1 do
  begin
       self.sqlquery1.Fields.Fields[i].Value:=atmp[i];
  end;
  sqlquery6.FieldByName('NAME').AsString:=stmp;
end;

procedure TeditSB.Button1Click(Sender: TObject);
var
  atmp:array of variant;
  i:integer;
  sost1,sost6: TDataSetState;
  stmp:string;
begin
  sost1:= sqlquery1.State;sost6:=sqlquery6.State;
  stmp:=sqlquery6.FieldByName('name').AsString;
  setlength(atmp,sqlquery1.Fields.Count);
  for i:=0 to self.sqlquery1.Fields.Count-1 do
  begin
       atmp[i]:=self.sqlquery1.Fields.Fields[i].Value;
  end;
  //завершим транзакции, чтобы получить обновленные данные
  sqltransaction1.Rollback;
  sqltransaction2.Rollback;
   //вызываем справочник
  mainf.openNAME_SB;
  //откроем наборы данных
   for i:=0 to self.ComponentCount-1 do
  begin
       if (self.Components[i] is TSQLQuery)  then
       begin
         TSQLQuery(self.Components[i]).Open;
       end;
  end;
  //восстанавливаем значения полей
  if sost1=db.dsInsert then sqlquery1.Insert else sqlquery1.Edit;
  if sost6=db.dsInsert then sqlquery6.Insert else sqlquery6.Edit;
  for i:=0 to  self.sqlquery1.Fields.Count-1 do
  begin
       self.sqlquery1.Fields.Fields[i].Value:=atmp[i];
  end;
  sqlquery6.FieldByName('NAME').AsString:=stmp;
end;

procedure TeditSB.Button3Click(Sender: TObject);
var
  atmp:array of variant;
  i:integer;
  sost1,sost6: TDataSetState;
  stmp:string;
begin
  sost1:= sqlquery1.State;sost6:=sqlquery6.State;
  stmp:=sqlquery6.FieldByName('name').AsString;
  setlength(atmp,sqlquery1.Fields.Count);
  for i:=0 to self.sqlquery1.Fields.Count-1 do
  begin
       atmp[i]:=self.sqlquery1.Fields.Fields[i].Value;
  end;
  //завершим транзакции, чтобы получить обновленные данные
  sqltransaction1.Rollback;
  sqltransaction2.Rollback;
   //вызываем справочник
  mainf.openNAME_OS;
  //откроем наборы данных
   for i:=0 to self.ComponentCount-1 do
  begin
       if (self.Components[i] is TSQLQuery)  then
       begin
         TSQLQuery(self.Components[i]).Open;
       end;
  end;
  //восстанавливаем значения полей
  if sost1=db.dsInsert then sqlquery1.Insert else sqlquery1.Edit;
  if sost6=db.dsInsert then sqlquery6.Insert else sqlquery6.Edit;
  for i:=0 to  self.sqlquery1.Fields.Count-1 do
  begin
       self.sqlquery1.Fields.Fields[i].Value:=atmp[i];
  end;
  sqlquery6.FieldByName('NAME').AsString:=stmp;
end;

procedure TeditSB.Button4Click(Sender: TObject);
var
  atmp:array of variant;
  i:integer;
  sost1,sost6: TDataSetState;
  stmp:string;
begin
  sost1:= sqlquery1.State;sost6:=sqlquery6.State;
  stmp:=sqlquery6.FieldByName('name').AsString;
  setlength(atmp,sqlquery1.Fields.Count);
  for i:=0 to self.sqlquery1.Fields.Count-1 do
  begin
       atmp[i]:=self.sqlquery1.Fields.Fields[i].Value;
  end;
  //завершим транзакции, чтобы получить обновленные данные
  sqltransaction1.Rollback;
  sqltransaction2.Rollback;
   //вызываем справочник
  mainf.openTIP_WORK_SB;
  //откроем наборы данных
   for i:=0 to self.ComponentCount-1 do
  begin
       if (self.Components[i] is TSQLQuery)  then
       begin
         TSQLQuery(self.Components[i]).Open;
       end;
  end;
  //восстанавливаем значения полей
  if sost1=db.dsInsert then sqlquery1.Insert else sqlquery1.Edit;
  if sost6=db.dsInsert then sqlquery6.Insert else sqlquery6.Edit;
  for i:=0 to  self.sqlquery1.Fields.Count-1 do
  begin
       self.sqlquery1.Fields.Fields[i].Value:=atmp[i];
  end;
  sqlquery6.FieldByName('NAME').AsString:=stmp;
end;

 {
procedure TeditSB.Button7Click(Sender: TObject);
var stmp:string;
begin
  //if InputQuery('111','222',stmp) then showmessage('истина') else showmessage('ложь')
 // DBLookupComboBox1.Enabled:=true;
  stmp:=sqlquery2.FieldByName('FAM').AsString;
  stmp:=InputBox('смена фамилии','введите новую фамилию',stmp);
  sqlquery2.Locate('id',sqlquery1.FieldByName('id_people').AsInteger,[]);
  sqlquery2.Edit;
  sqlquery2.FieldByName('fam').AsString:=stmp;
  sqlquery2.Post;
 // DBLookupComboBox1.Refresh;
 // sqlquery2.Refresh;
 // sqlquery1.Refresh;
 // DBLookupComboBox1.Enabled:=false;
  end;    }

procedure TeditSB.Button8Click(Sender: TObject);
begin
  sqlquery1.Cancel;
  sqlquery6.Cancel;
end;

procedure TeditSB.Button9Click(Sender: TObject);
begin
  sqlquery1.FieldByName('id_model').Value:=null;
end;

procedure TeditSB.CheckBox2Change(Sender: TObject);
begin

end;

procedure TeditSB.DBEdit2UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
begin
  if UTF8Key='.' then UTF8Key:=',';
  if utf8pos(UTF8Key,'0123456789,'+#8)<=0 then UTF8Key:=#0;
end;

procedure TeditSB.DBEdit6Change(Sender: TObject);
begin

end;

procedure TeditSB.DBEdit6KeyPress(Sender: TObject; var Key: char);
begin
     if pos(Key,'1234')<=0 then Key:=#0;
end;

procedure TeditSB.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if sqltransaction1.Active then
  begin
    sqltransaction1.Commit;
  end;
  if sqltransaction2.Active then
  begin
    sqltransaction2.Commit;
  end;
  CloseAction:=caFree;
end;

procedure TeditSB.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

function TeditSB.FileNameToURL(FileName: string): variant;
var
    i: Integer;
//    ch:char;//не работает с кирилицей
//    ch: string;//должно тоже работать с кирилицей.
    ch:tUTF8char;
begin
     Result:='';
      For i:=1 to utf8Length(FileName) do
      Begin
        ch:=utf8copy(FileName, i, 1);//получаем один символ который может занимать
                               //два байта поэтому используем utf8copy
        case ch of
        //Если русский символ, то заменяем шестнадцатиричным значением первого байта и второго,
        //это нужно для перевода пути в URL нотацию
        'а'..'я','А'..'Я':Result:=Result+'%'+IntToHex(Ord(ch[1]), 2)+'%'+IntToHex(Ord(ch[2]), 2);
        '\':result:=result+'/';//для URL нотации
        ':':result:=result+'|';//для URL нотации
        else
               Result:=Result+ch;
        end ;
      End;
      Result:=varastype(Result,varolestr);
end;

end.

