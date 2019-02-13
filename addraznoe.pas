unit addraznoe;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, DBDateTimePicker, Forms, Controls,
  Graphics, Dialogs, StdCtrls, DbCtrls, DBGrids, ComCtrls, ActnList, Menus,
  lclproc, LCLType, MaskEdit{, PairSplitter}, fileprocs, variants, workBD, Types;

type

  //запомним значения полей которые пишутся в журнал
    //для их дальнейшей проверки
    TMymemField=record
    id_start_work:string;
    ID_PR_RASPR:string;
    ID_LOCATION:string;
    ID_SB:string;
    end;
  { TeditRAZNOE }
  TeditRAZNOE = class(TForm)

    Aadding: TAction;
    ActionList1: TActionList;
    ADeleting: TAction;
    Asaveing: TAction;
    AUpdating: TAction;
    Button1: TButton;
    Button10: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    DataSource1: TDataSource;
    DataSource10: TDataSource;
    DataSource11: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DataSource9: TDataSource;
    DBDateTimePicker1: TDBDateTimePicker;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox5: TDBLookupComboBox;
    DBLookupComboBox6: TDBLookupComboBox;
    DBLookupComboBox7: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    ImageList1: TImageList;
    Label1: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
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
    SQLQuery10: TSQLQuery;
    SQLQuery11: TSQLQuery;
    SQLQuery1DOP: TStringField;
    SQLQuery1DT: TDateField;
    SQLQuery1DTR: TDateTimeField;
    SQLQuery1ID: TLongintField;
    SQLQuery1ID_LOCATION: TLongintField;
    SQLQuery1ID_MODEL: TLongintField;
    SQLQuery1ID_PR_RASPR: TSmallintField;
    SQLQuery1ID_RAION: TLongintField;
    SQLQuery1ID_SB: TLongintField;
    SQLQuery1ID_START_WORK: TLongintField;
    SQLQuery1ID_TIP: TLongintField;
    SQLQuery1ID_USER: TLongintField;
    SQLQuery1INVENT: TStringField;
    SQLQuery1OTKUDA: TStringField;
    SQLQuery1SERIAL: TStringField;
    SQLQuery2: TSQLQuery;
    SQLQuery3: TSQLQuery;
    SQLQuery4: TSQLQuery;
    SQLQuery9: TSQLQuery;
    TabSheet1: TTabSheet;
    procedure Button10Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure DBEdit2UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    FconnectorWrite:TMyworkbd;
    Fconnector: TMyworkbd;
    { private declarations }
    //------------
    //запомним значения полей которые пишутся в журнал
    //для их дальнейшей проверки
    FmemFielf:TMymemField;
    //-------------
    Fexit:boolean;
   // procedure Setconnector(AValue: TMyworkbd);
    //procedure Setediting_id(AValue: integer);
    function savechange:boolean;
    procedure memJournal;
    function checkjournal:boolean;
    procedure savejournal;
    function delbackspacetext(const txt:string):string;
    //function FileNameToURL(FileName: string): variant;
  public
    { public declarations }
     function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
  end;

var
  editRAZNOE: TeditRAZNOE;

implementation
uses  main;
{$R *.lfm}

{ TeditRAZNOE }


function TeditRAZNOE.savechange: boolean;
begin
  result:=false;
  try
         if not (sqlquery1.Modified) then exit;
         //------------------
         //Если добавление
          if (sqlquery1.State=db.dsInsert) then
          begin
              sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_RAZNOE_ID', sqlquery1.DataBase);
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
              MessageDlg('Ошибка','не заполнено обязательное поле',mtInformation,[mbOK],0)
            end else if (pos('unique_raznoe_uchetn',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','такой инвентарный номер уже есть',mtInformation,[mbOK],0)
            end else MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
      end;
  end;
end;

procedure TeditRAZNOE.memJournal;
begin
  //------------
  //запомним значения полей которые пишутся в журнал
  //для их дальнейшей проверки
  self.FmemFielf.id_start_work:= sqlquery1.FieldByName('id_start_work').AsString;
  self.FmemFielf.ID_PR_RASPR:=sqlquery1.FieldByName('ID_PR_RASPR').AsString;
  self.FmemFielf.ID_LOCATION:=sqlquery1.FieldByName('ID_LOCATION').AsString;
  if sqlquery1.FieldByName('ID_SB').IsNull then self.FmemFielf.ID_SB:='null' else
    self.FmemFielf.ID_SB:=sqlquery1.FieldByName('ID_SB').AsString;
  //-----------
end;

function TeditRAZNOE.checkjournal: boolean;
var stmp:string;
begin
  if sqlquery1.FieldByName('ID_SB').IsNull then stmp:='null' else
    stmp:=sqlquery1.FieldByName('ID_SB').AsString;
  result:=       (sqlquery1.FieldByName('ID_PR_RASPR').AsString<>self.FmemFielf.ID_PR_RASPR)or
              (sqlquery1.FieldByName('id_start_work').AsString<>self.FmemFielf.id_start_work)or
              (sqlquery1.FieldByName('ID_LOCATION').AsString<>self.FmemFielf.ID_LOCATION)or
              (stmp<>self.FmemFielf.ID_SB);
end;

procedure TeditRAZNOE.savejournal;
VAR SCRIPT:TSQLSCRIPT;
  stmp1:string;
begin
  if NOT checkbox1.Checked then exit;
  try
    script:=TSQLSCRIPT.Create(self);
         script.DataBase:=sqlquery1.DataBase;
         script.Transaction:=self.FconnectorWrite.transaction;
         script.CommentsInSQL:=false;
         script.UseSetTerm:=true;
         script.Script.Clear;
         if sqlquery1.FieldByName('ID_SB').IsNull then stmp1:='null' else stmp1:=SQLQUERY1.FieldByName('ID_SB').AsString;
           script.Script.Add('insert into MOVE_RAZNOE(ID,ID_RAZNOE, ID_START_WORK, ID_PR_RASPR, ID_LOCATION, ID_SB) values('
           +INTTOSTR(CreateGUID('GEN_CHANGE_RAZNOE_ID', sqlquery1.DataBase))+','+
           SQLQUERY1.FieldByName('ID').AsString+','+
           SQLQUERY1.FieldByName('ID_START_WORK').AsString+','+
           SQLQUERY1.FieldByName('ID_PR_RASPR').AsString+','+
           SQLQUERY1.FieldByName('ID_LOCATION').AsString+','+
           stmp1+');');
           script.Script.Add('commit;');
         script.Execute;
         script.Free;
  except
    on E: Exception do
      begin
              MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)   ;
      end;
  end;
end;

function TeditRAZNOE.delbackspacetext(const txt: string): string;
var i:integer;
begin
  result:='';
  for i:=0 to length(txt) do
  begin
       if copy(txt,i,1)<>' ' then result:=result+ copy(txt,i,1);
  end;
end;

procedure TeditRAZNOE.Button5Click(Sender: TObject);
begin
  Fexit:= savechange;
end;

procedure TeditRAZNOE.Button6Click(Sender: TObject);
var
  nRec, i:integer;
begin
  nRec:=-1;
  nRec:=mainf.openLOCATION(true);
  i:=self.SQLQuery1.FieldByName('ID_LOCATION').AsInteger;
  sqlquery11.Close;
  sqlquery11.Open;
  self.SQLQuery1.FieldByName('ID_LOCATION').AsInteger:=i;
  sqlquery11.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_LOCATION').AsInteger:=nRec;
end;

procedure TeditRAZNOE.Button10Click(Sender: TObject);
begin
  sqlquery1.FieldByName('id_sb').Value:=null;
end;

procedure TeditRAZNOE.Button1Click(Sender: TObject);
var
  nRec, i:integer;
begin
  nRec:=-1;
  nRec:=mainf.openRAZNOEMODEL(true);
  i:=self.SQLQuery1.FieldByName('ID_MODEL').AsInteger;
   sqlquery2.Close;
   sqlquery2.Open;
   self.SQLQuery1.FieldByName('ID_MODEL').AsInteger:=i;
  sqlquery2.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_MODEL').AsInteger:=nRec;
end;

procedure TeditRAZNOE.Button3Click(Sender: TObject);
var
  nRec, i:integer;
begin
   nRec:=-1;
   nRec:=mainf.openRAZNOETIP(true);
   i:=self.SQLQuery1.FieldByName('ID_TIP').AsInteger;
   sqlquery2.Close;
   sqlquery2.Open;
   self.SQLQuery1.FieldByName('ID_TIP').AsInteger:=i;
   sqlquery2.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_TIP').AsInteger:=nRec;
end;

procedure TeditRAZNOE.Button4Click(Sender: TObject);
var
  nRec, i:integer;
begin
   nRec:=-1;
   nRec:=mainf.openPEOPLE(true);
   i:=self.SQLQuery1.FieldByName('ID_START_WORK').AsInteger;
   sqlquery2.Close;
   sqlquery2.Open;
   self.SQLQuery1.FieldByName('ID_START_WORK').AsInteger:=i;
   sqlquery2.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_START_WORK').AsInteger:=nRec;
end;

procedure TeditRAZNOE.Button8Click(Sender: TObject);
begin
  sqlquery1.Cancel;
end;

procedure TeditRAZNOE.Button9Click(Sender: TObject);
begin
  sqlquery1.FieldByName('id_model').Value:=null;
end;

procedure TeditRAZNOE.CheckBox2Change(Sender: TObject);
begin
 // if checkbox2.Checked then maskedit1.EditMask:='';
end;

procedure TeditRAZNOE.DBEdit2UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
begin
  if UTF8Key='.' then UTF8Key:=',';
  if pos(UTF8Key,'0123456789,'+#8)<=0 then UTF8Key:=#0;
end;

procedure TeditRAZNOE.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Rollback;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TeditRAZNOE.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

procedure TeditRAZNOE.FormCreate(Sender: TObject);
begin
  Fexit:=true;
end;

procedure TeditRAZNOE.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

{function TeditRAZNOE.FileNameToURL(FileName: string): variant;
var
    i: Integer;
//    ch:char;//не работает с кирилицей
//    ch: string;//должно тоже работать с кирилицей.
    ch:tUTF8char;
begin
     Result:='';
      For i:=1 to Length(FileName) do
      Begin
        ch:=copy(FileName, i, 1);//получаем один символ который может занимать
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
end;    }

function TeditRAZNOE.SetConnect(connector: TMyworkbd; tipQuery: TDataSetState;
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
       SQLQuery9.Transaction:=self.Fconnector.transaction;
       sqlquery9.DataBase:=self.Fconnector.connector;
       SQLQuery10.Transaction:=self.Fconnector.transaction;
       sqlquery10.DataBase:=self.Fconnector.connector;
       SQLQuery11.Transaction:=self.Fconnector.transaction;
       sqlquery11.DataBase:=self.Fconnector.connector;
  end;
  //*****************

  //Откроем наборы
  //***************
  sqlquery3.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery11.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery1.Open;
  sqlquery2.Open;
  sqlquery3.Open;
  sqlquery4.Open;
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
           self.Caption:='редактирование РАЗНОЕ';//Заголовок

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
                (self.Components[i] is TToolButton)then  TWinControl(self.Components[i]).Enabled:=false;
           end;
           //**************

           //Разблокируем только, то что нужно
           //******************
           checkbox1.Enabled:=true;
           button1.Enabled:=true;
           button5.Enabled:=true;
           button6.Enabled:=true;
           button8.Enabled:=true;
           button10.Enabled:=true;
           DBLookupComboBox1.Enabled:=true;
           DBLookupComboBox3.Enabled:=true;
           DBLookupComboBox5.Enabled:=true;
           DBLookupComboBox6.Enabled:=true;
           DBLookupComboBox7.Enabled:=true;
           dbedit3.ReadOnly:=false;
           dbedit4.ReadOnly:=false;
           dbmemo1.ReadOnly:=false;
           //*******************
           memJournal;//Запомним значения полей которые пишутся в журнал
    end;
  dsInsert:
    begin
         //Вставка
         sqlquery1.Insert;
    end;
  end;
  //****************
  //Сдклаем активной первую вкладку
  pagecontrol1.ActivePage:=tabsheet1;
  result:=true;
end;

end.

