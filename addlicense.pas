unit addLicense;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, DBDateTimePicker, {MyMaskEdit,} Forms,
  Controls, Graphics, Dialogs, StdCtrls, DbCtrls, DBGrids, ComCtrls, ActnList,
  Menus, lazfileutils, LCLType, MaskEdit, Buttons, workBD, Types;

type
  //запомним значения полей которые пишутся в журнал
      //для их дальнейшей проверки
      TMymemField=record
      ID_GROUP:string;
      ID_LOCATION:STRING;
      FFAM:STRING;
      ID_POST:string;
      end;

  { TeditLicense }

  TeditLicense = class(TForm)
    Aadding: TAction;
    ActionList1: TActionList;
    Asaveing: TAction;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Button5: TButton;
    Button8: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    GroupBox1: TGroupBox;
    ImageList1: TImageList;
    Label16: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label5: TLabel;
    lblNameOP: TLabel;
    lblNameOP1: TLabel;
    lblNameOP3: TLabel;
    lblNameOP4: TLabel;
    PageControl1: TPageControl;
    SQLQuery1: TSQLQuery;
    SQLQuery1DTR: TDateTimeField;
    SQLQuery1ID: TLongintField;
    SQLQuery1ID_LIC_PO: TLongintField;
    SQLQuery1ID_RAION: TLongintField;
    SQLQuery1ID_USER: TLongintField;
    SQLQuery1KEYPO1: TStringField;
    SQLQuery1KEYPO2: TStringField;
    SQLQuery1KEYPO3: TStringField;
    SQLQuery1NUMBERL: TStringField;
    SQLQuery1PICLICENSE: TBlobField;
    SQLQuery1PICNAME: TStringField;
    SQLQuery2: TSQLQuery;
    edit1: TStaticText;
    TabSheet1: TTabSheet;
    procedure AaddingExecute(Sender: TObject);
    procedure AsaveingExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
  private
    //запомним значения полей которые пишутся в журнал
    //для их дальнейшей проверки
    FmemFielf:TMymemField;
    Fconnector: TMyworkbd;
    FconnectorWrite:TMyworkbd;
    Fexit:boolean;
    function savechange:boolean;
    //procedure memJournal;
    function checkjournal:boolean;
    //procedure savejournal;
    { private declarations }
  public
    { public declarations }
    function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
  end;

var
  editLicense: TeditLicense;

implementation
uses  main;
{$R *.lfm}

{ TeditLicense }

procedure TeditLicense.FormCreate(Sender: TObject);
begin
  Fexit:=true;
end;

function TeditLicense.savechange: boolean;
begin
  result:=false;
  try
      if (not (sqlquery1.Modified)) then exit;

     //------------------
         //Если добавление
          if (sqlquery1.State=db.dsInsert) then
          begin
              sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_LICENSE_ID', sqlquery1.DataBase);
              sqlquery1.FieldByName('id_raion').Value:=id_raion;
              sqlquery1.FieldByName('id_user').Value:=id_user;
          end;
          sqlquery1.Post;
          sqlquery1.ApplyUpdates;
          result:=true;
          self.FconnectorWrite.transaction.CommitRetaining;
          //Если редактирование прошло успешно, то добавляем запись в журнал
          //если есть изменения
         // if checkjournal then  savejournal;
          //подтверждаем и завершаем транзакцию
          self.FconnectorWrite.transaction.Commit;
  except
    on E: Exception do
      begin
           result:=false;
            if (pos('requi',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','Незаполненно обязательное поле',mtInformation,[mbOK],0)
            end else MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
      end;
  end;
end;

{procedure TeditLicense.memJournal;
begin
  //------------
  //запомним значения полей которые пишутся в журнал
  //для их дальнейшей проверки
  sqlquery2.Locate('id',sqlquery1.FieldByName('id_people').AsInteger,[]);
  self.FmemFielf.FFAM:=sqlquery2.FieldByName('fam').AsString;
  self.FmemFielf.ID_LOCATION:= sqlquery1.FieldByName('id_location').AsString;
  self.FmemFielf.ID_GROUP:=sqlquery1.FieldByName('id_group').AsString;
  self.FmemFielf.ID_POST:=sqlquery1.FieldByName('id_post').AsString;
  //-----------
end;  }

function TeditLicense.checkjournal: boolean;
begin
  sqlquery2.Locate('id',sqlquery1.FieldByName('id_people').AsInteger,[]);
  result:=(sqlquery1.FieldByName('id_group').AsString<>self.FmemFielf.ID_GROUP) or
              (sqlquery1.FieldByName('id_post').AsString<>self.FmemFielf.ID_POST)or
              (sqlquery1.FieldByName('id_location').AsString<>self.FmemFielf.ID_LOCATION)or
              (sqlquery2.FieldByName('FAM').AsString<>self.FmemFielf.FFAM);
end;

{procedure TeditLicense.savejournal;
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
end;   }

function TeditLicense.SetConnect(connector: TMyworkbd; tipQuery: TDataSetState;
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
       { SQLQuery3.Transaction:=self.Fconnector.transaction;
        sqlquery3.DataBase:=self.Fconnector.connector;
        SQLQuery4.Transaction:=self.Fconnector.transaction;
        sqlquery4.DataBase:=self.Fconnector.connector;
        SQLQuery5.Transaction:=self.Fconnector.transaction;
        sqlquery5.DataBase:=self.Fconnector.connector;
        SQLQuery7.Transaction:=self.Fconnector.transaction;
        sqlquery7.DataBase:=self.Fconnector.connector;
        SQLQuery8.Transaction:=self.Fconnector.transaction;
        sqlquery8.DataBase:=self.Fconnector.connector;}
  end;
  //*****************

  //Откроем наборы
  //***************
 // sqlquery2.ParamByName('id_raion').AsInteger:=id_raion;
 // sqlquery8.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery1.Open;
  sqlquery2.Open;
  {sqlquery3.Open;
  sqlquery4.Open;
  sqlquery5.Open;
  sqlquery8.Open;  }
{  if not ((tipQuery=dsInsert)) then
  begin
    sqlquery7.ParamByName('id_sw').AsInteger:=editing_id;
    sqlquery7.Open;
  end;    }
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
       self.Aadding.Enabled:=false;
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
       self.Caption:='просмотр лицензии';//Заголовок
       edit1.Font.Color:=clwhite;
       edit1.Color:=TColor($00bb00);//clgreen;
       self.Asaveing.Enabled:=true;
       self.Edit1.Caption:='имеется';
      // maskedit1.Text:= sqlquery1.FieldByName('NETNAME').AsString;
    end;
  {dsEdit:
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
           //checkbox1.Enabled:=true;
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
           //checkbox1.Enabled:=true;
           {button2.Enabled:=true;
           button3.Enabled:=true; }
           button5.Enabled:=true;
           {button6.Enabled:=true;
           button7.Enabled:=true;
           button7.Visible:=true; }
           button8.Enabled:=true;
          // button9.Enabled:=true;
           {DBLookupComboBox2.Enabled:=true;
           DBLookupComboBox3.Enabled:=true;
           DBLookupComboBox5.Enabled:=true; }
           //dbmemo1.ReadOnly:=false;
           //maskedit1.ReadOnly:=false;
           //*******************
           //memJournal;//Запомним значения полей которые пишутся в журнал
           //maskedit1.Text:= sqlquery1.FieldByName('NETNAME').AsString;
    end;  }
  dsInsert:
    begin
         //Вставка
       self.Caption:='добавление лицензии';//Заголовок
         sqlquery1.Insert;
    end;
  end;
  //****************
  //Сдклаем активной первую вкладку
  pagecontrol1.ActivePage:=tabsheet1;
  result:=true;
end;

procedure TeditLicense.Button5Click(Sender: TObject);
begin
  Fexit:= savechange;
end;

procedure TeditLicense.AaddingExecute(Sender: TObject);
var od:topendialog;
  fname:string;
  qq:tsqlquery;
  stmp:string;
  ms:TFileStream;
begin
  stmp:='';
  od:=topendialog.Create(self.Owner);
  od.Filter:='всё|*.*|изображение|*.jpg;*gif;*tiff|документ|*.doc;*.docx;*.xls;*.xlsx;*.rtf;*.odt;*.ods|архив|*.zip;*.rar;*.7z';
  if not  od.Execute then
  begin
       od.Free;
       exit;
  end;
  fname:=ExtractFileName(od.FileName);
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
    od.Free;
    exit;
  end else if (ms.Size/(1048576))>0.5 then
  begin
    MessageDlg('Предупреждение','рекомендуемый размер файлов до 0.5Мб',mtInformation,[mbOK],0);
  end;
  ms.Free;
  tblobfield(self.SQLQuery1.FieldByName('piclicense')).LoadFromFile('D:\TMP\111.ltmp');
  SQLQuery1.FieldByName('picname').Value:=fname;
  edit1.Font.Color:=clwhite;
  edit1.Color:=TColor($00bb00);//clgreen;
  self.Asaveing.Enabled:=true;
  self.Edit1.Caption:='имеется';
  od.Free;
  if fileexists('D:\TMP\111.ltmp') then  deletefile('D:\TMP\111.ltmp');
end;

procedure TeditLicense.AsaveingExecute(Sender: TObject);
var sd:tsavedialog;
begin
     sd:=tsavedialog.Create(self.Owner);
     sd.Filter:='|*.*';
     sd.FileName:=sqlquery1.FieldByName('picname').AsString;
  if not  sd.Execute then exit;
  if DirectoryExists('D:\TMP') then
   begin
     if fileexists('D:\TMP\111.ltmp') then  deletefile('D:\TMP\111.ltmp');
   end  else
   begin
     CreateDir('D:\TMP');
   end;
  tblobfield(sqlquery1.FieldByName('piclicense')).SaveToFile('D:\TMP\111.ltmp');
  RenameFileUTF8('D:\TMP\111.ltmp', sd.FileName);
  sd.Free;
end;

procedure TeditLicense.Button1Click(Sender: TObject);
var
  nRec, i:integer;
begin
   nRec:=-1;
   nRec:=mainf.openLicPO(true);
   i:=self.SQLQuery1.FieldByName('ID_lic_po').AsInteger;
   sqlquery2.Close;
   sqlquery2.Open;
   self.SQLQuery1.FieldByName('ID_lic_po').AsInteger:=i;
   sqlquery2.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_lic_po').AsInteger:=nRec;
end;



procedure TeditLicense.Button8Click(Sender: TObject);
begin
  sqlquery1.Cancel;
end;

procedure TeditLicense.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Rollback;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TeditLicense.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

end.

