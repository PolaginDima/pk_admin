unit addkripto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, DBDateTimePicker, Forms, Controls,
  Graphics, Dialogs, StdCtrls, DbCtrls, DBGrids, ComCtrls, ActnList, Menus,
  lclproc, LCLType, Buttons, fileprocs, variants, {types,} workbd;

type
  { TeditKRIPTO }
   //запомним значения полей которые пишутся в журнал
      //для их дальнейшей проверки
      TMymemField=record
      ID_SB:string;
      ID_KRIPTO:string;
      ID_KRIPTO_NAME:string;
      end;
  TeditKRIPTO = class(TForm)
    Aadding: TAction;
    ActionList1: TActionList;
    ADeleting: TAction;
    Asaveing: TAction;
    AUpdating: TAction;
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button10: TButton;
    Button5: TButton;
    Button6: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    DataSource6: TDataSource;
    DataSource7: TDataSource;
    DataSource9: TDataSource;
    DBDateTimePicker1: TDBDateTimePicker;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox6: TDBLookupComboBox;
    DBLookupComboBox7: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    ImageList1: TImageList;
    Label1: TLabel;
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
    Label23: TLabel;
    Label3: TLabel;
    Label5: TLabel;
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
    SQLQuery1ID: TLongintField;
    SQLQuery1ID_KRIPTO: TLongintField;
    SQLQuery1ID_MNI: TLongintField;
    SQLQuery1ID_RAION: TLongintField;
    SQLQuery1ID_SB: TLongintField;
    SQLQuery1ID_SERTIFIKATS: TLongintField;
    SQLQuery1ID_START_WORK: TLongintField;
    SQLQuery1ID_USER: TLongintField;
    SQLQuery1NUMBER_COPY: TStringField;
    SQLQuery1OTKUDA: TStringField;
    SQLQuery1SERIAL: TStringField;
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
    SQLQuery9: TSQLQuery;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ToolBar5: TToolBar;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    procedure AaddingExecute(Sender: TObject);
    procedure ADeletingExecute(Sender: TObject);
    procedure AsaveingExecute(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    Fconnector: TMyworkbd;
    { private declarations }
    FconnectorWrite:TMyworkbd;
    FmemFielf:TMymemField;
    Fexit:boolean;
    function savechange(exiting:boolean=true):boolean;
    //function FileNameToURL(FileName: string): variant;
    procedure memJournal;
    function checkjournal:boolean;
    procedure savejournal;
  public
    { public declarations }
    function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
  end;

var
  editKRIPTO: TeditKRIPTO;

implementation
uses  main, addsertifikat;
{$R *.lfm}

{ TeditKRIPTO }

procedure TeditKRIPTO.FormCreate(Sender: TObject);
begin
  Fexit:=true;
end;

procedure TeditKRIPTO.PageControl1Change(Sender: TObject);
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

function TeditKRIPTO.savechange(exiting: boolean): boolean;
begin
  result:=false;
  try
         if not (sqlquery1.Modified) then exit;
           //------------------
         //Если добавление
          if (sqlquery1.State=db.dsInsert) then
          begin
              sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_KRIPTO_ID', sqlquery1.DataBase);
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
              MessageDlg('Ошибка','не заполненно обязательное поле',mtInformation,[mbOK],0)
            end else if (pos('UNIQUE_COPY_KRIPTO_UCHETN',uppercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','Такой экземпляр уже есть',mtInformation,[mbOK],0)
            end else if (pos('dt_ck_incorrect_operation',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','дата приема работника'+lineending+
              'меньше даты регистрации криптосредства',mtInformation,[mbOK],0)
            end else if (pos('corr_kripto_vvod',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','обязательно к заполнению одно из полей'+lineending+
              'МНИ, номер экземпляра, серийный номер',mtInformation,[mbOK],0)
            end else MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
      end;
  end;
end;

procedure TeditKRIPTO.memJournal;
begin
  //------------
  //запомним значения полей которые пишутся в журнал
  //для их дальнейшей проверки
  //sqlquery5.Locate('id',sqlquery1.FieldByName('id_sb').AsInteger,[]);
  self.FmemFielf.ID_SB:=sqlquery1.FieldByName('id_sb').AsString;
  self.FmemFielf.ID_KRIPTO:=sqlquery1.FieldByName('id').AsString;
  self.FmemFielf.ID_KRIPTO_NAME:=sqlquery1.FieldByName('id_kripto').AsString;
  //-----------
end;

function TeditKRIPTO.checkjournal: boolean;
begin
   //sqlquery5.Locate('id',sqlquery1.FieldByName('id_sb').AsInteger,[]);
   result:=(sqlquery1.FieldByName('id_sb').AsString<>self.FmemFielf.ID_SB)or
   (sqlquery1.FieldByName('id').AsString<>self.FmemFielf.ID_KRIPTO)or
   (sqlquery1.FieldByName('id_kripto').AsString<>self.FmemFielf.ID_KRIPTO_NAME);
end;

procedure TeditKRIPTO.savejournal;
VAR SCRIPT:TSQLSCRIPT;
  //stmp1:string;
begin
  try
    script:=TSQLSCRIPT.Create(self);
         script.DataBase:=sqlquery1.DataBase;
         script.Transaction:=self.FconnectorWrite.transaction;
         script.CommentsInSQL:=false;
         script.UseSetTerm:=true;
         script.Script.Clear;
         {if not SQLQUERY5.Locate('id',sqlquery1.FieldByName('id_sb').AsInteger,[]) then
         begin
           script.Free;
           exit;
         end;}
         //if sqlquery1.FieldByName('id_group').IsNull then stmp1:='null' else stmp1:=SQLQUERY1.FieldByName('ID_GROUP').AsString;
         if checkbox1.Checked then
         begin
           script.Script.Add('insert into MOVE_KRIPTO(ID_SB,ID_KRIPTO,ID_KRIPTO_NAME) values('+
           //+INTTOSTR(CreateGUID('GEN_MOVE_KRIPTO_ID', sqlquery1.DataBase))+','+
           SQLQUERY1.FieldByName('ID_SB').AsString+','+lineending+
           SQLQUERY1.FieldByName('ID').AsString+','+lineending+
           SQLQUERY1.FieldByName('ID_KRIPTO').AsString+');');
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

function TeditKRIPTO.SetConnect(connector: TMyworkbd; tipQuery: TDataSetState;
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
       SQLQuery7.Transaction:=self.Fconnector.transaction;
       sqlquery7.DataBase:=self.Fconnector.connector;
       //SQLQuery8.Transaction:=self.Fconnector.transaction;
       //sqlquery8.DataBase:=self.Fconnector.connector;
       SQLQuery9.Transaction:=self.Fconnector.transaction;
       sqlquery9.DataBase:=self.Fconnector.connector;
  end;
  //*****************

  //Откроем наборы
  //***************
  sqlquery3.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery4.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery5.ParamByName('id_raion').AsInteger:=id_raion;
  //sqlquery8.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery1.Open;
  sqlquery2.Open;
  sqlquery3.Open;
  sqlquery4.Open;
  sqlquery5.Open;
  //sqlquery8.Open;
  sqlquery9.Open;
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
    sqlquery7.ParamByName('id_KRIPTO').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
    sqlquery7.Open;
  end;

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
           self.Caption:='редактирование экземпляра криптосредства'; //Заголовок
           //Заблокируем все
           //**************
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


           self.DBEdit3.ReadOnly:=false;
           self.DBEdit4.ReadOnly:=false;

           //**************

           //Разблокируем только, то что нужно
           self.DBLookupComboBox2.Enabled:=true;
           self.DBLookupComboBox3.Enabled:=true;
           self.DBLookupComboBox7.Enabled:=true;
           self.DBLookupComboBox6.Enabled:=true;
           self.CheckBox1.Enabled:=true;
           self.Button10.Enabled:=true;
           button1.Enabled:=true;
           //*******************
           memJournal;//Запомним значения полей которые пишутся в журнал
           button5.Enabled:=true;
           dbmemo1.ReadOnly:=false;
           //*******************
    end;
  dsInsert:
    begin
         //Вставка
      self.Caption:='добавление экземпляра криптосредства'; //Заголовок
      sqlquery1.Insert;
    end;
  end;
  //****************
  //Сдклаем активной первую вкладку
  pagecontrol1.ActivePage:=tabsheet1;
  result:=true;
end;

procedure TeditKRIPTO.Button5Click(Sender: TObject);
begin
  Fexit:= savechange;
end;

procedure TeditKRIPTO.AaddingExecute(Sender: TObject);
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
  qq.FieldByName('ID_KRIPTO').AsInteger:=sqlquery1.FieldByName('ID').AsInteger;
  qq.Post;
  qq.ApplyUpdates;
  self.FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Refresh;
  qq.Free;
  od.Free;
  if fileexists('D:\TMP\111.ltmp') then  deletefile('D:\TMP\111.ltmp');
end;

procedure TeditKRIPTO.ADeletingExecute(Sender: TObject);
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
  script.Execute;
  self.FconnectorWrite.transaction.CommitRetaining;
  sqlquery7.Refresh;
  script.Free;
end;

procedure TeditKRIPTO.AsaveingExecute(Sender: TObject);
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

procedure TeditKRIPTO.BitBtn1Click(Sender: TObject);
var
  {nrec,}i:integer;
begin
  editSert:=TeditSert.Create(mainF);
            if editSert.SetConnect(self.Fconnector)and(editSert.ShowModal=mrok) then
            begin
              if not self.SQLQuery1.FieldByName('ID_SERTIFIKATS').IsNull then
             i:=self.SQLQuery1.FieldByName('ID_SERTIFIKATS').AsInteger;
             sqlquery9.Close;
             sqlquery9.Open;
             self.SQLQuery1.FieldByName('ID_SERTIFIKATS').AsInteger:=i;
            end;
            editSert.Free;
end;

procedure TeditKRIPTO.Button10Click(Sender: TObject);
begin
  sqlquery1.FieldByName('id_SERTIFIKATS').Value:=null;
end;

procedure TeditKRIPTO.Button1Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openKripto(true);
   sqlquery2.Close;
   sqlquery2.Open;
   sqlquery2.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_KRIPTO').AsInteger:=nRec;
end;

procedure TeditKRIPTO.Button8Click(Sender: TObject);
begin
  sqlquery1.Cancel;
end;

procedure TeditKRIPTO.Button9Click(Sender: TObject);
begin
  sqlquery1.FieldByName('id_MNI').Value:=null;
end;

procedure TeditKRIPTO.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Rollback;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TeditKRIPTO.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

{procedure TeditKRIPTO.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
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
end;}

end.

