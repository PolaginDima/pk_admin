unit my_tabsheet;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,comctrls, controls,sqldb,db,Forms,{Actnlist,}
  dialogs, {lclproc,} myDBGrid, Graphics, {menus,} fpspreadsheet, dateutils, fileutil,
  shellapi, LCLType, DBGrids, Grids, fpsTypes, xlsbiff8;
type
    TMyEvent0=procedure(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer)  of object;
    TMyEvent=procedure(DataSet: TDataSet;IndexPage:integer;NamePage:string; IDPage:integer) of object;
    TMyEvent2=procedure(IndexPage:integer;NamePage:string) of object;
    TMyEvent3=procedure({IndexPage:integer;}NamePage:string;IDPage:integer) of object;
  { Tmytabsheet }

  Tmytabsheet=class(TTabSheet)
    {type
     TMyrecCol=record
                    name:string;
                              left:integer;
                              right:integer;
               end;    }
    private
      //FColArray:array of TMyreccol;
      Fconnector: TSQLconnector;
      FID: integer;
      FmyAfterOpen: TMyEvent;
      FMyAfterUpdateSheet: TNotifyEvent;
      //FmySettingMenu: TMyEvent2;
      FMyFiltered: TNotifyEvent;
      //FmyShow: TNotifyEvent;
      //FnameSheet: string;
      //Fparent_frm: tform;
      FSoftFind: boolean;
      FcountRow:integer;
      FboolPos:boolean;
      function getQ: TSQLQUERY;
      procedure Setconnector(AValue: TSQLconnector);
      procedure SetID(AValue: integer);
      //procedure SetnameSheet(AValue: string);
      //procedure Setparent_frm(AValue: tform);
      function loadSQL(const tSQL:string):boolean;
      procedure SetSoftFind(AValue: boolean);
      procedure SheetFiltered(Sender: TObject);
      procedure SheetDataChange(Sender: TObject; Field: TField);
      procedure MyAfterOpen(DataSet: TDataSet);
      {procedure MyDBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);}
      {procedure OnMyMouseDown(Sender: TObject; Button: TMouseButton;
                          Shift: TShiftState; X, Y: Integer);}
    protected
      FTrans:TSQLTransaction;
      FQuery:TSQLQuery;
      FDS:tdatasource;
      Fdbgr:TMydbgrid;//TDBGrid;
      StatusBar: TStatusBar;
      procedure uploadDBGR;
      procedure uploadRow;
    public
      constructor Create(TheOwner: TComponent);override;
      destructor Destroy;override;
      //property nameSheet:string read FnameSheet write SetnameSheet;
      //property parent_frm:tform read Fparent_frm write Setparent_frm;
      property connector:TSQLconnector read Fconnector write Setconnector;
      procedure UPDatingsheet;
      property Q:TSQLQUERY read getQ;
      property SoftFind:boolean read FSoftFind write SetSoftFind;
      property OnmyAfterOpen:TMyEvent read  FmyAfterOpen write FmyAfterOpen;
      //property OnmySettingMenu:TMyEvent2 read  FmySettingMenu write FmySettingMenu;
      property OnMyFiltered:TNotifyEvent read FMyFiltered write FMyFiltered;
      property OnMyAfterUpdateSheet:TNotifyEvent read FMyAfterUpdateSheet write FMyAfterUpdateSheet;
      property ID:integer read FID write SetID;
  end;

  { Tmypagecontrol }

  Tmypagecontrol=class(Tpagecontrol)
  private
    FFlagNewPage:boolean;
    FflagdblClick:boolean;
    FMyAfterChangePage: TNotifyEvent;
    FMyAfterUpdatePage: TNotifyEvent;
    FmyDblClick: TMyEvent0;
    FMySheetFiltered: TNotifyEvent;
    //FmyShowSheet: TNotifyEvent;
    //FmyDblClick: TMyEvent0;
    FNumberSheet:integer;
    FmyAfterOpen: TMyEvent;
    //FmySettingMenu: TMyEvent3;
    FSoftFind: boolean;
    function GetIDActivPage: integer;
    function GetnameIDSheet(ID: integer): string;
    function GetnameSheet(Sheet: TPersistent): string;
    function GETQUERY: TSQLQUERY;
    function GetSoftFind: boolean;
    //procedure changepage;
    procedure mypagecontrolChange(Sender: TObject);
    procedure mypagecontrolChanging(Sender: TObject;
    var AllowChange: Boolean);
    //procedure ClearToolBar;
    procedure SetIDActivPage(AValue: integer);
    procedure SetSoftFind(AValue: boolean);
    procedure MyAfterOpen(DataSet: TDataSet;IndexPage:integer;NamePage:string; IDPage:integer);
    //procedure MySettingMenu(IndexPage:integer;NamePage:string);
    procedure MyDblClick(Sender:TObject);
    //procedure MyShowSheet(Sender:TObject);
    procedure MyPageFiltered(Sender:TObject);
    procedure MyPageUpdated(Sender:TObject);
    procedure MyMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    function CheckIDTab(ID:integer):boolean;
  public
    constructor Create(TheOwner: TComponent);override;
    destructor Destroy;override;
     procedure loadPAG(const tSQL:string;const namesheet:string;
       conn:TSQLConnector; const ID:integer);
     procedure UnLoadPAG(const Index:integer);
     procedure UPDatingPAG;
     procedure ExitSheet;
     procedure uploadDBGR;
     procedure uploadRow;
     procedure RefreshPAG;overload;
     procedure RefreshPAG(IDPage:integer);overload;
     procedure RefreshPAG(namePage:string);overload;
     procedure SetIDPage(const IndexPage:integer;const ID:integer);
     property Query:TSQLQUERY read GETQUERY;
     property SoftFind:boolean read GetSoftFind write SetSoftFind;
     property OnmyAfterOpen:TMyEvent read  FmyAfterOpen write FmyAfterOpen;
     //property OnmySettingMenu:TMyEvent3 read  FmySettingMenu write FmySettingMenu;
     property OnmyDblClick:TMyEvent0 read  FmyDblClick write FmyDblClick;
     //property OnmyShowSheet:TNotifyEvent read  FmyShowSheet write FmyShowSheet;
     property OnMySheetFiltered:TNotifyEvent read FMySheetFiltered write FMySheetFiltered;
     property OnMyAfterChangePage:TNotifyEvent read FMyAfterChangePage write FMyAfterChangePage;
     property OnMyAfterUpdatePage:TNotifyEvent read FMyAfterUpdatePage write FMyAfterUpdatePage;
     //property OnmyDblClick:TNotifyEvent read  FmyDblClick write FmyDblClick;
     property IDActivPage:integer read GetIDActivPage write SetIDActivPage;
     property nameIDSheet[ID:integer]:string read GetnameIDSheet;
     property nameSheet[Sheet:TPersistent]:string read GetnameSheet;
  end;

implementation
uses createDOC;
{const
SPREAD_FORMAT: array[0..4] of TsSpreadsheetFormat = (sfOpenDocument, sfOOXML, sfExcel8, sfExcel5, sfExcel2);  }


procedure Tmypagecontrol.mypagecontrolChange(Sender: TObject);
begin
   if Assigned(OnMyAfterChangePage) then FMyAfterChangePage(Sender);
   //changepage;
   RefreshPAG;
end;

procedure Tmypagecontrol.mypagecontrolChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  //ClearToolBar;
 { changepage;
  //Tmytabsheet(self.ActivePage).Fdbgr.Refresh;
  RefreshPAG;  }
end;

{procedure Tmypagecontrol.ClearToolBar;
var i,j:integer;
begin
 for i:=0 to Parent.ComponentCount-1 do
    if (Parent.Components[i] is TActionList) then
    if (TActionList(Parent.Components[i]).Name='ActionList1') then
      for j:= TActionList(Parent.Components[i]).ActionCount-1 downto 0 do
         begin
          TAction( TActionList(Parent.Components[i]).Actions[j]).Enabled:=false;
          Taction( TActionList(Parent.Components[i]).Actions[j]).Hint:='';
         end          else
         for j:= TActionList(Parent.Components[i]).ActionCount-1 downto 0 do
            begin
             TAction( TActionList(Parent.Components[i]).Actions[j]).Enabled:=false;
             Taction( TActionList(Parent.Components[i]).Actions[j]).Hint:='';
            end;
end; }

procedure Tmypagecontrol.SetIDActivPage(AValue: integer);
begin
  if Tmytabsheet(self.ActivePage).ID=AValue then Exit;
  //Проверим, а вдруг такой ID уже используется
  if not CheckIDTab(AValue) then
  begin
    messagedlg('ошибка','лист с таким идентификатором уже есть!',mtError,[mbOK],0);
    exit;
  end;
  Tmytabsheet(self.ActivePage).ID:=AValue;
end;

procedure Tmypagecontrol.SetSoftFind(AValue: boolean);
begin
  if SoftFind=AValue then Exit;
  FSoftFind:=AValue;
  if PageCount>0 then
  begin
     Tmytabsheet(ActivePage).SoftFind:=FSoftFind;
  end;
end;

procedure Tmypagecontrol.MyAfterOpen(DataSet: TDataSet; IndexPage: integer;
  NamePage: string; IDPage: integer);
begin
 if assigned(OnmyafterOpen) then FmyAfterOpen(DataSet,IndexPage,NamePage, IDPage);
end;

procedure Tmypagecontrol.MyDblClick(Sender:TObject);
begin
 FflagdblClick:=true;
 //if assigned(self.OnmyDblClick) then self.OnmyDblClick(Sender);
end;

{procedure Tmypagecontrol.MyShowSheet(Sender: TObject);
begin
  if Assigned(OnMyShowSheet) then FMyShowSheet(Sender);
end; }

procedure Tmypagecontrol.MyPageFiltered(Sender: TObject);
begin
  if Assigned(OnMySheetFiltered) then FMySheetFiltered(Sender);
end;

procedure Tmypagecontrol.MyPageUpdated(Sender: TObject);
begin
  if Assigned(OnMyAfterUpdatePage) then FMyAfterUpdatePage(Sender);
end;

procedure Tmypagecontrol.MyMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if FflagdblClick then
 begin
    if assigned(OnmyDblClick) then OnmyDblClick(Sender,Button,Shift,X,Y);
    FflagdblClick:=false;
 end;
end;

function Tmypagecontrol.CheckIDTab(ID: integer): boolean;
var i:integer;
begin
 result:=true;
 for i:=0 to PageCount-1 do
    begin
     if Tmytabsheet(Pages[i]).ID=ID then
     begin
        result:=false;
        exit;
     end;
    end;
end;

function Tmypagecontrol.GETQUERY: TSQLQUERY;
begin
  result:=Tmytabsheet(ActivePage).Q;
end;

function Tmypagecontrol.GetIDActivPage: integer;
begin
  if PageCount<=0 then result:=-1 else result:=Tmytabsheet(ActivePage).ID;
end;

function Tmypagecontrol.GetnameIDSheet(ID: integer): string;
var
   i:integer;
begin
 for i:=0 to PageCount-1 do
    begin
     if (Pages[i] as Tmytabsheet).ID=ID then
     begin
          result:=(Pages[i] as Tmytabsheet).Caption;
          break;
     end;
    end;
end;

function Tmypagecontrol.GetnameSheet(Sheet: TPersistent): string;
begin
 if IndexOf(Sheet)<0 then exit;
 result:=(Pages[indexof(Sheet)] as Tmytabsheet).Caption;
end;

function Tmypagecontrol.GetSoftFind: boolean;
begin
 if PageCount>0 then
  begin
     result:=Tmytabsheet(ActivePage).SoftFind;
  end;
end;

constructor Tmypagecontrol.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  OnChange:=@mypagecontrolChange;
  OnChanging:=@mypagecontrolChanging;
  //OnmyShowSheet:=@MyShowSheet;
  TabPosition:=tpBottom;
  FNumberSheet:=0;
  FflagdblClick:=false;
end;

destructor Tmypagecontrol.Destroy;
var i:integer;
begin
  //Тут перебрать все листы и уничтожить их
 for i:=self.PageCount-1 downto 0 do
 begin
  Tmytabsheet(Pages[i]).Free;
 end;
  inherited Destroy;
end;

procedure Tmypagecontrol.loadPAG(const tSQL: string; const namesheet: string;
  conn: TSQLConnector; const ID: integer);
var tabsheettmp: Tmytabsheet;
  i:integer;
begin
  //проверяем, если листа с таким именем нет, то
  //создадим лист, иначе сделаем его активным
  for i:=0 to self.PageCount-1 do
      if Pages[i].Caption=namesheet then
         begin
           ActivePageIndex:=i;//break;
           tabsheettmp:=Tmytabsheet(ActivePage);//Сделаем активным
           tabsheettmp.Fdbgr.SetFocus;//передадим фокус в DataGrid
           exit;
         end;

         tabsheettmp:=Tmytabsheet.Create(Owner);
         tabsheettmp.OnmyAfterOpen:=@MyAfterOpen;
         //tabsheettmp.OnmySettingMenu:=@MySettingMenu;
         tabsheettmp.OnMyFiltered:=@MyPageFiltered;
         //tabsheettmp.OnShow:=@MyShowSheet;
         tabsheettmp.OnMyAfterUpdateSheet:=@MyPageUpdated;
         tabsheettmp.Fdbgr.OnDblClick:=@MyDblClick;
         tabsheettmp.Fdbgr.OnMouseUp:=@MyMouseUp;

      tabsheettmp.Parent:=self;
      tabsheettmp.Caption:=namesheet;
      inc(FNumberSheet);
      tabsheettmp.Name:='mysheet'+inttostr(FNumberSheet);//inttostr(self.PageCount+1);
      //tabsheettmp.nameSheet:=namesheet;
      tabsheettmp.ID:=ID;
      //tabsheettmp.parent_frm:=tform(Parent);
      tabsheettmp.connector:=conn;
      FFlagNewPage:=true;
  if tabsheettmp.loadSQL(tSQL) then
      begin
        //Создадим свой компонент потомок от DBGRID
        //с возможностью разукрашивать заголовки
         tabsheettmp.Visible:=true;//сделаем новую вкладку видимой
         ActivePage:=tabsheettmp;//сделаем новую вкладку активной
         tabsheettmp.Fdbgr.SetFocus;//передадим фокус в DataGrid
         FFlagNewPage:=false;
      end else
      begin
       FFlagNewPage:=false;
       exit;
      end;
end;

procedure Tmypagecontrol.UnLoadPAG(const Index: integer);
begin
  (Pages[Index] as Tmytabsheet).Free;
end;

procedure Tmypagecontrol.UPDatingPAG;
var tabsheettmp:Tmytabsheet;
begin
  if PageCount<=0 then exit;
  tabsheettmp:=(ActivePage as Tmytabsheet);
  tabsheettmp.UPDatingsheet;
end;

procedure Tmypagecontrol.ExitSheet;
 var tmp:Tmytabsheet;
begin
  //Если есть листы, то закрываем активный
  if PageCount>0 then
  begin
     tmp:= Tmytabsheet(ActivePage);
     Query.Filtered:=false;
    RemovePage(self.ActivePage.TabIndex);// Tmytabsheet(self.ActivePage).Free;
    tmp.Free;
  end;
  //if PageCount<=0 then
    //уберем кнопки, если нет листов
  //ClearToolBar;
end;

procedure Tmypagecontrol.uploadDBGR;
begin
  if (PageCount>0)and
  ((ActivePage as Tmytabsheet).FQuery.RecordCount>0) then
  (ActivePage as Tmytabsheet).uploadDBGR;
end;

procedure Tmypagecontrol.uploadRow;
begin
  if (PageCount>0)and
  ((ActivePage as Tmytabsheet).FQuery.RecordCount>0) then
  (ActivePage as Tmytabsheet).uploadRow;
end;

procedure Tmypagecontrol.RefreshPAG;
var
  recNo:integer;
begin
  //if not Tmytabsheet(self.ActivePage).Q.IsEmpty then recNo:=Tmytabsheet(self.ActivePage).Q.RecNo;
  if (ActivePage as Tmytabsheet).Q.IsEmpty then exit;
  if (ActivePage as Tmytabsheet).Q.FindField('ID')=nil then
  begin
    recNo:=(ActivePage as Tmytabsheet).Q.RecNo;
    (ActivePage as Tmytabsheet).Q.Refresh;
    (ActivePage as Tmytabsheet).Q.RecNo:=recNo;
    exit;
  end;
  recNo:=(ActivePage as Tmytabsheet).Q.FieldByName('ID').AsInteger;
  (ActivePage as Tmytabsheet).Q.Refresh;
  //(ActivePage as Tmytabsheet).Q.RecNo:=recNo;
  (ActivePage as Tmytabsheet).Q.Locate('ID',recNo,[]);
end;

procedure Tmypagecontrol.RefreshPAG(IDPage: integer);
var i:integer;
    recNo:integer;
begin
  for i:=0 to PageCount-1 do
  begin
       if Tmytabsheet(Pages[i]).ID=IDPage then
       begin
         if not (ActivePage as Tmytabsheet).Q.IsEmpty then recNo:=(ActivePage as Tmytabsheet).Q.FieldByName('ID').AsInteger;
         (Pages[i] as Tmytabsheet).Q.DisableControls;
         (Pages[i] as Tmytabsheet).Q.Refresh;
         (ActivePage as Tmytabsheet).Q.Locate('ID',recNo,[]);
         (Pages[i] as Tmytabsheet).Q.EnableControls;
         exit;
       end;
  end;
end;

procedure Tmypagecontrol.RefreshPAG(namePage: string);
var i:integer;
    recNo:integer;
begin
  for i:=0 to self.PageCount-1 do
  begin
       if self.Pages[i].Caption=namePage then
       begin
         if not (ActivePage as Tmytabsheet).Q.IsEmpty then recNo:=(ActivePage as Tmytabsheet).Q.FieldByName('ID').AsInteger;
         (Pages[i] as Tmytabsheet).Q.DisableControls;
         (Pages[i] as Tmytabsheet).Q.Refresh;
         (ActivePage as Tmytabsheet).Q.Locate('ID',recNo,[]);
         (Pages[i] as Tmytabsheet).Q.EnableControls;
         exit;
       end;
  end;
end;

procedure Tmypagecontrol.SetIDPage(const IndexPage: integer; const ID: integer);
begin
  //Проверим, а вдруг такой ID уже используется
  if not CheckIDTab(ID) then
  begin
    messagedlg('ошибка','лист с таким идентификатором уже есть!',mtError,[mbOK],0);
    exit;
  end;
  Tmytabsheet(Pages[IndexPage]).ID:=ID;
end;

{ Tmytabsheet }
function Tmytabsheet.getQ: TSQLQUERY;
begin
  result:=fQuery;
end;

procedure Tmytabsheet.Setconnector(AValue: TSQLconnector);
begin
  if Fconnector=AValue then Exit;
  Fconnector:=AValue;
end;

procedure Tmytabsheet.SetID(AValue: integer);
begin
  if FID=AValue then Exit;
  FID:=AValue;
end;

{procedure Tmytabsheet.SetnameSheet(AValue: string);
begin
  if FnameSheet=AValue then Exit;
  FnameSheet:=AValue;
end;

procedure Tmytabsheet.Setparent_frm(AValue: tform);
begin
  if Fparent_frm=AValue then Exit;
  Fparent_frm:=AValue;
end; }

function Tmytabsheet.loadSQL(const tSQL: string): boolean;
begin
  result:=false;
  //-------------
  try
     //загружаем данные в сетку
  FQuery.DataBase:=connector;
  FQuery.Transaction:=self.connector.Transaction;
  FQuery.SQL.Clear;
  Fquery.SQL.Add(tSQL);
  FQuery.ReadOnly:=true;
  FDS.DataSet:=FQuery;
  FDBGR.DataSource:=FDS;
  FDBGR.SQLQUERYdop:=FQuery;
  FQuery.Close;
  FQuery.Open;
  FQuery.Refresh;
  //Если подключено, то сгенерируем событие
  //if assigned(OnmySettingMenu) then FmySettingMenu(TabIndex,Caption);
  //setlength(self.FColArray, FQuery.Fields.Count);
  result:=true;
  except
    on E: Exception do
      begin
           if (pos('sw_incorrect_operation',lowercase( e.message))>0) then
            begin
              MessageDlg('Ошибка','Нельзя дважды принять одного и того же'+lineending+
              'человека',mtInformation,[mbOK],0)
            end else  MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
      end;
  end;
end;

procedure Tmytabsheet.SetSoftFind(AValue: boolean);
begin
  if FSoftFind=AValue then Exit;
  FSoftFind:=AValue;
  Fdbgr.SoftFind:=FSoftFind;
end;

procedure Tmytabsheet.SheetFiltered(Sender: TObject);
var stmp, stmp2:string;
  j:integer;
begin
  //self.SettingPAG;
  //if assigned(OnmySettingMenu) then FmySettingMenu(TabIndex,Caption);
  if assigned(OnMyFiltered) then FMyFiltered(self);
  FboolPos:=true;
  FcountRow:=FQuery.RecordCount;
  if (Fdbgr.DataSource=nil)  then exit;
  if not Fdbgr.DataSource.DataSet.IsEmpty then
  begin
       if Fdbgr.DataSource.DataSet.FindField('ID')=nil then
       begin
         StatusBar.SimpleText:='';
         exit;
       end;
       stmp2:=Fdbgr.DataSource.DataSet.FieldByName('ID').AsString;
       Fdbgr.DataSource.DataSet.DisableControls;
       Fdbgr.DataSource.DataSet.First;
       j:=0;
       while not Fdbgr.DataSource.DataSet.EOF  do
       begin
        j:=j+1;
            if FQuery.FieldByName('ID').AsString=stmp2 then stmp:='Запись '+inttostr(j);
            Fdbgr.DataSource.DataSet.Next;
       end;
       Fdbgr.DataSource.DataSet.Locate('ID',stmp2,[]);
       Fdbgr.DataSource.DataSet.EnableControls;
       stmp:=stmp+' из '+inttostr(j);
  end else stmp:='нет записей ';
  if FcountRow>=0 then stmp:=stmp+' Всего записей: '+inttostr(FcountRow);
  StatusBar.SimpleText:=stmp;
  FboolPos:=false;
end;

procedure Tmytabsheet.SheetDataChange(Sender: TObject; Field: TField);
var stmp:string;
begin
 if FboolPos then exit;
  if (Fdbgr.DataSource=nil) then exit;
  if (FQuery.EOF) then FcountRow:=FQuery.RecordCount;

  if Fdbgr.DataSource.DataSet.Filtered then SheetFiltered(self) else
    begin
      if not Fdbgr.DataSource.DataSet.IsEmpty then
      stmp:='Запись: ' + inttostr(self.Fdbgr.DataSource.DataSet.RecNo)
      else stmp:='нет записей ';
       if FcountRow>=0 then stmp:=stmp+' Всего записей: '+inttostr(FcountRow);
        StatusBar.SimpleText:=stmp;
    end;
end;

procedure Tmytabsheet.MyAfterOpen(DataSet: TDataSet);
begin
   if Assigned(OnmyAfterOpen) then FmyAfterOpen(dataset,TabIndex,Caption, self.ID);
end;

constructor Tmytabsheet.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  Visible:=false;
  StatusBar:=TStatusBar.Create(Owner);
  StatusBar.Parent:=self;
  StatusBar.Align:=alBottom;
  Fdbgr:=TMydbgrid.Create(Owner);//tdbgrid.Create(self.Owner); //сетка
  Fdbgr.Parent:=self;
  Fdbgr.Align:=alClient;
  Fdbgr.ReadOnly:=true;
  Fdbgr.Options:=Fdbgr.Options+[dgRowHighlight];//Подсветка выделенной строки, вроде
  Fdbgr.FiltrMarkColor:=clBlue;//Цвет разукрашенного заголовка
  Fdbgr.FiltrMarkFontColor:=clwhite;//Цвет букв разукрашенного заголовка
  Fdbgr.EnabledMarkFiltr:=true;//Включаем фльтрацию и подсветку
  //Fdbgr.OnDrawColumnCell:=@MyDBGrid1DrawColumnCell;
  //Fdbgr.OnMouseDown:=@OnMyMouseDown;
  Fdbgr.Font.Size:=14;   //Размер текста в сетке
  Fdbgr.DefaultRowHeight:=30; //высота строк в сетке
  FTrans:=tsqltransaction.Create(self.Owner);
  FQuery:=tsqlquery.Create(self.Owner);
  FDS:=tdatasource.Create(self.Owner);
  FDS.OnDataChange:=@SheetDataChange;
  SoftFind:=true;
  fdbgr.OnmyFiltered:=@SheetFiltered;
  FQuery.AfterOpen:=@MyAfterOpen;
  FcountRow:=0;
  FboolPos:=false;
end;

destructor Tmytabsheet.Destroy;
begin
  //Закрываем наборы данных
  //Уничтожаем наборы данных
  //Fdbgr.Free;
  FTrans.Rollback;
  FTrans.Free;
  FQuery.Free;
  FDS.Free;
  Fdbgr.Free;
  StatusBar.Free;
  inherited Destroy;
end;

procedure Tmytabsheet.UPDatingsheet;
type
  setqr=record
  //setgr=record
    width:integer;
    DisplayLabel:string;
    Visible:boolean;
  end;
var stmp:string;
  j:integer;
  stqr:array of setqr;
begin
             FcountRow:=0;
        setlength(stqr,Fquery.FieldCount);
        for j:=0 to Fquery.Fields.Count-1 do
        begin
          stqr[j].width:=Fquery.Fields.Fields[j].DisplayWidth;
          stqr[j].DisplayLabel:=Fquery.Fields.Fields[j].DisplayLabel;
          stqr[j].Visible:=Fquery.Fields.Fields[j].Visible;
         //stgr[j].width:=Fdbgr.Columns.Items[j].Width;
        end;
        if not Fquery.IsEmpty then
        stmp:=Fquery.FieldByName('ID').asstring else
          stmp:='';
        Fquery.DisableControls;
        //self.connector.Transaction.Commit;
        //self.connector.Connected:=false;
        Fquery.Close;
        Fquery.Open;
        Fquery.Refresh;
        if stmp<>'' then
        Fquery.Locate('ID',stmp,[]);
        for j:=0 to Fquery.Fields.Count-1 do
        begin
         Fquery.Fields.Fields[j].DisplayWidth:=stqr[j].width;
         Fquery.Fields.Fields[j].DisplayLabel:=stqr[j].DisplayLabel;
         Fquery.Fields.Fields[j].Visible:=stqr[j].Visible;
        end;
        Fquery.EnableControls;
        finalize(stqr);
        stqr:=nil;
        //настройка кнопок
        //if assigned(OnmySettingMenu) then FmySettingMenu(TabIndex,self.Caption);
        if Assigned(OnMyAfterUpdateSheet) then FMyAfterUpdateSheet(self);
end;

procedure Tmytabsheet.uploadDBGR;
var i, j:integer;
  MyWorkbook: TsWorkbook;
  MyWorksheet: TsWorksheet;
  sostFiltered:boolean;
  sdir, spath:string;
   sl:tstringlist;
   RecNo:integer;
begin
  //---------
  try
   MyWorkbook := TsWorkbook.Create;
  // MyWorkbook.ReadFromFile(UTF8ToSys('D:\MY_PROGRAMS\Project\PTK_ADMIN\data\shablon\shablongr.xls'),SPREAD_FORMAT[2]);
   MyWorksheet :=MyWorkbook.AddWorksheet(Caption);  {MyWorkbook.GetWorksheetByIndex(0);}
   MyWorkbook.Options := [];//Options;
   //Application.ProcessMessages;
  //---------
  FQuery.DisableControls;
  //запоминаем позицию
  RecNo:=self.FQuery.RecNo;
  {if self.FQuery.FindField('ID')<>nil then
  idd:=self.FQuery.FieldByName('ID').AsInteger;}
  FQuery.First;
  try
  //MyWorksheet.WriteUTF8Text(0, 0,'Выгрузка');
  MyWorksheet.WriteText(0, 0,'Выгрузка');
  for i:=0 to self.FQuery.FieldCount-1 do
  begin
  // if self.FQuery.Fields.Fields[i].Visible then
   begin
        MyWorksheet.WriteText(2, i, FQuery.Fields.Fields[i].FieldName);
        MyWorksheet.WriteUsedFormatting(2, i, [uffWordwrap]);
        MyWorksheet.WriteBorders(2, i, [cbNorth, cbEast, cbSouth, cbWest]);
        MyWorksheet.WriteBackgroundColor(2, i, scSilver);
   end;
  end;
  //Application.ProcessMessages;
  sostFiltered:=FQuery.Filtered;
  FQuery.Filtered:=false;
  i:=0;
  while not FQuery.EOF do
  begin
   for j:=0 to FQuery.FieldCount-1 do
   begin
        MyWorksheet.WriteUsedFormatting(3+i, j, [uffWordwrap]);
        MyWorksheet.WriteBorders(3+i, j, [cbNorth, cbEast, cbSouth, cbWest]);
        MyWorksheet.WriteBackgroundColor(3+i, j, scGray10pct{%H-});
        if not FQuery.Fields.Fields[j].IsNull then
        MyWorksheet.WriteText(3+i, j, ''+self.FQuery.Fields.Fields[j].AsString);
       end;
   //Application.ProcessMessages;
   i:=i+1;
   FQuery.Next;
  end;
  MyWorksheet.WriteText(1, 0, 'Всего записей: '+inttostr(i)+'');
//  MyWorksheet.WriteFormula(1,1,'SUBTOTAL(3;A3:A5)');//'+inttostr(3+i)+')');
  //Application.ProcessMessages;
  FQuery.Filtered:=sostfiltered;
  //Сохраняем в файл
  sdir:=ExtractFilePath(Application.ExeName) + 'data' + DirectorySeparator+'out'+DirectorySeparator;
  spath:=sdir + inttostr(SecondOfTheWeek(now))+'.xls';
  //почистим директорию от старых файлов
    if DirectoryExists(sdir) then
  begin
    sl:=FindAllFiles(sdir,'');
    for i:=0 to sl.Count-1 do     DeleteFile(sl.ValueFromIndex[i]);
  end else CreateDir(sdir);
  try
      //Application.ProcessMessages;
      myWorkbook.WriteToFile(spath,  sfExcel8{SPREAD_FORMAT[2]}, true);
       MessageDlg  ('информация','Выгрузка завершена', mtConfirmation, [mbOk],0);
       if directoryexists(sdir) then
       if (MessageDlg  ('информация','Открыть папку с выгрузкой?', mtConfirmation, [mbYes]+[mbNo],0))=6 then
          begin
            shellexecute(Parent.Parent.Handle  {parent_frm.Handle},'explore',pchar(sdir),nil,nil,SW_RESTORE);
          end;
  except
  end;
  except
    on E: Exception do
        MessageDlg('Неизвестная ошибка',e.Message,mtError,[mbOK],0);
  end;
  //----------
  finally
     self.FQuery.RecNo:=RecNo;//встаем на запомненную запись
     {if self.FQuery.FindField('ID')<>nil then
     self.FQuery.Locate('ID',idd,[]);}
     self.FQuery.EnableControls;
     MyWorkbook.Free;
  end;
end;

procedure Tmytabsheet.uploadRow;
var myDOCS:TmyDOCS;
   nr:integer;
begin
  nr:=self.Q.RecNo;
  myDOCS:=TmyDOCS.Create(ttaKart_Slovar,ExtractFilePath(Application.ExeName),self.FQuery, self.Caption);
  //Тут всякие действия
  myDOCS.Free;
  try
     self.Q.RecNo:=nr;
  finally
  end;
end;
end.

