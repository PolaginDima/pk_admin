unit Edit_Rash_For;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, StdCtrls, DbCtrls, workBD;

type

  { TfrmRashFor }

  TfrmRashFor = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DataSource5: TDataSource;
    DataSource6: TDataSource;
    DataSource7: TDataSource;
    DBGrid1: TDBGrid;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    DBLookupComboBox4: TDBLookupComboBox;
    DBLookupComboBox5: TDBLookupComboBox;
    DBText1: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLQuery2ID: TLongintField;
    SQLQuery2MODEL_RAZN: TStringField;
    SQLQuery2NAME_R: TStringField;
    SQLQuery2TIP_R: TStringField;
    SQLQuery3: TSQLQuery;
    SQLQuery4: TSQLQuery;
    SQLQuery5: TSQLQuery;
    SQLQuery6: TSQLQuery;
    SQLQuery7: TSQLQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SQLQuery6AfterScroll(DataSet: TDataSet);
  private
    { private declarations }
    FconnectorWrite:TMyworkbd;
    Fconnector: TMyworkbd;
    Fresult_vibor: integer;
    FExit:boolean;
    procedure Setresult_vibor(AValue: integer);
  public
    { public declarations }
   function SetConnect(connector:TMyworkbd;tipQuery:TDataSetState = dsInsert;editing_id:integer = -1):boolean;
   property result_vibor:integer read Fresult_vibor write Setresult_vibor default -1;
  end;

var
  frmRashFor: TfrmRashFor;

  function showfrm(connector:TMyworkbd;ID_SW:integer=-1; ID_NAME:integer=-1):integer;

implementation

function showfrm(connector: TMyworkbd; ID_SW: integer; ID_NAME: integer
  ): integer;
begin
  result:=-1;
  frmRashFor:=TfrmRashFor.Create(application);
  //****************
  if not frmRashFor.SetConnect(connector) then
  begin
       frmRashFor.Free;
       exit;
  end;
  //*****************
  if {(ID_SW<>-1)and} (ID_NAME<>-1) then
  begin
    if frmRashFor.SQLQuery4.Locate('ID',id_name,[]) then
    begin
      frmRashFor.SQLQuery5.ParamByName('id_tip').AsInteger:=frmRashFor.SQLQuery4.FieldByName('id_tip').AsInteger;
      frmRashFor.SQLQuery5.Open;
      frmRashFor.SQLQuery5.Refresh;
      if (ID_SW<>-1) then
      begin
        frmRashFor.SQLQuery6.ParamByName('id_sw').AsInteger:=id_sw;
        frmRashFor.SQLQuery6.Open;
        frmRashFor.SQLQuery6.Refresh;
        frmRashFor.SQLQuery2.ParamByName('id_sw').AsInteger:=id_sw;
        frmRashFor.SQLQuery2.Open;
        frmRashFor.SQLQuery2.Refresh;
        frmRashFor.Caption:='Связь расходников и оборудования (для сотрудника '+frmRashFor.SQLQuery6.FieldByName('FIO').AsString+')';
      end else
      begin
              result:=-1;
              exit;
     {         frmRashFor.SQLQuery6.
              frmRashFor.SQLQuery6.Open;
              frmRashFor.SQLQuery6.Refresh;
              frmRashFor.SQLQuery2.ParamByName('id_sw').AsInteger:=id_sw;
              frmRashFor.SQLQuery2.Open;
              frmRashFor.SQLQuery2.Refresh;
              frmRashFor.Caption:='Связь расходников и оборудования (для сотрудника '+frmRashFor.SQLQuery6.FieldByName('FIO').AsString+')';}
      end;
    end else
    begin
      result:=-1;
      exit;
    end;
    frmRashFor.ShowModal;
    result:=frmRashFor.result_vibor;
    frmRashFor.Free;
  end else
  begin

  end;
end;

{$R *.lfm}

{ TfrmRashFor }

procedure TfrmRashFor.SQLQuery6AfterScroll(DataSet: TDataSet);
begin
  self.SQLQuery7.ParamByName('ID_SW').AsInteger:=dataset.FieldByName('ID_SW').AsInteger;
  self.SQLQuery7.ParamByName('ID_tip').AsInteger:=dataset.FieldByName('ID').AsInteger;
  self.SQLQuery7.Close;
  self.SQLQuery7.Open;
end;

procedure TfrmRashFor.Setresult_vibor(AValue: integer);
begin
  if Fresult_vibor=AValue then Exit;
  Fresult_vibor:=AValue;
end;

procedure TfrmRashFor.Button1Click(Sender: TObject);
VAR SCRIPT:TSQLSCRIPT;
begin
  if self.SQLQuery5.IsEmpty
  or self.SQLQuery4.IsEmpty
  or self.SQLQuery6.IsEmpty
  or self.SQLQuery7.IsEmpty then exit;
   try
    script:=TSQLSCRIPT.Create(self);
         script.DataBase:=sqlquery1.DataBase;
         script.Transaction:=self.FconnectorWrite.transaction;
         script.CommentsInSQL:=false;
         script.UseSetTerm:=true;
         script.Script.Clear;
         script.Script.Add('insert into rashodnik_for (ID,ID_NAME, ID_RAZNOE_MODEL, ID_RAZNOE_TIP)'+lineending
         +'values(GEN_ID(GEN_SLOVAR_ID,1),'+self.SQLQuery4.FieldByName('ID').AsString+', '+lineending
         +self.SQLQuery7.FieldByName('ID').AsString+', '+lineending
         +self.SQLQuery6.FieldByName('ID').AsString+');');
         //showmessage(script.Script.Text);
         script.Execute;
         script.Free;
   except
     on E: Exception do
      begin
              MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)   ;
      end;
   end;
   //подтверждаем и завершаем транзакцию
          self.FconnectorWrite.transaction.Commit;
          //Обновляем таблицу
          self.SQLQuery2.Refresh;
          self.SQLQuery2.Refresh;
end;

procedure TfrmRashFor.Button2Click(Sender: TObject);
begin
  if self.SQLQuery2.IsEmpty then
  begin
    FExit:=false;
    exit;
  end;
  self.result_vibor:=self.SQLQuery2.FieldByName('ID').AsInteger;
end;

function TfrmRashFor.SetConnect(connector: TMyworkbd; tipQuery: TDataSetState;
  editing_id: integer): boolean;
begin

  if (connector=nil)or(self.Fconnector<>nil)then exit;
  result:=true;
  self.Fconnector:=connector;
  //создадим подключение
  //*****************
     FconnectorWrite:=TMyworkbd.Create;
     self.Fconnector.copyParams(self,self.FconnectorWrite.connector);
     FconnectorWrite.transaction.Params.Add('isc_tpb_nowait');
  //*****************

  //Подключим наборы к нашему подключению и транзакции
  //*****************
                     {SQLQuery1.Transaction:=self.FconnectorWrite.transaction;
                     sqlquery1.DataBase:=self.FconnectorWrite.connector;      }
                     //к словарям подключу читающую транзакцию, чтобы по refresh можно было обновить их
                     SQLQuery2.Transaction:=self.Fconnector.transaction;
                     sqlquery2.DataBase:=self.Fconnector.connector;
                     SQLQuery3.Transaction:=self.Fconnector.transaction;
                     sqlquery3.DataBase:=self.Fconnector.connector;
                     SQLQuery4.Transaction:=self.Fconnector.transaction;
                     sqlquery4.DataBase:=self.Fconnector.connector;
                     SQLQuery5.Transaction:=self.Fconnector.transaction;
                     sqlquery5.DataBase:=self.Fconnector.connector;
                     SQLQuery6.Transaction:=self.Fconnector.transaction;
                     sqlquery6.DataBase:=self.Fconnector.connector;
                     SQLQuery7.Transaction:=self.Fconnector.transaction;
                     sqlquery7.DataBase:=self.Fconnector.connector;
  //*****************

   //Откроем наборы
  //***************
  frmRashFor.SQLQuery2.Open;
  frmRashFor.SQLQuery4.Open;
  //sqlquery1.Open;
  {sqlquery2.Open;
  self.SQLQuery3.ParamByName('ID_TIP').AsInteger:=sqlquery2.FieldByName('id').AsInteger;
  sqlquery3.Open;
  sqlquery4.Open; }
  //***************
end;

end.

