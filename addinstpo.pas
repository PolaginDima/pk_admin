unit addInstPO;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, DBDateTimePicker, Forms,
  Controls, Graphics, Dialogs, StdCtrls, DbCtrls, DBGrids, ComCtrls, ActnList,
  Menus, lclproc, LCLType, workBD;

type
  //запомним значения полей которые пишутся в журнал
      //для их дальнейшей проверки
     { TMymemField=record
      ID_GROUP:string;
      ID_LOCATION:STRING;
      FFAM:STRING;
      ID_POST:string;
      end; }

  { TeditInstPO }

  TeditInstPO = class(TForm)
    Button2: TButton;
    Button3: TButton;
    Button5: TButton;
    Button6: TButton;
    Button8: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DBDateTimePicker1: TDBDateTimePicker;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    SQLQuery1: TSQLQuery;
    SQLQuery1DOP: TStringField;
    SQLQuery1DT: TDateField;
    SQLQuery1ID: TLongintField;
    SQLQuery1ID_INSTALL_ACTION: TLongintField;
    SQLQuery1ID_PO: TLongintField;
    SQLQuery1ID_RAION: TLongintField;
    SQLQuery1ID_SB: TLongintField;
    SQLQuery1ID_START_WORK: TLongintField;
    SQLQuery1ID_USER: TLongintField;
    SQLQuery2: TSQLQuery;
    SQLQuery3: TSQLQuery;
    SQLQuery4: TSQLQuery;
    TabSheet1: TTabSheet;
    procedure AaddingExecute(Sender: TObject);
    procedure ADeletingExecute(Sender: TObject);
    procedure AsaveingExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    //procedure Button9Click(Sender: TObject);
    procedure DBEdit1UTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
    procedure DBLookupComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure MaskEdit1Change(Sender: TObject);
    procedure MaskEdit1EditingDone(Sender: TObject);
    //procedure PageControl1Change(Sender: TObject);
  private
    //запомним значения полей которые пишутся в журнал
    //для их дальнейшей проверки
    FID_SB_arr:array of integer;
    //FmemFielf:TMymemField;
    Fconnector: TMyworkbd;
    FconnectorWrite:TMyworkbd;
    Fexit:boolean;
    function savechange(exiting:boolean=true):boolean;
    {procedure memJournal;
    function checkjournal:boolean;
    procedure savejournal;}
    { private declarations }
  public
    { public declarations }
    function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
  end;

var
  editInstPO: TeditInstPO;

implementation
uses  main,InstPO;
{$R *.lfm}

{ TeditInstPO }

procedure TeditInstPO.FormCreate(Sender: TObject);
begin
  Fexit:=true;
end;

procedure TeditInstPO.MaskEdit1Change(Sender: TObject);
begin

end;

procedure TeditInstPO.MaskEdit1EditingDone(Sender: TObject);
begin

end;

{procedure TeditInstPO.PageControl1Change(Sender: TObject);
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
end;}

function TeditInstPO.savechange(exiting: boolean): boolean;
var
  i:integer;
  ID_START_WORK,ID_PO,ID_INSTALL_ACTION:integer;
  DT:Tdate;
  dop:string;
begin
  result:=false;
  try
      if (not (sqlquery1.Modified))or(FID_SB_arr=nil)or(length(FID_SB_arr)<=0)then exit;

     //------------------
         //Если добавление
         if (sqlquery1.State=db.dsInsert) then
              begin
                ID_INSTALL_ACTION:=sqlquery1.FieldByName('ID_INSTALL_ACTION').AsInteger;
                ID_PO:=sqlquery1.FieldByName('ID_PO').AsInteger;
                ID_START_WORK:=sqlquery1.FieldByName('ID_START_WORK').AsInteger;
                DT:=sqlquery1.FieldByName('DT').AsDateTime;
                DOP:=sqlquery1.FieldByName('DOP').AsString;
                for i:=0 to  high(FID_SB_arr) do
                begin
                     if (sqlquery1.State<>db.dsInsert) then sqlquery1.Insert;
                     sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_INSTALL_PO_ID', sqlquery1.DataBase);
                     sqlquery1.FieldByName('id_raion').Value:=id_raion;
                     sqlquery1.FieldByName('id_user').Value:=id_user;
                     sqlquery1.FieldByName('ID_SB').AsInteger:=FID_SB_arr[i];
                     sqlquery1.FieldByName('ID_INSTALL_ACTION').AsInteger:=ID_INSTALL_ACTION;
                     sqlquery1.FieldByName('ID_PO').AsInteger:=ID_PO;
                     sqlquery1.FieldByName('ID_START_WORK').AsInteger:=ID_START_WORK;
                     sqlquery1.FieldByName('DT').AsDateTime:=DT;
                     sqlquery1.FieldByName('DOP').AsString:=DOP;
                     sqlquery1.Post;
                     sqlquery1.ApplyUpdates;
                end;
              end;

          result:=true;
          self.FconnectorWrite.transaction.CommitRetaining;
          //Если редактирование прошло успешно, то добавляем запись в журнал
          //если есть изменения
          //if checkjournal then  savejournal;
          //подтверждаем и завершаем транзакцию
          if exiting then self.FconnectorWrite.transaction.Commit
          else
            begin
             { //редактирование
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
              end; }
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

{procedure TeditInstPO.memJournal;
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

{function TeditInstPO.checkjournal: boolean;
begin
  sqlquery2.Locate('id',sqlquery1.FieldByName('id_people').AsInteger,[]);
  result:=(sqlquery1.FieldByName('id_group').AsString<>self.FmemFielf.ID_GROUP) or
              (sqlquery1.FieldByName('id_post').AsString<>self.FmemFielf.ID_POST)or
              (sqlquery1.FieldByName('id_location').AsString<>self.FmemFielf.ID_LOCATION)or
              (sqlquery2.FieldByName('FAM').AsString<>self.FmemFielf.FFAM);
end; }

{procedure TeditInstPO.savejournal;
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
end; }

function TeditInstPO.SetConnect(connector: TMyworkbd; tipQuery: TDataSetState;
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
        {SQLQuery5.Transaction:=self.Fconnector.transaction;
        sqlquery5.DataBase:=self.Fconnector.connector;
        SQLQuery7.Transaction:=self.Fconnector.transaction;
        sqlquery7.DataBase:=self.Fconnector.connector;
        SQLQuery8.Transaction:=self.Fconnector.transaction;
        sqlquery8.DataBase:=self.Fconnector.connector;   }
  end;
  //*****************

  //Откроем наборы
  //***************
  sqlquery2.ParamByName('id_raion').AsInteger:=id_raion;
  //sqlquery8.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery1.Open;
  sqlquery2.Open;
  sqlquery3.Open;
  sqlquery4.Open;
  //sqlquery5.Open;
  //sqlquery8.Open;
  if not ((tipQuery=dsInsert)) then
  begin
    {sqlquery7.ParamByName('id_sw').AsInteger:=editing_id;
    sqlquery7.Open;}
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
           button2.Enabled:=true;
           button3.Enabled:=true;
           button5.Enabled:=true;
           button6.Enabled:=true;
           {button7.Enabled:=true;
           button7.Visible:=true;}
           button8.Enabled:=true;
           //button9.Enabled:=true;
           {toolbutton14.Enabled:=true;
           toolbutton15.Enabled:=true;
           toolbutton16.Enabled:=true; }
           DBLookupComboBox2.Enabled:=true;
           DBLookupComboBox3.Enabled:=true;
           //DBLookupComboBox5.Enabled:=true;
           dbmemo1.ReadOnly:=false;
           //maskedit1.ReadOnly:=false;
           //*******************
           //memJournal;//Запомним значения полей которые пишутся в журнал
           //maskedit1.Text:= sqlquery1.FieldByName('NETNAME').AsString;
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

procedure TeditInstPO.Button5Click(Sender: TObject);
begin
  Fexit:= savechange;
end;

procedure TeditInstPO.Button6Click(Sender: TObject);
var
  //i:integer;
  Q{,Q2}:TSQLQUERY;
  //DS1,DS2:TDATASource;
  Fld:TField;
  FieldDef: TFieldDef;
begin
  frmInstPO:=TfrmInstPO.Create(self);
  {if frmInstPO.ShowModal=mrok then
  begin

  end;     }
  self.FID_SB_arr:=nil;
  Q:=TSQLQuery.Create(self);
  {Q2:=TSQLQuery.Create(self);
  Q2.SQL.Clear;
  Q2.SQL.Add('select SB.ID as ID,PEOPLES.FAM||'' ''||LEFT(PEOPLES.NAM,1)||''. '''+lineending+
  '||LEFT(PEOPLES.OTCH,1)||''. s/n:''||SB.SERIAL||'' инв.:''||COALESCE(SB.INVENT,'''')||'', ''||PR_RASPR_SB.NAME'+lineending+
  ' as NAME, PR_RASPR_SB.NAME as pr from SB'+lineending+
  'join START_WORK on (SB.ID_START_WORK=START_WORK.ID) join PEOPLES on (PEOPLES.ID=START_WORK.ID_PEOPLE)'+lineending+
  'join  PR_RASPR_SB on (SB.ID_PR_RASPR=PR_RASPR_SB.ID)'+lineending+
  'order by NAME');
  Q2.Transaction:=self.Fconnector.transaction;
  Q2.DataBase:=self.Fconnector.connector;
  Q2.Open; }

  Q.SQL.Clear;
  {Q.SQL.Add('select 0 as sel,SB.ID as ID,'+lineending+
  'SB.ID as ID2'+lineending+
  'from SB '+lineending+
  '/*order by sel*/');}
  Q.SQL.Add('select 0 as sel, ID,'+lineending+
  'PFIO||'' ''||SERIAL||'' ''||INV||'' ''||PR as SN, PR'+lineending+
  'from INSTPOINCOMP '+lineending+
  'order by PR DESC, SN');

  Q.Transaction:=self.Fconnector.transaction;
  Q.DataBase:=self.Fconnector.connector;
  Q.Open;
  Q.Active:=false;

  FieldDef:=Q.FieldDefs.Find('sel');
  fld:=FieldDef.CreateField(Q);
  //Тут если надо настраиваем fld
  fld.DisplayLabel:='выбор';
  fld.DisplayWidth:=15;

  FieldDef:=Q.FieldDefs.Find('ID');
  fld:=FieldDef.CreateField(Q);
  //Тут если надо настраиваем fld
  fld.Visible:=false;
  fld.ProviderFlags:=fld.ProviderFlags+[pfInKey];
  {
  FieldDef:=Q.FieldDefs.Find('ID2');
  fld:=FieldDef.CreateField(Q);
  //Тут если надо настраиваем fld
  fld.Visible:=false;
  //fld.ProviderFlags:=fld.ProviderFlags+[pfInKey];   }

  FieldDef:=Q.FieldDefs.Find('pr');
  fld:=FieldDef.CreateField(Q);
  //Тут если надо настраиваем fld
  fld.Visible:=false;

  FieldDef:=Q.FieldDefs.Find('SN');
  fld:=FieldDef.CreateField(Q);
  //Тут если надо настраиваем fld
  fld.Visible:=true;

   {
  //Ниже создаем lookup поле
  fld:=TStringField.Create(Q);
  fld.FieldKind:=fkLookup;
  fld.KeyFields:='ID2';
  fld.LookupDataSet:=Q2;
  fld.LookupKeyFields:='ID';
  fld.LookupResultField:='pr';
  fld.DataSet:=Q;
  fld.DisplayLabel:='';
  fld.ProviderFlags:=[];
  fld.Name:='PR';
  //fld.Required:=true;
  fld.FieldName:='PR';
  fld.Visible:=false;

  //Ниже создаем lookup поле
  fld:=TStringField.Create(Q);
  fld.FieldKind:=fkLookup;
  fld.KeyFields:='ID2';
  fld.LookupDataSet:=Q2;
  fld.LookupKeyFields:='ID';
  fld.LookupResultField:='NAME';
  fld.DataSet:=Q;
  fld.DisplayLabel:='сист. блок';
  fld.ProviderFlags:=[];
  fld.Name:='SN';
  //fld.Required:=true;
  fld.FieldName:='SN';
  fld.DisplayWidth:=25;
  fld.Size:=200;
   }
  frmInstPO.DataSource1.DataSet:=Q;
  Q.Open;
  {Q.First;
  while not Q.EOF do
  begin
       Q.FieldByName('');
       Q.Next;
  end;
  Q.First;  }
  {DS1:=TDataSource.Create(self);
  DS2:=TDataSource.Create(self);
  DS1.DataSet:=Q;
  DS2.DataSet:=Q2;
  self.DBGrid1.DataSource:=DS1;
  self.DBGrid2.DataSource:=DS2;}
  //exit;
  if frmInstPO.ShowModal=mrOk then
  begin
  if Q.IsEmpty then
  begin
    self.Label8.Caption:='пусто';exit;
  end;
  q.Filter:='sel=1';
  q.Filtered:=true;
  frmInstPO.DBGrid1.DataSource.DataSet.First;
  {frmInstPO.DBGrid1.DataSource.DataSet.Last;
  showmessage(inttostr(frmInstPO.DBGrid1.DataSource.DataSet.RecordCount)); exit;}
  while not frmInstPO.DBGrid1.DataSource.DataSet.EOF do
  begin
       if self.FID_SB_arr=nil then
       setlength(self.FID_SB_arr,1) else setlength(self.FID_SB_arr,high(self.FID_SB_arr)+2);
       self.FID_SB_arr[high(self.FID_SB_arr)]:=frmInstPO.DBGrid1.DataSource.DataSet.FieldByName('ID').AsInteger;
       frmInstPO.DBGrid1.DataSource.DataSet.Next;
  end;
  Q.Close;
  Q.Free;
  frmInstPO.Free;
  self.Label8.Caption:=inttostr(length(FID_SB_arr))+' шт.';
  end
     else self.Label8.Caption:='0 шт.';
end;

procedure TeditInstPO.AaddingExecute(Sender: TObject);
begin

end;

procedure TeditInstPO.ADeletingExecute(Sender: TObject);
begin

end;

procedure TeditInstPO.AsaveingExecute(Sender: TObject);
begin

end;

procedure TeditInstPO.Button1Click(Sender: TObject);
begin

end;

procedure TeditInstPO.Button2Click(Sender: TObject);
var
  nRec, i:integer;
begin
   nRec:=-1;
   nRec:=mainf.openPO(true);
   i:=self.SQLQuery1.FieldByName('ID_PO').AsInteger;
   sqlquery3.Close;
   sqlquery3.Open;
   self.SQLQuery1.FieldByName('ID_PO').AsInteger:=i;
   sqlquery3.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_PO').AsInteger:=nRec;
end;

procedure TeditInstPO.Button3Click(Sender: TObject);
var
  nRec,i:integer;
begin
   nRec:=-1;
   nRec:=mainf.openInstAction(true);
   i:=self.SQLQuery1.FieldByName('ID_INSTALL_ACTION').AsInteger;
   sqlquery4.Close;
   sqlquery4.Open;
   self.SQLQuery1.FieldByName('ID_INSTALL_ACTION').AsInteger:=i;
   sqlquery4.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_INSTALL_ACTION').AsInteger:=nRec;
end;

procedure TeditInstPO.Button7Click(Sender: TObject);
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

procedure TeditInstPO.Button8Click(Sender: TObject);
begin
  sqlquery1.Cancel;
end;

procedure TeditInstPO.DBEdit1UTF8KeyPress(Sender: TObject;
  var UTF8Key: TUTF8Char);
begin
   if pos(UTF8Key,'0123456789')<=0 then UTF8Key:=#0;
end;

procedure TeditInstPO.DBLookupComboBox1Change(Sender: TObject);
begin

end;

procedure TeditInstPO.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Rollback;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TeditInstPO.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

end.

