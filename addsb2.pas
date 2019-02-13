unit addsb2;

{$mode objfpc}{$H+}


interface

uses
 Classes, SysUtils, sqldb, db, FileUtil, DBDateTimePicker, Forms, Controls,
 Graphics, Dialogs, StdCtrls, DbCtrls, DBGrids, ComCtrls, ActnList, Menus,
 lclproc, LCLType, MaskEdit, ExtCtrls, fileprocs, {MyMaskEdit,} variants, workBD;

type

  //запомним значения полей которые пишутся в журнал
    //для их дальнейшей проверки
    TMymemField=record
    id_start_work:string;
    ID_NAME_OS:STRING;
    ID_WORK_SB:STRING;
    ID_PR_RASPR:string;
    ID_LOCATION:string;
    SIZE_MEMORY_MB:string;
    STIKER:string;
    end;

  { TeditSB2 }

  TeditSB2 = class(TForm)
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
    Button15: TButton;
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
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    DBLookupComboBox5: TDBLookupComboBox;
    DBLookupComboBox6: TDBLookupComboBox;
    DBLookupComboBox7: TDBLookupComboBox;
    DBLookupComboBox8: TDBLookupComboBox;
    DBLookupComboBox9: TDBLookupComboBox;
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
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit3: TMaskEdit;
    MaskEdit4: TMaskEdit;
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
    SQLQuery1DOP: TStringField;
    SQLQuery1DT: TDateField;
    SQLQuery1DTI: TDateField;
    SQLQuery1DTR: TDateTimeField;
    SQLQuery1ID: TLongintField;
    SQLQuery1ID_LICENSE_OS: TSmallintField;
    SQLQuery1ID_LOCATION: TLongintField;
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
    SQLQuery1IPADDRESS: TStringField;
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
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    //procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure DBEdit2UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
    procedure DBEdit6KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure MaskEdit1Exit(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    Fconnector: TMyworkbd;
    FconnectorWrite:TMyworkbd;
    { private declarations }
         //------------
    //запомним значения полей которые пишутся в журнал
    //для их дальнейшей проверки
          FmemFielf:TMymemField;
        Fexit:boolean;
        function savechange:boolean;
        procedure memJournal;
        function checkjournal:boolean;
        procedure savejournal;
        //function FileNameToURL(FileName: string): variant;
      public
        { public declarations }
        function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
  end;

var
  editSB2: TeditSB2;

implementation
uses   main,createDOC;
{$R *.lfm}

 { TeditSB2 }

procedure TeditSB2.FormCreate(Sender: TObject);
begin
  Fexit:=true;
end;

procedure TeditSB2.MaskEdit1Exit(Sender: TObject);
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

procedure TeditSB2.PageControl1Change(Sender: TObject);
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

function TeditSB2.savechange: boolean;
begin
  result:=false;
  try
         if length(maskedit1.Text)>0 then
         if sqlquery1.FieldByName('CPU_MHZ').AsInteger<>strtoint(maskedit1.Text)   then
         sqlquery1.FieldByName('CPU_MHZ').AsInteger:=strtoint(maskedit1.Text);
         if sqlquery1.FieldByName('CPU_MHZ').AsString=''{self.DBEdit7.Text=''} then sqlquery1.FieldByName('CPU_MHZ').Value:=null;
         if length(maskedit3.Text)>0 then
         if sqlquery1.FieldByName('SIZE_MEMORY_MB').AsInteger<>strtoint(maskedit3.Text) then
         sqlquery1.FieldByName('SIZE_MEMORY_MB').AsInteger:=strtoint(maskedit3.Text);
         if sqlquery1.FieldByName('SIZE_MEMORY_MB').AsString=''{self.DBEdit7.Text=''} then sqlquery1.FieldByName('SIZE_MEMORY_MB').Value:=null;
          if length(maskedit4.Text)>0 then
         if sqlquery1.FieldByName('IPADDRESS').AsString<>maskedit4.Text then
         sqlquery1.FieldByName('IPADDRESS').AsString:=maskedit4.Text;
         if sqlquery1.FieldByName('IPADDRESS').AsString=''{self.DBEdit7.Text=''} then sqlquery1.FieldByName('IPADDRESS').Value:=null;

     //------------------
         //Если добавление
          if (sqlquery1.State=db.dsInsert) then
          begin
              sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_SB_ID', sqlquery1.DataBase);
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
          self.FconnectorWrite.transaction.Commit;
  except
    on E: Exception do
      begin
           result:=false;
           if (pos('required',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','не заполнено обязательное поле'{+lineending+e.message},mtInformation,[mbOK],0)
            end else if (pos('unique_sb',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','Такой системный блок'+lineending+
              'уже есть!',mtInformation,[mbOK],0)
            end else if (pos('corr_sb_dt_dti',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','дата изготовления должна быть'+lineending+
              'раньше даты поступления',mtInformation,[mbOK],0)
            end else  MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
      end;
  end;
end;

procedure TeditSB2.memJournal;
begin
  //------------
  //запомним значения полей которые пишутся в журнал
  //для их дальнейшей проверки
  self.FmemFielf.id_start_work:= sqlquery1.FieldByName('id_start_work').AsString;
  self.FmemFielf.ID_LOCATION:= sqlquery1.FieldByName('id_location').AsString;
  if sqlquery1.FieldByName('id_NAME_OS').IsNull then self.FmemFielf.id_NAME_OS:='null' else
    self.FmemFielf.id_NAME_OS:= sqlquery1.FieldByName('id_NAME_OS').AsString;
  if sqlquery1.FieldByName('ID_WORK_SB').IsNull then self.FmemFielf.ID_WORK_SB:='null' else
    self.FmemFielf.ID_WORK_SB:= sqlquery1.FieldByName('ID_WORK_SB').AsString;
  self.FmemFielf.ID_PR_RASPR:=sqlquery1.FieldByName('ID_PR_RASPR').AsString;
  self.FmemFielf.SIZE_MEMORY_MB:=sqlquery1.FieldByName('SIZE_MEMORY_MB').AsString;
  if sqlquery1.FieldByName('STIKER').IsNull then self.FmemFielf.STIKER:='null' else
    self.FmemFielf.STIKER:=sqlquery1.FieldByName('STIKER').AsString;

  //-----------
end;

function TeditSB2.checkjournal: boolean;
var stmp1, stmp2, stmp3:string;
begin
  if sqlquery1.FieldByName('id_NAME_OS').IsNull then stmp1:='null' else
    stmp1:=sqlquery1.FieldByName('id_NAME_OS').AsString;
  if sqlquery1.FieldByName('ID_WORK_SB').IsNull then stmp2:='null' else
    stmp2:=sqlquery1.FieldByName('ID_WORK_SB').AsString;
  if sqlquery1.FieldByName('STIKER').IsNull then stmp3:='null' else
    stmp3:=sqlquery1.FieldByName('STIKER').AsString;
  result:=(sqlquery1.FieldByName('ID_LOCATION').AsString<>self.FmemFielf.ID_LOCATION) or
  (sqlquery1.FieldByName('SIZE_MEMORY_MB').AsString<>self.FmemFielf.SIZE_MEMORY_MB) or
              (sqlquery1.FieldByName('ID_PR_RASPR').AsString<>self.FmemFielf.ID_PR_RASPR)or
              (sqlquery1.FieldByName('id_start_work').AsString<>self.FmemFielf.id_start_work)or
              (stmp1<>self.FmemFielf.id_NAME_OS)or(stmp2<>self.FmemFielf.ID_WORK_SB)or(stmp3<>self.FmemFielf.STIKER);
end;

procedure TeditSB2.savejournal;
VAR SCRIPT:TSQLSCRIPT;
  stmp1, stmp2, stmp3, stmp4:string;
begin
  try
    script:=TSQLSCRIPT.Create(self);
         script.DataBase:=sqlquery1.DataBase;
         script.Transaction:=self.FconnectorWrite.transaction;
         script.CommentsInSQL:=false;
         script.UseSetTerm:=true;
         script.Script.Clear;
         if sqlquery1.FieldByName('ID_NAME_OS').IsNull then stmp1:='null' else stmp1:=SQLQUERY1.FieldByName('ID_NAME_OS').AsString;
         if sqlquery1.FieldByName('ID_WORK_SB').IsNull then stmp2:='null' else stmp2:=SQLQUERY1.FieldByName('ID_WORK_SB').AsString;
         if sqlquery1.FieldByName('SIZE_MEMORY_MB').IsNull then stmp4:='null' else stmp4:=inttostr(1000*SQLQUERY1.FieldByName('SIZE_MEMORY_MB').AsInteger);
         if sqlquery1.FieldByName('STIKER').IsNull then stmp3:='null' else stmp3:=SQLQUERY1.FieldByName('STIKER').AsString;
         if checkbox1.Checked then
         begin
           script.Script.Add('insert into MOVE_SB(ID,ID_SB,SIZE_MEMORY_MB,ID_START_WORK,ID_PR_RASPR, ID_LOCATION, ID_NAME_OS, ID_WORK_SB, STIKER) values('
           +INTTOSTR(CreateGUID('GEN_CHANGE_SB_ID',sqlquery1.DataBase))+','+
           SQLQUERY1.FieldByName('ID').AsString+','+
           stmp4+','+
           SQLQUERY1.FieldByName('ID_START_WORK').AsString+','+
           SQLQUERY1.FieldByName('ID_PR_RASPR').AsString+','+
           SQLQUERY1.FieldByName('ID_LOCATION').AsString+','+
           stmp1+','+
           stmp2+','''+
           stmp3+''');');
           script.Script.Add('commit;');
           //showmessage(script.Script.Text);
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

procedure TeditSB2.Button5Click(Sender: TObject);
begin
  Fexit:= savechange;
end;

procedure TeditSB2.Button6Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openTIP_LICENSE_OS(true);
   sqlquery4.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_LICENSE_OS').AsInteger:=nRec;
end;

procedure TeditSB2.Button7Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openTIP_MEMORY(true);
   sqlquery5.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_TIP_MEMORY').AsInteger:=nRec;
end;

procedure TeditSB2.AaddingExecute(Sender: TObject);
var od:topendialog;
  fname:string;
  qq:tsqlquery;
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
  qq.SQL.Add('select * from SVIAZ_SB_DOCS');
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
  qq.FieldByName('ID_SB').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
  qq.Post;
  qq.ApplyUpdates;
  self.FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Refresh;
  qq.Free;
  od.Free;
  if fileexists('D:\TMP\111.ltmp') then  deletefile('D:\TMP\111.ltmp');
end;

procedure TeditSB2.ADeletingExecute(Sender: TObject);
var SCRIPT:TSQLScript;
begin
  if sqlquery7.IsEmpty then exit;
   script:=tsqlscript.Create(self);
  script.DataBase:=sqlquery1.DataBase;
  script.Transaction:=self.FconnectorWrite.transaction;
  script.CommentsInSQL:=false;
  script.UseSetTerm:=true;
  script.Script.Clear;
  script.Script.Add('delete from SVIAZ_SB_DOCS where (ID='+sqlquery7.FieldByName('ID').AsString+');');
  script.Execute;
  self.FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Refresh;
  script.Free;
end;

procedure TeditSB2.AsaveingExecute(Sender: TObject);
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

procedure TeditSB2.Button10Click(Sender: TObject);
begin
   sqlquery1.FieldByName('ID_NAME_OS').Value:=null;
end;

procedure TeditSB2.Button11Click(Sender: TObject);
begin
  sqlquery1.FieldByName('ID_LICENSE_OS').Value:=null;
end;

procedure TeditSB2.Button12Click(Sender: TObject);
begin
   sqlquery1.FieldByName('ID_TIP_MEMORY').Value:=null;
end;

procedure TeditSB2.Button13Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openTIP_PROC(true);
   sqlquery8.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_TIP_PROC').AsInteger:=nRec;
end;

procedure TeditSB2.Button14Click(Sender: TObject);
begin
  sqlquery1.FieldByName('ID_TIP_PROC').Value:=null;
end;

procedure TeditSB2.Button15Click(Sender: TObject);
var
  nRec:integer;
begin
  nRec:=-1;
  nRec:=mainf.openLOCATION(true);
  sqlquery6.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_LOCATION').AsInteger:=nRec;
end;

procedure TeditSB2.Button1Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openNAME_SB(true);
   sqlquery2.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_NAME_SB').AsInteger:=nRec;
end;

procedure TeditSB2.Button2Click(Sender: TObject);
var myDOCS:TmyDOCS;
  SQLqr:TSQLQuery;
  tr:TSQLTransaction;
  stmp:string;
  ID:string;
begin
  ID:=sqlquery1.FieldByName('ID').AsString;
  if savechange then
  begin
    SQLqr:=TSQLQuery.Create(self);
    tr:= TSQLTransaction.Create(self);
    SQLqr.Transaction:=tr;
    SQLqr.DataBase:=self.Fconnector.connector;
    tr.DataBase:=self.Fconnector.connector;
    SQLqr.SQL.Clear;
    stmp:='select SB.ID, NAME_SB.NAME as sbNAME, INVENT, SB.SERIAL, PEOPLES.FAM as FIO,'+lineending+
    'SB.OTKUDA, PR_RASPR_SB.NAME as prrNAME, SB.DT, SB.DTI, STIKER, TIP_LICENSE_OS.NAME as licNAME,'+lineending+
    'TIP_WORK_SB.NAME as wsbNAME, NAME_OS.NAME as osNAME, TIP_PROC.NAME as procNAME,'+lineending+
    'SB.CPU_MHZ, SB.COUNT_IADRA, TIP_MEMORY.NAME as memNAME, SB.SIZE_MEMORY_MB, SB.DOP as DOP_INF, LOCATIONS.NAME as lNAME'+lineending+
    ''+lineending+
    ''+lineending+
    'from SB'+lineending+
    'join NAME_SB on (SB.ID_NAME_SB=NAME_SB.ID)'+lineending+
    'join START_WORK on (SB.ID_START_WORK=START_WORK.ID)'+lineending+
    'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
    'join PR_RASPR_SB on (SB.ID_PR_RASPR=PR_RASPR_SB.ID)'+lineending+
    'join TIP_WORK_SB on (SB.ID_WORK_SB=TIP_WORK_SB.ID)'+lineending+
    'join LOCATIONS on (SB.ID_LOCATION=LOCATIONS.ID)'+lineending+
    'left join TIP_PROC on (SB.ID_TIP_PROC=TIP_PROC.ID)'+lineending+
    'left join TIP_MEMORY on (SB.ID_TIP_MEMORY=TIP_MEMORY.ID)'+lineending+
    'left join NAME_OS on (SB.ID_NAME_OS=NAME_OS.ID)'+lineending+
    ''+lineending+
    'left join TIP_LICENSE_OS on (SB.ID_LICENSE_OS=TIP_LICENSE_OS.ID)'+lineending+
    'where (SB.ID = '+ID+' )';
    SQLqr.SQL.Add(stmp);
    SQLqr.Open;
    SQLqr.Locate('ID', self.SQLQuery1.FieldByName('ID').AsInteger,[]);
    SQLqr.FieldByName('ID').DisplayLabel:='идентификатор';
    SQLqr.FieldByName('sbNAME').DisplayLabel:='наименование системного блока';
    SQLqr.FieldByName('INVENT').DisplayLabel:='инвентарный';
    SQLqr.FieldByName('SERIAL').DisplayLabel:='серийный';
    SQLqr.FieldByName('FIO').DisplayLabel:='ответственный';
    SQLqr.FieldByName('OTKUDA').DisplayLabel:='откуда поступил';
    SQLqr.FieldByName('prrNAME').DisplayLabel:='признак распределения';
    SQLqr.FieldByName('DT').DisplayLabel:='дата постановки на учет';
    SQLqr.FieldByName('DTI').DisplayLabel:='дата изготовления';
    SQLqr.FieldByName('STIKER').DisplayLabel:='стикер';
    SQLqr.FieldByName('licNAME').DisplayLabel:='тип лицензии';
    SQLqr.FieldByName('wsbNAME').DisplayLabel:='направление использования';
    SQLqr.FieldByName('osNAME').DisplayLabel:='установленная ОС';
    SQLqr.FieldByName('procNAME').DisplayLabel:='тип процессора';
    SQLqr.FieldByName('CPU_MHZ').DisplayLabel:='частота процессора';
    SQLqr.FieldByName('COUNT_IADRA').DisplayLabel:='количество ядер';
    SQLqr.FieldByName('memNAME').DisplayLabel:='тип ОЗУ';
    SQLqr.FieldByName('SIZE_MEMORY_MB').DisplayLabel:='объем ОЗУ';
    SQLqr.FieldByName('DOP_INF').DisplayLabel:='дополнительная информация';
    SQLqr.FieldByName('lNAME').DisplayLabel:='местоположение';
    myDOCS:=TmyDOCS.Create(ttaKart_Slovar,ExtractFilePath(Application.ExeName),SQLqr, 'компьютер');
    //Тут всякие действия
    SQLqr.Close;
    SQLqr.Free;
    tr.Free;
    myDOCS.Free;
    Fexit:=true;
    close;
  end;
end;

procedure TeditSB2.Button3Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openNAME_OS(true);
   sqlquery11.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_NAME_OS').AsInteger:=nRec;
end;

procedure TeditSB2.Button4Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openTIP_WORK_SB(true);
   sqlquery10.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_WORK_SB').AsInteger:=nRec;
end;

procedure TeditSB2.Button8Click(Sender: TObject);
begin
  sqlquery1.Cancel;
end;

procedure TeditSB2.Button9Click(Sender: TObject);
begin
  sqlquery1.FieldByName('ID_WORK_SB').Value:=null;
end;

procedure TeditSB2.DBEdit2UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
begin
  if UTF8Key='.' then UTF8Key:=',';
  if pos(UTF8Key,'0123456789,'+#8)<=0 then UTF8Key:=#0;
end;

procedure TeditSB2.DBEdit6KeyPress(Sender: TObject; var Key: char);
begin
     if pos(Key,'1234')<=0 then Key:=#0;
end;

procedure TeditSB2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Commit;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TeditSB2.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

{function TeditSB2.FileNameToURL(FileName: string): variant;
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
end;  }

function TeditSB2.SetConnect(connector: TMyworkbd; tipQuery: TDataSetState;
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
       SQLQuery3.Transaction:=self.Fconnector.transaction;
       sqlquery3.DataBase:=self.Fconnector.connector;
       SQLQuery4.Transaction:=self.Fconnector.transaction;
       sqlquery4.DataBase:=self.Fconnector.connector;
       SQLQuery5.Transaction:=self.Fconnector.transaction;
       sqlquery5.DataBase:=self.Fconnector.connector;
       SQLQuery9.Transaction:=self.Fconnector.transaction;
       sqlquery9.DataBase:=self.Fconnector.connector;
       SQLQuery6.Transaction:=self.Fconnector.transaction;
       sqlquery6.DataBase:=self.Fconnector.connector;
       SQLQuery7.Transaction:=self.Fconnector.transaction;
       sqlquery7.DataBase:=self.Fconnector.connector;
       SQLQuery8.Transaction:=self.Fconnector.transaction;
       sqlquery8.DataBase:=self.Fconnector.connector;
       SQLQuery10.Transaction:=self.Fconnector.transaction;
       sqlquery10.DataBase:=self.Fconnector.connector;
       SQLQuery11.Transaction:=self.Fconnector.transaction;
       sqlquery11.DataBase:=self.Fconnector.connector;
  end;
  //*****************

  //Откроем наборы
  //***************
  sqlquery3.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery3.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery6.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery1.Open;
  sqlquery2.Open;
  sqlquery3.Open;
  sqlquery4.Open;
  sqlquery5.Open;
  sqlquery6.Open;
  sqlquery8.Open;
  sqlquery9.Open;
  sqlquery10.Open;
  sqlquery11.Open;

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

  if not (tipQuery=dsBrowse) then
  begin
    sqlquery7.ParamByName('id_SB').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
    sqlquery7.Open;
  end;

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
       self.Caption:='просмотр системника';     //Заголовок
       maskedit1.Text:= sqlquery1.FieldByName('CPU_MHZ').AsString;
       maskedit3.Text:= sqlquery1.FieldByName('SIZE_MEMORY_MB').AsString;
       maskedit4.Text:= sqlquery1.FieldByName('IPADDRESS').AsString;
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
           self.Caption:='редактирование Системника'; //Заголовок
           //Заблокируем все
           //**************
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
           //**************

           //Разблокируем только, то что нужно
           //******************
           checkbox1.Enabled:=true;
           button1.Enabled:=true;
           button2.Enabled:=true;
           button4.Enabled:=true;
           button5.Enabled:=true;
           button8.Enabled:=true;
           button9.Enabled:=true;
           button13.Enabled:=true;
           button14.Enabled:=true;
           button15.Enabled:=true;
           toolbutton14.Enabled:=true;
           toolbutton15.Enabled:=true;
           toolbutton16.Enabled:=true;
           DBLookupComboBox1.Enabled:=true;
           DBLookupComboBox2.Enabled:=true;
           DBLookupComboBox3.Enabled:=true;
           DBLookupComboBox4.Enabled:=true;
           DBLookupComboBox5.Enabled:=true;
           DBLookupComboBox6.Enabled:=true;
           DBLookupComboBox7.Enabled:=true;
           DBLookupComboBox8.Enabled:=true;
           DBLookupComboBox9.Enabled:=true;
           DBDateTimePicker2.Enabled:=true;
           dbedit3.ReadOnly:=false;
           dbedit4.ReadOnly:=false;
           dbedit5.ReadOnly:=false;
           dbedit6.ReadOnly:=false;
           dbmemo1.ReadOnly:=false;
           maskedit1.ReadOnly:=false;
           maskedit3.ReadOnly:=false;
           maskedit4.ReadOnly:=false;
           //*******************
           memJournal;//Запомним значения полей которые пишутся в журнал
           maskedit1.Text:= sqlquery1.FieldByName('CPU_MHZ').AsString;
           maskedit3.Text:= sqlquery1.FieldByName('SIZE_MEMORY_MB').AsString;
           maskedit4.Text:= sqlquery1.FieldByName('IPADDRESS').AsString;
    end;
  dsInsert:
    begin
         //Вставка
      self.Caption:='добавление МНИ';//Заголовок
         sqlquery1.Insert;
    end;
  end;
  //****************
  //Сдклаем активной первую вкладку
  pagecontrol1.ActivePage:=tabsheet1;
  result:=true;
end;

end.


