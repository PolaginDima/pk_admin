unit slovarPL;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, DBGrids, sqldb,
  IBConnection, DB, dialogs, ExtCtrls, ComCtrls, ActnList, {StdActns, StdCtrls, }
  Buttons{, StdCtrls};

type

  { TslovarPLF }

  TslovarPLF = class(TForm)
    Aadding: TAction;
    ADeleting: TAction;
    AEditing: TAction;
    Aselect: TAction;
    ActionList1: TActionList;
    DBGrid: TDBGrid;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure AaddingUpdate(Sender: TObject);
    procedure ADeletingExecute(Sender: TObject);
    procedure ADeletingUpdate(Sender: TObject);
    procedure AEditingUpdate(Sender: TObject);
    procedure AselectExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
  private
    DS_Sl_Pl: TDataSource;
    SQLQ_Sl_Pl: TSQLQuery;
    SQLT_Sl_Pl: TSQLTransaction;
    { private declarations }
    var connector:tsqlconnector;
  public
    { public declarations }

  end;
   function showSlPl(var conn:tsqlconnector;select:boolean=false):integer;
var
  slovarPLF: TslovarPLF;

implementation
uses addslpl;
var
  result_vibor:integer;
function showSlPl(var conn: tsqlconnector; select: boolean): integer;
begin
     result:=-1;
     result_vibor:=-1;
      slovarPLF:=TslovarPLF.Create(application);
  with  slovarPLF do
  begin
  try
  //Загрузим наборы данных
    connector:=conn;
    SQLT_Sl_Pl:=TSQLTransaction.Create(slovarPLF);
    SQLT_Sl_Pl.DataBase:=connector;
    SQLQ_Sl_Pl:=TSQLQuery.Create(slovarPLF);
    SQLQ_Sl_Pl.DataBase:=connector;
    SQLQ_Sl_Pl.Transaction:=SQLT_Sl_Pl;
    DS_Sl_Pl:=TDataSource.Create(slovarPLF);
    DS_Sl_Pl.DataSet:=SQLQ_Sl_Pl;
    SQLQ_Sl_Pl.SQL.Clear;
    SQLQ_Sl_Pl.SQL.add('select * from PLACE');
    SQLQ_Sl_Pl.Active:=true;
    dbgrid.DataSource:=DS_Sl_Pl;
    //если форма загружена для выбора, то отобразим кнопку выбора
  slovarPLF.Aselect.visible:=select;
  slovarPLF.Aadding.Enabled:=true;
  showmodal;
  result:=result_vibor;
  finally
  free;
end;
  end;
end;

{$R *.lfm}
{ TslovarPLF }

//кнопка добавления
procedure TslovarPLF.ToolButton2Click(Sender: TObject);
var addPL:Taddeditslpl;
begin
  application.createform(Taddeditslpl, addPL);
  //Передаем true, т.к. хотим добавить
 if addPL.ShowModal(true,connector)=1 then
 begin
   //Что-то изменили или добавили в словарь
   //нужно обновить отображаемый список
 end;
 addPl.Free;
end;

//кнопка редактирования
procedure TslovarPLF.ToolButton3Click(Sender: TObject);
var addPL:Taddeditslpl;
begin
  application.createform(Taddeditslpl, addPL);
  //Передаем true, т.к. хотим добавить
 if addPL.ShowModal(false,connector)=1 then
 begin
   //Что-то изменили или добавили в словарь
   //нужно обновить отображаемый список
 end;
 addPl.Free;
end;


procedure TslovarPLF.AaddingUpdate(Sender: TObject);
begin
 // Aadding.Enabled:=true;
end;

procedure TslovarPLF.ADeletingExecute(Sender: TObject);
begin

end;

procedure TslovarPLF.ADeletingUpdate(Sender: TObject);
begin
 //Проверяем, если есть что удалять, то активируем
     ADeleting.Enabled:=SQLQ_Sl_Pl.RecordCount>0;;
end;

procedure TslovarPLF.AEditingUpdate(Sender: TObject);
begin
 //Проверяем, если есть что редактировать, то активируем
 AEditing.Enabled:=SQLQ_Sl_Pl.RecordCount>0;
end;

procedure TslovarPLF.AselectExecute(Sender: TObject);
begin
  //DS_Sl_Pl.DataSet.;
end;

procedure TslovarPLF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
 CloseAction:=cafree;
 slovarPLF:=nil;
 SQLT_Sl_Pl.Free;
 SQLQ_Sl_Pl.Free;
 DS_Sl_Pl.Free;
end;

procedure TslovarPLF.FormCreate(Sender: TObject);
begin

end;


{ TslovarPLF }

{  showmessage(inttostr(dbgrid.Columns.Count));
   }


end.

