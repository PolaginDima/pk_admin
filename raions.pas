unit RAIONS;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DbCtrls, MaskEdit, workbd;

type

  { TFormRaion }

  TFormRaion = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    MaskEdit1: TMaskEdit;
    SQLQuery1: TSQLQuery;
    SQLQuery1ADDRESS: TStringField;
    SQLQuery1FULL_KR_NAME: TStringField;
    SQLQuery1FULL_NAME: TStringField;
    SQLQuery1ID: TLongintField;
    SQLQuery1ID_BOSS: TLongintField;
    SQLQuery1ID_MAINBUH: TLongintField;
    SQLQuery1INN: TStringField;
    SQLQuery1NAME: TStringField;
    SQLQuery1OGRN: TStringField;
    SQLQuery1PREFIKS: TStringField;
    SQLQuery1SMALL_NAME: TStringField;
    SQLQuery2: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    connWrite:TMyworkbd;
    Fconn: TMyworkbd;
    procedure Setconn(AValue: TMyworkbd);
    { private declarations }
  public
    { public declarations }
    property conn:TMyworkbd write Setconn;
  end;

var
  FormRaion: TFormRaion;

implementation
uses  main;
{$R *.lfm}

{ TFormRaion }

procedure TFormRaion.FormCreate(Sender: TObject);
//var i:integer;
begin
 { connWrite:=TMyworkbd.Create;
  Fconn.copyParams(self,connWrite.connector);
  connWrite.transaction.Params.Add('isc_tpb_nowait');
  for i:=0 to self.ComponentCount-1 do
  begin
  if (self.Components[i] is TSQLQuery)  then
  begin
    TSQLQuery(self.Components[i]).DataBase:=connWrite.connector;
    TSQLQuery(self.Components[i]).Transaction:=connWrite.transaction;
  end;
  {if (self.Components[i] is TSQLTransaction)  then
  begin
    TSQLTransaction(self.Components[i]).DataBase:=mainf.connector;
  end;}
  end;
  sqlquery1.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery2.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery1.Open;
  sqlquery2.Open;
  if sqlquery1.isempty then
  begin
    close;
    exit;
  end;
  self.MaskEdit1.Text:=sqlquery1.FieldByName('prefiks').AsString;
  sqlquery1.Edit; }
end;

procedure TFormRaion.Setconn(AValue: TMyworkbd);
var i:integer;
begin
  if AValue=Fconn then exit;
  Fconn:=AValue;
  connWrite:=TMyworkbd.Create;
  Fconn.copyParams(self,connWrite.connector);
  connWrite.transaction.Params.Add('isc_tpb_nowait');
  for i:=0 to self.ComponentCount-1 do
  begin
  if (self.Components[i] is TSQLQuery)  then
  begin
    TSQLQuery(self.Components[i]).DataBase:=connWrite.connector;
    TSQLQuery(self.Components[i]).Transaction:=connWrite.transaction;
  end;
  {if (self.Components[i] is TSQLTransaction)  then
  begin
    TSQLTransaction(self.Components[i]).DataBase:=mainf.connector;
  end;}
  end;
  sqlquery1.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery2.ParamByName('id_raion').AsInteger:=id_raion;
  sqlquery1.Open;
  sqlquery2.Open;
  if sqlquery1.isempty then
  begin
    close;
    exit;
  end;
  self.MaskEdit1.Text:=sqlquery1.FieldByName('prefiks').AsString;
  sqlquery1.Edit;
end;

procedure TFormRaion.Button1Click(Sender: TObject);
begin
  if sqlquery1.FieldByName('prefiks').AsString<>maskedit1.Text then
  sqlquery1.FieldByName('prefiks').AsString:=maskedit1.Text;
  if sqlquery1.Modified then
  begin
    sqlquery1.Post;
    sqlquery1.ApplyUpdates;
    connWrite.transaction.Commit;
    //self.SQLTransaction1.Commit;
  end;
end;

end.

