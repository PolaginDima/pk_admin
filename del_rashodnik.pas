unit Del_rashodnik;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, FileUtil, DBDateTimePicker, Forms, Controls,
  Graphics, Dialogs, DbCtrls, StdCtrls, ComCtrls, db, BufDataset, workBD{,
  IBDatabase};

type

  { TfrmRashodnikdel }

  TfrmRashodnikdel = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    DBDateTimePicker1: TDBDateTimePicker;
    DBEdit1: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
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
    SQLQuery1ID_RASHODNIK_FOR: TLongintField;
    SQLQuery1ID_START_WORK: TLongintField;
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
    SQLQuery5: TSQLQuery;
    UpDown1: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DBLookupComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure SQLQuery3AfterScroll(DataSet: TDataSet);
    procedure SQLQuery4AfterScroll(DataSet: TDataSet);
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
  frmRashodnikdel: TfrmRashodnikdel;

implementation
uses main, Edit_Rash_For;
{$R *.lfm}

{ TfrmRashodnikdel }

procedure TfrmRashodnikdel.FormCreate(Sender: TObject);
begin
  Fexit:=true;
end;

procedure TfrmRashodnikdel.SQLQuery3AfterScroll(DataSet: TDataSet);
begin
  {self.SQLQuery5.ParamByName('ID_NAME').AsInteger:=dataset.FieldByName('ID').AsInteger;
  self.SQLQuery5.Open;
  self.SQLQuery5.Refresh;  }
end;

procedure TfrmRashodnikdel.SQLQuery4AfterScroll(DataSet: TDataSet);
begin
  {self.SQLQuery5.ParamByName('ID_SW').AsInteger:=dataset.FieldByName('ID').AsInteger;
  self.SQLQuery5.Open;
  self.SQLQuery5.Refresh;
  showmessage(self.SQLQuery5.ParamByName('ID_NAME').AsString+lineending
  +self.SQLQuery5.ParamByName('ID_SW').AsString);   }
end;

procedure TfrmRashodnikdel.Button3Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openRASHODNIKNAME(true);
   sqlquery2.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_NAME').AsInteger:=nRec;
end;

procedure TfrmRashodnikdel.Button4Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openRASHODNIKTIP(true);
   sqlquery2.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery2.Locate('ID', nRec,[]);
end;

procedure TfrmRashodnikdel.Button5Click(Sender: TObject);
begin
  if self.SQLQuery1.FieldByName('id_name').IsNull or self.SQLQuery1.FieldByName('id_start_work').IsNull then exit;;
  Edit_Rash_For.showfrm(self.Fconnector, self.SQLQuery1.FieldByName('id_start_work').AsInteger,self.SQLQuery1.FieldByName('id_name').AsInteger);
  self.SQLQuery5.Refresh;
end;

procedure TfrmRashodnikdel.Button6Click(Sender: TObject);
var
  nRec:integer;
begin
   nRec:=-1;
   nRec:=mainf.openSTART_WORK(true);
   sqlquery3.Refresh;
  if nRec=-1 then exit;
  self.SQLQuery1.FieldByName('ID_START_WORK').AsInteger:=nRec;
end;

procedure TfrmRashodnikdel.DataSource1DataChange(Sender: TObject; Field: TField
  );
begin
  self.SQLQuery5.ParamByName('ID_NAME').AsInteger:=self.SQLQuery1.FieldByName('id_name').AsInteger;
  self.SQLQuery5.Open;
  self.SQLQuery5.Refresh;
  self.SQLQuery5.ParamByName('ID_SW').AsInteger:=self.SQLQuery1.FieldByName('id_start_work').AsInteger;
  self.SQLQuery5.Open;
  self.SQLQuery5.Refresh;
end;

procedure TfrmRashodnikdel.DBLookupComboBox1Change(Sender: TObject);
begin
  self.SQLQuery3.ParamByName('ID_TIP').AsInteger:=self.SQLQuery2.FieldByName('id').AsInteger;
  self.SQLQuery3.Open;
  self.SQLQuery3.Refresh;
end;

procedure TfrmRashodnikdel.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  if FconnectorWrite.transaction.Active then
  begin
    FconnectorWrite.transaction.Rollback;
  end;
  FconnectorWrite.connector.Close;
end;

procedure TfrmRashodnikdel.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  canclose:=fexit;
  fexit:=true;
end;

procedure TfrmRashodnikdel.Button1Click(Sender: TObject);
begin
  Fexit:= savechange;
end;


procedure TfrmRashodnikdel.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
  if self.SQLQuery1.FieldByName('count_r').IsNull then self.SQLQuery1.FieldByName('count_r').AsInteger:=1 ;
end;

function TfrmRashodnikdel.savechange: boolean;
begin
   result:=false;
  try
         if not (sqlquery1.Modified) then exit;
         //------------------
         //Если добавление
          if (sqlquery1.State=db.dsInsert) then
          begin
              sqlquery1.FieldByName('ID').Value :=CreateGUID('GEN_RASHODNIK_ID', sqlquery1.DataBase);
              sqlquery1.FieldByName('id_raion').Value:=id_raion;
          end;
          sqlquery1.Post;
          sqlquery1.ApplyUpdates;
          result:=true;
          FconnectorWrite.transaction.CommitRetaining;
          //подтверждаем и завершаем транзакцию
          FconnectorWrite.transaction.Commit;
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

function TfrmRashodnikdel.SetConnect(connector: TMyworkbd;
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
                     SQLQuery5.Transaction:=self.Fconnector.transaction;
                     sqlquery5.DataBase:=self.Fconnector.connector;

  //*****************

   //Откроем наборы
  //***************
  sqlquery1.Open;
  sqlquery2.Open;
  self.SQLQuery3.ParamByName('ID_TIP').AsInteger:=sqlquery2.FieldByName('id').AsInteger;
  sqlquery3.Open;
  self.SQLQuery4.ParamByName('ID_RAION').AsInteger:=ID_RAION;
  sqlquery4.Open;
  {self.SQLQuery5.ParamByName('ID_TIP').AsInteger:=sqlquery2.FieldByName('id').AsInteger;
  sqlquery5.Open;  }
  //***************

  //Вставка
  //***************
  sqlquery1.Insert;
  //***************
  result:=true;
end;

end.

