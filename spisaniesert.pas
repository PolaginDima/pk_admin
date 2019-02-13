unit spisaniesert;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, DBDateTimePicker, Forms, Controls,
  Graphics, Dialogs, StdCtrls, DbCtrls, DBGrids, ComCtrls, ActnList, Menus,
  lclproc, variants, workbd;

type

  { TspisSert }

  TspisSert = class(TForm)
    Aadding: TAction;
    ActionList1: TActionList;
    ADeleting: TAction;
    Asaveing: TAction;
    AUpdating: TAction;
    Button5: TButton;
    Button8: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBDateTimePicker1: TDBDateTimePicker;
    DBMemo1: TDBMemo;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    PageControl1: TPageControl;
    PopupMenu1: TPopupMenu;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    TabSheet1: TTabSheet;
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
  spisSert: TspisSert;

implementation
uses  main;
{$R *.lfm}

{ TspisSert }

procedure TspisSert.FormCreate(Sender: TObject);
begin
  Fexit:=true;
end;

function TspisSert.savechange: boolean;
begin
  result:=false;
  try
         if not (sqlquery1.Modified) then exit;
           //------------------
         //Если добавление
          if (sqlquery1.State=db.dsInsert) then
          begin
              sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_DEL_SERT_ID', sqlquery1.DataBase);
              sqlquery1.FieldByName('id_sertifikat').AsInteger:=sqlquery2.FieldByName('ID').AsInteger;
              {sqlquery1.FieldByName('id_raion').Value:=id_raion;
              sqlquery1.FieldByName('id_user').Value:=id_user;  }
          end;
          {sqlquery4.Edit;
          sqlquery4.FieldByName('HIDE').AsBoolean:=(not sqlquery1.FieldByName('DT').IsNull); }
          sqlquery1.Post;
          sqlquery1.ApplyUpdates;
          {sqlquery4.Post;
          sqlquery4.ApplyUpdates;}
          result:=true;
          self.FconnectorWrite.transaction.Commit;
  except
    on E: Exception do
      begin
           result:=false;
           if (pos('del_sertifikat_incorrect_operation',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','Нельзя отозвать раньше'+lineending+
              'чем получен сертификат',mtInformation,[mbOK],0)
            end else  MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
      end;
  end;
end;

function TspisSert.SetConnect(connector: TMyworkbd; tipQuery: TDataSetState;
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
  end;
  //*****************

  //Откроем наборы
  //***************
  sqlquery2.ParamByName('ID_SERTIFIKAT').AsInteger:=editing_id;
  //sqlquery4.ParamByName('ID').AsInteger:=editing_id;
  sqlquery1.Open;
  sqlquery2.Open;
  //sqlquery4.Open;

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

  // if not (tipQuery=dsInsert) then
 // begin

  //end;

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
       self.Caption:='просмотр МНИ';//Заголовок
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
           self.Caption:='редактирование МНИ';//Заголовок

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
           //*******************
    end;
  dsInsert:
    begin
         //Вставка
      self.Caption:='ОТЗЫВ сертификата';//Заголовок
      //Заблокируем возможность изменять присоединенные документы
      sqlquery1.Insert;
    end;
  end;
  //****************
  //Сдклаем активной первую вкладку
  pagecontrol1.ActivePage:=tabsheet1;
  result:=true;
end;

procedure TspisSert.Button5Click(Sender: TObject);
begin
  Fexit:= savechange;
end;

procedure TspisSert.Button8Click(Sender: TObject);
begin
  sqlquery1.Cancel;
end;

procedure TspisSert.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Commit;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TspisSert.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

end.

