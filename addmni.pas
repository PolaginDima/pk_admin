unit addmni;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, DBDateTimePicker, Forms, Controls,
  Graphics, Dialogs, StdCtrls, DbCtrls, DBGrids, ComCtrls, ActnList, Menus,
  lazutf8, lazfileutils, LCLType, MaskEdit{, PairSplitter}, fileprocs, variants, workBD;

type
  //запомним значения полей которые пишутся в журнал
    //для их дальнейшей проверки
    TMymemField=record
    id_start_work:string;
    ID_KEY:STRING;
    UCHETN:STRING;
    ID_PR_RASPR:string;
    ID_SB:string;
    end;

  { TeditMNI }

  TeditMNI = class(TForm)
    Aadding: TAction;
    ActionList1: TActionList;
    ADeleting: TAction;
    Asaveing: TAction;
    AUpdating: TAction;
    Button1: TButton;
    Button10: TButton;
    Button3: TButton;
    Button5: TButton;
    Button6: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    DataSource1: TDataSource;
    DataSource10: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    DataSource7: TDataSource;
    DataSource8: TDataSource;
    DataSource9: TDataSource;
    DBDateTimePicker1: TDBDateTimePicker;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    DBLookupComboBox5: TDBLookupComboBox;
    DBLookupComboBox6: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    DBText1: TDBText;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MaskEdit1: TMaskEdit;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    PageControl1: TPageControl;
    PopupMenu1: TPopupMenu;
    SQLQuery1: TSQLQuery;
    SQLQuery10: TSQLQuery;
    SQLQuery1DOP: TStringField;
    SQLQuery1DT: TDateField;
    SQLQuery1DTR: TDateTimeField;
    SQLQuery1ID: TLongintField;
    SQLQuery1ID_KEY: TSmallintField;
    SQLQuery1ID_MODEL: TLongintField;
    SQLQuery1ID_PR_RASPR: TSmallintField;
    SQLQuery1ID_RAION: TLongintField;
    SQLQuery1ID_SB: TLongintField;
    SQLQuery1ID_START_WORK: TLongintField;
    SQLQuery1ID_TIP: TLongintField;
    SQLQuery1ID_USER: TLongintField;
    SQLQuery1OTKUDA: TStringField;
    SQLQuery1SERIAL: TStringField;
    SQLQuery1SSIZE: TFMTBCDField;
    SQLQuery1UCHETN: TStringField;
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
    SQLQuery9: TSQLQuery;
    SQLTransaction2: TSQLTransaction;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ToolBar5: TToolBar;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    procedure AaddingExecute(Sender: TObject);
    procedure ADeletingExecute(Sender: TObject);
    procedure AsaveingExecute(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure DBEdit2UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure MaskEdit1Change(Sender: TObject);
    procedure MaskEdit1Exit(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    FconnectorWrite:TMyworkbd;
    Fconnector: TMyworkbd;
    { private declarations }
    //запомним значения полей которые пишутся в журнал
    //для их дальнейшей проверки
    FmemFielf:TMymemField;
    Fexit:boolean;
    function savechange(exiting:boolean=true):boolean;
    procedure memJournal;
    function checkjournal:boolean;
    procedure savejournal;
    function delbackspacetext(const txt:string):string;
    //function FileNameToURL(FileName: string): variant;
    const maska = '!00\/009;1;_';
  public
    { public declarations }
    function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
  end;

var
  editMNI: TeditMNI;

implementation
uses  main;
{$R *.lfm}

{ TeditMNI }

procedure TeditMNI.FormCreate(Sender: TObject);
begin
  Fexit:=true;
end;

procedure TeditMNI.MaskEdit1Change(Sender: TObject);
begin

end;

procedure TeditMNI.MaskEdit1Exit(Sender: TObject);
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

procedure TeditMNI.PageControl1Change(Sender: TObject);
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
           sqlquery7.ParamByName('id_mni').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
           sqlquery7.Open;
           if sqlquery1.State<>db.dsEdit then sqlquery1.Edit;
         end else pagecontrol1.ActivePageIndex:=0;;
    end;
  end;
end;

function TeditMNI.savechange(exiting: boolean): boolean;
begin
  result:=false;
  try
         if  sqlquery1.FieldByName('UCHETN').AsString<>delbackspacetext(maskedit1.Text) then
         sqlquery1.FieldByName('UCHETN').AsString:=delbackspacetext(maskedit1.Text);
         if not (sqlquery1.Modified) then exit;
           //------------------
         //Если добавление
          if (sqlquery1.State=db.dsInsert) then
          begin
              sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_MNI_ID', sqlquery1.DataBase);
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
                 //И еще раз чтобы были изменения
                 self.SQLQuery1.Edit;
                 self.SQLQuery1.FieldByName('ID').AsInteger:=self.SQLQuery1.FieldByName('ID').AsInteger;
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
           if (pos('required',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','не заполнено обязательное поле',mtInformation,[mbOK],0)
            end else if (pos('unique_mni_uchetn',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','МНИ с таким учетным номером'+lineending+
              'уже есть',mtInformation,[mbOK],0)
            end else if (pos('this is serial mni exists',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','МНИ с таким серийным номером'+lineending+
              'уже есть',mtInformation,[mbOK],0)
            end else  MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
      end;
  end;
end;

procedure TeditMNI.memJournal;
begin
  //------------
  //запомним значения полей которые пишутся в журнал
  //для их дальнейшей проверки
  self.FmemFielf.id_start_work:= sqlquery1.FieldByName('id_start_work').AsString;
  SELF.FmemFielf.ID_KEY:=sqlquery1.FieldByName('id_key').AsString;
  self.FmemFielf.ID_PR_RASPR:=sqlquery1.FieldByName('ID_PR_RASPR').AsString;
  self.FmemFielf.UCHETN:=sqlquery1.FieldByName('UCHETN').AsString;
  if sqlquery1.FieldByName('ID_SB').IsNull then self.FmemFielf.ID_SB:='null' else
    self.FmemFielf.ID_SB:=sqlquery1.FieldByName('ID_SB').AsString;
  //-----------
end;

function TeditMNI.checkjournal: boolean;
var stmp:string;
begin
  if sqlquery1.FieldByName('ID_SB').IsNull then stmp:='null' else
    stmp:=sqlquery1.FieldByName('ID_SB').AsString;
  result:=(sqlquery1.FieldByName('id_key').AsString<>self.FmemFielf.id_key) or
  (sqlquery1.FieldByName('ID_PR_RASPR').AsString<>self.FmemFielf.ID_PR_RASPR)or
              (sqlquery1.FieldByName('id_start_work').AsString<>self.FmemFielf.id_start_work)or
              (sqlquery1.FieldByName('UCHETN').AsString<>self.FmemFielf.UCHETN)or
              (stmp<>self.FmemFielf.ID_SB);
end;

procedure TeditMNI.savejournal;
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
         if sqlquery1.FieldByName('ID_SB').IsNull then stmp1:='null' else stmp1:=SQLQUERY1.FieldByName('ID_SB').AsString;
         if checkbox1.Checked then
         begin
           script.Script.Add('insert into MOVE_MNI(ID,ID_MNI,ID_KEY,ID_START_WORK,ID_PR_RASPR, UCHETN, ID_SB) values('
           +INTTOSTR(CreateGUID('GEN_CHANGE_MNI_ID', sqlquery1.DataBase))+','+
           SQLQUERY1.FieldByName('ID').AsString+','+
           SQLQUERY1.FieldByName('ID_KEY').AsString+','+
           SQLQUERY1.FieldByName('ID_START_WORK').AsString+','+
           SQLQUERY1.FieldByName('ID_PR_RASPR').AsString+','+
           SQLQUERY1.FieldByName('UCHETN').AsString+','+
           stmp1+');');
           script.Script.Add('commit;');
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

function TeditMNI.delbackspacetext(const txt: string): string;
var i:integer;
begin
  result:='';
  for i:=1 to utf8length(txt) do
  begin
       if utf8copy(txt,i,1)<>' ' then result:=result+ utf8copy(txt,i,1);
  end;
end;

function TeditMNI.SetConnect(connector: TMyworkbd; tipQuery: TDataSetState;
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
       SQLQuery7.Transaction:=self.Fconnector.transaction;
       sqlquery7.DataBase:=self.Fconnector.connector;
       SQLQuery8.Transaction:=self.Fconnector.transaction;
       sqlquery8.DataBase:=self.Fconnector.connector;
       SQLQuery10.Transaction:=self.Fconnector.transaction;
       sqlquery10.DataBase:=self.Fconnector.connector;
  end;
  //*****************

  //Откроем наборы
  //***************
  sqlquery3.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery1.Open;
  sqlquery2.Open;
  sqlquery3.Open;
  sqlquery4.Open;
  sqlquery5.Open;
  sqlquery8.Open;
  sqlquery9.Open;
  sqlquery10.Open;
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
    sqlquery7.ParamByName('id_mni').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
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
       self.Caption:='просмотр МНИ';//Заголовок
       maskedit1.Text:=sqlquery1.FieldByName('UCHETN').AsString;
         if delbackspacetext(maskedit1.Text)<>delbackspacetext(sqlquery1.FieldByName('UCHETN').AsString) then
         begin
           maskedit1.EditMask:='';
           maskedit1.Text:=delbackspacetext(sqlquery1.FieldByName('UCHETN').AsString);
         end;
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
           self.Caption:='редактирование МНИ';//Заголовок

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
           button5.Enabled:=true;
           button8.Enabled:=true;
           button10.Enabled:=true;
           toolbutton14.Enabled:=true;
           toolbutton15.Enabled:=true;
           toolbutton16.Enabled:=true;
           DBLookupComboBox1.Enabled:=true;
           DBLookupComboBox3.Enabled:=true;
           DBLookupComboBox4.Enabled:=true;
           DBLookupComboBox5.Enabled:=true;
           DBLookupComboBox6.Enabled:=true;
           dbedit2.ReadOnly:=false;
           dbedit3.ReadOnly:=false;
           dbmemo1.ReadOnly:=false;
           //*******************
           memJournal;//Запомним значения полей которые пишутся в журнал
           maskedit1.Text:=sqlquery1.FieldByName('UCHETN').AsString;
           if delbackspacetext(maskedit1.Text)<>delbackspacetext(sqlquery1.FieldByName('UCHETN').AsString) then
           begin
             maskedit1.EditMask:='';
             maskedit1.Text:=delbackspacetext(sqlquery1.FieldByName('UCHETN').AsString);
           end;
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

procedure TeditMNI.Button5Click(Sender: TObject);
begin
  Fexit:= savechange;
end;

procedure TeditMNI.AaddingExecute(Sender: TObject);
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
  qq.SQL.Add('select * from SVIAZ_MNI_DOCS');
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
  qq.FieldByName('ID_MNI').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
  qq.Post;
  qq.ApplyUpdates;
  self.FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Refresh;
  qq.Free;
  od.Free;
  if fileexists('D:\TMP\111.ltmp') then  deletefile('D:\TMP\111.ltmp');
end;

procedure TeditMNI.ADeletingExecute(Sender: TObject);
var SCRIPT:TSQLScript;
begin
  if sqlquery7.IsEmpty then exit;
   script:=tsqlscript.Create(self);
  script.DataBase:=sqlquery1.DataBase;
  script.Transaction:=self.FconnectorWrite.transaction;
  script.CommentsInSQL:=false;
  script.UseSetTerm:=true;
  script.Script.Clear;
  script.Script.Add('delete from SVIAZ_MNI_DOCS where (ID='+sqlquery7.FieldByName('ID').AsString+');');
  script.Execute;
  self.FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Refresh;
  script.Free;
end;

procedure TeditMNI.AsaveingExecute(Sender: TObject);
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

procedure TeditMNI.Button10Click(Sender: TObject);
begin
  sqlquery1.FieldByName('id_sb').Value:=null;
end;

procedure TeditMNI.Button1Click(Sender: TObject);
var
  nRec, i:integer;
begin
   nRec:=-1;
   nRec:=mainf.openMNIMODEL(true);
   i:=self.SQLQuery1.FieldByName('ID_MODEL').AsInteger;
   sqlquery2.Close;
   sqlquery2.Open;
   self.SQLQuery1.FieldByName('ID_MODEL').AsInteger:=i;
   sqlquery2.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_MODEL').AsInteger:=nRec;
end;

procedure TeditMNI.Button3Click(Sender: TObject);
var
  nRec, i:integer;
begin
   nRec:=-1;
   nRec:=mainf.openMNITIP(true);
   i:=self.SQLQuery1.FieldByName('ID_TIP').AsInteger;
   sqlquery4.Close;
   sqlquery4.Open;
   self.SQLQuery1.FieldByName('ID_TIP').AsInteger:=i;
   sqlquery4.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_TIP').AsInteger:=nRec;
end;

procedure TeditMNI.Button8Click(Sender: TObject);
begin
  sqlquery1.Cancel;
end;

procedure TeditMNI.Button9Click(Sender: TObject);
begin
  sqlquery1.FieldByName('id_model').Value:=null;
end;

procedure TeditMNI.CheckBox2Change(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked then MaskEdit1.EditMask:='' else MaskEdit1.EditMask:=maska;
end;

procedure TeditMNI.DBEdit2UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
begin
  if UTF8Key='.' then UTF8Key:=',';
  if pos(UTF8Key,'0123456789,'+#8)<=0 then UTF8Key:=#0;
end;

procedure TeditMNI.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Rollback;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TeditMNI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

{function TeditMNI.FileNameToURL(FileName: string): variant;
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
end; }

end.

