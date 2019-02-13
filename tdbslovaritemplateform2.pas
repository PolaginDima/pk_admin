unit TDBSlovariTemplateForm2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ActnList,
  ComCtrls,  db,lclproc, LCLType, StdCtrls, ExtCtrls, myDBGrid,sqldb;


type
  proc=procedure(generator, IDPole:string; Q:TSQLQuery);
  procF=procedure(var F:TForm);
  procO1=procedure(var F:TForm;var O:TObject);

  { TDBTemplateForm2 }

  TDBTemplateForm2 = class(TForm)
    Aadding: TAction;
    AUpdating: TAction;
    ActionList1: TActionList;
    ADeleting: TAction;
    AEditing: TAction;
    Aselect: TAction;
    Edit1: TEdit;
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    DBGR:TMydbgrid;
    procedure AaddingExecute(Sender: TObject);
    procedure ADeletingExecute(Sender: TObject);
    procedure AEditingExecute(Sender: TObject);
    procedure AselectExecute(Sender: TObject);
    procedure AUpdatingExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FG: string;
    FI: string;
    FP: proc;
    FPF: procF;
    FPoB: procO1;
    { private declarations }
    tr:TSQLTransaction;
    QR:tsqlquery;
    procedure SetG(AValue: string);
    procedure SetI(AValue: string);
    procedure SetP(AValue: proc);
    procedure SetPF(AValue: procF);
    procedure myOnEditButtonClick(Sender: TObject);
    procedure SetPoB(AValue: procO1);
  public
    { public declarations }
    property P:proc read FP write SetP;
    property PoB:procO1 read FPoB write SetPoB;
    property G:string read FG write SetG;
    property I:string read FI write SetI;
   // property PF:procF read FPF write SetPF;
  end;


var
  DBTemplateForm2: TDBTemplateForm2;
  //function ShowGridSlovari(sCaption:string;ds:tdatasource;TRANSACTION:TSQLTransaction;QUERY:tsqlquery;select:boolean=false):integer;
  function ShowGridSlovari(sCaption:string;TRANSACTION:TSQLTransaction;QUERY:tsqlquery;Pr:proc;Generator, IDPole:string;PrF:procF;PrO:procO1; select:boolean=false):integer;

implementation
uses tdbeditslovari;
var
  result_vibor:integer;
  DS:Tdatasource;
function ShowGridSlovari(sCaption: string; TRANSACTION: TSQLTransaction;
  QUERY: tsqlquery; Pr: proc; Generator, IDPole: string; PrF: procF;
  PrO: procO1; select: boolean): integer;

begin
  if QUERY=nil then exit;

  ds:=tdatasource.Create(nil);
  ds.DataSet:=QUERY;
  DBTemplateForm2:=TDBTemplateForm2.Create(application);
   result:=-1;
   result_vibor:=-1;
  with  DBTemplateForm2 do
  begin
  try
  //Создадим таймер
  //Загрузим наборы данных
  //если форма загружена для выбора, то отобразим кнопку выбора
  DBTemplateForm2.Aselect.visible:=select;
  DBTemplateForm2.Aadding.Enabled:=true;
  DBTemplateForm2.Caption:=sCaption;
  DBTemplateForm2.P:=Pr;
  DBTemplateForm2.PoB:=PrO;;
  DBTemplateForm2.G:=Generator;
  DBTemplateForm2.I:=IDPole;;
  //DBTemplateForm2.Name:='form'+inttostr(nomerF);
  /////////////
   //Создадим свой компонент потомок от DBGRID
   //с возможностью разукрашивать заголовки
   DBGR:=TMydbgrid.Create(DBTemplateForm2.Owner);
  dbgr.Parent:=DBTemplateForm2;
  dbgr.Align:=alTop;
  dbgr.DataSource:=ds;//ds;
  dbgr.OnEditButtonClick:=@myOnEditButtonClick;
  //DBTemplateForm2.dbgr.DataSource:=QUERY.DataSource;//ds;
  ////////////
  tr:=transaction;
  qr:=query;
   //Обнулим фильтр
  qr.Filtered:=false;
  qr.Filter:='';
  dbgr.Height:=200;
  dbgr.Top:=30;;
  dbgr.ReadOnly:=false;
  dbgr.Visible:=true;
  dbgr.FiltrMarkColor:=clBlue;//Цвет разукрашенного заголовка
  dbgr.FiltrMarkFontColor:=clwhite;//Цвет букв разукрашенного заголовка
  dbgr.EnabledMarkFiltr:=true;//Включаем фльтрацию и подсветку
  //dbgr.OnEditButtonClick:=@myOnEditButtonClick;
  if PrF<>nil then PrF(DBTemplateForm2); //дополнительная процедура которая может что-то настроить/сделать
  //на форме и с её компонентами перед её отображением
  showmodal;
  result:=result_vibor;
  finally
  free;
  //QUERY.Free;
  //DS.Free;
end;
  end;
end;

{$R *.lfm}

procedure TDBTemplateForm2.FormShow(Sender: TObject);
begin
  dbgr.Align:=alTop;
  edit1.Top:=0;
end;

procedure TDBTemplateForm2.SetP(AValue: proc);
begin
  if FP=AValue then Exit;
  FP:=AValue;
end;

procedure TDBTemplateForm2.SetPF(AValue: procF);
begin
  if FPF=AValue then Exit;
  FPF:=AValue;
end;

procedure TDBTemplateForm2.myOnEditButtonClick(Sender: TObject);
begin
  if DBTemplateForm2.PoB<>nil then DBTemplateForm2.PoB(DBTemplateForm2, Sender);
end;

procedure TDBTemplateForm2.SetPoB(AValue: procO1);
begin
  if FPoB=AValue then Exit;
  FPoB:=AValue;
end;


procedure TDBTemplateForm2.SetG(AValue: string);
begin
  if FG=AValue then Exit;
  FG:=AValue;
end;

procedure TDBTemplateForm2.SetI(AValue: string);
begin
  if FI=AValue then Exit;
  FI:=AValue;
end;

procedure TDBTemplateForm2.AselectExecute(Sender: TObject);
begin

end;

procedure TDBTemplateForm2.AUpdatingExecute(Sender: TObject);
begin
  qr.Refresh;
end;

procedure TDBTemplateForm2.Button1Click(Sender: TObject);
begin
  //dbgr.addMarkTitle(100);
end;

procedure TDBTemplateForm2.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin

  //if qr.Modified then
 // if ds.DataSet.Modified then
 // begin
   // QR.ApplyUpdates;
    TR.Commit;
 // end;
 //tr.Free;
 // qr.Free;
 //DBGR.Free;
  CloseAction:=cafree;
end;

procedure TDBTemplateForm2.FormCreate(Sender: TObject);
begin

end;

procedure TDBTemplateForm2.AaddingExecute(Sender: TObject);
begin
  qr.Insert;
  DBTemplateForm2.P(DBTemplateForm2.G,DBTemplateForm2.I,qr);
  tdbeditslovari.ShowEditSlovari('добавление',dbgr.DataSource,qr);
end;

procedure TDBTemplateForm2.ADeletingExecute(Sender: TObject);
begin
  //Пометка на удаление и удаление при выходе
  if messagedlg('','удалить запись?',mtInformation ,[mbOK, mbCancel],0)=mrok then  qr.delete;
end;

procedure TDBTemplateForm2.AEditingExecute(Sender: TObject);
begin
  tdbeditslovari.ShowEditSlovari('редактирование',dbgr.DataSource,qr);//dbgr.DataSource);
end;

end.

