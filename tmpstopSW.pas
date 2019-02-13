unit tmpstopSW;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, DBDateTimePicker, Forms, Controls,
  Graphics, Dialogs, StdCtrls, DbCtrls, DBGrids, ComCtrls, ActnList, Menus,
  lclproc,ibconnection, workbd;

type

  { TtmpstopSTARTWORK }

  TtmpstopSTARTWORK = class(TForm)
    Aadding: TAction;
    ActionList1: TActionList;
    ADeleting: TAction;
    Asaveing: TAction;
    AUpdating: TAction;
    Button1: TButton;
    Button2: TButton;
    Button5: TButton;
    Button8: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource7: TDataSource;
    DBDateTimePicker1: TDBDateTimePicker;
    DBDateTimePicker2: TDBDateTimePicker;
    DBGrid1: TDBGrid;
    DBLookupComboBox4: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    DBText1: TDBText;
    ImageList1: TImageList;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
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
    procedure Button1Click(Sender: TObject);
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
    { private declarations }
  public
    { public declarations }
    function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
  end;

var
  tmpstopSTARTWORK: TtmpstopSTARTWORK;

implementation
uses  main, addEmploy;
{$R *.lfm}

{ TtmpstopSTARTWORK }

procedure TtmpstopSTARTWORK.FormCreate(Sender: TObject);
begin
  Fexit:=true;
end;

function TtmpstopSTARTWORK.savechange: boolean;
begin
  result:=false;
  try
           if not (sqlquery1.Modified) then exit;
           //------------------
         //Если добавление
          if (sqlquery1.State=db.dsInsert) then
          begin
              sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_TMP_STOP_SW_ID', sqlquery1.DataBase);
              sqlquery1.FieldByName('id_START_WORK').AsInteger:=sqlquery2.FieldByName('ID_SW').AsInteger;
             // sqlquery1.FieldByName('id_raion').Value:=id_raion;
             // sqlquery1.FieldByName('id_user').Value:=id_user;
          end;
         { sqlquery4.Edit;
          sqlquery4.FieldByName('HIDE').AsBoolean:=sqlquery1.FieldByName('DT_END').IsNull;}
          sqlquery1.Post;
          sqlquery1.ApplyUpdates;
          {sqlquery4.Post;
          sqlquery4.ApplyUpdates;}
          self.FconnectorWrite.transaction.Commit;
          result:=true;
  except
    on E: Exception do
      begin
           result:=false;
         if(pos('constraint CORR_DT_END',e.message)>0) then
            begin
              MessageDlg('Ошибка','Дата окончания должна быть не меньше'+lineending+
              'даты начала',mtInformation,[mbOK],0)
            end else
         if(pos('TMP_STOP_SW_INCORRECT_OPERATION',e.message)>0) then
            begin
              MessageDlg('Ошибка','Дата начала или окончания прекращения попадает на'+lineending+
              'период другого прекращения'+lineending
              +'или дата начала раньше начала трудовой деятельности',mtInformation,[mbOK],0)
            end else MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
      end;
  end;
end;

function TtmpstopSTARTWORK.SetConnect(connector: TMyworkbd;
  tipQuery: TDataSetState; editing_id: integer): boolean;
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
       {SQLQuery4.Transaction:=self.FconnectorWrite.transaction;
       sqlquery4.DataBase:=self.FconnectorWrite.connector;}
       //к словарям подключу читающую транзакцию, чтобы по refresh можно было обновить их
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
  //sqlquery4.ParamByName('ID').AsInteger:=editing_id;
  sqlquery1.Open;
  sqlquery2.Open;
  sqlquery3.Open;
  //sqlquery4.Open;
  //if not ((tipQuery=dsInsert)) then
  //begin

  //end;
  //***************

  //Позицируем набор если нужно
  //**********
  if (editing_id<>-1)
  and((tipQuery=dsBrowse)or(tipQuery=dsEdit))
  and(not sqlquery1.Locate('ID',editing_id,[])) then
  begin
    result:=false;
    FconnectorWrite.transaction.Rollback;
    exit;
  end else
      begin
        sqlquery2.ParamByName('ID_SW').AsInteger:=sqlquery1.FieldByName('ID_START_WORK').AsInteger;
        sqlquery7.ParamByName('id_sw').AsInteger:=sqlquery1.FieldByName('ID_START_WORK').AsInteger;
        sqlquery7.Open;
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
       self.Caption:='просмотр временного прекращения сотрудника';//Заголовок
        button1.Enabled:=true;
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
           self.Caption:='редактирование временного прекращения сотрудника';//Заголовок

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
           button1.Enabled:=true;
           button5.Enabled:=true;
           button8.Enabled:=true;
           self.DBDateTimePicker2.Enabled:=true;
           toolbutton15.Enabled:=true;
           //*******************
    end;
  dsInsert:
    begin
         //Вставка
      self.Caption:='создание временного прекращения';//Заголовок
      //Заблокируем возможность изменять присоединенные документы
       button1.Enabled:=true;
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

procedure TtmpstopSTARTWORK.Button5Click(Sender: TObject);
begin
  Fexit:= savechange;
end;

procedure TtmpstopSTARTWORK.AaddingExecute(Sender: TObject);
var od:topendialog;
  fname:string;
  qq:tsqlquery;
  SCRIPT:TSQLScript;
  stmp:string;
begin
  stmp:='';
  od:=topendialog.Create(self.Owner);
  od.Filter:='изображение|*.jpg;*gif;*tiff';
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
end;

procedure TtmpstopSTARTWORK.ADeletingExecute(Sender: TObject);
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

procedure TtmpstopSTARTWORK.AsaveingExecute(Sender: TObject);
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

procedure TtmpstopSTARTWORK.Button1Click(Sender: TObject);
begin
  editEmploy:=TeditEmploy.Create(mainF);
         if editEmploy.SetConnect(self.Fconnector,dsBrowse,self.SQLQuery2.FieldByName('id_SW').AsInteger)
         then editEmploy.ShowModal;
         editEmploy.Free;
end;

procedure TtmpstopSTARTWORK.Button2Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openMOTIVE_TMP_STOP_SW(true);
   sqlquery3.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_MOTIVE_TMP_STOP_SW').AsInteger:=nRec;
end;

procedure TtmpstopSTARTWORK.Button8Click(Sender: TObject);
begin
  sqlquery1.Cancel;
end;

procedure TtmpstopSTARTWORK.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Commit;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TtmpstopSTARTWORK.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

end.

