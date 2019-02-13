unit Add_rashodnik;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, DBDateTimePicker, Forms, Controls,
  Graphics, Dialogs, DbCtrls, StdCtrls, ComCtrls, db, BufDataset, workBD;

type

  { TfrmRashodnik }

  TfrmRashodnik = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DBDateTimePicker1: TDBDateTimePicker;
    DBEdit1: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SQLQuery1: TSQLQuery;
    SQLQuery1COUNT_R: TSmallintField;
    SQLQuery1DT: TDateField;
    SQLQuery1DTR: TDateTimeField;
    SQLQuery1ID: TLongintField;
    SQLQuery1ID_NAME: TLongintField;
    SQLQuery1ID_RAION: TLongintField;
    SQLQuery1ID_START_WORK: TLongintField;
    SQLQuery1OTKUDA: TStringField;
    SQLQuery2: TSQLQuery;
    SQLQuery2ID: TLongintField;
    SQLQuery2NAME: TStringField;
    SQLQuery3: TSQLQuery;
    SQLQuery3ID: TLongintField;
    SQLQuery3ID_TIP: TLongintField;
    SQLQuery3NAME: TStringField;
    SQLQuery4: TSQLQuery;
    SQLQuery4FIO: TStringField;
    SQLQuery4GNAME: TStringField;
    SQLQuery4ID: TLongintField;
    SQLQuery4PNAME: TStringField;
    SQLQuery4TABNOM: TStringField;
    UpDown1: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DBLookupComboBox3Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure SQLQuery2AfterScroll(DataSet: TDataSet);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
  private
    { private declarations }
    FconnectorWrite:TMyworkbd;
    Fconnector: TMyworkbd;
    Fexit:boolean;
    function savechange:boolean;
  public
    { public declarations }
    function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
  end;

var
  frmRashodnik: TfrmRashodnik;

implementation
uses main,Edit_Rash_For;
{$R *.lfm}

{ TfrmRashodnik }

procedure TfrmRashodnik.FormCreate(Sender: TObject);
begin
  Fexit:=true;
end;

procedure TfrmRashodnik.Button3Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openRASHODNIKNAME(true);
   sqlquery3.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_NAME').AsInteger:=nRec;
end;

procedure TfrmRashodnik.Button4Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openRASHODNIKTIP(true);
   sqlquery2.Refresh;
  if nRec=-1 then exit;
   self.SQLQuery2.Locate('ID', nRec,[]);
end;

procedure TfrmRashodnik.Button5Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openSTART_WORK(true);
   sqlquery3.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_START_WORK').AsInteger:=nRec;
end;

procedure TfrmRashodnik.DBLookupComboBox3Change(Sender: TObject);
begin
  if self.SQLQuery1.FieldByName('count_r').IsNull then self.SQLQuery1.FieldByName('count_r').AsInteger:=1 ;
end;

procedure TfrmRashodnik.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Rollback;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TfrmRashodnik.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

procedure TfrmRashodnik.Button1Click(Sender: TObject);
begin
  Fexit:= savechange;
end;

procedure TfrmRashodnik.SQLQuery2AfterScroll(DataSet: TDataSet);
begin
  self.SQLQuery3.ParamByName('ID_TIP').AsInteger:=dataset.FieldByName('id').AsInteger;
  self.SQLQuery3.Open;
  self.SQLQuery3.Refresh;
end;

procedure TfrmRashodnik.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  if self.SQLQuery1.FieldByName('count_r').IsNull then self.SQLQuery1.FieldByName('count_r').AsInteger:=1 ;
end;

function TfrmRashodnik.savechange: boolean;
begin
   result:=false;
  try
         if not (sqlquery1.Modified) then exit;
         //------------------
         //Если добавление
          if (sqlquery1.State=db.dsInsert) then
          begin
              sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_RASHODNIK_ID', sqlquery1.DataBase);
              sqlquery1.FieldByName('id_raion').AsInteger:=id_raion;
          end;
          sqlquery1.Post;
          sqlquery1.ApplyUpdates;
          result:=true;
          self.FconnectorWrite.transaction.CommitRetaining;
          //подтверждаем и завершаем транзакцию
          self.FconnectorWrite.transaction.Commit;
  except
    on E: Exception do
      begin
           result:=false;
           if (pos('required',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','не заполнено обязательное поле',mtInformation,[mbOK],0)
            end else  MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
      end;
  end;
end;

function TfrmRashodnik.SetConnect(connector: TMyworkbd;
  tipQuery: TDataSetState; editing_id: integer): boolean;
begin
  if (connector=nil)or(self.Fconnector<>nil)then exit;
  result:=false;
  self.Fconnector:=connector;
  //создадим подключение
  //*****************
     FconnectorWrite:=TMyworkbd.Create;
     self.Fconnector.copyParams(self,self.FconnectorWrite.connector);
     FconnectorWrite.transaction.Params.Add('isc_tpb_nowait');
  //*****************

  //Подключим наборы к нашему подключению и транзакции
  //*****************
                     SQLQuery1.Transaction:=self.FconnectorWrite.transaction;
                     sqlquery1.DataBase:=self.FconnectorWrite.connector;
                     //к словарям подключу читающую транзакцию, чтобы по refresh можно было обновить их
                     SQLQuery2.Transaction:=self.Fconnector.transaction;
                     sqlquery2.DataBase:=self.Fconnector.connector;
                     SQLQuery3.Transaction:=self.Fconnector.transaction;
                     sqlquery3.DataBase:=self.Fconnector.connector;
                     SQLQuery4.Transaction:=self.Fconnector.transaction;
                     sqlquery4.DataBase:=self.Fconnector.connector;
  //*****************

   //Откроем наборы
  //***************
  sqlquery1.Open;
  sqlquery2.Open;
  self.SQLQuery3.ParamByName('ID_TIP').AsInteger:=sqlquery2.FieldByName('id').AsInteger;
  sqlquery3.Open;
  sqlquery4.Open;
  //***************

  //Вставка
  //***************
  sqlquery1.Insert;
  //***************
  result:=true;
end;

end.

