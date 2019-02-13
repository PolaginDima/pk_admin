unit add_dostup;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DbCtrls, DBGrids, workBD;

type

  { TfrmDostup }

  TfrmDostup = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    Label1: TLabel;
    Label9: TLabel;
    SQLQuery1: TSQLQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SQLQuery1BeforeInsert(DataSet: TDataSet);
  private
    Fconnector: TMyworkbd;
    FconnectorWrite:TMyworkbd;
    FFIO: string;
    FID:integer;
    procedure FillSpis;
  public
    property FIO:string read FFIO write FFIO;
    function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
  end;

var
  frmDostup: TfrmDostup;

implementation
uses main;
{$R *.lfm}

{ TfrmDostup }

procedure TfrmDostup.Button1Click(Sender: TObject);
var
  NRec:integer;
begin
   NRec:=mainf.openRESURS(true);
   sqlquery1.Close;
   sqlquery1.Open;
   sqlquery1.Refresh;
   FillSpis;
   sqlquery1.Locate('ID_RES',NRec,[]);
   NRec:=ComboBox1.Items.IndexOf(sqlquery1.FieldByName('name').AsString);
   if NRec>-1 then
      ComboBox1.ItemIndex:=NRec;
end;

procedure TfrmDostup.Button2Click(Sender: TObject);
VAR SCRIPT:TSQLSCRIPT;
  stmp1:string;
begin
   if ComboBox1.ItemIndex=-1 then exit;
   if not sqlquery1.Locate('name',trim( ComboBox1.Text),[]) then exit;
   script:=TSQLSCRIPT.Create(self);
   script.DataBase:=sqlquery1.DataBase;
   script.Transaction:=FconnectorWrite.transaction;
   script.CommentsInSQL:=false;
   script.UseSetTerm:=true;
   script.Script.Clear;
   script.Script.Add('insert into DOSTUP_RES (ID,ID_START_WORK,ID_ROLE) VALUES(GEN_ID("GEN_DOSTUP",1),'+inttostr(FID)+','+sqlquery1.FieldByName('ID').AsString+');');
   script.Script.Add('commit;');
   script.Execute;
   FreeAndNil( script);
  Close;
end;

procedure TfrmDostup.SQLQuery1BeforeInsert(DataSet: TDataSet);
begin
  if DataSet.State=dsInsert then DataSet.Cancel;
end;

procedure TfrmDostup.FillSpis;
begin
  if SQLQuery1.IsEmpty then exit;
  ComboBox1.Clear;
  SQLQuery1.First;
  while not SQLQuery1.EOF do
  begin
    ComboBox1.Items.Add(SQLQuery1.FieldByName('name').AsString);
    SQLQuery1.Next;
  end;
end;

function TfrmDostup.SetConnect(connector: TMyworkbd; tipQuery: TDataSetState;
  editing_id: integer): boolean;
begin
  if (connector=nil)or(Fconnector<>nil)then exit;
  FID:=editing_id;
  result:=false;
  Fconnector:=connector;
  //создадим подключение
  //*****************
     FconnectorWrite:=TMyworkbd.Create;
     Fconnector.copyParams(self,FconnectorWrite.connector);
     FconnectorWrite.transaction.Params.Add('isc_tpb_nowait');

  //*****************

  //Подключим наборы к нашему подключению и транзакции
  //*****************

        SQLQuery1.Transaction:=Fconnector.transaction;
        sqlquery1.DataBase:=FconnectorWrite.connector;
  //*****************

  //Откроем наборы
  //***************
  sqlquery1.Open;
   //***************
   Caption:=Caption+' '+FIO;
   FillSpis;
  result:=true;
end;

end.

