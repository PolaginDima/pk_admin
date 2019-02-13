unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  Menus, ComCtrls, DbCtrls, ActnList, ExtCtrls, sqldb, db, my_tabsheet, lazutf8,
  LCLType, DBGrids, workBD, Grids, ExtDlgs, StdCtrls, dateutils, findrecord;

type
  TMyStatusLoadBD=(MySLBDErr, MySLBDcheckUsr, MySLBDcheckUsrErr,
    MySLBDConnUsr, MySLBDcheckUsrNo, MySLBDcheckUsrYes);
  TOnMyStatus=procedure (Status:TMyStatusLoadBD) of object;
  { TMyThread }

  TMyThread=class (TThread)
      private
        //FClose:boolean;
        //Fconnlogin: string;
        //Fconnpwd: string;
        FconnectorRead:TMyworkbd;
        FOnMyStatus: TOnMyStatus;
        FStatus:TMyStatusLoadBD;
        procedure Showstatus;
      protected
        procedure execute; override;
      public
        constructor Create( CreateSuspended:boolean;var X:TMyworkbd);
        property OnMyStatus:TOnMyStatus read FOnMyStatus write FOnMyStatus ;
    end;



  { TmainF }
   tqquery=array of TSQLQuery;
  TmainF = class(TForm)
      Aadding: TAction;
      Aakt: TAction;
      AFindNext: TAction;
      AUpload: TAction;
      AFind: TAction;
      AExit: TAction;
      aMoving: TAction;
      ActionList1: TActionList;
      ActionList2: TActionList;
      ADeleting: TAction;
      ADeleting1: TAction;
      AEditing: TAction;
      AMoving2: TAction;
      AUpdating: TAction;
      AUpdating1: TAction;
      CalendarDialog1: TCalendarDialog;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem51: TMenuItem;
    MenuItem52: TMenuItem;
    MenuItem53: TMenuItem;
    MenuItem54: TMenuItem;
    MenuItem55: TMenuItem;
    MenuItem56: TMenuItem;
    MenuItem57: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem59: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem60: TMenuItem;
    MenuItem61: TMenuItem;
    MenuItem62: TMenuItem;
    MenuItem63: TMenuItem;
    MenuItem64: TMenuItem;
    MenuItem65: TMenuItem;
    MenuItem66: TMenuItem;
    MenuItem67: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItemSU: TMenuItem;
    MenuItemSD: TMenuItem;
    MenuItemSG: TMenuItem;
    MenuItemSP: TMenuItem;
    MenuItemDP: TMenuItem;
    MenuItemS: TMenuItem;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    ToolBar4: TToolBar;
    ToolBar5: TToolBar;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    procedure AaddingExecute(Sender: TObject);
    procedure AaktExecute(Sender: TObject);
    procedure ADeletingExecute(Sender: TObject);
    procedure AEditingExecute(Sender: TObject);
    procedure AExitExecute(Sender: TObject);
    procedure AFindExecute(Sender: TObject);
    procedure AFindNextExecute(Sender: TObject);
    procedure aMovingExecute(Sender: TObject);
    procedure AUpdatingExecute(Sender: TObject);
    procedure AUploadExecute(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure MenuItem33Click(Sender: TObject);
    procedure MenuItem34Click(Sender: TObject);
    procedure MenuItem35Click(Sender: TObject);
    procedure MenuItem36Click(Sender: TObject);
    procedure MenuItem37Click(Sender: TObject);
    procedure MenuItem39Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem40Click(Sender: TObject);
    procedure MenuItem41Click(Sender: TObject);
    procedure MenuItem43Click(Sender: TObject);
    procedure MenuItem44Click(Sender: TObject);
    procedure MenuItem45Click(Sender: TObject);
    procedure MenuItem46Click(Sender: TObject);
    procedure MenuItem48Click(Sender: TObject);
    procedure MenuItem49Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem51Click(Sender: TObject);
    procedure MenuItem52Click(Sender: TObject);
    procedure MenuItem53Click(Sender: TObject);
    procedure MenuItem54Click(Sender: TObject);
    procedure MenuItem55Click(Sender: TObject);
    procedure MenuItem56Click(Sender: TObject);
    procedure MenuItem57Click(Sender: TObject);
    procedure MenuItem58Click(Sender: TObject);
    procedure MenuItem59Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem61Click(Sender: TObject);
    procedure MenuItem62Click(Sender: TObject);
    procedure MenuItem63Click(Sender: TObject);
    procedure MenuItem64Click(Sender: TObject);
    procedure MenuItem65Click(Sender: TObject);
    procedure MenuItem66Click(Sender: TObject);
    procedure MenuItem67Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItemDPClick(Sender: TObject);
    procedure MenuItemSDClick(Sender: TObject);
    procedure MenuItemSGClick(Sender: TObject);
    procedure MenuItemSPClick(Sender: TObject);
    procedure MenuItemSUClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    private
      Fwinstat:TWindowState;
      bdchld:Tstringlist;
      bdemplstr:string;
      Ffirst:boolean;
      frmfindrecord: Tfrmfindrecord;
      //FconnFind:TMyworkbd;
      //FQueryFind:TSQLQuery;
      Fshowbirthday:boolean;
      Fconnector: tsqlconnector;
      FconnectorRead:TMyworkbd;
      FmyClass:Tmypagecontrol;
      //для журналов
      //FTrans:tsqltransaction;
     // FDS:TDataSource;
      Fconnlogin: string;
      Fconnpwd: string;
    { private declarations }
      tmpquery:tsqlquery;
      tmptrans:tsqltransaction;
      ThreadLoadBD:TMyThread;
    procedure   myOnCalcFields(DataSet: TDataSet);
    procedure resAuth;
    procedure Check_TMP_STOP;
    procedure EndLoad(Status:TMyStatusLoadBD);
    procedure Setconnector(AValue: tsqlconnector);
    procedure Setconnlogin(AValue: string);
    procedure Setconnpwd(AValue: string);
    procedure ClearToolBar;
    procedure loadPAG(const ID:integer;const namesheet:string;
       conn:TSQLConnector;const ID_RAION:integer;var ID_USER:integer;periodb:boolean=false;
       const yyyystart:integer=0;const mmstart:integer=0;const ddstart:integer=0;
       const yyyyend:integer=0;const mmend:integer=0;const ddend:integer=0);
    procedure AfterOpen(DataSet: TDataSet;IndexPage:integer;NamePage:string; IDPage:integer);
    procedure SettingMenu({IndexPage:integer;}NamePage:string;IDPage:integer);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure MyMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    //procedure dblClick(Sender:TObject);
    function checkparametr(value:string):boolean;
    function checkdostup(name_table:string):integer;
    //procedure MyShowSheet(Sender:TObject);
    procedure MySheetFiltered(Sender:TObject);
    procedure MyAfterChangePage(Sender:TObject);
  public
    { public declarations }
    Trans:array of TSQLTransaction;
    Query:array of TSQLQuery;
    DS:array of tdatasource;
    //property connlogin:string read Fconnlogin write Setconnlogin;
    //property connpwd:string read Fconnpwd write Setconnpwd;
    //-------------------
    //Процедуры вызова словарей
    function openPEOPLE(const select:boolean=false):integer;
    function openLicPO(const select:boolean=false):integer;
    function openSTART_WORK(const select:boolean=false):integer;
    function openPOST(const select:boolean=false):integer;
    function openRESURS(const select:boolean=false):integer;
    function openPO(const select:boolean=false):integer;
    function openInstAction(const select:boolean=false):integer;
    function openGROUP(const select:boolean=false):integer;
    function openLOCATION(const select:boolean=false):integer;
    function openTERRITOR(const select:boolean=false):integer;
    function openMOTIVESTARTWORK(const select:boolean=false):integer;
    function openMOTIVEUVOLNENIE(const select:boolean=false):integer;
    function openMNIMODEL(const select:boolean=false):integer;
    function openRAZNOEMODEL(const select:boolean=false):integer;
    function openMNITIP(const select:boolean=false):integer;
    function openRAZNOETIP(const select:boolean=false):integer;
    function openRASHODNIKNAME(const select:boolean=false):integer;
    function openRASHODNIKTIP(const select:boolean=false):integer;
    function openMOTIVESPISMNI(const select:boolean=false):integer;
    function openMOTIVESPISRAZNOE(const select:boolean=false):integer;
    function openMOTIVESPISSB(const select:boolean=false):integer;
    function openKripto(const select:boolean=false):integer;
    procedure openTMP_STOP_SW;
    function openMOTIVEDELKRIPTO(const select:boolean=false):integer;
    function  openTIPEDU(const select:boolean=false):integer;
    function openMOTIVE_TMP_STOP_SW(const select:boolean=false):integer;
    function openMOTIVE_TMP_STOP_SERT(const select:boolean=false):integer;
    function openNAME_SB(const select:boolean=false):integer;
    function openTIP_LICENSE_OS(const select:boolean=false):integer;
    function openTIP_WORK_SB(const select:boolean=false):integer;
    function openNAME_OS(const select:boolean=false):integer;
    function openTIP_PROC(const select:boolean=false):integer;
    function openTIP_MEMORY(const select:boolean=false):integer;
    procedure openRAIONS;
    //-------------------
    //property Trans:tsqltransaction read FTrans write SetTrans;
    //property DS:tdatasource read FDS write SetDS;
    { property QUERY:tqquery read FQuery write SetQuery;   }
    property connector:tsqlconnector read Fconnector write Setconnector;
  end;

var
  mainF: TmainF;

implementation
uses  TDBSlovariTemplateForm, forslovari, auth,
  addEmploy, uvolnenieEmployee, tmpstopSW,addmni, spisaniemni, createDOC, addsertifikat,
  addkripto, deletekripto, {addSB,} addSB2, RAIONS, selectDOC, addraznoe, spisaniesb
  ,Add_rashodnik, Del_rashodnik, spisanieraznoe, spisaniesert, addLicense, infokartridj
  ,addInstPO, add_dostup;
{$R *.lfm}

{ TMyThread }

procedure TMyThread.Showstatus;
begin
  if assigned(OnMyStatus) then FOnMyStatus(FStatus);
end;

procedure TMyThread.execute;
var
  rrole:string;
  tmpquery:tsqlquery;
  tmptrans:tsqltransaction;
begin
     sleep(100);
     //********************
     FconnectorRead.connector.Role:='AUTH'; //Роль для первоначального соединения
     {showmessage(FconnectorRead.connector.UserName+lineending+
     FconnectorRead.connector.Password);}
     //Пробуем соединиться
     if not FconnectorRead.connectBD then
     begin
        //сигнализируем о неудаче
        FStatus:=MySLBDErr;
        Synchronize(@Showstatus);
        exit;
     end;
     //---------------------
     //-----------------------
     {tmpquery:=tsqlquery.Create(nil);
     tmptrans:=tsqltransaction.Create(nil);
     tmptrans.DataBase:=FconnectorRead.connector;tmpquery.DataBase:=FconnectorRead.connector;
     tmpquery.Transaction:=tmptrans;
     tmpquery.SQL.Clear;
     tmpquery.SQL.Add('SELECT CURRENT_ROLE, CURRENT_USER FROM RDB$DATABASE');
     tmpquery.Open;
     showmessage(tmpquery.Fields.Fields[0].AsString+lineending+
     tmpquery.Fields.Fields[1].AsString); }
     //---------------------
     //-----------------------
     //соединение прошло начинаем проверку пользователя
     //сигнализируем
     FStatus:=MySLBDcheckUsr;
     Synchronize(@Showstatus);
     sleep(100);
     tmpquery:=tsqlquery.Create(application);
     tmptrans:=tsqltransaction.Create(application);
     tmptrans.DataBase:=FconnectorRead.connector;
     tmpquery.DataBase:=FconnectorRead.connector;
     tmpquery.Transaction:=tmptrans;
     tmpquery.SQL.Clear;
     tmpquery.SQL.Add('select ROLES.RROLE as rrole, USERS.NAME as uname, USERS.ID as id_user, RAIONS.ID as id_raion  from USERS join RAIONS on (RAIONS.ID=USERS.ID_RAION)'+lineending+
     'join ROLES on (ROLES.ID=USERS.ID_ROLE)'+lineending+
     'where USERS.NAME='''+utf8copy(FconnectorRead.connector.UserName,11,utf8length(FconnectorRead.connector.UserName)-10)+'''');
     tmpquery.Open;

     if tmpquery.IsEmpty then
     begin
        //Пользователь не найден в базе нужно обратиться к администратору
        FStatus:=MySLBDcheckUsrErr;
        Synchronize(@Showstatus);
        sleep(100);
        //уничтожим созданное
        tmpquery.Close;
        tmpquery.Free;
        tmptrans.Free;
        exit;
     end;
     //получаем район, пользователя, роль пользователя
     id_raion:=tmpquery.FieldByName('id_raion').AsInteger;
     id_user:=tmpquery.FieldByName('id_user').AsInteger;
     rrole:=tmpquery.FieldByName('rrole').AsString;
     tmpquery.Close;
     tmpquery.Free;
     tmptrans.Free;
     //Отсоединимся, для того чтобы
     //соединиться с новыми учетными данными
     FconnectorRead.connector.Connected:=false;
     //*******************
     FconnectorRead.connector.Role:=rrole;
     //*******************
     //Пытаемся соединиться теперь уже указанным пользователем с ролью
     //взятой из базы(из таблицы USERS), при неудаче уничтожаем все созданные объекты
     //и завершаем работу программы
     FStatus:=MySLBDConnUsr;
     Synchronize(@Showstatus); //сигнализируем
     if not FconnectorRead.connectBD then
     begin
        FStatus:=MySLBDcheckUsrNo;
        Synchronize(@Showstatus);
        exit;
     end;

     //if not workbd.conconnBD(FconnectorRead.connector) then Fclose:=true else Fclose:=false;
     //--------------------------
     self.FStatus:=MySLBDcheckUsrYes;
     self.Synchronize(@Showstatus);
     //showmessage(self.FconnectorRead.connector.Role);
end;

constructor TMyThread.Create(CreateSuspended: boolean; var X: TMyworkbd);
begin
    FreeOnTerminate := True;
     FconnectorRead:=X;
     inherited Create(CreateSuspended);
end;


{ TmainF }


procedure TmainF.FormCreate(Sender: TObject);
var
  sl:tstringlist;
begin
  //workbd
     Fwinstat:=WindowState;
    sl:=tstringlist.Create;
    sl.LoadFromFile(ExtractFilePath(Application.ExeName) + 'nastr' );
    sl.Delimiter:='=';
    //Отобразим заставку на случай если операция затянется
   // zastavka1:=tzastavka1.Create(application);
     //Создаем объект для соединения с базой(для чтения)
     //*****************
     FconnectorRead:=TMyworkbd.Create;
     //FconnectorRead.InitializationClass;
     FconnectorRead.connector.DatabaseName:=sl.ValueFromIndex[0];
     sl.Free;
     FconnectorRead.connector.CharSet:='UTF8';
     FconnectorRead.connector.ConnectorType:='Firebird';
     FconnectorRead.connector.Name:='connectorRead';
     FconnectorRead.connector.Role:='administrator';
     FconnectorRead.connector.Params.Add('PAGE_SIZE=16384');
     //Установим параметры для ЧИТАЮЩЕЙ транзакции
     FconnectorRead.transaction.Params.Add('isc_tpb_read');
     //FconnectorRead.transaction.Params.Add('isc_tpb_read_consistency');
     FconnectorRead.transaction.Params.Add('isc_tpb_read_committed');
     FconnectorRead.transaction.Params.Add('isc_tpb_nowait');
     //*****************
     connector:=FconnectorRead.connector;
end;

procedure TmainF.FormDestroy(Sender: TObject);
begin
     if pHeadDostup<>nil then
     begin
          while pHeadDostup<>nil do
          begin
           pCurrentDostup:=pHeadDostup;
           pHeadDostup:=pHeadDostup^.Next;
           dispose(pCurrentDostup);
          end;
     end;
end;

procedure TmainF.FormShow(Sender: TObject);
begin
     if not ffirst then
     begin
          //self.Hide;
     //self.Visible:=false;
          frmauth:=Tfrmauth.Create(self);
          frmauth.OnMyResAuth:=@resAuth;
          if (frmauth.ShowModal=mrCancel)and(not frmauth.resultF) then
          begin
                         FconnectorRead.Free;
                         frmauth.Free;
                         FMyClass.Free;
                         application.Terminate;
                         exit;
          end;
     end;
     Check_TMP_STOP;
     if Fshowbirthday then
     begin
          if utf8length(self.bdemplstr)>0 then
          MessageDlg(' ',self.bdemplstr,mtInformation,[mbok],0);
          MenuItemDPClick(nil);
          Fshowbirthday:=false;
     end;
end;

procedure TmainF.FormWindowStateChange(Sender: TObject);
begin
     if (FmyClass.PageCount>0) and (self.WindowState<>wsMinimized) then
  Timer1.Enabled:=true;
end;

procedure TmainF.MenuItem10Click(Sender: TObject);
begin
  loadPAG(27,'расходники - поступление всего',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem11Click(Sender: TObject);
begin
  loadPAG(28,'расходники_поступления',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem12Click(Sender: TObject);
begin
  loadPAG(18,'расходники_наличие',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem13Click(Sender: TObject);
begin
  openRAIONS;
end;

procedure TmainF.MenuItem14Click(Sender: TObject);
var
  tbsht:Ttabsheet;
  i:integer;
begin
  loadPAG(2,'Временное прекращение',Fconnector,id_raion,id_user);
  tbsht:=FmyClass.ActivePage;
  for i:=0 to tbsht.ControlCount-1 do;
  begin
    if (tbsht.Controls[i] is TDBGRID) then
    begin
       //showmessage(inttostr(TDBGRID(tbsht.Controls[i]).Columns.Count));
       TDBGRID(tbsht.Controls[i]).OnDrawColumnCell:=@DBGridDrawColumnCell;
       TDBGRID(tbsht.Controls[i]).Refresh;
       i:=tbsht.ControlCount;
    end;
  end;
end;

procedure TmainF.MenuItem15Click(Sender: TObject);
begin
  self.openLOCATION;
end;


procedure TmainF.MenuItem18Click(Sender: TObject);
begin
  loadPAG(4,'списанные МНИ',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem19Click(Sender: TObject);
begin
  openKripto;
end;

procedure TmainF.MenuItem20Click(Sender: TObject);
begin
  self.openTERRITOR;
end;

procedure TmainF.MenuItem21Click(Sender: TObject);
{var
  tbsht:Ttabsheet;
  i:integer;}
begin
  {loadPAG(5,'Сертификаты',Fconnector,id_raion,id_user);
  tbsht:=FmyClass.ActivePage;
  for i:=0 to tbsht.ControlCount-1 do;
  begin
    if (tbsht.Controls[i] is TDBGRID) then
    begin
       //showmessage(inttostr(TDBGRID(tbsht.Controls[i]).Columns.Count));
       TDBGRID(tbsht.Controls[i]).OnDrawColumnCell:=@DBGridDrawColumnCell;
       TDBGRID(tbsht.Controls[i]).Refresh;
       i:=tbsht.ControlCount;
    end;
  end;  }
end;

procedure TmainF.MenuItem22Click(Sender: TObject);
begin

end;

procedure TmainF.MenuItem23Click(Sender: TObject);
begin
  loadPAG(23,'не действующие сертификаты',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem24Click(Sender: TObject);
begin
  loadPAG(6,'Движение МНИ',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem27Click(Sender: TObject);
begin
   menuitem27.Checked:=not menuitem27.Checked;
   if  Fmyclass.PageCount>0 then
   begin
    Fmyclass.SoftFind:=not menuitem27.Checked;
   end;
end;

procedure TmainF.MenuItem28Click(Sender: TObject);
begin
  //loadPAG(8,'Системники',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem30Click(Sender: TObject);
begin
  loadPAG(9,'уничтоженные криптосредства',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem31Click(Sender: TObject);
begin
  MessageDlg('Внимание','Будут показаны все пользователи'+lineending+
  'за которыми числятся не уничтоженные криптосредства'+lineending+
  'в том числе уволенные/декретники', mtInformation, [mbOK],0);
  loadPAG(10,'Пользователи и криптосредств',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem32Click(Sender: TObject);
begin
   MessageDlg('Внимание','Будут показаны все пользователи'+lineending+
  'за которыми числятся не уничтоженные криптосредства'+lineending+
  'в том числе уволенные/декретники', mtInformation, [mbOK],0);
  loadPAG(11,'Пользователи криптосредств',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem33Click(Sender: TObject);
begin
  MessageDlg('Внимание','Будут показаны все пользователи'+lineending+
  'за которыми числятся не уничтоженные МНИ'+lineending+
  'в том числе уволенные/декретники', mtInformation, [mbOK],0);
  loadPAG(12,'Пользователи и МНИ',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem34Click(Sender: TObject);
begin
  MessageDlg('Внимание','Будут показаны все пользователи'+lineending+
  'за которыми числятся не уничтоженные МНИ'+lineending+
  'в том числе уволенные/декретники', mtInformation, [mbOK],0);
  loadPAG(13,'Пользователи МНИ',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem35Click(Sender: TObject);
begin
  loadPAG(14,'все криптосредства',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem36Click(Sender: TObject);
var
  lastNA:integer;
  NA:string;
  code, i:integer;
begin
  lastNA:=workbd.GET_NUMBER_AKT_CURR('kripto',FconnectorRead.connector);
  repeat
    NA:=InputBox('номер акта','Введите номер следующего акта(число)',inttostr(lastNA));
    val(NA,i,code);
    if (UTF8length(NA)>0) then
    begin
         if(code<>0)or(i<=0)then
         begin
              messagedlg('ошибка','нужно ввести целое число больше 0',mtWarning,[mbOK],0);
              code:=1;
         end;
    end else exit;
  until code=0;
  if lastNA<>i then workbd.SET_NUMBER_AKT('kripto', FconnectorRead.connector,strtoint(NA)-1);
end;

procedure TmainF.MenuItem37Click(Sender: TObject);
begin
  loadPAG(15,'Движение сотрудников',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem39Click(Sender: TObject);
begin
  loadPAG(16,'Движение СИСТЕМНЫЙ БЛОК',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem3Click(Sender: TObject);
begin
  loadPAG(3,'МНИ',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem40Click(Sender: TObject);
begin
  loadPAG(17,'разное',self.FconnectorRead.connector,id_raion,id_user);
end;

procedure TmainF.MenuItem41Click(Sender: TObject);
begin

end;

procedure TmainF.MenuItem43Click(Sender: TObject);
var
  tbsht:Ttabsheet;
  i:integer;
begin
  loadPAG(5,'Сертификаты',Fconnector,id_raion,id_user);
  tbsht:=FmyClass.ActivePage;
  for i:=0 to tbsht.ControlCount-1 do;
  begin
    if (tbsht.Controls[i] is TDBGRID) then
    begin
       //showmessage(inttostr(TDBGRID(tbsht.Controls[i]).Columns.Count));
       TDBGRID(tbsht.Controls[i]).OnDrawColumnCell:=@DBGridDrawColumnCell;
       TDBGRID(tbsht.Controls[i]).Refresh;
       i:=tbsht.ControlCount;
    end;
  end;
end;

procedure TmainF.MenuItem44Click(Sender: TObject);
begin
  //loadPAG(26,'расходники - поступление',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem45Click(Sender: TObject);
var
  start,endd:tdate;
begin
   case QuestionDlg('Расходники','Вывести',mtConfirmation,[mrYes,'Всё','isdefault',mrNo,'За период'],'') of
         mryes:
           begin
             loadPAG(19,'кто расходовал',Fconnector,id_raion,id_user);
           end;
         mrno:
           begin
             self.CalendarDialog1.Date:=now;
             self.CalendarDialog1.OKCaption:='начало';
             self.CalendarDialog1.Title:='период';
             if (not self.CalendarDialog1.Execute) then
             begin
                  start:=now;
             end else
                 start:=self.CalendarDialog1.Date;
             self.CalendarDialog1.Date:=now+1;
             self.CalendarDialog1.OKCaption:='окончание';
             self.CalendarDialog1.Title:='период';
             if (not self.CalendarDialog1.Execute)or(self.CalendarDialog1.Date<start) then
             begin
                  endd:=start;
             end else
                 endd:=self.CalendarDialog1.Date;
             loadPAG(19,'кто расходовал',Fconnector,id_raion,id_user,true,
             yearof(start),monthof(start),dayof(start),yearof(endd),monthof(endd),dayof(endd));
           end;
  end;

  loadPAG(19,'кто расходовал',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem46Click(Sender: TObject);
var
  start,endd:tdate;
begin
  case QuestionDlg('Расходники','Вывести',mtConfirmation,[mrYes,'Всё','isdefault',mrNo,'За период'],'') of
         mryes:
           begin
             //showmessage('Всё');
             loadPAG(20,'кто расходовал(свод)',Fconnector,id_raion,id_user);
           end;
         mrno:
           begin
             self.CalendarDialog1.Date:=now;
             self.CalendarDialog1.OKCaption:='начало';
             self.CalendarDialog1.Title:='период';
             if (not self.CalendarDialog1.Execute)
             {or(monthof(self.CalendarDialog1.Date)<>monthof(DT_sel))} then
             begin
                  start:=now;
             end else
                 start:=self.CalendarDialog1.Date;
             self.CalendarDialog1.Date:=now+1;
             self.CalendarDialog1.OKCaption:='окончание';
             self.CalendarDialog1.Title:='период';
             if (not self.CalendarDialog1.Execute)or(self.CalendarDialog1.Date<start) then
             begin
                  endd:=start;
             end else
                 endd:=self.CalendarDialog1.Date;
             loadPAG(20,'кто расходовал(свод)',Fconnector,id_raion,id_user,true,
             yearof(start),monthof(start),dayof(start),yearof(endd),monthof(endd),dayof(endd));
           end;
  end;
end;

procedure TmainF.MenuItem48Click(Sender: TObject);
begin
  loadPAG(21,'Движение РАЗНОЕ',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem49Click(Sender: TObject);
begin
  loadPAG(22,'списанные РАЗНОЕ',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem4Click(Sender: TObject);
var
  tbsht:Ttabsheet;
  i:integer;
begin
  loadPAG(7,'криптосредства',Fconnector,id_raion,id_user);
  tbsht:=FmyClass.ActivePage;
  for i:=0 to tbsht.ControlCount-1 do;
  begin
    if (tbsht.Controls[i] is TDBGRID) then
    begin
       //showmessage(inttostr(TDBGRID(tbsht.Controls[i]).Columns.Count));
       TDBGRID(tbsht.Controls[i]).OnDrawColumnCell:=@DBGridDrawColumnCell;
       TDBGRID(tbsht.Controls[i]).Refresh;
       i:=tbsht.ControlCount;
    end;
  end;

end;

procedure TmainF.MenuItem51Click(Sender: TObject);
begin
  loadPAG(24,'все акты и записи в ж-ле поэкз уч',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem52Click(Sender: TObject);
begin
  loadPAG(29,'установленные сертификаты',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem53Click(Sender: TObject);
begin
  loadPAG(30,'опечатывание',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem54Click(Sender: TObject);
begin
      loadPAG(31,'движение криптосредств',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem55Click(Sender: TObject);
var
  tbsht:Ttabsheet;
  i:integer;
begin
  loadPAG(8,'Системники',Fconnector,id_raion,id_user);
  tbsht:=FmyClass.ActivePage;
     for i:=0 to tbsht.ControlCount-1 do;
     begin
       if (tbsht.Controls[i] is TDBGRID) then
       begin
        //showmessage(inttostr(TDBGRID(tbsht.Controls[i]).Columns.Count));
            TDBGRID(tbsht.Controls[i]).OnDrawColumnCell:=@DBGridDrawColumnCell;
            TDBGRID(tbsht.Controls[i]).Refresh;
            i:=tbsht.ControlCount;
       end;
     end;
end;

procedure TmainF.MenuItem56Click(Sender: TObject);
begin
  editInstPO:=TeditInstPO.Create(mainF);
            if editInstPO.SetConnect(self.FconnectorRead)and(editInstPO.ShowModal=mrok) then
            begin
             //Fmyclass.UPDatingPAG;
            end;
            editInstPO.Free;
end;

procedure TmainF.MenuItem57Click(Sender: TObject);
begin
  loadPAG(32,'установка/удаление ПО',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem58Click(Sender: TObject);
begin
    loadPAG(33,'списанные системные блоки',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem59Click(Sender: TObject);
var
  lastNA:integer;
  NA:string;
  code, i:integer;
begin
  lastNA:=workbd.GET_NUMBER_AKT_CURR('remont',FconnectorRead.connector);
  repeat
    NA:=InputBox('номер заявки','Введите номер следующей зявки(число)',inttostr(lastNA));
    val(NA,i,code);
    if (UTF8length(NA)>0) then
    begin
         if(code<>0)or(i<=0)then
         begin
              messagedlg('ошибка','нужно ввести целое число больше 0',mtWarning,[mbOK],0);
              code:=1;
         end;
    end else exit;
  until code=0;
  if lastNA<>i then workbd.SET_NUMBER_AKT('remont', FconnectorRead.connector,strtoint(NA)-1);
end;

procedure TmainF.MenuItem5Click(Sender: TObject);
begin
  loadPAG(1,'уволенные',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem61Click(Sender: TObject);
begin
  messagedlg('соединение',self.FconnectorRead.connector.DatabaseName,mtInformation,[mbYes],0);
end;

procedure TmainF.MenuItem62Click(Sender: TObject);
begin

end;

procedure TmainF.MenuItem63Click(Sender: TObject);
begin
  loadPAG(34,'МНИ в сист блоках',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem64Click(Sender: TObject);
begin
  loadPAG(35,'Свод МНИ в сист блоках',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem65Click(Sender: TObject);
begin
  loadPAG(36,'Свод по сист блокам',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem66Click(Sender: TObject);
var
  tbsht:Ttabsheet;
  i:integer;
begin
     loadPAG(0,'сотрудники',FconnectorRead.connector{Fconnector},id_raion,id_user);
     tbsht:=FmyClass.ActivePage;
     for i:=0 to tbsht.ControlCount-1 do;
     begin
       if (tbsht.Controls[i] is TDBGRID) then
       begin
        //showmessage(inttostr(TDBGRID(tbsht.Controls[i]).Columns.Count));
            TDBGRID(tbsht.Controls[i]).OnDrawColumnCell:=@DBGridDrawColumnCell;
            TDBGRID(tbsht.Controls[i]).Refresh;
            i:=tbsht.ControlCount;
       end;
     end;
    { fmyclass.Query.Filter:='''TABNOM''=10';
     fmyclass.Query.Filtered:=true;}
end;

procedure TmainF.MenuItem67Click(Sender: TObject);
begin
  loadPAG(37,'Доступы',Fconnector,id_raion,id_user);
end;

procedure TmainF.MenuItem6Click(Sender: TObject);
begin
  loadPAG(25,'Лицензии',Fconnector,id_raion,id_user);
end;


procedure TmainF.MenuItemDPClick(Sender: TObject);
var
  tbsht:Ttabsheet;
  i:integer;
begin
     loadPAG(0,'сотрудники',FconnectorRead.connector{Fconnector},id_raion,id_user);
     tbsht:=FmyClass.ActivePage;
     for i:=0 to tbsht.ControlCount-1 do;
     begin
       if (tbsht.Controls[i] is TDBGRID) then
       begin
        //showmessage(inttostr(TDBGRID(tbsht.Controls[i]).Columns.Count));
            TDBGRID(tbsht.Controls[i]).OnDrawColumnCell:=@DBGridDrawColumnCell;
            TDBGRID(tbsht.Controls[i]).Refresh;
            i:=tbsht.ControlCount;
       end;
     end;
    { fmyclass.Query.Filter:='''TABNOM''=10';
     fmyclass.Query.Filtered:=true;}
end;

procedure TmainF.MenuItemSDClick(Sender: TObject);
{var querylocation:tsqlquery;
  translocation:tsqltransaction;}
begin
     openPOST;
     {//connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from POSTS') then exit;;
     querylocation.FieldByName('ID_user').Visible:=false;
     querylocation.FieldByName('ID_raion').Visible:=false;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='должность';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       TDBSlovariTemplateForm.ShowGridSlovari('должности', translocation, querylocation, @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;       }
end;

procedure TmainF.MenuItemSGClick(Sender: TObject);
{var querylocation:tsqlquery;
  translocation:tsqltransaction;  }
begin
     self.openGROUP;
     {//connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     QUERYSLOVAR( querylocation,translocation, 'select * from GROUPS');
     querylocation.FieldByName('ID_user').Visible:=false;
     querylocation.FieldByName('ID_raion').Visible:=false;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='группа';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       TDBSlovariTemplateForm.ShowGridSlovari('группы', translocation, querylocation, @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free; }
end;

procedure TmainF.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
     //переименовываем временную копию в постонную
     FreeAndNil(fmyclass);
     FreeAndNil(frmfindrecord);
     bdchld.Free;
     FconnectorRead.connector.Close(true);
     CloseAction:=caFree;
     //connector2.Free;
     //FQueryFind.Free;
     //FTransactionFind.Free;
     //FconnFind.Free;
     mainF:=nil;
end;

procedure TmainF.AaddingExecute(Sender: TObject);
begin
      //if (FconnectorRead.connector.Role<>'ADMINISTRATOR')and(FconnectorRead.connector.Role<>'KADRI') then exit;
  if checkdostup('START_WORK')=0 then exit;
     case Fmyclass.IDActivPage of
     0:Begin
            editEmploy:=TeditEmploy.Create(mainF);
            if editEmploy.SetConnect(FconnectorRead)and(editEmploy.ShowModal=mrok) then
            begin
             Fmyclass.UPDatingPAG;
            end;
            editEmploy.Free;
       end;
     3:Begin
            editMNI:=Teditmni.Create(mainF);
            if editMNI.SetConnect(FconnectorRead)and(editMNI.ShowModal=mrok) then
            begin
             Fmyclass.UPDatingPAG;
            end;
            editMNI.Free;
       end;
     5:Begin
            editSert:=TeditSert.Create(mainF);
            if editSert.SetConnect(self.FconnectorRead)and(editSert.ShowModal=mrok) then
            begin
             Fmyclass.UPDatingPAG;
            end;
            editSert.Free;
       end;
     7:Begin
            editKRIPTO:=TeditKRIPTO.Create(mainF);
            if editKRIPTO.SetConnect(FconnectorRead)and(editKRIPTO.ShowModal=mrok) then
            begin
             Fmyclass.UPDatingPAG;
            end;
            editKRIPTO.Free;
       end;
     8:Begin
            editSB2:=TeditSB2.Create(mainF);
            if editSB2.SetConnect(self.FconnectorRead)and(editSB2.ShowModal=mrok) then
            begin
             Fmyclass.UPDatingPAG;
            end;
            editSB2.Free;
       end;
     17:Begin
            editRAZNOE:=TeditRAZNOE.Create(mainF);
            if editRAZNOE.SetConnect(FconnectorRead)and(editRAZNOE.ShowModal=mrok) then
            begin
             //Fmyclass.UPDatingPAG;
             FMyClass.RefreshPAG;
            end;
            editRAZNOE.Free;
       end;
     18:
       begin
              frmRashodnik:=TfrmRashodnik.Create(mainF);
              if frmRashodnik.SetConnect(self.FconnectorRead)and(frmRashodnik.ShowModal=mrok) then
              begin
               //Fmyclass.UPDatingPAG;
               FMyClass.RefreshPAG;
              end;
              frmRashodnik.Free;
       end;
     25:
       begin
              editLicense:=TeditLicense.Create(mainF);
              if editLicense.SetConnect(self.FconnectorRead)and(editLicense.ShowModal=mrok) then
              begin
               //Fmyclass.UPDatingPAG;
               FMyClass.RefreshPAG;
              end;
              editLicense.Free;
       end;
     37:
       begin
              if Fmyclass.Query.IsEmpty or Fmyclass.Query.FieldByName('id').IsNull then exit;
              frmDostup:=TfrmDostup.Create(mainF);
              frmDostup.FIO:=Fmyclass.Query.FieldByName('fio').AsString;
              if frmDostup.SetConnect(FconnectorRead,dsInsert,Fmyclass.Query.FieldByName('id').AsInteger)and(frmDostup.ShowModal=mrok) then
              begin
               //Fmyclass.UPDatingPAG;
               FMyClass.RefreshPAG;
              end;
              FreeAndNil(frmDostup);
       end;
     end;
end;

procedure TmainF.AaktExecute(Sender: TObject);
{var myDOCS:TmyDOCS;
  Qr:TSQLQuery;
  Tr:TSQLTransaction;
  stmp:string; }
begin
     case Fmyclass.IDActivPage of
      0:Begin
             try
             viborDoc:=TviborDoc.Create(self.Owner);
             viborDoc.conn:=self.connector;
             viborDoc.N_journal:=0;
             viborDoc.ID:=Fmyclass.Query.FieldByName('ID').AsInteger; ;
             viborDoc.ComboBox1.Items.Clear;
             viborDoc.ComboBox1.Items.Add('Заявка на регистрацию пользователя VipNet');
             viborDoc.ComboBox1.Items.Add('Заявка на добавление связи(VipNet)');
             viborDoc.ComboBox1.Items.Add('Карточка учета техники');
             viborDoc.ComboBox1.Items.Add('Заявка на установку криптосредства/обучение');
             viborDoc.ComboBox1.Items.Add('Заявка на изготовление сертификата');
             viborDoc.ComboBox1.Items.Add('Опись МНИ');
             viborDoc.ComboBox1.Items.Add('Лицевой счет пользователя МНИ');
             viborDoc.ComboBox1.Items.Add('Карточка выдачи МНИ');
             viborDoc.ComboBox1.Items.Add('Заполнить произвольный шаблон');
             viborDoc.ComboBox1.ItemIndex:=0;
             viborDoc.Caption:='Заявки и акты';
             viborDoc.ShowModal;
             viborDoc.Free;
            except
               on E: Exception do
               begin
                       if (pos('файл не найден',lowercase( e.message))>0) then
                      begin
                       MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                      end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
               end;
            end;


             ///////////////////
                 {
            try
             // AKTT;
              //Создадим документ
              tr:=tSQLTransaction.Create(self);
              qr:=TSQLQuery.Create(self);
              Tr.DataBase:=self.connector;
              Qr.Transaction:=tr;
              qr.DataBase:=self.connector;
              qr.SQL.Clear;
              stmp:='select POSTS.NAME as dolj, GROUPS.NAME as gr, START_WORK.TABNOM, t1.FAM as FAM2, t1.NAM as NAM2, t1.OTCH as OTCH2, t1.SNILS,'+lineending+
              'RAIONS.ADDRESS, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, '+lineending+
              'RAIONS.FULL_KR_NAME as krname, RAIONS.INN as INN, RAIONS.OGRN as OGRN,'+lineending+
              'LOCATIONS.NAME as lNAME'+lineending+
              ' from START_WORK  join PEOPLES as t1 on (START_WORK.ID_PEOPLE=t1.ID) '+lineending+
              'join RAIONS on (RAIONS.ID=START_WORK.ID_RAION) '+lineending+
              'join POSTS on (START_WORK.ID_POST=POSTS.ID)'+lineending+
              'join LOCATIONS on (LOCATIONS.ID=START_WORK.ID_LOCATION)'+lineending+
              'left join GROUPS on (START_WORK.ID_GROUP=GROUPS.ID)'+lineending+
              'left join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
              'left join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
              'where (START_WORK.ID='+Fmyclass.Query.FieldByName('ID').AsString+')/*and*/'+lineending+
              '';
              qr.SQL.Add(stmp);
              qr.Open;
              myDOCS:=TmyDOCS.Create(ttaZaiv_SERT,ExtractFilePath(Application.ExeName),Qr);//Fmyclass.Query);
              //Тут всякие действия
              myDOCS.Free;
              tr.Free;
              qr.Free;
            except
               on E: Exception do
               begin
                       if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                      begin
                       MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                      end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
               end;
            end;   }
            //AKTT;
       end;
         3:Begin
               try
             viborDoc:=TviborDoc.Create(self.Owner);
             viborDoc.conn:=self.connector;
             viborDoc.N_journal:=3;
             viborDoc.ID:=Fmyclass.Query.FieldByName('ID').AsInteger; ;
             viborDoc.ComboBox1.Items.Clear;
             viborDoc.ComboBox1.Items.Add('AKT проверки наличия машинных носителей информации');
             viborDoc.ComboBox1.Items.Add('Карточка выдачи МНИ');
             viborDoc.ComboBox1.Items.Add('Карточки выдачи на все МНИ ');
             viborDoc.ComboBox1.ItemIndex:=0;
             viborDoc.Caption:='МНИ';
             viborDoc.ShowModal;
             viborDoc.Free;
            except
               on E: Exception do
               begin
                       if (pos('файл не найден',lowercase( e.message))>0) then
                      begin
                       MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                      end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
               end;
            end;
             {
            try
             // AKT проверки наличия машинных носителей информации
              //Создадим документ
              tr:=tSQLTransaction.Create(self);
              qr:=TSQLQuery.Create(self);
              Tr.DataBase:=self.connector;
              Qr.Transaction:=tr;
              qr.DataBase:=self.connector;
              qr.SQL.Clear;
              stmp:='select DISTINCT MNI_TIP.NAME as tNAME, MNI.UCHETN as UCHETN,'+lineending+
              'RAIONS.FULL_KR_NAME as krname, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1 '+lineending+
              ''+lineending+
              ''+lineending+
              ' from MNI join MNI_TIP on (MNI_TIP.ID=MNI.ID_TIP)'+lineending+
              'join RAIONS on (RAIONS.ID=MNI.ID_RAION)'+lineending+
              'left join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
              'left join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
              ''+lineending+
              ''+lineending+
              ''+lineending+
              'where ((MNI.ID_RAION='+inttostr(id_raion)+')and'+lineending+
              '(not exists(select * from DELETE_MNI where DELETE_MNI.ID_MNI=MNI.ID)))'+lineending+
              'order by tName, UCHETN';
              qr.SQL.Add(stmp);
              qr.Open;
              myDOCS:=TmyDOCS.Create(ttaAkt_MNI,ExtractFilePath(Application.ExeName),Qr);
              //Тут всякие действия
              myDOCS.Free;
              tr.Free;
              qr.Free;
            except
               on E: Exception do
               begin
                       if (pos('файл не найден',lowercase( e.message))>0) then
                      begin
                       MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                      end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
               end;
            end;}
            //AKTT;
       end;
     4:Begin
            try
             viborDoc:=TviborDoc.Create(self.Owner);
             viborDoc.conn:=self.connector;
             viborDoc.N_journal:=4;
             viborDoc.ID:=-1;
             viborDoc.ComboBox1.Items.Clear;
             viborDoc.ComboBox1.Items.Add('Акт уничтоженных МНИ');
             viborDoc.ComboBox1.ItemIndex:=0;
             viborDoc.Caption:='Уничтоженные МНИ';
             viborDoc.ShowModal;
             viborDoc.Free;
            except
               on E: Exception do
               begin
                       if (pos('файл не найден',lowercase( e.message))>0) then
                      begin
                       MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                      end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
               end;
            end;
            //AKTT;
       end;
     5:Begin
             try
             // AKTT;
              //Создадим документ
              viborDoc:=TviborDoc.Create(self.Owner);
             viborDoc.conn:=self.connector;
             viborDoc.N_journal:=5;
             viborDoc.ID:=Fmyclass.Query.FieldByName('ID').AsInteger;
             viborDoc.ComboBox1.Items.Clear;
             viborDoc.ComboBox1.Items.Add('Акт установки криптосредства');
             viborDoc.ComboBox1.Items.Add('Заявка на приостановку');
             viborDoc.ComboBox1.Items.Add('Заявка на отзыв');
             viborDoc.ComboBox1.Items.Add('Заявка на возобновление');
             viborDoc.ComboBox1.ItemIndex:=0;
             viborDoc.Caption:='Криптосредства';
             viborDoc.ShowModal;
             viborDoc.Free;
            except
               on E: Exception do
               begin
                       if (pos('файл не найден',lowercase( e.message))>0) then
                      begin
                       MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                      end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
               end;
            end;
       end;
     7:Begin
            try
             // AKTT;
              //Создадим документ
              viborDoc:=TviborDoc.Create(self.Owner);
             viborDoc.conn:=connector;
             viborDoc.N_journal:=7;
             viborDoc.ID:=Fmyclass.Query.FieldByName('ID').AsInteger;
             viborDoc.ComboBox1.Items.Clear;
             viborDoc.ComboBox1.Items.Add('Акт установки криптосредства');
             viborDoc.ComboBox1.Items.Add('сведения о наличии криптосредств');
             viborDoc.ComboBox1.Items.Add('Акт уничтожения одного криптосредства');
             viborDoc.ComboBox1.ItemIndex:=0;
             viborDoc.Caption:='Криптосредства';
             viborDoc.ShowModal;
             viborDoc.Free;
            except
               on E: Exception do
               begin
                       if (pos('файл не найден',lowercase( e.message))>0) then
                      begin
                       MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                      end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
               end;
            end;
            //AKTT;
       end;
     9:Begin
            try
             // AKTT;
              //Создадим документ
              viborDoc:=TviborDoc.Create(self.Owner);
             viborDoc.conn:=self.connector;
             viborDoc.N_journal:=9;
             viborDoc.ID:=Fmyclass.Query.FieldByName('ID').AsInteger;
             viborDoc.nom:=Fmyclass.Query.FieldByName('nom').AsInteger;
             viborDoc.ComboBox1.Items.Clear;
             viborDoc.ComboBox1.Items.Add('Акт уничтожения криптосредств');
             viborDoc.ComboBox1.Items.Add('Акт уничтожения одного криптосредства');
             viborDoc.ComboBox1.Items.Add('Акт установки криптосредства');
             viborDoc.ComboBox1.Items.Add('Отчет по уничтоженным криптосредствам');
             viborDoc.ComboBox1.ItemIndex:=1;
             viborDoc.Caption:='Криптосредства';
             viborDoc.ShowModal;
             viborDoc.Free;
            except
               on E: Exception do
               begin
                       if (pos('файл не найден',lowercase( e.message))>0) then
                      begin
                       MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                      end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
               end;
            end;
            //AKTT;
       end;
     17:Begin
            try
             viborDoc:=TviborDoc.Create(self.Owner);
             viborDoc.conn:=self.connector;
             viborDoc.N_journal:=17;
             viborDoc.ID:=Fmyclass.Query.FieldByName('ID').AsInteger; ;
             viborDoc.ComboBox1.Items.Clear;
             viborDoc.ComboBox1.Items.Add('Заявка на ремонт');
             viborDoc.ComboBox1.ItemIndex:=0;
             viborDoc.Caption:='Техника';
             viborDoc.ShowModal;
             viborDoc.Free;
            except
               on E: Exception do
               begin
                       if (pos('файл не найден',lowercase( e.message))>0) then
                      begin
                       MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                      end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
               end;
            end;
            //AKTT;
       end;
     24:Begin
            if (FmyClass.Query.FieldByName('pr').AsInteger<>0)and
            (FmyClass.Query.FieldByName('pr').AsInteger<>2)then exit;
            try
             // AKTT;
              //Создадим документ
              viborDoc:=TviborDoc.Create(self.Owner);
             viborDoc.conn:=self.connector;
             case self.FmyClass.Query.FieldByName('pr').AsInteger of
             0:viborDoc.N_journal:=7;
             2:viborDoc.N_journal:=5;
             end;
             //viborDoc.N_journal:=24;
             viborDoc.ID:=Fmyclass.Query.FieldByName('ID').AsInteger;
             viborDoc.ComboBox1.Items.Clear;
             viborDoc.ComboBox1.Items.Add('Акт установки криптосредства');
             viborDoc.ComboBox1.ItemIndex:=0;
             viborDoc.Caption:='Криптосредства';
             viborDoc.ShowModal;
             viborDoc.Free;
            except
               on E: Exception do
               begin
                       if (pos('файл не найден',lowercase( e.message))>0) then
                      begin
                       MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                      end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
               end;
            end;
            //AKTT;
       end;
     end;
end;

procedure TmainF.ADeletingExecute(Sender: TObject);
var
  FconnectorWrite:TMyworkbd;
  SCRIPT:TSQLSCRIPT;
begin
   //if (FconnectorRead.connector.Role<>'ADMINISTRATOR')and(FconnectorRead.connector.Role<>'KADRI') then exit;
   if checkdostup('START_WORK')=0 then exit;
   if Fmyclass.Query.IsEmpty then exit;
     case Fmyclass.IDActivPage of
  0:begin
         uvolnEmpl:=TuvolnEmpl.Create(mainF);
         if uvolnEmpl.SetConnect(self.FconnectorRead, dsInsert, Fmyclass.Query.FieldByName('id').AsInteger)and(uvolnEmpl.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         uvolnEmpl.Free;
  end;
  3:begin
         spisMni:=TspisMni.Create(mainF);
         if spisMni.SetConnect(self.FconnectorRead, dsInsert, Fmyclass.Query.FieldByName('id').AsInteger)and(spisMni.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         spisMni.Free;
  end;
  5:
    begin
           case QuestionDlg('отзыв/удаление ','сертификат: '+lineending+Fmyclass.Query.FieldByName('name').AsString+lineending+
         'будет удален', mtConfirmation,[mrYes,'Отозвать',mrNo,'Удалить из базы',mrCancel,'Отмена','isdefault'],'') of
         mryes:
           begin
             spisSert:=TspisSert.Create(mainF);
                if spisSert.SetConnect(self.FconnectorRead, dsInsert, Fmyclass.Query.FieldByName('id').AsInteger)
                and(spisSert.ShowModal=mrok) then
                begin
                 Fmyclass.UPDatingPAG;
                end;
                spisSert.Free;
           end;
         mrno:
           begin
                case QuestionDlg('удаление','Вы действительно хотите удалить?'+lineending
                +'Восстановление невозможно!',mtConfirmation,[mrYes,'Удалить',mrNo,'Не удалять','isdefault'],'') of
                 mryes:
                   begin
                        FconnectorWrite:=TMyworkbd.Create;
                        FconnectorRead.copyParams(self,FconnectorWrite.connector);
                        FconnectorWrite.transaction.Params.Clear;
                        FconnectorWrite.transaction.Params.Add('isc_tpb_nowait');
                        SCRIPT:=TSQLSCRIPT.Create(self);
                        script.DataBase:=FconnectorWrite.connector;
                        script.Transaction:=FconnectorWrite.transaction;
                        script.CommentsInSQL:=false;
                        script.UseSetTerm:=true;
                        script.Script.Clear;
                        script.Script.Add('DELETE FROM SERTIFIKATS WHERE ID='+self.FmyClass.Query.FieldByName('ID').AsString+';');
                        script.Script.Add('COMMIT;');
                        script.Execute;
                        SCRIPT.Free;
                        FconnectorWrite.transaction.Commit;
                        FconnectorWrite.Free;
                        self.FmyClass.RefreshPAG;
                   end;
                 end;
           end;
         mrcancel:
           begin
                showmessage('cancel');
           end;
         end;
    end;
  7:begin
         delKripto:=TdelKripto.Create(mainF);
         if delKripto.SetConnect(self.FconnectorRead, dsInsert, Fmyclass.Query.FieldByName('id').AsInteger)and(delKripto.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         delKripto.Free;
  end;
  8:
    begin
         spisSB:=TspisSB.Create(mainF);
         if spisSB.SetConnect(self.FconnectorRead, dsInsert, Fmyclass.Query.FieldByName('id').AsInteger)and(spisSB.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         spisSB.Free;
    end;
  17:
    begin
         //application.MessageBox('111','000',MB_YESNO+MB_ICONQUESTION);
         case QuestionDlg('списание/удаление',Fmyclass.Query.FieldByName('tip').AsString+' '+
         Fmyclass.Query.FieldByName('model_').AsString+lineending
         +'серийный: '+Fmyclass.Query.FieldByName('serial').AsString,mtConfirmation,[mrYes,'Списать',mrNo,'Удалить из базы',mrCancel,'Отмена','isdefault'],'') of
         mryes:
           begin
             spisRaznoe:=TspisRaznoe.Create(mainF);
                if spisRaznoe.SetConnect(self.FconnectorRead, dsInsert, Fmyclass.Query.FieldByName('id').AsInteger)and(spisRaznoe.ShowModal=mrok) then
                begin
                 Fmyclass.UPDatingPAG;
                end;
                spisRaznoe.Free;
           end;
         mrno:
           begin
                case QuestionDlg('удаление','Вы действительно хотите удалить?'+lineending
                +'Восстановление невозможно!',mtConfirmation,[mrYes,'Удалить',mrNo,'Не удалять','isdefault'],'') of
                 mryes:
                   begin
                        FconnectorWrite:=TMyworkbd.Create;
                        FconnectorRead.copyParams(self,FconnectorWrite.connector);
                        FconnectorWrite.transaction.Params.Clear;
                        FconnectorWrite.transaction.Params.Add('isc_tpb_nowait');
                        SCRIPT:=TSQLSCRIPT.Create(self);
                        script.DataBase:=FconnectorWrite.connector;
                        script.Transaction:=FconnectorWrite.transaction;
                        script.CommentsInSQL:=false;
                        script.UseSetTerm:=true;
                        script.Script.Clear;
                        script.Script.Add('DELETE FROM DELETE_RAZNOE WHERE ID_RAZNOE='+self.FmyClass.Query.FieldByName('ID').AsString+';');
                        script.Script.Add('COMMIT;');
                        script.Script.Add('DELETE FROM MOVE_RAZNOE WHERE ID_RAZNOE='+self.FmyClass.Query.FieldByName('ID').AsString+';');
                        script.Script.Add('COMMIT;');
                        script.Script.Add('DELETE FROM RAZNOE WHERE ID='+self.FmyClass.Query.FieldByName('ID').AsString+';');
                        script.Script.Add('COMMIT;');
                        script.Execute;
                        SCRIPT.Free;
                        FconnectorWrite.transaction.Commit;
                        FconnectorWrite.Free;
                        self.FmyClass.RefreshPAG;
                   end;
                 end;
           end;
         mrcancel:
           begin
                showmessage('cancel');
           end;
         end;
         {spisSB:=TspisSB.Create(mainF);
         if spisSB.SetConnect(self.FconnectorRead, dsInsert, Fmyclass.Query.FieldByName('id').AsInteger)and(spisSB.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         spisSB.Free;}
    end;
  18:
    begin
         frmRashodnikdel:=TfrmRashodnikdel.Create(mainF);
              if frmRashodnikdel.SetConnect(self.FconnectorRead)and(frmRashodnikdel.ShowModal=mrok) then
              begin
               //Fmyclass.UPDatingPAG;
               FMyClass.RefreshPAG;
              end;
              frmRashodnikdel.Free;
     end;
  25:
    begin
         case QuestionDlg('удаление','Вы действительно хотите удалить?'+lineending
                +'Восстановление невозможно!',mtConfirmation,[mrYes,'Удалить',mrNo,'Не удалять','isdefault'],'') of
                 mryes:
                   begin
                        FconnectorWrite:=TMyworkbd.Create;
                        FconnectorRead.copyParams(self,FconnectorWrite.connector);
                        FconnectorWrite.transaction.Params.Clear;
                        FconnectorWrite.transaction.Params.Add('isc_tpb_nowait');
                        SCRIPT:=TSQLSCRIPT.Create(self);
                        script.DataBase:=FconnectorWrite.connector;
                        script.Transaction:=FconnectorWrite.transaction;
                        script.CommentsInSQL:=false;
                        script.UseSetTerm:=true;
                        script.Script.Clear;
                        script.Script.Add('DELETE FROM LICENSE WHERE ID='+self.FmyClass.Query.FieldByName('ID').AsString+';');
                        script.Script.Add('COMMIT;');
                        script.Execute;
                        SCRIPT.Free;
                        FconnectorWrite.transaction.Commit;
                        FconnectorWrite.Free;
                        self.FmyClass.RefreshPAG;
                   end;
         end;
    end;
  32:
    begin
         case QuestionDlg('удаление','Вы действительно хотите удалить запись об установке?'+lineending
                +'Восстановление невозможно!',mtConfirmation,[mrYes,'Удалить',mrNo,'Не удалять','isdefault'],'') of
                 mryes:
                   begin
                        FconnectorWrite:=TMyworkbd.Create;
                        FconnectorRead.copyParams(self,FconnectorWrite.connector);
                        FconnectorWrite.transaction.Params.Clear;
                        FconnectorWrite.transaction.Params.Add('isc_tpb_nowait');
                        SCRIPT:=TSQLSCRIPT.Create(self);
                        script.DataBase:=FconnectorWrite.connector;
                        script.Transaction:=FconnectorWrite.transaction;
                        script.CommentsInSQL:=false;
                        script.UseSetTerm:=true;
                        script.Script.Clear;
                        script.Script.Add('DELETE FROM install_po WHERE ID='+self.FmyClass.Query.FieldByName('ID').AsString+';');
                        script.Script.Add('COMMIT;');
                        script.Execute;
                        SCRIPT.Free;
                        FconnectorWrite.transaction.Commit;
                        FconnectorWrite.Free;
                        self.FmyClass.RefreshPAG;
                   end;
         end;
    end;
     end;
end;

procedure TmainF.AEditingExecute(Sender: TObject);
var
  frm:Tfrminfokartridj;
  tip_Q:TDataSetState;
begin
  case Fmyclass.IDActivPage of
  0:begin
       //if (FconnectorRead.connector.Role<>'ADMINISTRATOR')and(FconnectorRead.connector.Role<>'KADRI') then tip_q:=dsBrowse else tip_Q:=dsEdit;
       if checkdostup('START_WORK')=0 then tip_Q:=dsBrowse else tip_Q:=dsEdit;
          editEmploy:=TeditEmploy.Create(mainF);
         if editEmploy.SetConnect(FconnectorRead,tip_q,Fmyclass.Query.FieldByName('id').AsInteger)and(editEmploy.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editEmploy.Free;
  end;
  5:begin
          editSert:=TeditSert.Create(mainF);
         if editSert.SetConnect(FconnectorRead,dsEdit{dsBrowse},Fmyclass.Query.FieldByName('id').AsInteger)and(editSert.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editSert.Free;
  end;
  29:begin
          editSert:=TeditSert.Create(mainF);
         if editSert.SetConnect(FconnectorRead,dsBrowse,Fmyclass.Query.FieldByName('id').AsInteger)and(editSert.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editSert.Free;
  end;
  1:begin
          editEmploy:=TeditEmploy.Create(mainF);
         if editEmploy.SetConnect(FconnectorRead,dsBrowse,Fmyclass.Query.FieldByName('id_sw').AsInteger)and(editEmploy.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editEmploy.Free;
  end;
  {1:begin
          editEmploy:=TeditEmploy.Create(mainF);
          editEmploy.editing_id:=Fmyclass.Query.FieldByName('ID_SW').AsInteger;
          editEmploy.ViewOnly:=true;
         if editEmploy.ShowModal=mrok then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editEmploy.Free;
  end;   }
  4:begin
          editMNI:=TeditMNI.Create(mainF);
         if editMNI.SetConnect(FconnectorRead,dsBrowse, Fmyclass.Query.FieldByName('id_mni').AsInteger)and(editMNI.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editMNI.Free;
  end;
  2:Begin
         tmpstopSTARTWORK:=TtmpstopSTARTWORK.Create(mainF);
         //if (FconnectorRead.connector.Role<>'ADMINISTRATOR')and(FconnectorRead.connector.Role<>'KADRI') then tip_q:=dsBrowse else tip_Q:=dsEdit;
         if checkdostup('TMP_STOP_SW')=0 then tip_Q:=dsBrowse else tip_Q:=dsEdit;
         if tmpstopSTARTWORK.SetConnect(self.FconnectorRead,tip_q,Fmyclass.Query.FieldByName('id').AsInteger)and(tmpstopSTARTWORK.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         tmpstopSTARTWORK.Free;
         end;
  3:Begin
         editMNI:=TeditMNI.Create(mainF);
         //if (FconnectorRead.connector.Role<>'ADMINISTRATOR')and(FconnectorRead.connector.Role<>'KADRI') then tip_q:=dsBrowse else tip_Q:=dsEdit;
         if checkdostup('MNI')=0 then tip_Q:=dsBrowse else tip_Q:=dsEdit;
         if editMNI.SetConnect(FconnectorRead, tip_q, Fmyclass.Query.FieldByName('id').AsInteger)and(editMNI.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editMNI.Free;
         end;
  6:begin
          editMNI:=TeditMNI.Create(mainF);
         if editMNI.SetConnect(FconnectorRead,dsBrowse, Fmyclass.Query.FieldByName('id_mni').AsInteger)and(editMNI.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editMNI.Free;
         end;
  7:begin
          editKRIPTO:=TeditKRIPTO.Create(mainF);
          //if (FconnectorRead.connector.Role<>'ADMINISTRATOR')and(FconnectorRead.connector.Role<>'KADRI') then tip_q:=dsBrowse else tip_Q:=dsEdit;
          if checkdostup('copy_kripto')=0 then tip_Q:=dsBrowse else tip_Q:=dsEdit;
         if editKRIPTO.SetConnect(self.FconnectorRead, tip_q, Fmyclass.Query.FieldByName('id').AsInteger)and(editKRIPTO.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editKRIPTO.Free;
  end;
  8:Begin
         editSB2:=TeditSB2.Create(mainF);
         //if (FconnectorRead.connector.Role<>'ADMINISTRATOR')and(FconnectorRead.connector.Role<>'KADRI') then tip_q:=dsBrowse else tip_Q:=dsEdit;
         if checkdostup('sb')=0 then tip_Q:=dsBrowse else tip_Q:=dsEdit;
         if editSB2.SetConnect(self.FconnectorRead, tip_q, Fmyclass.Query.FieldByName('id').AsInteger)and(editSB2.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editSB2.Free;
         end;
  9:begin
         if Fmyclass.Query.FieldByName('nom').AsInteger=0 then
         begin
          editKRIPTO:=TeditKRIPTO.Create(mainF);
          if editKRIPTO.SetConnect(FconnectorRead,dsBrowse, Fmyclass.Query.FieldByName('ID_COPY_KRIPTO').AsInteger)and(editKRIPTO.ShowModal=mrok) then
          begin
           Fmyclass.UPDatingPAG;
          end;
         editKRIPTO.Free;
         end else
         begin
                editMNI:=TeditMNI.Create(mainF);
                if editMNI.SetConnect(FconnectorRead,dsBrowse, Fmyclass.Query.FieldByName('ID_COPY_KRIPTO').AsInteger)and(editMNI.ShowModal=mrok) then
                begin
                 Fmyclass.UPDatingPAG;
                end;
                editMNI.Free;
         end;
  end;
  14:begin
         if Fmyclass.Query.FieldByName('nom').AsInteger=0 then
         begin
          editKRIPTO:=TeditKRIPTO.Create(mainF);
          if editKRIPTO.SetConnect(FconnectorRead,dsBrowse, Fmyclass.Query.FieldByName('ID').AsInteger)and(editKRIPTO.ShowModal=mrok) then
          begin
           Fmyclass.UPDatingPAG;
          end;
         editKRIPTO.Free;
         end else
         begin
                editMNI:=TeditMNI.Create(mainF);
                if editMNI.SetConnect(FconnectorRead,dsBrowse, Fmyclass.Query.FieldByName('ID').AsInteger)and(editMNI.ShowModal=mrok) then
                begin
                 Fmyclass.UPDatingPAG;
                end;
                editMNI.Free;
         end;
  end;
  16:begin
          editSB2:=TeditSB2.Create(mainF);
         if editSB2.SetConnect(self.FconnectorRead,dsBrowse, Fmyclass.Query.FieldByName('id_sb').AsInteger)and(editSB2.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editSB2.Free;
  end;
  17:Begin
         editRAZNOE:=TeditRAZNOE.Create(mainF);
         //if (FconnectorRead.connector.Role<>'ADMINISTRATOR')and(FconnectorRead.connector.Role<>'KADRI') then tip_q:=dsBrowse else tip_Q:=dsEdit;
         if checkdostup('RAZNOE')=0 then tip_Q:=dsBrowse else tip_Q:=dsEdit;
         if editRAZNOE.SetConnect(FconnectorRead, tip_q, Fmyclass.Query.FieldByName('id').AsInteger)and(editRAZNOE.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editRAZNOE.Free;
         end;
  21:begin
          editRAZNOE:=TeditRAZNOE.Create(mainF);
         if editRAZNOE.SetConnect(self.FconnectorRead,dsBrowse, Fmyclass.Query.FieldByName('RID').AsInteger)and(editRAZNOE.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editRAZNOE.Free;
         end;
  22:
    begin
    editRAZNOE:=TeditRAZNOE.Create(mainF);
           if editRAZNOE.SetConnect(FconnectorRead,dsBrowse, Fmyclass.Query.FieldByName('id_raznoe').AsInteger)and(editRAZNOE.ShowModal=mrok) then
           begin
            Fmyclass.UPDatingPAG;
           end;
           editRAZNOE.Free;
    end;
  25:begin
         editLicense:=TeditLicense.Create(mainF);
         if editLicense.SetConnect(FconnectorRead,dsBrowse, Fmyclass.Query.FieldByName('id').AsInteger)and(editLicense.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editLicense.Free;
     end;
  28:begin
       {messagedlg('информация','наименование: '+self.FmyClass.Query.FieldbyName('name').AsString+lineending+
       'дата поступления: '+self.FmyClass.Query.FieldbyName('dt').AsString+lineending+
       'количество: '+self.FmyClass.Query.FieldbyName('count_r').AsString+lineending+
       'откуда: '+self.FmyClass.Query.FieldbyName('otkuda').AsString+lineending+
       'кто принял: '+self.FmyClass.Query.FieldbyName('fio').AsString, mtInformation,
       [mbOK],''); }
         frm:=Tfrminfokartridj.Create(self);
         frm.Edit1.Text:=self.FmyClass.Query.FieldbyName('name').AsString;
         frm.Edit2.Text:=self.FmyClass.Query.FieldbyName('dt').AsString;
         frm.Memo1.Text:=self.FmyClass.Query.FieldbyName('otkuda').AsString;
         frm.Edit3.Text:=self.FmyClass.Query.FieldbyName('fio').AsString;
         frm.Edit4.Text:=self.FmyClass.Query.FieldbyName('count_r').AsString;
         frm.ShowModal;
         frm.Free;
     end;
  31:begin
          editKRIPTO:=TeditKRIPTO.Create(mainF);
         if editKRIPTO.SetConnect(self.FconnectorRead,dsBrowse, Fmyclass.Query.FieldByName('id_kripto').AsInteger)and(editKRIPTO.ShowModal=mrok) then
         begin
          Fmyclass.UPDatingPAG;
         end;
         editKRIPTO.Free;
         end;
  end;
end;

procedure TmainF.AExitExecute(Sender: TObject);
begin
  Fmyclass.ExitSheet;
  if Fmyclass.PageCount<=0 then
  begin
       ClearToolBar;
       exit;
  end;
  SettingMenu(Fmyclass.nameIDSheet[Fmyclass.IDActivPage], Fmyclass.IDActivPage);
end;

procedure TmainF.AFindExecute(Sender: TObject);

begin
  if self.FmyClass.PageCount<=0 then exit;
  if not frmfindrecord.Find(self.FmyClass.Query,self.FconnectorRead.connector,self.FconnectorRead.transaction,
  ['DOP', 'MNIDOP']) //Через запятую перечисляем поля в которых нужен поиск
  then exit;
  if frmfindrecord.ResultPoisk.IsEmpty then showmessage('ничего не нашлось')
  else
      begin
           //else showmessage('поиск успешный');
           //Встанем на первую найденную запись
           self.FmyClass.Query.Locate('ID',self.frmfindrecord.ResultPoisk.FieldByName('ID').AsString,[]);
      end;
end;

procedure TmainF.AFindNextExecute(Sender: TObject);
begin
  //Если ранее поиск велся, то перейдем к следующей записи
  if (frmfindrecord.ResultPoisk=nil)or(frmfindrecord.ResultPoisk.IsEmpty) then exit;
  if frmfindrecord.ResultPoisk.RecordCount>1 then
  begin
       frmfindrecord.ResultPoisk.Next;
       if frmfindrecord.ResultPoisk.EOF then frmfindrecord.ResultPoisk.First;
       FmyClass.Query.Locate('ID',self.frmfindrecord.ResultPoisk.FieldByName('ID').AsString,[]);
  end;
end;

procedure TmainF.aMovingExecute(Sender: TObject);
begin
   //if (FconnectorRead.connector.Role<>'ADMINISTRATOR')and(FconnectorRead.connector.Role<>'KADRI') then exit;
   if checkdostup('START_WORK')=0 then exit;
   case Fmyclass.IDActivPage of
    0:begin
    tmpstopSTARTWORK:=TtmpstopSTARTWORK.Create(mainF);
           if tmpstopSTARTWORK.SetConnect(self.FconnectorRead,dsInsert,Fmyclass.Query.FieldByName('id').AsInteger)and(tmpstopSTARTWORK.ShowModal=mrok) then
           begin
            Fmyclass.UPDatingPAG;
           end;
    tmpstopSTARTWORK.Free;
    end;
    5:
      begin
     { tmpstopSTARTWORK:=TtmpstopSTARTWORK.Create(mainF);
             if tmpstopSTARTWORK.SetConnect(self.FconnectorRead,dsInsert,Fmyclass.Query.FieldByName('id').AsInteger)and(tmpstopSTARTWORK.ShowModal=mrok) then
             begin
              Fmyclass.UPDatingPAG;
             end;
             tmpstopSTARTWORK.Free; }
      end;
   end;
end;

procedure TmainF.AUpdatingExecute(Sender: TObject);
begin
  //Fmyclass.UPDatingPAG;
  FMyclass.RefreshPAG;
end;

procedure TmainF.AUploadExecute(Sender: TObject);
begin
  case MessageDlg('Вопрос','Выгрузить таблицу (ДА)?'+lineending+
              'Выгрузить запись(нет)?'+lineending+
              'Отменить?',mtInformation,[mbYes, mbNo, mbCancel],0) of
              6:Fmyclass.uploadDBGR;
              7:Fmyclass.uploadRow;
              end;
 // Fmyclass.uploadDBGR;
end;

procedure TmainF.DBGrid1DblClick(Sender: TObject);
begin
  self.Caption:=self.Caption+'dblclick';
end;

procedure TmainF.MenuItemSPClick(Sender: TObject);
{var querylocation:tsqlquery;
  translocation:tsqltransaction;  }
begin
  //self.openLOCATION;
  {//connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     //querylocation.ReadOnly:=true;
     QUERYSLOVAR( querylocation,translocation, 'select * from LOCATIONS where id_raion='+inttostr(id_raion));
     querylocation.FieldByName('ID_user').Visible:=false;
     querylocation.FieldByName('ID_raion').Visible:=false;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='название локации';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       TDBSlovariTemplateForm.ShowGridSlovari('люди', translocation, querylocation, @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;}
end;

procedure TmainF.MenuItemSUClick(Sender: TObject);
{var querypeople:tsqlquery;
  transpeople:tsqltransaction;
  querysex:tsqlquery;
  Fld:TField;
  FieldDef: TFieldDef; }
begin
  openPEOPLE;
  //-----------------
     //connector.Connected:=false;
  {   tmpquery:=tsqlquery.Create(mainF.Owner);
     tmptrans:=tsqltransaction.Create(mainF.Owner);
     QUERYSLOVAR( tmpquery,tmptrans, 'select id_peoples, count(id) as countWORK from works group by id_peoples');
     transpeople:=tsqltransaction.Create(mainF.Owner);
     querypeople:=tsqlquery.Create(mainF.Owner);
     querysex:=tsqlquery.Create(mainF.Owner);
     QUERYSLOVAR( querypeople,transpeople, 'select * from PEOPLES');
     QUERYSLOVAR( querysex,transpeople, 'select * from SEX');
     querypeople.Active:=false;
     FieldDef:=querypeople.FieldDefs.Find('ID');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     fld.ProviderFlags:=fld.ProviderFlags+[pfInKey];
     FieldDef:=querypeople.FieldDefs.Find('FAM');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='фамилия';
     fld.DisplayWidth:=15;
     FieldDef:=querypeople.FieldDefs.Find('NAM');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='имя';
     fld.DisplayWidth:=15;
     FieldDef:=querypeople.FieldDefs.Find('OTCH');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='отчество';
     fld.DisplayWidth:=15;
     FieldDef:=querypeople.FieldDefs.Find('ID_SEX');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     FieldDef:=querypeople.FieldDefs.Find('ID_RAION');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     FieldDef:=querypeople.FieldDefs.Find('ID_USER');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     //Ниже создаем lookup поле
     fld:=TStringField.Create(querypeople);
     fld.FieldKind:=fkLookup;
     fld.KeyFields:='ID_SEX';
     fld.LookupDataSet:=querysex;
     fld.LookupKeyFields:='ID';
     fld.LookupResultField:='NAME';
     fld.DataSet:=querypeople;
     fld.DisplayLabel:='пол';
     fld.ProviderFlags:=[];
     fld.Name:='sex';
     //querypeople.Fields.Fields[5].DisplayLabel:='пол';
     fld.FieldName:='sex';
     fld.DisplayWidth:=5;
     FieldDef:=querypeople.FieldDefs.Find('DTB');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='дата рождения';
     fld.DisplayWidth:=10;
     FieldDef:=querypeople.FieldDefs.Find('PLB');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='место рождения';
     fld.DisplayWidth:=60;
     FieldDef:=querypeople.FieldDefs.Find('REGISTRATION');
     fld:=FieldDef.CreateField(querypeople);//(querylocation2);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='место проживания';
     fld.DisplayWidth:=60;
     //Ниже создаем вычисляемое поле
     fld:=TStringField.Create(querypeople);
     fld.FieldKind:=fkCalculated;
     fld.DataSet:=querypeople;
     fld.DisplayLabel:='предыдущая работа(ы)';
     fld.ProviderFlags:=[];
     fld.Name:='lastworks';
     //querypeople.Fields.Fields[5].DisplayLabel:='пол';
     fld.FieldName:='lastworks';
     fld.DisplayWidth:=20;
     querypeople.OnCalcFields:=@myOnCalcFields;
     querypeople.AutoCalcFields:=true;
     querypeople.Active:=true;querypeople.Refresh;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       TDBSlovariTemplateForm.ShowGridSlovari('люди', transpeople, querypeople, @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', @slovaripeople,@slovaripeople2);
       querypeople.Active:=false;
       querypeople.Free;
       transpeople.Free;  }
end;

procedure TmainF.Timer1Timer(Sender: TObject);
begin
   FmyClass.RefreshPAG;
   Timer1.Enabled:=false;
end;

procedure TmainF.MySheetFiltered(Sender: TObject);
begin
     SettingMenu(fmyclass.nameIDSheet[fmyclass.IDActivPage], fmyclass.IDActivPage);
end;

procedure TmainF.MyAfterChangePage(Sender: TObject);
var
  i:integer;
begin
  SettingMenu(fmyclass.nameIDSheet[fmyclass.IDActivPage], fmyclass.IDActivPage);
  for i:=0 to self.ComponentCount-1 do
     if (self.Components[i] is Tmenuitem) then
     if (self.Components[i] as Tmenuitem).Name='MenuItem27' then
     begin
        Tmenuitem(self.Components[i]).Checked:=not fmyclass.SoftFind;
     end;
end;

procedure TmainF.myOnCalcFields(DataSet: TDataSet);
begin
     tmpquery.Locate('id_people', dataset.FieldByName('ID').AsString,[] );
     dataset.FieldByName('lastworks').AsInteger:= tmpquery.FieldByName ('countWORK').AsInteger;
end;

procedure TmainF.resAuth;
begin
  //прочитаем введенный логин и пароль
     FconnectorRead.connector.Role:='ADMINISTRATOR';
     {if 'ptk_admin_u03408001'=trim(utf8lowercase('PTK_ADMIN_'+frmauth.Login))then
     showmessage('равны') else showmessage('не равны');
     exit;}
     FconnectorRead.connector.UserName:=trim(utf8lowercase('PTK_ADMIN_'+frmauth.Login));
     {showmessage(frmauth.pwd);
     if '26101979'=trim(frmauth.pwd)then
     showmessage('равны') else showmessage('не равны');
     exit; }
     FconnectorRead.connector.Password:=frmauth.pwd;
     //FconnectorRead.connector.Connected:=true;
     //Запускаем соединение и проверку введенных данных
     //в отдельном потоке
     ThreadLoadBD:=TMyThread.Create(true,FconnectorRead);
     ThreadLoadBD.OnMyStatus:=@EndLoad;
     ThreadLoadBD.Resume;
end;

procedure TmainF.Check_TMP_STOP;
var
    SCRIPT:TSQLScript;
begin
  //проверяем временные прекращения, возможно какие-то уже завершились
  script:=TSQLScript.Create(self);
  script.DataBase:=FconnectorRead.connector;
  script.Transaction:=FconnectorRead.transaction;
  script.CommentsInSQL:=false;
  script.UseSetTerm:=true;
  script.Script.Clear;
  script.Script.Add('execute procedure check_tmp_stop('+inttostr(id_raion)+');');
  script.Execute;
  FreeAndNil(script);
end;

procedure TmainF.EndLoad(Status: TMyStatusLoadBD);
var
  qq:tsqlquery;
  tmpstring:string;
begin
     case Status of
     MySLBDErr:
       begin
         //Уничтожаем созданные объекты и Завершаем программу
         messagedlg('ошибка','не удалось соединиться'
                        , mtError,[mbOK],0);
         ThreadLoadBD.Terminate;
          frmauth.ExF(false);
         exit;
       end;
     //Начало проверки введеного логина и пароля
     MySLBDcheckUsr:
       begin
         //Если окно авторизации  загружено
         //то
         //mainF.Show;
         if frmauth<>nil then
         frmauth.checkUsr:=1;//меняем надпись
       end;
     //Отсутствие пользователя в базе косяк админа
     MySLBDcheckUsrErr:
     begin
         messagedlg('ошибка','пользователь не заведен в базе данных'+lineending
         +'обратитесь к администратору', mtWarning,[mbOK],0);
         //Уничтожаем созданные объекты и Завершаем программу
         ThreadLoadBD.Terminate;
          frmauth.ExF(false);
          exit;
       end;
     //Соединение пользователем
     MySLBDConnUsr:
     begin
       //Если окно авторизации  загружено
         //то
        if frmauth<>nil then
        frmauth.checkUsr:=2;//меняем надпись
     end;
     MySLBDcheckUsrNo:
                      begin
                        messagedlg('ошибка','не верный логин или пароль'
                        , mtWarning,[mbOK],0);
                        //Уничтожаем созданные объекты и Завершаем программу
                        ThreadLoadBD.Terminate;
                        frmauth.ExF(false);
                        exit;
                      end;
     MySLBDcheckUsrYes:
                       begin
                         { frmauth.ExF(true); //frmauth.Hide;
                          //self.Show;
                         //self.WindowState:=wsNormal;
                         ThreadLoadBD.Terminate; }

                        //наш код при успешном соединении
                        //создадим свой класс
                        toolbar5.Align:=altop;
                        toolbar4.Align:=altop;
                        {showmessage(FconnectorRead.connector.UserName+lineending
                        +FconnectorRead.connector.Role); }
                        Fmyclass:=Tmypagecontrol.Create(mainF.Owner);
                        //Добавим обработчики
                        FMyclass.OnmyAfterOpen:=@AfterOpen;//Возникает после открытия набора данных
                        //Возникает при любых изменениях данных
                        //FMyClass.OnmySettingMenu:=@SettingMenu;//Используется для обновления меню
                        FMyClass.OnmyDblClick:=@MyMouseUp;
                        //FMyClass.OnmyShowSheet:=@MyShowSheet;
                        FMyClass.OnMySheetFiltered:=@MySheetFiltered; //Возникает после применения фильтра
                        FMyClass.OnMyAfterChangePage:=@MyAfterChangePage; //Возникает после смены вкладки
                        FMyClass.OnMyAfterUpdatePage:=@MySheetFiltered;//Возникает после обновления(повторной загрузки) данных вкладки
                        Fmyclass.Parent:=mainF;
                        fmyclass.Top:=250;
                        Fmyclass.Align:=alclient;//alTop;
                        fmyclass.Height:=500;
                        Fshowbirthday:=false;
                        //showmessage(application.Params[1]);
                        //showmessage(self.FconnectorRead.connector.Role);
                        //проверим количество параметров и их значения
                          if   {(application.ParamCount=0)or}(application.ParamCount>0)and(checkparametr('1')) then
                          begin
                           //проверка дней рождений у сотрудников
                               qq:=tsqlquery.Create(self);
                               qq.DataBase:=FconnectorRead.connector;//sqlquery1.DataBase;
                               qq.Transaction:=FconnectorRead.transaction;
                               //self.FconnectorWrite.transaction;
                               qq.SQL.Clear;
                               qq.SQL.Add('select DISTINCT DDD, FAM, NAM, OTCH from (select /*ABS*/(DATEDIFF(DAY FROM DATEADD(DATEDIFF(YEAR FROM DTB TO CURRENT_DATE ) YEAR TO DTB) TO CURRENT_DATE)) AS DDD, TABNOM, ID_PEOPLE, ID, rr, FAM, NAM, OTCH, post, ngroup, loc,'+lineending
                               +'DTB, REGISTRATION, STAJ, SNILS, INN, PHONE_SOTE from VIEW_START_WORK('+inttostr(id_raion)+')) as tab where ((tab.DDD<3)and(tab.DDD>-10))');
                               qq.Open;
                               if not qq.IsEmpty then
                               begin
                                    //showmessage('76');
                                    tmpstring:='';
                                    qq.First;
                                    while not qq.EOF do
                                    begin
                                     //showmessage(qq.FieldByName('FAM').AsString);
                                    tmpstring:=tmpstring+lineending+qq.FieldByName('FAM').AsString+
                                    ' '+utf8copy(qq.FieldByName('NAM').AsString,1,1)+'. '+
                                    utf8copy(qq.FieldByName('OTCH').AsString,1,1)+'.';
                                       if (qq.FieldByName('DDD').AsInteger>0) and (qq.FieldByName('DDD').AsInteger<3) then
                                       tmpstring:=tmpstring+' -прошло' else
                                           begin
                                                if qq.FieldByName('DDD').AsInteger<-1 then
                                                tmpstring:=tmpstring+' через '+inttostr(abs(qq.FieldByName('DDD').AsInteger))+
                                                ' дней'
                                                else if qq.FieldByName('DDD').AsInteger=-1 then tmpstring:=tmpstring+' -завтра' else tmpstring:=tmpstring+' -сегодня';
                                           end;
                                       qq.Next;
                                    end;
                                    WindowState:=wsMinimized;
                                    bdemplstr:='***********День рождения сотрудников********'+lineending+'---------------------------------'+tmpstring+
                                    lineending+'---------------------------------';
                                    //MessageDlg(' ','День рождения'+tmpstring,mtInformation,[mbok],0);
                                    //showmessage('День рождения');
                                    Fshowbirthday:=true;
                                    WindowState:=Fwinstat;
                               end;
                               qq.close;
                               qq.Free;
                          end;
                          if   {(application.ParamCount=0)or}((application.ParamCount>0)and(checkparametr('2'))) then
                          begin
                               //проверка дней рождений у детей сотрудников
                               qq:=tsqlquery.Create(self);
                               qq.DataBase:=FconnectorRead.connector;//sqlquery1.DataBase;
                               qq.Transaction:=FconnectorRead.transaction;
                               //self.FconnectorWrite.transaction;
                               qq.SQL.Clear;
                               qq.SQL.Add('select DISTINCT DDD, FAM, NAM, OTCH, ID_PEOPLE from '+lineending+
                               '(select /*ABS*/(DATEDIFF(DAY FROM DATEADD(DATEDIFF(YEAR FROM DTB TO CURRENT_DATE ) YEAR TO DTB) TO CURRENT_DATE)) AS DDD,'+lineending+
                               ' ID, FAM, NAM, OTCH,'+lineending+
                               'DTB, ID_PEOPLE from VIEW_CHILDREN_SW('+inttostr(id_raion)+')) as tab where ((tab.DDD<3)and(tab.DDD>-10))');
                               qq.Open;
                               if not qq.IsEmpty then
                               begin
                                    bdchld:=Tstringlist.Create;
                                    //showmessage('76');
                                    tmpstring:='';
                                    qq.First;
                                    while not qq.EOF do
                                    begin
                                     //showmessage(qq.FieldByName('FAM').AsString);
                                    tmpstring:=tmpstring+lineending+qq.FieldByName('FAM').AsString+
                                    ' '+qq.FieldByName('NAM').AsString{utf8copy(qq.FieldByName('NAM').AsString,1,1)+'. '}+' '+
                                    utf8copy(qq.FieldByName('OTCH').AsString,1,1)+'.';
                                       if (qq.FieldByName('DDD').AsInteger>0) and (qq.FieldByName('DDD').AsInteger<3) then
                                       tmpstring:=tmpstring+' -прошло' else
                                           begin
                                                if qq.FieldByName('DDD').AsInteger<-1 then
                                                tmpstring:=tmpstring+' через '+inttostr(abs(qq.FieldByName('DDD').AsInteger))+
                                                ' дней'
                                                else if qq.FieldByName('DDD').AsInteger=-1 then tmpstring:=tmpstring+' -завтра' else tmpstring:=tmpstring+' -сегодня';
                                           end;
                                       bdchld.Append(trim(inttostr(qq.FieldByName('ID_PEOPLE').AsInteger)));
                                       qq.Next;
                                    end;
                                    WindowState:=wsMinimized;
                                    if UTF8length(self.bdemplstr)>0 then
                                    bdemplstr:=bdemplstr+lineending;
                                    bdemplstr:=bdemplstr+lineending+'*******День рождения у детей сотрудников*****'+lineending+'---------------------------------'+tmpstring+
                                    lineending+'---------------------------------';
                                    //MessageDlg(' ','День рождения у детей'+tmpstring,mtInformation,[mbok],0);
                                    //showmessage('День рождения');
                                    Fshowbirthday:=true;
                                    WindowState:=Fwinstat;
                               end;
                               qq.close;
                               qq.Free;
                          end;
                          //Создадим класс для поиска
                          frmfindrecord:=Tfrmfindrecord.Create(mainF);

                          frmauth.ExF(true); //frmauth.Hide;
                          //self.Show;
                         //self.WindowState:=wsNormal;
                         ThreadLoadBD.Terminate;
                         qq:=TSQLQuery.Create(self);
                         qq.DataBase:=FconnectorRead.connector;//sqlquery1.DataBase;
                         qq.Transaction:=FconnectorRead.transaction;
                         qq.SQL.Clear;
                         qq.SQL.Add('select DOSTUP.ID as ID, DOSTUP.NAME_OBJECT as NAME_OBJECT, DOSTUP.DOSTUP as DOSTUP,'+
                         'DOSTUP.ID_USER as ID_USER, ROLES.RROLE as ROLE from DOSTUP left join Roles on (DOSTUP.ID_ROLE=Roles.ID) '+
                         'where ((DOSTUP.ID_USER = '+inttostr(id_user)+')or(LOWER(ROLES.RROLE) = '''+utf8lowercase(FconnectorRead.connector.Role)+''')) order by DOSTUP.ID_ROLE DESC');
                         qq.Open;
                         if not qq.IsEmpty then
                         begin
                              qq.First;//qq.Last;qq.First;
                              new(pHeadDostup);
                              pHeadDostup^.dostup:=qq.FieldByName('dostup').AsInteger;
                              if qq.FieldByName('Role').IsNull then
                                 pHeadDostup^.Role:='' else
                                     pHeadDostup^.Role:=qq.FieldByName('Role').asstring;
                              pHeadDostup^.Table:=qq.FieldByName('NAME_OBJECT').asstring;
                              if qq.FieldByName('ID_User').IsNull then
                                 pHeadDostup^.User_ID:=-1 else
                                     pHeadDostup^.User_ID:=qq.FieldByName('ID_User').AsInteger;
                              pHeadDostup^.Next:=nil;
                              qq.Next;
                              while not qq.EOF do
                              begin
                                if pHeadDostup^.Next=nil then
                                   begin
                                        new(pHeadDostup^.Next);
                                        pCurrentDostup:=pHeadDostup^.Next;
                                   end else
                                   begin
                                    new(pCurrentDostup^.Next);
                                    pCurrentDostup:=pCurrentDostup^.Next;
                                   end;
                                pCurrentDostup^.dostup:=qq.FieldByName('dostup').AsInteger;
                                if qq.FieldByName('Role').IsNull then
                                   pCurrentDostup^.Role:='' else
                                       pCurrentDostup^.Role:=qq.FieldByName('Role').asstring;
                                pCurrentDostup^.Table:=qq.FieldByName('NAME_OBJECT').asstring;
                                if qq.FieldByName('ID_User').IsNull then
                                   pCurrentDostup^.User_ID:=-1 else
                                       pCurrentDostup^.User_ID:=qq.FieldByName('ID_User').AsInteger;
                                pCurrentDostup^.Next:=nil;
                                qq.Next;
                              end;
                         end;
                         qq.Free;
                          //Уничтожаем созданные объекты и Завершаем программу
                        //ThreadLoadBD.Terminate;
                        //frmauth.ExF(false);
                          {//создадим свой класс
                          Fmyclass:=Tmypagecontrol.Create(self);
                          //Добавим обработчики
                          FMyclass.OnmyAfterOpen:=@self.AfterOpen;//Возникает после открытия набора данных
                        //Возникает при любых изменениях данных
                        FMyClass.OnmySettingMenu:=@self.SettingMenu;//Используется для обновления меню
                        Fmyclass.Parent:=self;
                        //fmyclass.Top:=250;
                        Fmyclass.Align:=alclient;//alTop;
                        //fmyclass.Height:=500;}
                        //if (FconnectorRead.connector.Role<>'ADMINISTRATOR')and(FconnectorRead.connector.Role<>'KADRI') then MenuItemS.Visible:=false;
                       end;
     end;
end;

procedure TmainF.Setconnector(AValue: tsqlconnector);
begin
  if Fconnector=AValue then Exit;
  Fconnector:=AValue;
end;

procedure TmainF.Setconnlogin(AValue: string);
begin
      if Fconnlogin=AValue then Exit;
      Fconnlogin:=AValue;
end;

procedure TmainF.Setconnpwd(AValue: string);
begin
  if Fconnpwd=AValue then Exit;
  Fconnpwd:=AValue;
end;

function TmainF.openPEOPLE(const select: boolean): integer;
var querypeople:tsqlquery;
  querypeopleV:tsqlquery;
  transpeople:tsqltransaction;
  querysex:tsqlquery;
  querytipedu:tsqlquery;
  Fld:TField;
  FieldDef: TFieldDef;
begin
     //connector.Connected:=false;
     tmpquery:=tsqlquery.Create(mainF.Owner);
     tmptrans:=tsqltransaction.Create(mainF.Owner);
     QUERYSLOVAR( tmpquery,tmptrans, 'select id_people, count(id) as countWORK from'+lineending+
     ' works group by id_people');
     transpeople:=tsqltransaction.Create(mainF.Owner);
     querypeople:=tsqlquery.Create(mainF.Owner);
     querypeopleV:=tsqlquery.Create(mainF.Owner);
     querysex:=tsqlquery.Create(mainF.Owner);
     querytipedu:=tsqlquery.Create(mainF.Owner);
     querypeopleV.ReadOnly:=true;
     QUERYSLOVAR(querypeopleV,transpeople,'select * from VIEW_SLOVAR_PEOPLES /*GET_SLOVAR_PEOPLES*/ order by FAM, NAM, OTCH');
     querypeopleV.FieldByName('NAME_TIP').DisplayWidth:=15;
     querypeopleV.FieldByName('place_education').DisplayLabel:='место образования';
     querypeopleV.FieldByName('place_education').DisplayWidth:=15;
     querypeopleV.FieldByName('NAME_TIP').DisplayLabel:='Образование';
     querypeopleV.FieldByName('ID').Visible:=false;
     querypeopleV.FieldByName('FAM').DisplayWidth:=15;
     querypeopleV.FieldByName('FAM').DisplayLabel:='фамилия';
     querypeopleV.FieldByName('NAM').DisplayWidth:=15;
     querypeopleV.FieldByName('NAM').DisplayLabel:='имя';
     querypeopleV.FieldByName('OTCH').DisplayWidth:=15;
     querypeopleV.FieldByName('OTCH').DisplayLabel:='отчество';
     querypeopleV.FieldByName('PHONE_HOME').DisplayWidth:=15;
     querypeopleV.FieldByName('PHONE_HOME').DisplayLabel:='телефон домашний';
     querypeopleV.FieldByName('PHONE_WORK').DisplayWidth:=15;
     querypeopleV.FieldByName('PHONE_WORK').DisplayLabel:='телефон рабочий';
     querypeopleV.FieldByName('PHONE_SOTE').DisplayWidth:=15;
     querypeopleV.FieldByName('PHONE_SOTE').DisplayLabel:='сотовый';
     querypeopleV.FieldByName('DTB').DisplayWidth:=15;
     querypeopleV.FieldByName('DTB').DisplayLabel:='дата рождения';
     querypeopleV.FieldByName('VOZR').DisplayWidth:=15;
     querypeopleV.FieldByName('VOZR').DisplayLabel:='возраст';
     querypeopleV.FieldByName('PLB').DisplayWidth:=15;
     querypeopleV.FieldByName('PLB').DisplayLabel:='место рождения';
     querypeopleV.FieldByName('REGISTRATION').DisplayWidth:=15;
     querypeopleV.FieldByName('REGISTRATION').DisplayLabel:='место регистрации';
     querypeopleV.FieldByName('PASPORT').DisplayWidth:=15;
     querypeopleV.FieldByName('PASPORT').DisplayLabel:='паспорт';
     querypeopleV.FieldByName('SNILS').DisplayWidth:=15;
     querypeopleV.FieldByName('SNILS').DisplayLabel:='СНИЛС';
     querypeopleV.FieldByName('INN').DisplayWidth:=15;
     querypeopleV.FieldByName('INN').DisplayLabel:='ИНН';
     querypeopleV.FieldByName('LASTWORK').DisplayWidth:=15;
     querypeopleV.FieldByName('LASTWORK').DisplayLabel:='предыдущая работа(ы)';
     querypeopleV.FieldByName('CHILDRENS').DisplayWidth:=15;
     querypeopleV.FieldByName('CHILDRENS').DisplayLabel:='дети';
     QUERYSLOVAR( querypeople,transpeople, 'select * from PEOPLES order by fam, nam, otch');
     QUERYSLOVAR( querysex,transpeople, 'select * from SEX');
     QUERYSLOVAR( querytipedu,transpeople, 'select * from TIP_EDUCATION');
     querypeople.Active:=false;
     FieldDef:=querypeople.FieldDefs.Find('ID');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     fld.ProviderFlags:=fld.ProviderFlags+[pfInKey];
     FieldDef:=querypeople.FieldDefs.Find('FAM');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='фамилия';
     fld.DisplayWidth:=15;
     fld.Required:=true;
     FieldDef:=querypeople.FieldDefs.Find('NAM');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='имя';
     fld.DisplayWidth:=15;
     fld.Required:=true;
     FieldDef:=querypeople.FieldDefs.Find('OTCH');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='отчество';
     fld.DisplayWidth:=15;
     fld.Required:=true;

     FieldDef:=querypeople.FieldDefs.Find('PASPORT');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='паспорт';
     fld.DisplayWidth:=15;

     FieldDef:=querypeople.FieldDefs.Find('SNILS');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='СНИЛС';
     fld.DisplayWidth:=15;

     FieldDef:=querypeople.FieldDefs.Find('INN');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='ИНН';
     fld.DisplayWidth:=15;

     FieldDef:=querypeople.FieldDefs.Find('ID_SEX');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
      FieldDef:=querypeople.FieldDefs.Find('ID_TIP_EDUCATION');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     FieldDef:=querypeople.FieldDefs.Find('ID_RAION');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     FieldDef:=querypeople.FieldDefs.Find('ID_USER');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     //Ниже создаем lookup поле
     fld:=TStringField.Create(querypeople);
     fld.FieldKind:=fkLookup;
     fld.KeyFields:='ID_SEX';
     fld.LookupDataSet:=querysex;
     fld.LookupKeyFields:='ID';
     fld.LookupResultField:='NAME';
     fld.DataSet:=querypeople;
     fld.DisplayLabel:='пол';
     fld.ProviderFlags:=[];
     fld.Name:='sex';
     fld.Required:=true;
     fld.FieldName:='sex';
     fld.DisplayWidth:=5;

     //Ниже создаем lookup поле
     fld:=TStringField.Create(querypeople);
     fld.FieldKind:=fkLookup;
     fld.KeyFields:='ID_TIP_EDUCATION';
     fld.LookupDataSet:=querytipedu;
     fld.LookupKeyFields:='ID';
     fld.LookupResultField:='NAME';
     fld.DataSet:=querypeople;
     fld.DisplayLabel:='образование';
     fld.ProviderFlags:=[];
     fld.Name:='tip_education';
     //fld.Required:=true;
     fld.FieldName:='tip_education';
     fld.DisplayWidth:=5;

     FieldDef:=querypeople.FieldDefs.Find('place_education');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='место обучения';
     //fld.DisplayWidth:=10;
     //fld.Required:=true;

     FieldDef:=querypeople.FieldDefs.Find('DTB');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='дата рождения';
     fld.DisplayWidth:=10;
     fld.Required:=true;
     FieldDef:=querypeople.FieldDefs.Find('PLB');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='место рождения';
     fld.DisplayWidth:=60;
     FieldDef:=querypeople.FieldDefs.Find('REGISTRATION');
     fld:=FieldDef.CreateField(querypeople);//(querylocation2);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='место проживания';
     fld.DisplayWidth:=60;

     //Ниже создаем вычисляемое поле
     fld:=TStringField.Create(querypeople);
     fld.FieldKind:=fkCalculated;
     fld.DataSet:=querypeople;
     fld.DisplayLabel:='предыдущая работа(ы)';
     fld.ProviderFlags:=[];
     fld.Name:='lastworks';
     //querypeople.Fields.Fields[5].DisplayLabel:='пол';
     fld.FieldName:='lastworks';
     fld.DisplayWidth:=20;

     FieldDef:=querypeople.FieldDefs.Find('PHONE_HOME');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='Домашний телефон';
     fld.DisplayWidth:=15;
     FieldDef:=querypeople.FieldDefs.Find('PHONE_WORK');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='Рабочий телефон';
     fld.DisplayWidth:=15;
     FieldDef:=querypeople.FieldDefs.Find('PHONE_SOTE');
     fld:=FieldDef.CreateField(querypeople);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='сотовый';
     fld.DisplayWidth:=15;
     //querypeople.OnCalcFields:=@myOnCalcFields;
     //querypeople.AutoCalcFields:=true;
     querypeople.Active:=true;querypeople.Refresh;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('люди', transpeople, querypeople, querypeoplev,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', @slovaripeople,@slovaripeople2,select);{
       result:=TDBSlovariTemplateForm.ShowGridSlovari('люди', transpeople, querypeople, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', @slovaripeople,@slovaripeople2,select);  }
       querypeople.Active:=false;
       querypeople.Free;
       transpeople.Free;
end;

function TmainF.openLicPO(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from lic_po') then exit;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('namepo').DisplayLabel:='продукт лицензирования';
     querylocation.Fields.FieldByName('namepo').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('продукты лицензирования', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openSTART_WORK(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select t1.ID as ID, t2.FAM as FIO, t1.TABNOM as TABNOM from START_WORK as t1 join PEOPLES as t2'+lineending
     +'on (t1.ID_PEOPLE=t2.ID)') then exit;;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('FIO').DisplayLabel:='ФИО';
     querylocation.Fields.FieldByName('FIO').DisplayWidth:=80;
     querylocation.Fields.FieldByName('TABNOM').DisplayLabel:='табельный №';
     querylocation.Fields.FieldByName('TABNOM').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('сотрудники', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select, true);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openTIPEDU(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from TIP_EDUCATION') then exit;;
    // querylocation.FieldByName('ID_user').Visible:=false;
    // querylocation.FieldByName('ID_raion').Visible:=false;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='образование';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('должности', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openMOTIVE_TMP_STOP_SW(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from MOTIVE_TMP_STOP_SW') then exit;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='причины временного прекращения';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('должности', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openMOTIVE_TMP_STOP_SERT(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from MOTIVE_TMP_STOP_SERT') then exit;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='причины временного прекращения';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('причины', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openPOST(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from POSTS') then exit;;
    // querylocation.FieldByName('ID_user').Visible:=false;
    // querylocation.FieldByName('ID_raion').Visible:=false;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='должность';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('должности', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil,select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openRESURS(const select: boolean): integer;
var queryresurs:tsqlquery;
  transresurs:tsqltransaction;
begin
     //connector.Connected:=false;
     transresurs:=tsqltransaction.Create(mainF.Owner);
     queryresurs:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( queryresurs,transresurs, 'select * from RESURS order by name') then exit;;
    // querylocation.FieldByName('ID_user').Visible:=false;
    // querylocation.FieldByName('ID_raion').Visible:=false;
     queryresurs.FieldByName('ID').Visible:=false;
     queryresurs.FieldByName('ID').ProviderFlags:=queryresurs.Fields.Fields[0].ProviderFlags+[pfInKey];
     queryresurs.Fields.FieldByName('name').DisplayLabel:='ресурс';
     queryresurs.Fields.FieldByName('name').DisplayWidth:=80;
     queryresurs.Fields.FieldByName('dop').DisplayLabel:='описание';
     queryresurs.Fields.FieldByName('dop').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('список ресурсов', transresurs, queryresurs, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil,select);
       queryresurs.Active:=false;
       queryresurs.Free;
       transresurs.Free;
end;

function TmainF.openPO(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     QUERYSLOVAR( querylocation,translocation, 'select * from PO');
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='ПО';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('Программы', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openInstAction(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     QUERYSLOVAR( querylocation,translocation, 'select * from Install_action');
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='действия с программами';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('действия с программами', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openGROUP(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     QUERYSLOVAR( querylocation,translocation, 'select * from GROUPS');
     //querylocation.FieldByName('ID_user').Visible:=false;
    //querylocation.FieldByName('ID_raion').Visible:=false;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='группа';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('группы', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openMNIMODEL(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
  queryMNIMODELV:tsqlquery;
  //transMNIMODELV:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     queryMNIMODELV:=tsqlquery.Create(mainF.Owner);
     //queryMNIMODELV.Close;
     queryMNIMODELV.ReadOnly:=true;
     QUERYSLOVAR( querylocation,translocation, 'select * from MNI_MODEL order by name');
     QUERYSLOVAR( queryMNIMODELV,translocation, 'select * from MNI_MODEL order by name');
     queryMNIMODELV.Open;
     queryMNIMODELV.FieldByName('ID').Visible:=false;
     queryMNIMODELV.FieldByName('ID').ProviderFlags:=queryMNIMODELV.Fields.Fields[0].ProviderFlags+[pfInKey];
     queryMNIMODELV.Fields.FieldByName('name').DisplayLabel:='модель';
     queryMNIMODELV.Fields.FieldByName('name').DisplayWidth:=80;
     //-----------
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='модель';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('модель МНИ', translocation, querylocation, queryMNIMODELV,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openRAZNOEMODEL(const select: boolean): integer;
  var query2:tsqlquery;
    transR:tsqltransaction;
    queryRAZNOEMODELV:tsqlquery;
    //transMNIMODELV:tsqltransaction;
  begin
       //connector.Connected:=false;
       transR:=tsqltransaction.Create(mainF.Owner);
       query2:=tsqlquery.Create(mainF.Owner);
       queryRAZNOEMODELV:=tsqlquery.Create(mainF.Owner);
       //queryMNIMODELV.Close;
       queryRAZNOEMODELV.ReadOnly:=true;
       QUERYSLOVAR( query2,transR, 'select * from RAZNOE_MODEL order by name');
       QUERYSLOVAR( queryRAZNOEMODELV,transR, 'select * from RAZNOE_MODEL order by name');
       queryRAZNOEMODELV.FieldByName('ID').Visible:=false;
       queryRAZNOEMODELV.Fields.FieldByName('name').DisplayLabel:='модель';
       queryRAZNOEMODELV.Fields.FieldByName('name').DisplayWidth:=80;
       //-----------
       query2.FieldByName('ID').Visible:=false;
       query2.FieldByName('ID').ProviderFlags:=query2.Fields.Fields[0].ProviderFlags+[pfInKey];
       query2.Fields.FieldByName('name').DisplayLabel:='модель';
       query2.Fields.FieldByName('name').DisplayWidth:=80;
       //Вызываем форму локации
       //false значит выбираем не для выбора
         result:=TDBSlovariTemplateForm.ShowGridSlovari('модель РАЗНОЕ', transR, query2, queryRAZNOEMODELV,
         @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil, nil, select);
         query2.Active:=false;
         query2.Free;
         transR.Free;
  end;

function TmainF.openMNITIP(const select: boolean): integer;
var querylocation, queryV:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     queryV:=tsqlquery.Create(mainF.Owner);
     queryV.ReadOnly:=true;
     QUERYSLOVAR( querylocation,translocation, 'select * from MNI_TIP');
     QUERYSLOVAR( queryV,translocation, 'select * from MNI_TIP order by name');
     //querylocation.FieldByName('ID_user').Visible:=false;
     //querylocation.FieldByName('ID_raion').Visible:=false;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='тип';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //----
     queryV.FieldByName('ID').Visible:=false;
     //queryV.FieldByName('ID').ProviderFlags:=queryV.Fields.Fields[0].ProviderFlags+[pfInKey];
     queryV.Fields.FieldByName('name').DisplayLabel:='тип';
     queryV.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('тип МНИ', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openRAZNOETIP(const select: boolean): integer;
var querylocation, queryV:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     queryV:=tsqlquery.Create(mainF.Owner);
     queryV.ReadOnly:=true;
     QUERYSLOVAR( querylocation,translocation, 'select * from RAZNOE_TIP order by name');
     QUERYSLOVAR( queryV,translocation, 'select * from RAZNOE_TIP order by name');
     //querylocation.FieldByName('ID_user').Visible:=false;
     //querylocation.FieldByName('ID_raion').Visible:=false;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='тип';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //----
     queryV.FieldByName('ID').Visible:=false;
     //queryV.FieldByName('ID').ProviderFlags:=queryV.Fields.Fields[0].ProviderFlags+[pfInKey];
     queryV.Fields.FieldByName('name').DisplayLabel:='тип';
     queryV.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('тип РАЗНОЕ', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openRASHODNIKNAME(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
  querytip:tsqlquery;
  Fld:TField;
  FieldDef: TFieldDef;
begin
     translocation:=tsqltransaction.Create(mainF.Owner);
     querytip:=tsqlquery.Create(mainF.Owner);
     querytip.ReadOnly:=true;
     QUERYSLOVAR(querytip,translocation,'select * from rashodnik_tip');
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     QUERYSLOVAR( querylocation,translocation, 'select * from RASHODNIK_NAME');
     {querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='наименование расходника';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;  }
     querylocation.Close;
     //****************
     FieldDef:=querylocation.FieldDefs.Find('ID');
     fld:=FieldDef.CreateField(querylocation);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     fld.ProviderFlags:=fld.ProviderFlags+[pfInKey];
     //****************
     FieldDef:=querylocation.FieldDefs.Find('NAME');
     fld:=FieldDef.CreateField(querylocation);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='наименование расходника';
     fld.DisplayWidth:=30;
     //****************
     FieldDef:=querylocation.FieldDefs.Find('ID_TIP');
     fld:=FieldDef.CreateField(querylocation);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     //****************
     //Ниже создаем lookup поле
     fld:=TStringField.Create(querylocation);
     fld.FieldKind:=fkLookup;
     fld.KeyFields:='ID_TIP';
     fld.LookupDataSet:=querytip;
     fld.LookupKeyFields:='ID';
     fld.LookupResultField:='NAME';
     fld.DataSet:=querylocation;
     fld.DisplayLabel:='тип расходника'+lineending+'для чего';
     fld.ProviderFlags:=[];
     fld.Name:='tip_rashodnik';
     fld.Required:=true;
     fld.FieldName:='tip_rashodnik';
     fld.DisplayWidth:=20;
     //******************
     querylocation.Open;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('расходники', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querytip.Active:=false;
       querylocation.Free;
       querytip.Free;
       translocation.Free;
end;

function TmainF.openRASHODNIKTIP(const select: boolean): integer;
var querylocation{, queryV}:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     {queryV:=tsqlquery.Create(mainF.Owner);
     queryV.ReadOnly:=true; }
     QUERYSLOVAR( querylocation,translocation, 'select * from RASHODNIK_TIP order by name');
     //QUERYSLOVAR( queryV,translocation, 'select * from RAZNOE_TIP order by name');
     //querylocation.FieldByName('ID_user').Visible:=false;
     //querylocation.FieldByName('ID_raion').Visible:=false;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='тип';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //----
     {queryV.FieldByName('ID').Visible:=false;
     //queryV.FieldByName('ID').ProviderFlags:=queryV.Fields.Fields[0].ProviderFlags+[pfInKey];
     queryV.Fields.FieldByName('name').DisplayLabel:='тип';
     queryV.Fields.FieldByName('name').DisplayWidth:=80;  }
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('тип РАСХОДНИКА', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openNAME_SB(const select: boolean): integer;
var querylocation,queryV:tsqlquery;
  translocation:tsqltransaction;

begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     queryV:=tsqlquery.Create(mainF.Owner);
     queryV.ReadOnly:=true;
     QUERYSLOVAR( querylocation,translocation, 'select * from NAME_SB');
     QUERYSLOVAR( queryV,translocation, 'select * from NAME_SB order by name');
     //querylocation.FieldByName('ID_user').Visible:=false;
     //querylocation.FieldByName('ID_raion').Visible:=false;
     queryV.FieldByName('ID').Visible:=false;
     //querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     queryV.Fields.FieldByName('name').DisplayLabel:='системный блок';
     queryV.Fields.FieldByName('name').DisplayWidth:=80;
     //-----
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='системный блок';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('название системного блока', translocation, querylocation, queryV,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openTIP_LICENSE_OS(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     QUERYSLOVAR( querylocation,translocation, 'select * from TIP_LICENSE_OS');
     //querylocation.FieldByName('ID_user').Visible:=false;
     //querylocation.FieldByName('ID_raion').Visible:=false;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='лицензия';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('лиценция', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openTIP_WORK_SB(const select: boolean): integer;
var querylocation, queryV:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     queryV:=tsqlquery.Create(mainF.Owner);
     queryV.ReadOnly:=true;
     QUERYSLOVAR( querylocation,translocation, 'select * from TIP_WORK_SB');
     QUERYSLOVAR( queryV,translocation, 'select * from TIP_WORK_SB order by name');
     //querylocation.FieldByName('ID_user').Visible:=false;
     //querylocation.FieldByName('ID_raion').Visible:=false;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='направление';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //----
     queryV.FieldByName('ID').Visible:=false;
     //queryV.FieldByName('ID').ProviderFlags:=queryV.Fields.Fields[0].ProviderFlags+[pfInKey];
     queryV.Fields.FieldByName('name').DisplayLabel:='направление';
     queryV.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('направление использования', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openNAME_OS(const select: boolean): integer;
var querylocation, queryV:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     queryV:=  tsqlquery.Create(mainF.Owner);
     queryV.ReadOnly:=true;
     QUERYSLOVAR( querylocation,translocation, 'select * from NAME_OS');
     QUERYSLOVAR( queryV,translocation, 'select * from NAME_OS order by name');
     //querylocation.FieldByName('ID_user').Visible:=false;
     //querylocation.FieldByName('ID_raion').Visible:=false;
     queryV.FieldByName('ID').Visible:=false;
     //queryV.FieldByName('ID').ProviderFlags:=queryV.Fields.Fields[0].ProviderFlags+[pfInKey];
     queryV.Fields.FieldByName('name').DisplayLabel:='Операционная система';
     queryV.Fields.FieldByName('name').DisplayWidth:=80;
     //--
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='Операционная система';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('наименование ОС', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openTIP_PROC(const select: boolean): integer;
var querylocation, queryV:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     queryV:=tsqlquery.Create(mainF.Owner);
     queryV.ReadOnly:=true;
     QUERYSLOVAR( querylocation,translocation, 'select * from TIP_PROC');
     QUERYSLOVAR( queryV,translocation, 'select * from TIP_PROC order by name');
     //querylocation.FieldByName('ID_user').Visible:=false;
     //querylocation.FieldByName('ID_raion').Visible:=false;
     queryV.FieldByName('ID').Visible:=false;
     //queryV.FieldByName('ID').ProviderFlags:=queryV.Fields.Fields[0].ProviderFlags+[pfInKey];
     queryV.Fields.FieldByName('name').DisplayLabel:='процессор';
     queryV.Fields.FieldByName('name').DisplayWidth:=80;
     //----
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='процессор';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('тип процессора', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openTIP_MEMORY(const select: boolean): integer;
var querylocation, queryV:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     queryV:=tsqlquery.Create(mainF.Owner);
     queryV.ReadOnly:=true;
     QUERYSLOVAR( querylocation,translocation, 'select * from TIP_MEMORY');
     QUERYSLOVAR( queryV,translocation, 'select * from TIP_MEMORY order by name');
     //querylocation.FieldByName('ID_user').Visible:=false;
     //querylocation.FieldByName('ID_raion').Visible:=false;
     queryV.FieldByName('ID').Visible:=false;
     //queryV.FieldByName('ID').ProviderFlags:=queryV.Fields.Fields[0].ProviderFlags+[pfInKey];
     queryV.Fields.FieldByName('name').DisplayLabel:='тип памяти';
     queryV.Fields.FieldByName('name').DisplayWidth:=80;
     //---
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='тип памяти';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('тип памяти', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

procedure TmainF.openRAIONS;
begin
 FormRaion:=TFormRaion.Create(mainF);
 FormRaion.conn:=self.FconnectorRead;
 FormRaion.ShowModal;
 FormRaion.Free;
end;

function TmainF.openLOCATION(const select: boolean): integer;
var querylocation, querylocationV, queryterr:tsqlquery;
  translocation:tsqltransaction;
  Fld:TField;
  FieldDef: TFieldDef;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     querylocationV:=tsqlquery.Create(mainF.Owner);
     queryterr:=tsqlquery.Create(mainF.Owner);
     querylocationV.ReadOnly:=true;
     //querylocation.ReadOnly:=true;
     //QUERYSLOVAR( querylocationV,translocation, 'select * from GET_LOCATIONS('+inttostr(id_raion)+')');
     QUERYSLOVAR( querylocationV,translocation, 'select * from GET_LOCATIONS('+inttostr(id_raion)+') order by ID_T, name');
     //querylocationV.FieldByName('ID_raion').Visible:=false;
     querylocationV.FieldByName('ID').Visible:=false;
     querylocationV.FieldByName('ID_T').Visible:=false;
     //queryV.FieldByName('ID').ProviderFlags:=queryV.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocationV.Fields.FieldByName('name').DisplayLabel:='название локации';
     querylocationV.Fields.FieldByName('name').DisplayWidth:=80;
     querylocationV.FieldByName('tname').DisplayLabel:='тер. расположение';
     querylocationV.FieldByName('tname').DisplayWidth:=15;
     //---
     {querylocation.FieldByName('ID_user').Visible:=false;
     querylocation.FieldByName('ID_raion').Visible:=false;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='название локации';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;  }

     QUERYSLOVAR( querylocation,translocation, 'select * from LOCATIONS where (id_raion='+inttostr(id_raion)+')');
     QUERYSLOVAR( queryterr,translocation, 'select * from TERRITOR');
     querylocation.Active:=false;
     FieldDef:=querylocation.FieldDefs.Find('name');
     fld:=FieldDef.CreateField(querylocation);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='название локации';
     fld.Name:='name';
     fld.DisplayWidth:=15;

     FieldDef:=querylocation.FieldDefs.Find('ID');
     fld:=FieldDef.CreateField(querylocation);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     fld.Name:='ID';
     fld.ProviderFlags:=fld.ProviderFlags+[pfInKey];

     FieldDef:=querylocation.FieldDefs.Find('ID_territor');
     fld:=FieldDef.CreateField(querylocation);
     fld.Name:='ID_territor';
     //Тут если надо настраиваем fld
     fld.Visible:=false;

     FieldDef:=querylocation.FieldDefs.Find('ID_user');
     fld:=FieldDef.CreateField(querylocation);
     fld.Name:='ID_user';
     //Тут если надо настраиваем fld
     fld.Visible:=false;

     FieldDef:=querylocation.FieldDefs.Find('ID_raion');
     fld:=FieldDef.CreateField(querylocation);
     fld.Name:='ID_raion';
     //Тут если надо настраиваем fld
     fld.Visible:=false;

     //Ниже создаем lookup поле
     fld:=TStringField.Create(querylocation);
     fld.FieldKind:=fkLookup;
     fld.KeyFields:='ID_TERRITOR';
     fld.LookupDataSet:=queryterr;
     fld.LookupKeyFields:='ID';
     fld.LookupResultField:='NAME';
     fld.DataSet:=querylocation;
     fld.DisplayLabel:='тер. расположение';
     fld.ProviderFlags:=[];
     fld.Name:='terr';
     fld.Required:=true;
     fld.FieldName:='terr';
     fld.DisplayWidth:=5;
     querylocation.Active:=true;

     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('локации', translocation, querylocation, querylocationV,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openTERRITOR(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from TERRITOR') then exit;;
    // querylocation.FieldByName('ID_user').Visible:=false;
    // querylocation.FieldByName('ID_raion').Visible:=false;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='тер. расположение';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('территории', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil,select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openMOTIVESTARTWORK(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from COND_START_WORK') then exit;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='усл-я приема на работу';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('условия приема на работу', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openMOTIVESPISMNI(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from MOTIVE_DELETE_MNI order by NAME') then exit;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='основание';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('основания списания МНИ', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openMOTIVESPISRAZNOE(const select: boolean): integer;
 var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from MOTIVE_DEL_RAZNOE order by NAME') then exit;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='основание';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('основания списания РАЗНОЕ', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openMOTIVESPISSB(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from MOTIVE_DEL_SB order by NAME') then exit;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='основание';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('основания списания СИСТЕМНИКА', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil,select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openMOTIVEUVOLNENIE(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from MOTIVE_DISCHARGE order by NAME') then exit;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='основание увольнения';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('основания увольнения', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil,select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openMOTIVEDELKRIPTO(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from MOTIVE_DEL_KRIPTO order by NAME') then exit;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='основание уничтожения криптосредства';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('основание уничтожения криптосредства', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

function TmainF.openKripto(const select: boolean): integer;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     //querylocation.ReadOnly:=true;
     QUERYSLOVAR( querylocation,translocation, 'select * from KRIPTO');
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='криптосредство';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       result:=TDBSlovariTemplateForm.ShowGridSlovari('люди', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil, select);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

procedure TmainF.openTMP_STOP_SW;
var querylocation:tsqlquery;
  translocation:tsqltransaction;
begin
     //connector.Connected:=false;
     translocation:=tsqltransaction.Create(mainF.Owner);
     querylocation:=tsqlquery.Create(mainF.Owner);
     if not QUERYSLOVAR( querylocation,translocation, 'select * from TMP_STOP_SW  order by NAME') then exit;
     querylocation.FieldByName('ID').Visible:=false;
     querylocation.FieldByName('ID').ProviderFlags:=querylocation.Fields.Fields[0].ProviderFlags+[pfInKey];
     querylocation.Fields.FieldByName('name').DisplayLabel:='основание для временного прекращения';
     querylocation.Fields.FieldByName('name').DisplayWidth:=80;
     //Вызываем форму локации
     //false значит выбираем не для выбора
       TDBSlovariTemplateForm.ShowGridSlovari('основания временного прекращения', translocation, querylocation, nil,
       @Zapolnenie, 'GEN_SLOVAR_ID', 'ID', nil,nil);
       querylocation.Active:=false;
       querylocation.Free;
       translocation.Free;
end;

{function TmainF.FileNameToURL(FileName: string): variant;
var
    i: Integer;
//    ch:char;//не работает с кирилицей
//    ch: string;//должно тоже работать с кирилицей.
    ch:tUTF8char;
begin
     Result:='';
      For i:=1 to Length(FileName) do
      Begin
        ch:=copy(FileName, i, 1);//получаем один символ который может занимать
                               //два байта поэтому используем utf8copy
        case ch of
        //Если русский символ, то заменяем шестнадцатиричным значением первого байта и второго,
        //это нужно для перевода пути в URL нотацию
        'а'..'я','А'..'Я':Result:=Result+'%'+IntToHex(Ord(ch[1]), 2)+'%'+IntToHex(Ord(ch[2]), 2);
        '\':result:=result+'/';//для URL нотации
        ':':result:=result+'|';//для URL нотации
        else
               Result:=Result+ch;
        end ;
      End;
      Result:=varastype(Result,varolestr);
end; }

procedure TmainF.ClearToolBar;
var i:integer;
begin
  for i:=0 to ActionList1.ActionCount-1 do
  begin
   (ActionList1.Actions[i] as TAction).Enabled:=false;
   (ActionList1.Actions[i] as TAction).Hint:='';
  end;
  for i:=0 to ActionList2.ActionCount-1 do
  begin
   (ActionList2.Actions[i] as TAction).Enabled:=false;
   (ActionList2.Actions[i] as TAction).Hint:='';
  end;
end;

procedure TmainF.loadPAG(const ID: integer; const namesheet: string;
  conn: TSQLConnector; const ID_RAION: integer; var ID_USER: integer;
  periodb: boolean; const yyyystart: integer; const mmstart: integer;
  const ddstart: integer; const yyyyend: integer; const mmend: integer;
  const ddend: integer);
var tSQL:string;
begin
  //В зависимости от ID(идентификатор) создаем соответсвующий запрос
  case ID of
  0:
    begin
     // tSQL:='select (DATEDIFF(YEAR FROM DTB TO CURRENT_DATE )) AS DDD, TABNOM, ID_PEOPLE, ID, rr, FAM, NAM, OTCH, post, ngroup, loc,'+lineending
      //+'DTB, REGISTRATION, STAJ, SNILS, INN, PHONE_SOTE from VIEW_START_WORK('+inttostr(id_raion)+') where (/*(CURRENT_DATE-DTB)*/4<10)';
      //tSQL:='select (DATEADD(DATEDIFF(YEAR FROM DTB TO CURRENT_DATE ) YEAR TO DTB)) AS DDD, TABNOM, ID_PEOPLE, ID, rr, FAM, NAM, OTCH, post, ngroup, loc,'+lineending
      //+'DTB, REGISTRATION, STAJ, SNILS, INN, PHONE_SOTE from VIEW_START_WORK('+inttostr(id_raion)+') where (/*(CURRENT_DATE-DTB)*/4<10)';
      tSQL:='select /*DISTINCT*/ TABNOM, ID_PEOPLE, ID, rr, FAM, NAM, OTCH, post, ngroup, loc, tname,'+lineending
      +'DTB, REGISTRATION, STAJ, SNILS, INN, PHONE_SOTE, DOP from VIEW_START_WORK('+inttostr(id_raion)+') order by FAM, NAM, OTCH';
      end;
  1:begin
    tSQL:='select DISCHARGE.DT as DTU, START_WORK.ID as ID_SW, MOTIVE_DISCHARGE.NAME,START_WORK.ID_PEOPLE, DISCHARGE.ID as ID, RAIONS.NAME as rr, PEOPLES.FAM as FIO, '+
    'PEOPLES.REGISTRATION, PEOPLES.DTB, PEOPLES.PLB, POSTS.NAME as post, GROUPS.NAME as ngroup '+
    'from DISCHARGE JOIN START_WORK ON (DISCHARGE.ID_START_WORK=START_WORK.ID) join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID) left join groups '+lineending+
  'on (START_WORK.ID_GROUP=GROUPS.ID) join POSTS ON (START_WORK.ID_POST=POSTS.ID) join RAIONS on (START_WORK.ID_RAION=RAIONS.ID) '+
  'join MOTIVE_DISCHARGE ON (DISCHARGE.ID_MOTIVE_DISCHARGE=MOTIVE_DISCHARGE.ID) where (START_WORK.ID_RAION='+
  inttostr(id_raion)+')'+lineending+
  'order by DISCHARGE.DT, ngroup, PEOPLES.FAM, PEOPLES.NAM, PEOPLES.OTCH';
    end;
   2:begin
     tSQL:='select START_WORK.ID as ID_SW, MOTIVE_TMP_STOP_SW.NAME, TMP_STOP_SW.DT_START, TMP_STOP_SW.DT_END,'+
     'ABS(DATEDIFF(DAY, TMP_STOP_SW.DT_START, TMP_STOP_SW.DT_END)) as count_tmp_stop,'+lineending+
     'START_WORK.ID_PEOPLE, TMP_STOP_SW.ID as ID, RAIONS.NAME as rr, PEOPLES.FAM as FIO,'+lineending+
     ' PEOPLES.REGISTRATION, PEOPLES.DTB, PEOPLES.PLB, POSTS.NAME as post, GROUPS.NAME as ngroup'+
     ' '+lineending+
     'from TMP_STOP_SW JOIN START_WORK ON (TMP_STOP_SW.ID_START_WORK=START_WORK.ID) join PEOPLES ON '+lineending+
     '(START_WORK.ID_PEOPLE=PEOPLES.ID) left join groups '+lineending+
  'on (START_WORK.ID_GROUP=GROUPS.ID) join POSTS ON (START_WORK.ID_POST=POSTS.ID) join RAIONS on '+lineending+
  '(START_WORK.ID_RAION=RAIONS.ID) join MOTIVE_TMP_STOP_SW ON '+lineending+
  '(TMP_STOP_SW.ID_MOTIVE_TMP_STOP_SW=MOTIVE_TMP_STOP_SW.ID) where ((START_WORK.ID_RAION='+
  inttostr(id_raion)+')/*and(TMP_STOP_SW.DT_END is null)*/)'+lineending+
  'order by TMP_STOP_SW.DT_END, TMP_STOP_SW.DT_START, MOTIVE_TMP_STOP_SW.NAME, ngroup, PEOPLES.FAM, PEOPLES.NAM, PEOPLES.OTCH ';
    end;
   3:begin
      tSQL:='select MNI.DT as dt, MNI.UCHETN as uch, MNI_TIP.NAME as tip, PEOPLES.FAM||'' ''||LEFT(PEOPLES.NAM,1)||''. ''||LEFT(PEOPLES.OTCH,1)||''.'' as fio,'+lineending+
      'TERRITOR.NAME as tname, GROUPS.NAME as group_, PR_RASPR_MNI.NAME as raspr, KEY_.name as keyn, MNI.SERIAL as serial, MNI.id as id,'+lineending+
   'MNI.SSIZE as ssize, MNI_MODEL.NAME as model_, MNI.DOP as mnidop, SB.SERIAL as sNAME, SB.INVENT as iNAME, tP.FAM as FIOSB, MNI.OTKUDA as otkuda'+lineending+
   ' from MNI  join MNI_TIP on (MNI.ID_TIP=MNI_TIP.ID)'+lineending+
   'join PR_RASPR_MNI on (MNI.ID_PR_RASPR=PR_RASPR_MNI.ID) join START_WORK on'+lineending+
   '(START_WORK.ID=MNI.ID_START_WORK) join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID) '+lineending+
   'join KEY_ on (KEY_.ID=MNI.ID_KEY) join LOCATIONS on (LOCATIONS.ID=START_WORK.ID_LOCATION)'+lineending+
   'join TERRITOR on (TERRITOR.ID=LOCATIONS.ID_TERRITOR)'+lineending+
   'left join GROUPS on (GROUPS.ID=START_WORK.ID_GROUP) '+lineending+
   'left join MNI_MODEL on (MNI.ID_MODEL=MNI_MODEL.ID)'+lineending+
   'left join SB on (MNI.ID_SB=SB.ID) '+lineending+
   'left join START_WORK as tSW on (tSW.ID=SB.ID_START_WORK)'+lineending+
   'left join PEOPLES as tP on (tP.ID=tSW.ID_PEOPLE)'+lineending+
   'where (MNI.ID_RAION='+inttostr(id_raion)+')and'+lineending+
   '(MNI.HIDE=0)'+lineending+
   ''+lineending+
   ''+lineending+
   ''+lineending+
   {'where (MNI.ID_RAION='+inttostr(id_raion)+')and'+lineending+
   '(not exists(select ID from DELETE_MNI where DELETE_MNI.ID_MNI=MNI.ID'+lineending+
   'union all'+lineending+
   'select ID from DISCHARGE where DISCHARGE.ID_START_WORK=START_WORK.ID'+lineending+
   '))'+lineending+}
  'order by MNI.DT, MNI.UCHETN';
    end;
   4:begin
       tSQL:='select MNI.ID as ID_MNI, DELETE_MNI.ID as ID, DELETE_MNI.DT, MNI.UCHETN, MNI_TIP.NAME as tNAME, PEOPLES.FAM as FIO, MOTIVE_DELETE_MNI.NAME,'+lineending+
       'MNI.SERIAL, MNI.SSIZE from DELETE_MNI JOIN MNI ON'+lineending+
   ' (DELETE_MNI.ID_MNI=MNI.ID) join MOTIVE_DELETE_MNI ON(MOTIVE_DELETE_MNI.ID=DELETE_MNI.ID_MOTIVE_DELETE_MNI)'+lineending+
  'join MNI_TIP on (MNI_TIP.ID=MNI.ID_TIP) join START_WORK on (START_WORK.ID=MNI.ID_START_WORK) join PEOPLES'+lineending+
  'on (PEOPLES.ID=START_WORK.ID_PEOPLE) where (MNI.ID_RAION='+inttostr(id_raion)+')'+lineending+
  'order by DELETE_MNI.DT, MNI.UCHETN';
    end;
   5:begin
       tSQL:='/*select ID,DT,NAME,DT_START,DT_END,FIO,DOP, sum(ISP) as ISP from '+lineending+
       '(*/select SERTIFIKATS.ID as ID, SERTIFIKATS.DT, SERTIFIKATS.NAME, SERTIFIKATS.DT_START,SERTIFIKATS.DT_END,'+lineending+
   'PEOPLES.FAM||'' ''||left(PEOPLES.NAM,1)||''. ''||left(PEOPLES.OTCH,1)||''.'' as FIO, SERTIFIKATS.DOP as DOP,'+lineending+
   '/*case when not (COPY_KRIPTO.ID is NULL) then 1 else 0 end as ISP*/'+lineending+
   '/*case when not (COPY_KRIPTO.ID is NULL) then '''' else ''НЕ ИСПОЛЬЗУЕТСЯ'' end as ISP*/'+lineending+
   'case when sum(case when (not (COPY_KRIPTO.ID is NULL))and(DELETE_KRIPTO.ID is NULL) then 1 else 0 end)>0 then '''' else ''НЕ ИСПОЛЬЗУЕТСЯ'' end as ISP'+lineending+
   ' from SERTIFIKATS join START_WORK on (SERTIFIKATS.ID_START_WORK=START_WORK.ID)  '+lineending+
   'join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
   'left join COPY_KRIPTO on (COPY_KRIPTO.ID_SERTIFIKATS=SERTIFIKATS.ID)'+lineending+
   'left join DELETE_KRIPTO on (DELETE_KRIPTO.ID_KRIPTO=COPY_KRIPTO.ID)'+lineending+
   ' where (SERTIFIKATS.DT_END>=CURRENT_DATE)and'+lineending+
   '(SERTIFIKATS.HIDE=0)and(SERTIFIKATS.ID_RAION='+inttostr(id_raion)+')'+lineending+
   ''+lineending+
   ''+lineending+
   ''+lineending+
   ''+lineending+
   ''+lineending+
   ''+lineending+
   'group by ID,DT,NAME, DT_START,DT_END,FIO,DOP'+lineending+
  'order by ISP, DT_END, NAME, FIO/*)'+lineending+
  'group by ID,DT,NAME, DT_START,DT_END,FIO,DOP*/'+lineending+
  '';
    end;
   6:begin
          tSQL:='select MOVE_MNI.ID as ID, MOVE_MNI.DTR AS M_M_DT, MOVE_MNI.ID_MNI as ID_MNI,MNI.UCHETN as UCHETN, MNI_TIP.NAME as tNAME, '+
       'PEOPLES.FAM as FIO, SB.SERIAL as mSB, KEY_.NAME AS KEYN,PR_RASPR_MNI.NAME AS PR_R_M, ''ДЕЙСТВУЕТ'' as dop_pole '+
       'from MOVE_MNI join MNI on (MOVE_MNI.ID_MNI=mni.ID)  '+lineending+
       'join START_WORK on (MOVE_MNI.ID_START_WORK=START_WORK.ID) join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
       'join KEY_ on (KEY_.ID=MOVE_MNI.ID_KEY)'+lineending+
       'join PR_RASPR_MNI on (MOVE_MNI.ID_PR_RASPR=PR_RASPR_MNI.ID)'+lineending+
       'join MNI_TIP on (MNI_TIP.ID=MNI.ID_TIP)'+lineending+
       'left join SB on(SB.ID=MOVE_MNI.ID_SB)'+lineending+
       'WHERE (MNI.ID_RAION='+inttostr(id_raion)+')'+
       'order by MNI.HIDE,M_M_DT DESC';

       {tSQL:='select * from (select * from ('+lineending+
       'select 0 as pr_sort, MOVE_MNI.ID as ID, MOVE_MNI.DTR AS M_M_DT, MOVE_MNI.ID_MNI as ID_MNI,MNI.UCHETN as UCHETN, MNI_TIP.NAME as tNAME, '+
       'PEOPLES.FAM as FIO, SB.SERIAL as mSB, KEY_.NAME AS KEYN,PR_RASPR_MNI.NAME AS PR_R_M, ''ДЕЙСТВУЕТ'' as dop_pole '+
       'from MOVE_MNI join MNI on (MOVE_MNI.ID_MNI=mni.ID)  '+lineending+
   'join START_WORK on (MOVE_MNI.ID_START_WORK=START_WORK.ID) join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
   'join KEY_ on (KEY_.ID=MOVE_MNI.ID_KEY)'+lineending+
   'join PR_RASPR_MNI on (MOVE_MNI.ID_PR_RASPR=PR_RASPR_MNI.ID)'+lineending+
   'join MNI_TIP on (MNI_TIP.ID=MNI.ID_TIP)'+lineending+
   'left join SB on(SB.ID=MOVE_MNI.ID_SB)'+lineending+
   'where (NOT exists(select ID from DELETE_MNI where (DELETE_MNI.ID_MNI=MOVE_MNI.ID_MNI)))'+lineending+
  '/*order by M_M_DT*/'+lineending+
  'union all'+lineending+
  'select 1 as pr_sort, MOVE_MNI.ID as ID, MOVE_MNI.DTR AS M_M_DT, MOVE_MNI.ID_MNI as ID_MNI, MNI.UCHETN as UCHETN, '+
  'MNI_TIP.NAME as tNAME, PEOPLES.FAM as FIO, SB.SERIAL as mSB, KEY_.NAME AS KEYN,PR_RASPR_MNI.NAME AS PR_R_M, ''СПИСАН'' as dop_pole '+
  'from MOVE_MNI join MNI on (MOVE_MNI.ID_MNI=mni.ID)  '+lineending+
   'join START_WORK on (MOVE_MNI.ID_START_WORK=START_WORK.ID) join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
   'join KEY_ on (KEY_.ID=MOVE_MNI.ID_KEY)'+lineending+
   'join PR_RASPR_MNI on (MOVE_MNI.ID_PR_RASPR=PR_RASPR_MNI.ID)'+lineending+
   'join MNI_TIP on (MNI_TIP.ID=MNI.ID_TIP)'+lineending+
   'left join SB on(SB.ID=MOVE_MNI.ID_SB)'+lineending+
  'where (exists(select ID from DELETE_MNI where (DELETE_MNI.ID_MNI=MOVE_MNI.ID_MNI)))'+lineending+
  ') as t1'+lineending+
  'order by t1.pr_sort) as t2'+lineending+
  'order by t2.M_M_DT DESC'+lineending+
  ''+lineending;}
    end;
   7:begin
       tSQL:='select COPY_KRIPTO.ID as ID, COPY_KRIPTO.DT as DT, KRIPTO.NAME as NAME, COPY_KRIPTO.SERIAL as SR, COPY_KRIPTO.NUMBER_COPY as NC, SERTIFIKATS.NAME as SERT, COPY_KRIPTO.OTKUDA,'+lineending+
       'PEOPLES.FAM||'' ''||LEFT(PEOPLES.NAM,1)||''. ''||LEFT(PEOPLES.OTCH,1)||''.'' AS FIO,LOCATIONS.NAME as lNAME,SB.SERIAL as sbSERIAL,SB.STIKER as STIKER, COPY_KRIPTO.DOP as DOP,'+lineending+
       'case when (not (COPY_KRIPTO.ID_SERTIFIKATS is null))and((SERTIFIKATS.DT_END<current_date)or(SERTIFIKATS.HIDE=1)) then 1 else 0 end as pr_bad'+lineending+
       ', MNI.UCHETN as mUCH   from COPY_KRIPTO join KRIPTO on (COPY_KRIPTO.ID_KRIPTO=KRIPTO.ID)  '+lineending+
   'join START_WORK on (COPY_KRIPTO.ID_START_WORK=START_WORK.ID) join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
   'join SB on (COPY_KRIPTO.ID_SB=SB.ID)'+lineending+
   'join LOCATIONS on (SB.ID_LOCATION=LOCATIONS.ID)'+lineending+
   'left join SERTIFIKATS on (SERTIFIKATS.ID=COPY_KRIPTO.ID_SERTIFIKATS)'+lineending+
   'left join MNI on (MNI.ID=COPY_KRIPTO.ID_MNI)'+lineending+
   ''+lineending+
   'where (COPY_KRIPTO.HIDE=0)and(COPY_KRIPTO.ID_RAION='+inttostr(id_raion)+')'+lineending+
   ''+lineending+
   ''+lineending+
   ''+lineending+
  'order by DT DESC';
    end;
   8:begin
      tSQL:='select IPADDRESS as IP, SB.ID as ID, SB.DT as DT, SB.SERIAL, SB.INVENT, PEOPLES.FAM||'' ''||LEFT(PEOPLES.NAM,1)||''. ''||LEFT(PEOPLES.OTCH,1)||''.'' as FIO,'+lineending+
      ' PR_RASPR_SB.NAME as P_R_S,'+lineending+
   'TIP_WORK_SB.NAME as wNAME, SB.OTKUDA, NAME_SB.NAME as sbNAME, GROUPS.NAME as gNAME, TIP_PROC.NAME as namePR, SB.CPU_MHZ, SB.COUNT_IADRA, LOCATIONS.NAME as LOC, '+lineending+
   'TERRITOR.NAME as TNAME, SB.STIKER, SB.SIZE_MEMORY_MB as SMM, SB.DOP as DOP, NAME_OS.NAME as OS_NAME from SB  join NAME_SB on (SB.ID_NAME_SB=NAME_SB.ID)'+lineending+
   'join PR_RASPR_SB on (SB.ID_PR_RASPR=PR_RASPR_SB.ID)'+lineending+
   'join LOCATIONS on (LOCATIONS.ID=SB.ID_LOCATION) join TERRITOR on (TERRITOR.ID=LOCATIONS.ID_TERRITOR)'+lineending+
   ' join START_WORK on (START_WORK.ID=SB.ID_START_WORK) join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID) left join GROUPS'+lineending+
   'on (GROUPS.ID=START_WORK.ID_GROUP) join TIP_WORK_SB on (TIP_WORK_SB.ID=SB.ID_WORK_SB) '+lineending+
   'left join TIP_PROC on (SB.ID_TIP_PROC=TIP_PROC.ID)'+lineending+
   'left join NAME_OS on (NAME_OS.ID=SB.ID_NAME_OS)'+lineending+
   ''+lineending+
   ' where'+lineending+
   '(SB.ID_RAION='+inttostr(id_raion)+')'+lineending+
   'and(SB.HIDE=0)'+lineending+
   ''+lineending+
   'order by TERRITOR.NAME DESC, P_R_S DESC/*, SB.DT*/, NAME_SB.NAME, (PEOPLES.FAM||'' ''||LEFT(PEOPLES.NAM,1)||''. ''||LEFT(PEOPLES.OTCH,1)||''.'')';
    end;
   9:begin
      tSQL:='select * from ('+lineending+
      'select 0 as nom, COPY_KRIPTO.ID as ID_COPY_KRIPTO, DELETE_KRIPTO.ID as ID, DELETE_KRIPTO.DT, KRIPTO.NAME AS kNAME, '+lineending+
      'COPY_KRIPTO.SERIAL as kSERIAL, COPY_KRIPTO.NUMBER_COPY as NC, PEOPLES.FAM as FIO, MOTIVE_DEL_KRIPTO.NAME,'+lineending+
       'SB.SERIAL as SERIAL from DELETE_KRIPTO JOIN COPY_KRIPTO ON'+lineending+
   ' (DELETE_KRIPTO.ID_KRIPTO=COPY_KRIPTO.ID) join MOTIVE_DEL_KRIPTO ON (MOTIVE_DEL_KRIPTO.ID=DELETE_KRIPTO.ID_MOTIVE_DEL_KR)'+lineending+
  'join KRIPTO on (KRIPTO.ID=COPY_KRIPTO.ID_KRIPTO) join START_WORK on (START_WORK.ID=COPY_KRIPTO.ID_START_WORK) join PEOPLES'+lineending+
  'on (PEOPLES.ID=START_WORK.ID_PEOPLE) '+lineending+
  'join SB on (COPY_KRIPTO.ID_SB=SB.ID)'+lineending+
  'join LOCATIONS on (LOCATIONS.ID=SB.ID_LOCATION)'+lineending+
  'left join MNI on (COPY_KRIPTO.ID_MNI=MNI.ID)'+lineending+
  'where (COPY_KRIPTO.ID_RAION='+inttostr(id_raion)+')'+lineending+
  ''+lineending+
  ''+lineending+
  'union all'+lineending+
  'select 1 as nom, MNI.ID as ID_COPY_KRIPTO, DELETE_MNI.ID as ID, DELETE_MNI.DT, MNI_TIP.NAME as kNAME, MNI.UCHETN as kSERIAL, '''' as NC, PEOPLES.FAM as FIO, MOTIVE_DELETE_MNI.NAME, '+lineending+
  'SB.SERIAL as SERIAL'+lineending+
  'from DELETE_MNI join MNI on (DELETE_MNI.ID_MNI=MNI.ID) join MNI_TIP on (MNI.ID_TIP=MNI_TIP.ID)'+lineending+
  'join START_WORK on (MNI.ID_START_WORK=START_WORK.ID)'+lineending+
  'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
  'join MOTIVE_DELETE_MNI on (MOTIVE_DELETE_MNI.ID=DELETE_MNI.ID_MOTIVE_DELETE_MNI)'+lineending+
  'join KEY_ on (MNI.ID_KEY=KEY_.ID)'+lineending+
  'left join SB on (MNI.ID_SB=SB.ID)'+lineending+
  'where (KEY_.NAME starting with ''КЛЮЧ'')and(MNI.ID_RAION='+inttostr(id_raion)+')'+lineending+
  ')'+lineending+
  'order by nom, DT DESC, SERIAL';
    end;
   10:begin
      tSQL:='select t1.nom, t1.ID, t1.FIO, t1.kNAME, t1.kSERIAL, t1.sbSERIAL from ('+lineending+
      'select 1 as nom, START_WORK.ID as ID, PEOPLES.FAM||'' ''||PEOPLES.NAM||'' ''||PEOPLES.OTCH as FIO, MNI_TIP.NAME as kNAME, MNI.UCHETN as kSERIAL, SB.SERIAL as sbSERIAL'+lineending+
      'from START_WORK'+lineending+
      'join MNI on (MNI.ID_START_WORK=START_WORK.ID)'+lineending+
      'join MNI_TIP on (MNI.ID_TIP=MNI_TIP.ID)'+lineending+
      'join KEY_ on (MNI.ID_KEY=KEY_.ID)'+lineending+
      'join PR_RASPR_MNI on (PR_RASPR_MNI.ID=MNI.ID_PR_RASPR)'+lineending+
      'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
      'left join SB on (MNI.ID_SB=SB.ID)'+lineending+
      ''+lineending+
      'where ((KEY_.NAME starting with ''КЛЮЧ'')and(PR_RASPR_MNI.NAME starting with ''РАСПРЕ'')and'+lineending+
      '(MNI.HIDE=0)and(START_WORK.ID_RAION='+inttostr(id_raion)+'))'+lineending+
      'union all'+lineending+
      'select 0 as nom, START_WORK.ID as ID, PEOPLES.FAM||'' ''||PEOPLES.NAM||'' ''||PEOPLES.OTCH as FIO, KRIPTO.NAME as kNAME, '+
      'COPY_KRIPTO.SERIAL||''; ''||COPY_KRIPTO.NUMBER_COPY as kSERIAL, SB.SERIAL as sbSERIAL '+lineending+
      'from START_WORK'+lineending+
  'join COPY_KRIPTO on (COPY_KRIPTO.ID_START_WORK=START_WORK.ID)'+lineending+
  'join KRIPTO on (COPY_KRIPTO.ID_KRIPTO=KRIPTO.ID)'+lineending+
  'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
  'join SB on (COPY_KRIPTO.ID_SB=SB.ID)'+lineending+
  ''+lineending+
  ''+lineending+
  'where (COPY_KRIPTO.HIDE=0)and(START_WORK.ID_RAION='+inttostr(id_raion)+')'+lineending+
  ''+lineending+
  ') as t1'+lineending+
  'order by FIO, nom, kNAME'+lineending+
  ''+lineending+
  '';
    end;
   11:begin
      tSQL:='select t1.ID, t1.FIO, count(t1.FIO)as kcount from ('+lineending+
      'select 1 as nom, START_WORK.ID as ID, PEOPLES.FAM||'' ''||PEOPLES.NAM||'' ''||PEOPLES.OTCH as FIO, MNI_TIP.NAME as kNAME, MNI.UCHETN as kSERIAL, SB.SERIAL as sbSERIAL'+lineending+
      'from START_WORK'+lineending+
      'join MNI on (MNI.ID_START_WORK=START_WORK.ID)'+lineending+
      'join MNI_TIP on (MNI.ID_TIP=MNI_TIP.ID)'+lineending+
      'join KEY_ on (MNI.ID_KEY=KEY_.ID)'+lineending+
      'join PR_RASPR_MNI on (PR_RASPR_MNI.ID=MNI.ID_PR_RASPR)'+lineending+
      'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
      'left join SB on (MNI.ID_SB=SB.ID)'+lineending+
      ''+lineending+
      'where ((KEY_.NAME starting with ''КЛЮЧ'')and(PR_RASPR_MNI.NAME starting with ''РАСПРЕ'')and'+lineending+
      '(MNI.HIDE=0)and(START_WORK.ID_RAION='+inttostr(id_raion)+'))'+lineending+
      'union all'+lineending+
      'select 0 as nom, START_WORK.ID as ID, PEOPLES.FAM||'' ''||PEOPLES.NAM||'' ''||PEOPLES.OTCH as FIO, KRIPTO.NAME as kNAME, COPY_KRIPTO.SERIAL||''; ''||COPY_KRIPTO.NUMBER_COPY as kSERIAL, SB.SERIAL as sbSERIAL '+lineending+
      'from START_WORK'+lineending+
  'join COPY_KRIPTO on (COPY_KRIPTO.ID_START_WORK=START_WORK.ID)'+lineending+
  'join KRIPTO on (COPY_KRIPTO.ID_KRIPTO=KRIPTO.ID)'+lineending+
  'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
  'join SB on (COPY_KRIPTO.ID_SB=SB.ID)'+lineending+
  ''+lineending+
  ''+lineending+
  'where (COPY_KRIPTO.HIDE=0)and(START_WORK.ID_RAION='+inttostr(id_raion)+')'+lineending+
  ''+lineending+
  ') as t1'+lineending+
  'group by ID, FIO'+lineending+
  'order by FIO'+lineending+
  '';
    end;
   12:begin
      tSQL:=''+lineending+
      'select START_WORK.ID as ID, PEOPLES.FAM||'' ''||PEOPLES.NAM||'' ''||PEOPLES.OTCH as FIO, MNI_TIP.NAME as tNAME, MNI.UCHETN as UCHETN, SB.SERIAL as sbSERIAL'+lineending+
      'from START_WORK'+lineending+
      'join MNI on (MNI.ID_START_WORK=START_WORK.ID)'+lineending+
      'join MNI_TIP on (MNI.ID_TIP=MNI_TIP.ID)'+lineending+
      'join KEY_ on (MNI.ID_KEY=KEY_.ID)'+lineending+
      'join PR_RASPR_MNI on (PR_RASPR_MNI.ID=MNI.ID_PR_RASPR)'+lineending+
      'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
      'left join SB on (MNI.ID_SB=SB.ID)'+lineending+
      ''+lineending+
      'where (MNI.HIDE=0)and(START_WORK.ID_RAION='+inttostr(id_raion)+')'+lineending+
      'order by (PEOPLES.FAM||'' ''||PEOPLES.NAM||'' ''||PEOPLES.OTCH), tNAME, UCHETN'+lineending+
  ''+lineending+
  '';
    end;
   13:begin
      tSQL:= 'select PEOPLES.FAM as FIO, count(START_WORK.ID) as mnicount'+lineending+
      'from START_WORK'+lineending+
      'join MNI on (MNI.ID_START_WORK=START_WORK.ID)'+lineending+
      'join KEY_ on (MNI.ID_KEY=KEY_.ID)'+lineending+
      'join PR_RASPR_MNI on (PR_RASPR_MNI.ID=MNI.ID_PR_RASPR)'+lineending+
      'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
      'left join SB on (MNI.ID_SB=SB.ID)'+lineending+
      ''+lineending+
      'where (MNI.HIDE=0)and(START_WORK.ID_RAION='+inttostr(id_raion)+')'+lineending+
      'group by FIO'+lineending+
      'order by FIO'+lineending+
  '';
    end;
   14:begin
      tSQL:='select * from ('+lineending+
      'select 0 as nom, COPY_KRIPTO.ID as ID, COPY_KRIPTO.DT, KRIPTO.NAME AS kNAME, COPY_KRIPTO.SERIAL as kSERIAL,  PEOPLES.FAM as FIO,'+lineending+
       'SB.SERIAL as SERIAL from COPY_KRIPTO '+lineending+
   ''+lineending+
  'join KRIPTO on (KRIPTO.ID=COPY_KRIPTO.ID_KRIPTO) join START_WORK on (START_WORK.ID=COPY_KRIPTO.ID_START_WORK) join PEOPLES'+lineending+
  'on (PEOPLES.ID=START_WORK.ID_PEOPLE) '+lineending+
  'join SB on (COPY_KRIPTO.ID_SB=SB.ID)'+lineending+
  'join LOCATIONS on (LOCATIONS.ID=SB.ID_LOCATION)'+lineending+
  'left join MNI on (COPY_KRIPTO.ID_MNI=MNI.ID)'+lineending+
  'where ((COPY_KRIPTO.ID_RAION='+inttostr(id_raion)+')and'+lineending+
  '(COPY_KRIPTO.HIDE=0))'+lineending+
  ''+lineending+
  'union all'+lineending+
  'select 1 as nom, MNI.ID as ID, MNI.DT, MNI_TIP.NAME as kNAME, MNI.UCHETN as kSERIAL, PEOPLES.FAM as FIO, '+lineending+
  'SB.SERIAL as SERIAL'+lineending+
  'from MNI join MNI_TIP on (MNI.ID_TIP=MNI_TIP.ID)'+lineending+
  'join START_WORK on (MNI.ID_START_WORK=START_WORK.ID)'+lineending+
  'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
  ''+lineending+
  'join KEY_ on (MNI.ID_KEY=KEY_.ID)'+lineending+
  'join PR_RASPR_MNI on (PR_RASPR_MNI.ID=MNI.ID_PR_RASPR)'+lineending+
  'left join SB on (MNI.ID_SB=SB.ID)'+lineending+
  'where ((MNI.ID_RAION='+inttostr(id_raion)+')and(KEY_.NAME starting with ''КЛЮЧ'')and'+lineending+
  '(MNI.HIDE=0)and'+lineending+
  '(PR_RASPR_MNI.NAME starting with ''РАСПР''))'+lineending+
  ')order by nom, DT, SERIAL';
    end;
   15:begin
       tSQL:='select * from (select * from ('+lineending+
       'select 0 as pr_sort, MOVE_EMPL.ID as ID, MOVE_EMPL.DTR AS M_E_DT, PEOPLES.FAM as FIO, POSTS.NAME as pNAME, GROUPS.NAME as gNAME, '+
       'LOCATIONS.NAME AS lNAME, ''РАБОТАЕТ'' as dop_pole from MOVE_EMPL join START_WORK on (MOVE_EMPL.ID_START_WORK=START_WORK.ID)  '+lineending+
       'join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
       'join LOCATIONS on (LOCATIONS.ID=MOVE_EMPL.ID_LOCATION)'+lineending+
       'join POSTS on (POSTS.ID=START_WORK.ID_POST)'+lineending+
       'left join GROUPS on (GROUPS.ID=START_WORK.ID_GROUP)'+lineending+
       ''+lineending+
       'where (START_WORK.ID_RAION='+inttostr(id_raion)+')and(START_WORK.HIDE=0)'+lineending+
       ''+lineending+
       'union all'+lineending+
       'select 1 as pr_sort, MOVE_EMPL.ID as ID, MOVE_EMPL.DTR AS M_E_DT, PEOPLES.FAM as FIO, POSTS.NAME as pNAME, GROUPS.NAME as gNAME, '+
       'LOCATIONS.NAME AS lNAME, MOTIVE_TMP_STOP_SW.NAME as dop_pole from MOVE_EMPL join START_WORK on (MOVE_EMPL.ID_START_WORK=START_WORK.ID)  '+lineending+
       'join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
       'join LOCATIONS on (LOCATIONS.ID=MOVE_EMPL.ID_LOCATION)'+lineending+
       'join POSTS on (POSTS.ID=START_WORK.ID_POST)'+lineending+
       'join TMP_STOP_SW on (TMP_STOP_SW.ID_START_WORK=MOVE_EMPL.ID_START_WORK)'+lineending+
       'join MOTIVE_TMP_STOP_SW on (TMP_STOP_SW.ID_MOTIVE_TMP_STOP_SW=MOTIVE_TMP_STOP_SW.ID)'+lineending+
       'left join GROUPS on (GROUPS.ID=START_WORK.ID_GROUP)'+lineending+
       ''+lineending+
       'where (START_WORK.ID_RAION='+inttostr(id_raion)+')and(START_WORK.HIDE=0)'+lineending+
       'union all'+lineending+
       'select 2 as pr_sort, MOVE_EMPL.ID as ID, MOVE_EMPL.DTR AS M_E_DT, PEOPLES.FAM as FIO, POSTS.NAME as pNAME, GROUPS.NAME as gNAME, '+
       'LOCATIONS.NAME AS lNAME, ''УВОЛЕН ''||MOTIVE_DISCHARGE.NAME as dop_pole from MOVE_EMPL join START_WORK on (MOVE_EMPL.ID_START_WORK=START_WORK.ID)  '+lineending+
       'join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
       'join LOCATIONS on (LOCATIONS.ID=MOVE_EMPL.ID_LOCATION)'+lineending+
       'join POSTS on (POSTS.ID=START_WORK.ID_POST)'+lineending+
       'join DISCHARGE on (DISCHARGE.ID_START_WORK=MOVE_EMPL.ID_START_WORK)'+lineending+
       'join MOTIVE_DISCHARGE on (DISCHARGE.ID_MOTIVE_DISCHARGE=MOTIVE_DISCHARGE.ID)'+lineending+
       'left join GROUPS on (GROUPS.ID=START_WORK.ID_GROUP)'+lineending+
       'where (START_WORK.ID_RAION='+inttostr(id_raion)+')and(START_WORK.HIDE=0)'+lineending+
       ''+lineending+
       ') as t1'+lineending+
       'order by t1.pr_sort) as t2 order by  t2.M_E_DT DESC'+lineending+
       ''+lineending;
   end;
   16:begin
       tSQL:=''+lineending+
       'select 0 as pr_sort, MOVE_SB.ID as ID, MOVE_SB.DTR AS M_S_DT, MOVE_SB.ID_SB as ID_SB,'+lineending
       + 'SB.SERIAL as SERIAL, SB.INVENT as INVENT, PEOPLES.FAM as FIO,'+lineending
       + 'PR_RASPR_SB.NAME AS prNAME, NAME_OS.NAME AS osNAME, TIP_WORK_SB.NAME AS wNAME, LOCATIONS.NAME as lNAME,'+lineending
       +'MOVE_SB.STIKER AS STIKER, ''РАБОТАЕТ'' as dop_pole from MOVE_SB'+lineending+
       'join SB on (SB.ID=MOVE_SB.ID_SB)'+lineending+
       'join START_WORK on (MOVE_SB.ID_START_WORK=START_WORK.ID)  '+lineending+
       'join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
       'join LOCATIONS ON (MOVE_SB.ID_LOCATION=LOCATIONS.ID)'+lineending+
       ''+lineending+
       'join PR_RASPR_SB on (PR_RASPR_SB.ID=MOVE_SB.ID_PR_RASPR)'+lineending+
       'join TIP_WORK_SB on (TIP_WORK_SB.ID=MOVE_SB.ID_WORK_SB)'+lineending+
       'left join NAME_OS on (NAME_OS.ID=MOVE_SB.ID_NAME_OS)'+lineending+
       'where (SB.ID_RAION='+inttostr(id_raion)+')and(SB.HIDE=0)'+lineending+
       ' order by M_S_DT DESC'+lineending+
       ''+lineending;
   end;
   17:begin
      tSQL:='select Raznoe.DT as dt,  Raznoe_TIP.NAME as tip, PEOPLES.FAM as fio, GROUPS.NAME as group_, '+lineending+
      'PR_RASPR_Raznoe.NAME as raspr, Raznoe.SERIAL as serial, Raznoe.id as id,'+lineending+
   ' Raznoe_MODEL.NAME as model_, SB.SERIAL as sNAME, tP.FAM as FIOR, Raznoe.OTKUDA as otkuda,'+lineending+
   'RAZNOE.INVENT as INVENT, LOCATIONS.NAME as LOC, TERRITOR.NAME as TNAME, Raznoe.DOP as DOP from Raznoe  join Raznoe_TIP on (Raznoe.ID_TIP=Raznoe_TIP.ID)'+lineending+
   'join PR_RASPR_Raznoe on (Raznoe.ID_PR_RASPR=PR_RASPR_Raznoe.ID) join START_WORK on'+lineending+
   '(START_WORK.ID=Raznoe.ID_START_WORK) join LOCATIONS on (LOCATIONS.ID=Raznoe.ID_LOCATION) join TERRITOR on (TERRITOR.ID=LOCATIONS.ID_TERRITOR) '+
   'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID) left join GROUPS'+lineending+
   'on (GROUPS.ID=START_WORK.ID_GROUP) left join Raznoe_MODEL on (Raznoe.ID_MODEL=Raznoe_MODEL.ID)'+lineending+
   'left join SB on (Raznoe.ID_SB=SB.ID) '+lineending+
   'left join START_WORK as tSW on (tSW.ID=SB.ID_START_WORK)'+lineending+
   'left join PEOPLES as tP on (tP.ID=tSW.ID_PEOPLE)'+lineending+
   'where (Raznoe.ID_RAION='+inttostr(id_raion)+')and'+lineending+
   '(Raznoe.HIDE=0)'+lineending+
  'order by TNAME DESC, raspr DESC, Raznoe.DT';
    end;
   18: tSQL:='select RASHODNIK_ID, RASHODNIK_NAME_ID, RASHODNIK_NAME, RASHODNIK_COUNT from VIEW_RASHODNIK_NAL where (ID_RAION='+inttostr(id_raion)+') order by rashodnik_name';
   19:
     begin
        periodb:=(yyyystart=0)or(mmstart=0)or(ddstart=0)or
         (yyyyend=0)or(mmend=0)or(ddend=0);
        if not periodb then
         tSQL:='select ID, FIO_R, TIP_R, NAME_R, NAME_TRZN, NAME_RZN, CNT, DT_R from get_ST_RASHOD(1,'''+inttostr(yyyystart)+'-'+inttostr(mmstart)+'-'+inttostr(ddstart)+''','''+
            inttostr(yyyyend)+'-'+inttostr(mmend)+'-'+inttostr(ddend)+''', '+inttostr(ID_RAION)+') order by DT_R, FIO_R'
        else
        tSQL:='select ID, FIO_R, TIP_R, NAME_R, NAME_TRZN, NAME_RZN, CNT, DT_R from get_ST_RASHOD(0,'''','''', '+inttostr(ID_RAION)+') order by DT_R, FIO_R';
     end;
   20:
     begin
         periodb:=(yyyystart=0)or(mmstart=0)or(ddstart=0)or
         (yyyyend=0)or(mmend=0)or(ddend=0);
        if not periodb then
           tSQL:='select ID, FIO_R, TIP_R, NAME_R, CNT from get_ST_RASHOD(1,'''+inttostr(yyyystart)+'-'+inttostr(mmstart)+'-'+inttostr(ddstart)+''','''+
            inttostr(yyyyend)+'-'+inttostr(mmend)+'-'+inttostr(ddend)+''', '+inttostr(ID_RAION)+')/* group by FIO_R, TIP_R, NAME_R */order by NAME_R, FIO_R'
        else
            tSQL:='select ID, FIO_R, TIP_R, NAME_R, count(CNT) as CNT from get_ST_RASHOD(0,'''','''', '+inttostr(ID_RAION)+')  group by ID, FIO_R, TIP_R, NAME_R  order by NAME_R, FIO_R';
     end;
   21:begin
       tSQL:=''+lineending
       +'select MOVE_RAZNOE.ID as ID, RAZNOE.ID as RID, MOVE_RAZNOE.DTR AS M_R_DT, RAZNOE_TIP.NAME as tip, MOVE_RAZNOE.ID_RAZNOE as ID_RAZNOE,'+lineending
       + 'RAZNOE.SERIAL as SERIAL, RAZNOE.INVENT as INVENT, PEOPLES.FAM as FIO,'+lineending
       + 'PR_RASPR_RAZNOE.NAME AS prNAME '+lineending
       +' from MOVE_RAZNOE'+lineending+
       'join RAZNOE on (RAZNOE.ID=MOVE_RAZNOE.ID_RAZNOE)'+lineending+
       'join RAZNOE_TIP on (RAZNOE.ID_TIP=RAZNOE_TIP.ID)'+lineending+
       'join START_WORK on (MOVE_RAZNOE.ID_START_WORK=START_WORK.ID)  '+lineending+
       'join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
       ''+lineending+
       'join PR_RASPR_RAZNOE on (PR_RASPR_RAZNOE.ID=MOVE_RAZNOE.ID_PR_RASPR)'+lineending+
       ''+lineending+
       'where (RAZNOE.HIDE=0)'+lineending+
       ''+lineending+
       ''+lineending+
       'order by M_R_DT DESC, SERIAL, INVENT'+lineending+
       ''+lineending;
   end;
   22:begin
       tSQL:='select RAZNOE.ID as ID_RAZNOE, DELETE_RAZNOE.ID as ID, DELETE_RAZNOE.DT, RAZNOE.INVENT, RAZNOE_TIP.NAME as tNAME, PEOPLES.FAM as FIO, MOTIVE_DEL_RAZNOE.NAME,'+lineending+
       'RAZNOE.SERIAL, RAZNOE_MODEL.NAME as mNAME from DELETE_RAZNOE JOIN RAZNOE ON'+lineending+
   ' (DELETE_RAZNOE.ID_RAZNOE=RAZNOE.ID) join MOTIVE_DEL_RAZNOE ON(MOTIVE_DEL_RAZNOE.ID=DELETE_RAZNOE.ID_MOTIVE_DELETE_RAZNOE)'+lineending+
  'join RAZNOE_TIP on (RAZNOE_TIP.ID=RAZNOE.ID_TIP) join RAZNOE_MODEL on (RAZNOE.ID_MODEL=RAZNOE_MODEL.ID) join START_WORK on (START_WORK.ID=RAZNOE.ID_START_WORK) join PEOPLES'+lineending+
  'on (PEOPLES.ID=START_WORK.ID_PEOPLE) where (RAZNOE.ID_RAION='+inttostr(id_raion)+')'+lineending+
  'order by DELETE_RAZNOE.DT';
   end;
   23:
     begin
     tSQL:='select * from '+lineending+
     ''+lineending+
     '(select ''окончание срока'' as pr, SERTIFIKATS.ID as ID, SERTIFIKATS.DT, SERTIFIKATS.NAME, SERTIFIKATS.DT_START,SERTIFIKATS.DT_END,'+lineending+
     'PEOPLES.FAM||'' ''||left(PEOPLES.NAM,1)||''. ''||left(PEOPLES.OTCH,1)||''.'' as FIO, null as dt_otziv from SERTIFIKATS join '+
     'START_WORK on (SERTIFIKATS.ID_START_WORK=START_WORK.ID)  '+lineending+
     'join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID) where (SERTIFIKATS.ID_RAION='+inttostr(id_raion)+')and(SERTIFIKATS.DT_END<CURRENT_DATE)'+lineending+
     ''+lineending+
     'UNION ALL'+lineending+
     'select ''отозванные'' as pr, SERTIFIKATS.ID as ID, SERTIFIKATS.DT, SERTIFIKATS.NAME, SERTIFIKATS.DT_START,SERTIFIKATS.DT_END,'+lineending+
     'PEOPLES.FAM||'' ''||left(PEOPLES.NAM,1)||''. ''||left(PEOPLES.OTCH,1)||''.'' as FIO, STOP_SERTIFIKATS.DT as dt_otziv from STOP_SERTIFIKATS'+lineending+
     'join SERTIFIKATS on (SERTIFIKATS.ID=STOP_SERTIFIKATS.ID_SERTIFIKAT)'+lineending+
     'join START_WORK on (SERTIFIKATS.ID_START_WORK=START_WORK.ID)  '+lineending+
     'join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID) '+lineending+
     'where (SERTIFIKATS.ID_RAION='+inttostr(id_raion)+')'+lineending+
     ')'+lineending+
     ''+lineending+
     'order by pr, DT_END DESC, DT DESC, NAME'+lineending+
     ''+lineending;
     end;
   24:
     begin
     tSQL:='select * from '+lineending+
     ''+lineending+
     '(select COPY_KRIPTO.ID as ID, 0 as pr, ''уcтановка криптосредства'' as aname, COPY_KRIPTO.DT as dta, '+
     'coalesce(COPY_KRIPTO.NUMBER_COPY,'''')||coalesce('' s/n:''||COPY_KRIPTO.SERIAL,'''') as UCHETN,'+lineending+
     'PEOPLES.FAM||'' ''||left(PEOPLES.NAM,1)||''. ''||left(coalesce(PEOPLES.OTCH,'' ''),1)||''.'' as FIO,'+lineending+
     'SERTIFIKATS.name as sert,'+lineending+
     'case when not (DELETE_KRIPTO.DT is NULL) then ''ЗАКРЫТО'' end as PRCLOSE, DELETE_KRIPTO.DT as DTCLOSE '+lineending+
     ' from COPY_KRIPTO join START_WORK on (COPY_KRIPTO.ID_START_WORK=START_WORK.ID)  '+lineending+
     'join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
     'left join DELETE_KRIPTO on (DELETE_KRIPTO.ID_KRIPTO=COPY_KRIPTO.ID)'+lineending+
     'left join SERTIFIKATS on (SERTIFIKATS.ID=COPY_KRIPTO.ID_SERTIFIKATS)'+lineending+
     'where (COPY_KRIPTO.ID_RAION='+inttostr(id_raion)+')'+lineending+
     ''+lineending+
     'UNION ALL'+lineending+
     'select COPY_KRIPTO.ID as ID, 3 as pr, ''удаление криптосредства'' as aname, DELETE_KRIPTO.DT as dta, '+lineending+
     'coalesce(COPY_KRIPTO.NUMBER_COPY,'''')||coalesce('' s/n:''||COPY_KRIPTO.SERIAL,'''') as UCHETN,'+lineending+
     'PEOPLES.FAM||'' ''||left(PEOPLES.NAM,1)||''. ''||left(coalesce(PEOPLES.OTCH,'' ''),1)||''.'' as FIO,'+lineending+
     'SERTIFIKATS.name as sert,'+lineending+
     'case when not (DELETE_KRIPTO.DT is NULL) then ''ЗАКРЫТО'' end as PRCLOSE, DELETE_KRIPTO.DT as DTCLOSE '+lineending+
     ' from DELETE_KRIPTO join COPY_KRIPTO on (DELETE_KRIPTO.ID_KRIPTO=COPY_KRIPTO.ID)'+lineending+
     ' join START_WORK on (COPY_KRIPTO.ID_START_WORK=START_WORK.ID)  '+lineending+
     'join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
     'left join SERTIFIKATS on (SERTIFIKATS.ID=COPY_KRIPTO.ID_SERTIFIKATS)'+lineending+
     'where (COPY_KRIPTO.ID_RAION='+inttostr(id_raion)+')'+lineending+
     ')'+lineending+
      'order by DTA DESC'+lineending+
     ''+lineending;
     end;
    25: tSQL:='select license.ID as ID, lic_po.namepo, license.keypo1, license.keypo2, license.keypo3, '+
    'license.numberl from license join lic_po on (license.id_lic_po=lic_po.id) where (license.ID_RAION='+inttostr(id_raion)+')';
    //26: tSQL:='select DT, name, count_r, fio from get_rashodnik_add(0)';
    27: tSQL:='select DT, name, count_r, fio from get_rashodnik_add(1,'+inttostr(ID_RAION)+')';
    28: tSQL:='select ID, ID_NAME, DT, name, otkuda, count_r, fio, id_raion from VIEW_RASHODNIK_POSTUPILO where (ID_RAION='+inttostr(id_raion)+')'+lineending+
    'order by DT DESC';
    //29: tSQL:='select id,sname,fio,dts,dti,kname,sn_sb,inv,stiker,namesb,loc from get_sert_sb';
    29: tSQL:='select id, sname, kname, fio, dts, dti, sn_sb, inv, stiker, namesb, loc from sert_copy_kripto_sb where (ID_RAION='+inttostr(id_raion)+') order by kname, fio';
    30: tSQL:='select dtr, id, sn, inv, name, stiker, loc, fio from VIEW_STIKER_SB where (ID_RAION='+inttostr(id_raion)+') order by sn, move_sb_id DESC';
    31: tSQL:='select move_kripto.id as number_rec, move_kripto.DTR AS M_M_DT, peoples.fam||'' ''||LEFT(peoples.nam,1)||''. ''||LEFT(peoples.otch,1)||''.'' as FIO,move_kripto.id,'+lineending+
    'NUMBER_COPY, copy_kripto.serial as sn,move_kripto.id_kripto, /*kripto.name as kname*/k2.name as kname, sb.serial,'+lineending+
    ' sb.invent,sb.stiker, name_sb.name as sbname  from move_kripto join copy_kripto on (copy_kripto.id=move_kripto.id_kripto)'+lineending+
    'join kripto as k2 on (move_kripto.id_kripto_name=k2.id)'+lineending+
    'join kripto on (copy_kripto.id_kripto=kripto.id) join sb on (move_kripto.id_sb=sb.id)'+lineending+
    'join name_sb on (name_sb.id=sb.id_name_sb) '+lineending+
    'join START_WORK on (start_work.id=copy_kripto.id_start_work)'+lineending+
    'join peoples on (peoples.id=start_work.id_people) where (copy_kripto.ID_RAION='+inttostr(id_raion)+') order by move_kripto.dtr DESC';
    32: tSQL:='select id,id_sb,dt,serial,invent,fio_i,fio_sb, name_po,dop from view_install_po where (ID_RAION='+inttostr(id_raion)+') order by dt DESC, fio_i, fio_sb';
    33: tSQL:='select id, dt, serial, invent, fio, motive from VIEW_DELETE_SB where (ID_RAION='+inttostr(id_raion)+') order by dt DESC';
    34: tSQL:='select id, SB_SN, SB_INVENT, SB_STIKER, SB_TIP_WORK, FIO, MNI_UCHETN, MNI_SN from SB_MNI where (ID_RAION='+inttostr(id_raion)+') order by SB_SN';
    35: tSQL:='select id, SB_SN, SB_INVENT, SB_STIKER, SB_TIP_WORK, FIO, MNI_CNT from SVOD_SB_MNI where (ID_RAION='+inttostr(id_raion)+') order by SB_SN';
    36: tSQL:='select pr1, pr2, pr3,  case terrname when ''itogo'' then ''ИТОГО в УПФР'' else terrname end as terrname, '+
    'case locname when ''itogo'' then ''ИТОГО'' else locname end as locname, '+
    'case sb_sn when ''itogo'' then ''ИТОГО'' else sb_sn end as sb_sn, sb_inv, sb_stiker, sb_tip_work, FIO, sb_cnt from SVOD_SB where (ID_RAION='+inttostr(id_raion)+') '+
    'order by pr1, terrname,  pr2, locname, pr3';
    37: tSQL:='select ID,FAM,NAM,OTCH, FAM||'' ''||LEFT(NAM,1)||''. ''||LEFT(OTCH,1)||''.'' as  FIO, CNT '+
    'from view_dostup_svod where (ID_RAION='+inttostr(ID_RAION)+')and(HIDE=0) order by FIO';
  end;
  FmyClass.loadPAG(tSQL, namesheet,FconnectorRead.connector,ID);
end;

procedure TmainF.AfterOpen(DataSet: TDataSet; IndexPage: integer;
  NamePage: string; IDPage: integer);
begin
  //первоначальная настройка при открытиии набора
  //showmessage(fMyClass.Query.SQL.Text);
  case IDPage of
   0:begin
  //сначало то, что видимое
    {dataset.Fields.FieldByName('DDD').DisplayLabel:='DDD';
      dataset.Fields.FieldByName('DDD').DisplayWidth:=9;  }

      dataset.Fields.FieldByName('TABNOM').DisplayWidth:=5;
      dataset.Fields.FieldByName('TABNOM').DisplayWidth:=5;
      dataset.Fields.FieldByName('TABNOM').DisplayLabel:='таб.№';
      dataset.Fields.FieldByName('FAM').DisplayWidth:=11;
      dataset.Fields.FieldByName('FAM').DisplayLabel:='Фамилия';
      dataset.Fields.FieldByName('NAM').DisplayWidth:=9;
      dataset.Fields.FieldByName('NAM').DisplayLabel:='Имя';
      dataset.Fields.FieldByName('OTCH').DisplayWidth:=14;
      dataset.Fields.FieldByName('OTCH').DisplayLabel:='Отчество';
      dataset.Fields.FieldByName('post').DisplayWidth:=36;
      dataset.Fields.FieldByName('post').DisplayLabel:='Должность';
      dataset.Fields.FieldByName('ngroup').DisplayWidth:=20;
      dataset.Fields.FieldByName('ngroup').DisplayLabel:='Группа';
      dataset.Fields.FieldByName('DTB').DisplayWidth:=10;
      dataset.Fields.FieldByName('DTB').DisplayLabel:='дата рождения';
      dataset.Fields.FieldByName('STAJ').DisplayWidth:=10;
      dataset.Fields.FieldByName('STAJ').DisplayLabel:='стаж в ПФР(лет)';
      dataset.Fields.FieldByName('REGISTRATION').DisplayWidth:=10;
      dataset.Fields.FieldByName('REGISTRATION').DisplayLabel:='место регистрации';
      dataset.Fields.FieldByName('loc').DisplayWidth:=10;
      dataset.Fields.FieldByName('loc').DisplayLabel:='местоположение';
      dataset.Fields.FieldByName('TNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('TNAME').DisplayLabel:='тер. расположение';
      dataset.Fields.FieldByName('SNILS').DisplayWidth:=9;
      dataset.Fields.FieldByName('SNILS').DisplayLabel:='СНИЛС';
      dataset.Fields.FieldByName('INN').DisplayWidth:=9;
      dataset.Fields.FieldByName('INN').DisplayLabel:='ИНН';
      dataset.Fields.FieldByName('PHONE_SOTE').DisplayWidth:=9;
      dataset.Fields.FieldByName('PHONE_SOTE').DisplayLabel:='сотовый';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('rr').Visible:=false;
      dataset.Fields.FieldByName('rr').DisplayWidth:=5;
      dataset.Fields.FieldByName('rr').DisplayLabel:='район';
      dataset.Fields.FieldByName('id').Visible:=false;
      dataset.Fields.FieldByName('ID_PEOPLE').Visible:=false;
      dataset.Fields.FieldByName('DOP').Visible:=false;
   end;
   1:begin
     //первоначальная настройка
                    dataset.Fields.FieldByName('NAME').DisplayWidth:=20;
                   // dataset.Fields.FieldByName('NAME').DisplayLabel:='';
                   // dataset.Fields.FieldByName('rr').DisplayWidth:=5;
                    dataset.Fields.FieldByName('DTU').DisplayWidth:=7;
                    dataset.Fields.FieldByName('DTU').DisplayLabel:='дата';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ФИО';
                    dataset.Fields.FieldByName('post').DisplayWidth:=20;
                    dataset.Fields.FieldByName('post').DisplayLabel:='должность';
                    dataset.Fields.FieldByName('ngroup').DisplayWidth:=20;
                    dataset.Fields.FieldByName('ngroup').DisplayLabel:='группа';
                    dataset.Fields.FieldByName('DTB').DisplayWidth:=20;
                    dataset.Fields.FieldByName('DTB').DisplayLabel:='дата рождения';
                    dataset.Fields.FieldByName('PLB').DisplayWidth:=20;
                    dataset.Fields.FieldByName('PLB').DisplayLabel:='место рождения';
                    dataset.Fields.FieldByName('REGISTRATION').DisplayWidth:=20;
                    dataset.Fields.FieldByName('REGISTRATION').DisplayLabel:='место регистрации';
                    //теперь то, что не видимое
                     dataset.Fields.FieldByName('ID_SW').Visible:=false;
                     dataset.Fields.FieldByName('ID').Visible:=false;
                     dataset.Fields.FieldByName('rr').Visible:=false;
                     dataset.Fields.FieldByName('ID_PEOPLE').Visible:=false;
   end;
   2:begin
   //первоначальная настройка
                    dataset.Fields.FieldByName('NAME').DisplayWidth:=20;
                    dataset.Fields.FieldByName('NAME').DisplayLabel:='причина';
                    dataset.Fields.FieldByName('dt_start').DisplayWidth:=20;
                    dataset.Fields.FieldByName('dt_start').DisplayLabel:='начало прекращения';
                    dataset.Fields.FieldByName('dt_end').DisplayWidth:=20;
                    dataset.Fields.FieldByName('dt_end').DisplayLabel:='окончание прекращения';
                    dataset.Fields.FieldByName('count_tmp_stop').DisplayWidth:=5;
                    dataset.Fields.FieldByName('count_tmp_stop').DisplayLabel:='дней';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ФИО';
                    dataset.Fields.FieldByName('post').DisplayWidth:=20;
                    dataset.Fields.FieldByName('post').DisplayLabel:='должность';
                    dataset.Fields.FieldByName('ngroup').DisplayWidth:=20;
                    dataset.Fields.FieldByName('ngroup').DisplayLabel:='группа';
                    dataset.Fields.FieldByName('DTB').DisplayWidth:=20;
                    dataset.Fields.FieldByName('DTB').DisplayLabel:='дата рождения';
                    dataset.Fields.FieldByName('PLB').DisplayWidth:=20;
                    dataset.Fields.FieldByName('PLB').DisplayLabel:='место рождения';
                    dataset.Fields.FieldByName('REGISTRATION').DisplayWidth:=20;
                    dataset.Fields.FieldByName('REGISTRATION').DisplayLabel:='место регистрации';
                   //теперь то, что не видимое
                     dataset.Fields.FieldByName('ID_SW').Visible:=false;
                     dataset.Fields.FieldByName('ID_PEOPLE').Visible:=false;
                     dataset.Fields.FieldByName('ID').Visible:=false;
                     dataset.Fields.FieldByName('rr').Visible:=false;
   end;
   3:begin
     //первоначальная настройка
      dataset.Fields.FieldByName('tip').DisplayWidth:=5;
      dataset.Fields.FieldByName('tip').DisplayLabel:='тип';
      dataset.Fields.FieldByName('raspr').DisplayWidth:=10;
      dataset.Fields.FieldByName('raspr').DisplayLabel:='распределен';
      dataset.Fields.FieldByName('keyn').DisplayWidth:=10;
      dataset.Fields.FieldByName('keyn').DisplayLabel:='ключевой';
      dataset.Fields.FieldByName('uch').DisplayWidth:=8;
      dataset.Fields.FieldByName('uch').DisplayLabel:='учетный №';
      dataset.Fields.FieldByName('fio').DisplayWidth:=20;
      dataset.Fields.FieldByName('fio').DisplayLabel:='ФИО';
      dataset.Fields.FieldByName('tname').DisplayWidth:=20;
      dataset.Fields.FieldByName('tname').DisplayLabel:='расположение.';
      dataset.Fields.FieldByName('group_').DisplayWidth:=8;
      dataset.Fields.FieldByName('group_').DisplayLabel:='группа';
      dataset.Fields.FieldByName('serial').DisplayWidth:=10;
      dataset.Fields.FieldByName('serial').DisplayLabel:='серийный';
      dataset.Fields.FieldByName('ssize').DisplayWidth:=8;
      dataset.Fields.FieldByName('ssize').DisplayLabel:='размер Гб';
      dataset.Fields.FieldByName('dt').DisplayWidth:=6;
      dataset.Fields.FieldByName('dt').DisplayLabel:='дата постановки на учет';
      dataset.Fields.FieldByName('model_').DisplayWidth:=10;
      dataset.Fields.FieldByName('model_').DisplayLabel:='модель';
      dataset.Fields.FieldByName('sNAME').DisplayWidth:=10;
      dataset.Fields.FieldByName('sNAME').DisplayLabel:='системный блок s/n';
      dataset.Fields.FieldByName('iNAME').DisplayWidth:=10;
      dataset.Fields.FieldByName('iNAME').DisplayLabel:='системный блок инвент';
      dataset.Fields.FieldByName('FIOSB').DisplayWidth:=10;
      dataset.Fields.FieldByName('FIOSB').DisplayLabel:='системный блок-ответственный';
      dataset.Fields.FieldByName('otkuda').DisplayWidth:=20;
      dataset.Fields.FieldByName('otkuda').DisplayLabel:='ОТКУДА';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
      dataset.Fields.FieldByName('mnidop').Visible:=false;
   end;
   4:begin
     //первоначальная настройка
                    dataset.Fields.FieldByName('DT').DisplayWidth:=8;
                    dataset.Fields.FieldByName('DT').DisplayLabel:='дата списания';
                    dataset.Fields.FieldByName('UCHETN').DisplayWidth:=5;
                    dataset.Fields.FieldByName('UCHETN').DisplayLabel:='учетный номер';
                    dataset.Fields.FieldByName('tNAME').DisplayWidth:=5;
                    dataset.Fields.FieldByName('tNAME').DisplayLabel:='тип МНИ';
                    dataset.Fields.FieldByName('NAME').DisplayWidth:=26;
                    dataset.Fields.FieldByName('NAME').DisplayLabel:='основание списания';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=11;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ФИО';
                    dataset.Fields.FieldByName('SSIZE').DisplayWidth:=5;
                    dataset.Fields.FieldByName('SSIZE').DisplayLabel:='объем (ГБ)';
                    dataset.Fields.FieldByName('SERIAL').DisplayWidth:=4;
                    dataset.Fields.FieldByName('SERIAL').DisplayLabel:='серийный номер';
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('ID').Visible:=false;
                    dataset.Fields.FieldByName('ID_MNI').Visible:=false;
   end;
   5:begin
   //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('NAME').DisplayWidth:=28;
      dataset.Fields.FieldByName('NAME').DisplayLabel:='номер';
      dataset.Fields.FieldByName('DT').DisplayWidth:=9;
      dataset.Fields.FieldByName('DT').DisplayLabel:='дата получения';
      dataset.Fields.FieldByName('DT_START').DisplayWidth:=9;
      dataset.Fields.FieldByName('DT_START').DisplayLabel:='начало действия';
      dataset.Fields.FieldByName('DT_END').DisplayWidth:=9;
      dataset.Fields.FieldByName('DT_END').DisplayLabel:='окончание действия';
      dataset.Fields.FieldByName('FIO').DisplayWidth:=18;
      dataset.Fields.FieldByName('FIO').DisplayLabel:='пользователь';
      dataset.Fields.FieldByName('ISP').DisplayWidth:=15;
      dataset.Fields.FieldByName('ISP').DisplayLabel:=' ';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
      dataset.Fields.FieldByName('DOP').Visible:=false;
   end;
   6:begin
  //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('M_M_DT').DisplayWidth:=20;
      dataset.Fields.FieldByName('M_M_DT').DisplayLabel:='дата';
      dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
      dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
      dataset.Fields.FieldByName('KEYN').DisplayWidth:=15;
      dataset.Fields.FieldByName('KEYN').DisplayLabel:='ключевой';
      dataset.Fields.FieldByName('PR_R_M').DisplayWidth:=15;
      dataset.Fields.FieldByName('PR_R_M').DisplayLabel:='распределен';
      dataset.Fields.FieldByName('UCHETN').DisplayWidth:=9;
      dataset.Fields.FieldByName('UCHETN').DisplayLabel:='Учетный номер';
      dataset.Fields.FieldByName('mSB').DisplayWidth:=9;
      dataset.Fields.FieldByName('mSB').DisplayLabel:='Сист. блок';
      dataset.Fields.FieldByName('tNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('tNAME').DisplayLabel:='тип МНИ';
      dataset.Fields.FieldByName('dop_pole').DisplayWidth:=9;
      dataset.Fields.FieldByName('dop_pole').DisplayLabel:=' ';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
      dataset.Fields.FieldByName('ID_MNI').Visible:=false;
      //dataset.Fields.FieldByName('pr_sort').Visible:=false;
     // dataset.Fields.FieldByName('dop_pole').Visible:=false;
   end;
   7:begin
     //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('DT').DisplayWidth:=20;
      dataset.Fields.FieldByName('DT').DisplayLabel:='дата';
      dataset.Fields.FieldByName('FIO').DisplayWidth:=15;
      dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
      dataset.Fields.FieldByName('NAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('NAME').DisplayLabel:='криптосредство';
      {dataset.Fields.FieldByName('lNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('lNAME').DisplayLabel:='расположение';}
      dataset.Fields.FieldByName('SR').DisplayWidth:=9;
      dataset.Fields.FieldByName('SR').DisplayLabel:='серийный';
      dataset.Fields.FieldByName('NC').DisplayWidth:=9;
      dataset.Fields.FieldByName('NC').DisplayLabel:='номер экзепляра';
      dataset.Fields.FieldByName('SERT').DisplayWidth:=9;
      dataset.Fields.FieldByName('SERT').DisplayLabel:='сертификат';
      dataset.Fields.FieldByName('OTKUDA').DisplayWidth:=9;
      dataset.Fields.FieldByName('OTKUDA').DisplayLabel:='откуда';
      dataset.Fields.FieldByName('lNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('lNAME').DisplayLabel:='кабинет';
      dataset.Fields.FieldByName('sbSERIAL').DisplayWidth:=9;
      dataset.Fields.FieldByName('sbSERIAL').DisplayLabel:='системный блок';
      dataset.Fields.FieldByName('STIKER').DisplayWidth:=9;
      dataset.Fields.FieldByName('STIKER').DisplayLabel:='стикер';
      dataset.Fields.FieldByName('mUCH').DisplayWidth:=9;
      dataset.Fields.FieldByName('mUCH').DisplayLabel:='ключ. носитель';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
      dataset.Fields.FieldByName('DOP').Visible:=false;
      dataset.Fields.FieldByName('pr_bad').Visible:=false;
   end;
   8:begin
     //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('DT').DisplayWidth:=20;
      dataset.Fields.FieldByName('DT').DisplayLabel:='дата';
      dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
      dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
      dataset.Fields.FieldByName('SERIAL').DisplayWidth:=9;
      dataset.Fields.FieldByName('SERIAL').DisplayLabel:='серийный';
      dataset.Fields.FieldByName('INVENT').DisplayWidth:=9;
      dataset.Fields.FieldByName('INVENT').DisplayLabel:='инвентарный';
      dataset.Fields.FieldByName('OTKUDA').DisplayWidth:=9;
      dataset.Fields.FieldByName('OTKUDA').DisplayLabel:='откуда';
      dataset.Fields.FieldByName('P_R_S').DisplayWidth:=9;
      dataset.Fields.FieldByName('P_R_S').DisplayLabel:='распределен';
      dataset.Fields.FieldByName('wNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('wNAME').DisplayLabel:='направление использования';
      dataset.Fields.FieldByName('sbNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('sbNAME').DisplayLabel:='наименование сист. блока';
      dataset.Fields.FieldByName('gNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('gNAME').DisplayLabel:='группа';
      dataset.Fields.FieldByName('namePR').DisplayWidth:=9;
      dataset.Fields.FieldByName('namePR').DisplayLabel:='процессор';
      dataset.Fields.FieldByName('CPU_MHZ').DisplayWidth:=9;
      dataset.Fields.FieldByName('CPU_MHZ').DisplayLabel:='частота';
      dataset.Fields.FieldByName('COUNT_IADRA').DisplayWidth:=9;
      dataset.Fields.FieldByName('COUNT_IADRA').DisplayLabel:='кол-во ядер';
      dataset.Fields.FieldByName('LOC').DisplayWidth:=9;
      dataset.Fields.FieldByName('LOC').DisplayLabel:='местоположение';
      dataset.Fields.FieldByName('TNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('TNAME').DisplayLabel:='тер. расположение';
      dataset.Fields.FieldByName('STIKER').DisplayLabel:='стикер';
      dataset.Fields.FieldByName('SMM').DisplayWidth:=9;
      dataset.Fields.FieldByName('SMM').DisplayLabel:='ОЗУ';
      dataset.Fields.FieldByName('IP').DisplayWidth:=9;
      dataset.Fields.FieldByName('IP').DisplayLabel:='IP';
      dataset.Fields.FieldByName('OS_NAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('OS_NAME').DisplayLabel:='ОС';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
      dataset.Fields.FieldByName('DOP').Visible:=false;
   end;
    9:begin
     //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('DT').DisplayWidth:=20;
      dataset.Fields.FieldByName('DT').DisplayLabel:='дата';
      dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
      dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
      dataset.Fields.FieldByName('kNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('kNAME').DisplayLabel:='наименование криптосредства';
      dataset.Fields.FieldByName('NC').DisplayWidth:=9;
      dataset.Fields.FieldByName('NC').DisplayLabel:='ноер экземпляра';
      dataset.Fields.FieldByName('NAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('NAME').DisplayLabel:='причина уничтожения';
      dataset.Fields.FieldByName('SERIAL').DisplayWidth:=9;
      dataset.Fields.FieldByName('SERIAL').DisplayLabel:='системный блок';
      dataset.Fields.FieldByName('kSERIAL').DisplayWidth:=9;
      dataset.Fields.FieldByName('kSERIAL').DisplayLabel:='учетный/серийный';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
      dataset.Fields.FieldByName('ID_COPY_KRIPTO').Visible:=false;
      dataset.Fields.FieldByName('nom').Visible:=false;
   end;
    10:begin
     //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
      dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
      dataset.Fields.FieldByName('kNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('kNAME').DisplayLabel:='наименование криптосредства';
      dataset.Fields.FieldByName('sbSERIAL').DisplayWidth:=9;
      dataset.Fields.FieldByName('sbSERIAL').DisplayLabel:='системный блок';
      dataset.Fields.FieldByName('kSERIAL').DisplayWidth:=9;
      dataset.Fields.FieldByName('kSERIAL').DisplayLabel:='системный блок';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
      dataset.Fields.FieldByName('nom').Visible:=false;
   end;
    11:begin
     //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
      dataset.Fields.FieldByName('FIO').DisplayLabel:='пользователи криптосредств';
      dataset.Fields.FieldByName('kcount').DisplayWidth:=9;
      dataset.Fields.FieldByName('kcount').DisplayLabel:='количество криптосредств';
     { dataset.Fields.FieldByName('sbSERIAL').DisplayWidth:=9;
      dataset.Fields.FieldByName('sbSERIAL').DisplayLabel:='системный блок';
      dataset.Fields.FieldByName('kSERIAL').DisplayWidth:=9;
      dataset.Fields.FieldByName('kSERIAL').DisplayLabel:='системный блок'; }
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
     { dataset.Fields.FieldByName('nom').Visible:=false;  }
   end;
    12:begin
     //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
      dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
      dataset.Fields.FieldByName('tNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('tNAME').DisplayLabel:='тип МНИ';
      dataset.Fields.FieldByName('UCHETN').DisplayWidth:=9;
      dataset.Fields.FieldByName('UCHETN').DisplayLabel:='учетный номер';
      dataset.Fields.FieldByName('sbSERIAL').DisplayWidth:=9;
      dataset.Fields.FieldByName('sbSERIAL').DisplayLabel:='системный блок';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
   end;
    13:begin
     //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
      dataset.Fields.FieldByName('FIO').DisplayLabel:='пользователи МНИ';
      dataset.Fields.FieldByName('mnicount').DisplayWidth:=9;
      dataset.Fields.FieldByName('mnicount').DisplayLabel:='количество МНИ';
     //теперь то, что не видимое
     // dataset.Fields.FieldByName('ID').Visible:=false;
   end;
    14:begin
     //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('DT').DisplayWidth:=20;
      dataset.Fields.FieldByName('DT').DisplayLabel:='дата';
      dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
      dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
      dataset.Fields.FieldByName('kNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('kNAME').DisplayLabel:='наименование криптосредства';
      dataset.Fields.FieldByName('SERIAL').DisplayWidth:=9;
      dataset.Fields.FieldByName('SERIAL').DisplayLabel:='системный блок';
      dataset.Fields.FieldByName('kSERIAL').DisplayWidth:=9;
      dataset.Fields.FieldByName('kSERIAL').DisplayLabel:='учетный/серийный';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
      dataset.Fields.FieldByName('nom').Visible:=false;
   end;
    15:begin
     //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('M_E_DT').DisplayWidth:=20;
      dataset.Fields.FieldByName('M_E_DT').DisplayLabel:='дата';
      dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
      dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
      dataset.Fields.FieldByName('pNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('pNAME').DisplayLabel:='должность';
      dataset.Fields.FieldByName('gNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('gNAME').DisplayLabel:='группа';
      dataset.Fields.FieldByName('lNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('lNAME').DisplayLabel:='кабинет';
      dataset.Fields.FieldByName('dop_pole').DisplayWidth:=9;
      dataset.Fields.FieldByName('dop_pole').DisplayLabel:=' ';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
      dataset.Fields.FieldByName('pr_sort').Visible:=false;
   end;
    16:begin
     //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('M_S_DT').DisplayWidth:=20;
      dataset.Fields.FieldByName('M_S_DT').DisplayLabel:='дата';
      dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
      dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
      dataset.Fields.FieldByName('SERIAL').DisplayWidth:=9;
      dataset.Fields.FieldByName('SERIAL').DisplayLabel:='серийник';
      dataset.Fields.FieldByName('INVENT').DisplayWidth:=9;
      dataset.Fields.FieldByName('INVENT').DisplayLabel:='инвентарный';
      dataset.Fields.FieldByName('prNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('prNAME').DisplayLabel:='распределен/не распределен';
      dataset.Fields.FieldByName('osNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('osNAME').DisplayLabel:='операционная сист.';
      dataset.Fields.FieldByName('wNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('wNAME').DisplayLabel:='направление использования';
      dataset.Fields.FieldByName('lNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('lNAME').DisplayLabel:='местоположение';
      dataset.Fields.FieldByName('STIKER').DisplayWidth:=9;
      dataset.Fields.FieldByName('STIKER').DisplayLabel:='стикер';
      dataset.Fields.FieldByName('dop_pole').DisplayWidth:=9;
      dataset.Fields.FieldByName('dop_pole').DisplayLabel:=' ';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
      dataset.Fields.FieldByName('ID_SB').Visible:=false;
      dataset.Fields.FieldByName('pr_sort').Visible:=false;
   end;
    17:begin
     //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('DT').DisplayWidth:=9;
      dataset.Fields.FieldByName('DT').DisplayLabel:='дата';
      dataset.Fields.FieldByName('tip').DisplayWidth:=9;
      dataset.Fields.FieldByName('tip').DisplayLabel:='тип';
      dataset.Fields.FieldByName('model_').DisplayWidth:=9;
      dataset.Fields.FieldByName('model_').DisplayLabel:='модель';
      dataset.Fields.FieldByName('fio').DisplayWidth:=9;
      dataset.Fields.FieldByName('fio').DisplayLabel:='ответственный';
      dataset.Fields.FieldByName('group_').DisplayWidth:=9;
      dataset.Fields.FieldByName('group_').DisplayLabel:='группа';
      dataset.Fields.FieldByName('raspr').DisplayWidth:=5;
      dataset.Fields.FieldByName('raspr').DisplayLabel:='распределен/не распределен';
      dataset.Fields.FieldByName('serial').DisplayWidth:=9;
      dataset.Fields.FieldByName('serial').DisplayLabel:='s/n';
      dataset.Fields.FieldByName('sname').DisplayWidth:=9;
      dataset.Fields.FieldByName('sname').DisplayLabel:='системник';
      dataset.Fields.FieldByName('FIOR').DisplayWidth:=9;
      dataset.Fields.FieldByName('FIOR').DisplayLabel:='системник-ответственный';
      dataset.Fields.FieldByName('otkuda').DisplayWidth:=9;
      dataset.Fields.FieldByName('otkuda').DisplayLabel:='откуда';
      dataset.Fields.FieldByName('INVENT').DisplayWidth:=9;
      dataset.Fields.FieldByName('INVENT').DisplayLabel:='инвентарный';
      dataset.Fields.FieldByName('LOC').DisplayWidth:=9;
      dataset.Fields.FieldByName('LOC').DisplayLabel:='местоположение';
      dataset.Fields.FieldByName('TNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('TNAME').DisplayLabel:='тер. расположение';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
      dataset.Fields.FieldByName('DOP').Visible:=false;
    end;
    18:
      begin
        //первоначальная настройка
        //сначало то, что видимое
       dataset.Fields.FieldByName('RASHODNIK_NAME').DisplayWidth:=9;
       dataset.Fields.FieldByName('RASHODNIK_NAME').DisplayLabel:='наименование';
       dataset.Fields.FieldByName('RASHODNIK_COUNT').DisplayWidth:=9;
       dataset.Fields.FieldByName('RASHODNIK_COUNT').DisplayLabel:='количество';
       //теперь то, что не видимое
       dataset.Fields.FieldByName('RASHODNIK_ID').Visible:=false;
       dataset.Fields.FieldByName('RASHODNIK_NAME_ID').Visible:=false;
       { dataset.Fields.FieldByName('RAZNOE_TIP_NAME').DisplayWidth:=9;
       dataset.Fields.FieldByName('RAZNOE_TIP_NAME').DisplayLabel:='тип';
       dataset.Fields.FieldByName('RAZNOE_MODEL_NAME').DisplayWidth:=9;
       dataset.Fields.FieldByName('RAZNOE_MODEL_NAME').DisplayLabel:='к чему (модель)';
       dataset.Fields.FieldByName('RASHODNIK_NAME').DisplayWidth:=9;
       dataset.Fields.FieldByName('RASHODNIK_NAME').DisplayLabel:='наименование';
       //теперь то, что не видимое
       dataset.Fields.FieldByName('ID_RASHODNIK').Visible:=false;
       dataset.Fields.FieldByName('ID_RASHODNIK_NAME').Visible:=false;
       dataset.Fields.FieldByName('ssort').Visible:=false;}
       {dataset.Fields.FieldByName('RAZNOE_MODEL_NAME').DisplayWidth:=9;
       dataset.Fields.FieldByName('RAZNOE_MODEL_NAME').DisplayLabel:='модель (к чему)';
       dataset.Fields.FieldByName('RASHODNIK_NAME').DisplayWidth:=9;
       dataset.Fields.FieldByName('RASHODNIK_NAME').DisplayLabel:='наименование';
       dataset.Fields.FieldByName('RASHODNIK_COUNT').DisplayWidth:=9;
       dataset.Fields.FieldByName('RASHODNIK_COUNT').DisplayLabel:='количество'; }
      end;
    19, 20:
      begin
        //первоначальная настройка
        //сначало то, что видимое
       dataset.Fields.FieldByName('FIO_R').DisplayWidth:=9;
       dataset.Fields.FieldByName('FIO_R').DisplayLabel:='ФИО';
       dataset.Fields.FieldByName('TIP_R').DisplayWidth:=9;
       dataset.Fields.FieldByName('TIP_R').DisplayLabel:='тип расходника';
       dataset.Fields.FieldByName('NAME_R').DisplayWidth:=9;
       dataset.Fields.FieldByName('NAME_R').DisplayLabel:='наименование расходника';
      { if IDPage=19 then
       begin
            dataset.Fields.FieldByName('NAME_TRZN').DisplayWidth:=8;
            dataset.Fields.FieldByName('NAME_TRZN').DisplayLabel:='к чему расходник(тип)';
            dataset.Fields.FieldByName('NAME_RZN').DisplayWidth:=8;
            dataset.Fields.FieldByName('NAME_RZN').DisplayLabel:='к чему расходник(модель)';
       end; }
       dataset.Fields.FieldByName('CNT').DisplayWidth:=9;
       dataset.Fields.FieldByName('CNT').DisplayLabel:='количество';
       if IDPage=19 then
       begin
        dataset.Fields.FieldByName('NAME_TRZN').DisplayWidth:=8;
        dataset.Fields.FieldByName('NAME_TRZN').DisplayLabel:='к чему расходник(тип)';
        dataset.Fields.FieldByName('NAME_RZN').DisplayWidth:=8;
        dataset.Fields.FieldByName('NAME_RZN').DisplayLabel:='к чему расходник(модель)';
        dataset.Fields.FieldByName('DT_R').DisplayWidth:=9;
        dataset.Fields.FieldByName('DT_R').DisplayLabel:='когда';
       end;
       //теперь то, что не видимое
       dataset.Fields.FieldByName('ID').Visible:=false;
       //теперь то, что не видимое
       {dataset.Fields.FieldByName('RASHODNIK_ID').Visible:=false;
       dataset.Fields.FieldByName('RASHODNIK_NAME_ID').Visible:=false; }
      end;
    21:begin
     //первоначальная настройка
  //сначало то, что видимое
      dataset.Fields.FieldByName('M_R_DT').DisplayWidth:=20;
      dataset.Fields.FieldByName('M_R_DT').DisplayLabel:='дата';
      dataset.Fields.FieldByName('tip').DisplayWidth:=20;
      dataset.Fields.FieldByName('tip').DisplayLabel:='тип';
      dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
      dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
      dataset.Fields.FieldByName('SERIAL').DisplayWidth:=9;
      dataset.Fields.FieldByName('SERIAL').DisplayLabel:='серийник';
      dataset.Fields.FieldByName('INVENT').DisplayWidth:=9;
      dataset.Fields.FieldByName('INVENT').DisplayLabel:='инвентарный';
      dataset.Fields.FieldByName('prNAME').DisplayWidth:=9;
      dataset.Fields.FieldByName('prNAME').DisplayLabel:='распределен/не распределен';
     //теперь то, что не видимое
      dataset.Fields.FieldByName('ID').Visible:=false;
      dataset.Fields.FieldByName('ID_RAZNOE').Visible:=false;
      dataset.Fields.FieldByName('RID').Visible:=false;
      //dataset.Fields.FieldByName('pr_sort').Visible:=false;
   end;
    22:begin
     //первоначальная настройка
                    dataset.Fields.FieldByName('DT').DisplayWidth:=6;
                    dataset.Fields.FieldByName('DT').DisplayLabel:='дата списания';
                    dataset.Fields.FieldByName('INVENT').DisplayWidth:=4;
                    dataset.Fields.FieldByName('INVENT').DisplayLabel:='инвентарный';
                    dataset.Fields.FieldByName('tNAME').DisplayWidth:=8;
                    dataset.Fields.FieldByName('tNAME').DisplayLabel:='тип';
                    dataset.Fields.FieldByName('NAME').DisplayWidth:=26;
                    dataset.Fields.FieldByName('NAME').DisplayLabel:='основание списания';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=11;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ФИО';
                    dataset.Fields.FieldByName('mNAME').DisplayWidth:=15;
                    dataset.Fields.FieldByName('mNAME').DisplayLabel:='модель';
                    dataset.Fields.FieldByName('SERIAL').DisplayWidth:=4;
                    dataset.Fields.FieldByName('SERIAL').DisplayLabel:='серийный номер';
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('ID').Visible:=false;
                    dataset.Fields.FieldByName('ID_RAZNOE').Visible:=false;
   end;
    23:
      begin
     //первоначальная настройка
                    dataset.Fields.FieldByName('PR').DisplayWidth:=6;
                    dataset.Fields.FieldByName('PR').DisplayLabel:='причина прекращения';
                    dataset.Fields.FieldByName('DT').DisplayWidth:=6;
                    dataset.Fields.FieldByName('DT').DisplayLabel:='дата получения';
                    dataset.Fields.FieldByName('DT_START').DisplayWidth:=8;
                    dataset.Fields.FieldByName('DT_START').DisplayLabel:='с';
                    dataset.Fields.FieldByName('DT_END').DisplayWidth:=8;
                    dataset.Fields.FieldByName('DT_END').DisplayLabel:='по';
                    dataset.Fields.FieldByName('NAME').DisplayWidth:=28;
                    dataset.Fields.FieldByName('NAME').DisplayLabel:='номер сертификата';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=11;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ФИО';
                    dataset.Fields.FieldByName('dt_otziv').DisplayWidth:=15;
                    dataset.Fields.FieldByName('dt_otziv').DisplayLabel:='дата отзыва';
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('ID').Visible:=false;
   end;
    24:
      begin
     //первоначальная настройка
                    dataset.Fields.FieldByName('ANAME').DisplayWidth:=25;
                    dataset.Fields.FieldByName('ANAME').DisplayLabel:='причина';
                    dataset.Fields.FieldByName('DTA').DisplayWidth:=6;
                    dataset.Fields.FieldByName('DTA').DisplayLabel:='дата акта';
                    dataset.Fields.FieldByName('PRCLOSE').DisplayWidth:=8;
                    dataset.Fields.FieldByName('PRCLOSE').DisplayLabel:=' ';
                    dataset.Fields.FieldByName('DTCLOSE').DisplayWidth:=6;
                    dataset.Fields.FieldByName('DTCLOSE').DisplayLabel:='дата закрытия';
                    dataset.Fields.FieldByName('UCHETN').DisplayWidth:=28;
                    dataset.Fields.FieldByName('UCHETN').DisplayLabel:='учетные данные';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=11;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ФИО';
                    dataset.Fields.FieldByName('sert').DisplayWidth:=11;
                    dataset.Fields.FieldByName('sert').DisplayLabel:='сертификат';
                   { dataset.Fields.FieldByName('dt_otziv').DisplayWidth:=15;
                    dataset.Fields.FieldByName('dt_otziv').DisplayLabel:='дата отзыва';}
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('ID').Visible:=false;
                    dataset.Fields.FieldByName('pr').Visible:=false;
   end;
    25:
      begin
     //первоначальная настройка
                    dataset.Fields.FieldByName('namepo').DisplayWidth:=10;
                    dataset.Fields.FieldByName('namepo').DisplayLabel:='продукт';
                    dataset.Fields.FieldByName('keypo1').DisplayWidth:=25;
                    dataset.Fields.FieldByName('keypo1').DisplayLabel:='ключ №1';
                    dataset.Fields.FieldByName('keypo2').DisplayWidth:=25;
                    dataset.Fields.FieldByName('keypo2').DisplayLabel:='ключ №2';
                    dataset.Fields.FieldByName('keypo3').DisplayWidth:=25;
                    dataset.Fields.FieldByName('keypo3').DisplayLabel:='ключ №3';
                    dataset.Fields.FieldByName('numberl').DisplayWidth:=25;
                    dataset.Fields.FieldByName('numberl').DisplayLabel:='номер лицензии';
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('ID').Visible:=false;
                    //dataset.Fields.FieldByName('DOP').Visible:=false;
   end;
    26, 27:
      begin
     //первоначальная настройка
                    dataset.Fields.FieldByName('DT').DisplayWidth:=10;
                    dataset.Fields.FieldByName('DT').DisplayLabel:='дата поступления';
                    dataset.Fields.FieldByName('NAME').DisplayWidth:=25;
                    dataset.Fields.FieldByName('NAME').DisplayLabel:='наименование';
                    dataset.Fields.FieldByName('COUNT_R').DisplayWidth:=25;
                    dataset.Fields.FieldByName('COUNT_R').DisplayLabel:='количество';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=25;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='кто принял';

                   //теперь то, что не видимое
                   // dataset.Fields.FieldByName('ID').Visible:=false;
                    if IDPage=27 then
                    begin
                         dataset.Fields.FieldByName('FIO').Visible:=false;
                         dataset.Fields.FieldByName('NAME').Visible:=false;
                    end;
   end;
    28:
      begin
     //первоначальная настройка
                    dataset.Fields.FieldByName('DT').DisplayWidth:=10;
                    dataset.Fields.FieldByName('DT').DisplayLabel:='дата поступления';
                    dataset.Fields.FieldByName('NAME').DisplayWidth:=25;
                    dataset.Fields.FieldByName('NAME').DisplayLabel:='наименование';
                    dataset.Fields.FieldByName('COUNT_R').DisplayWidth:=25;
                    dataset.Fields.FieldByName('COUNT_R').DisplayLabel:='количество';
                    dataset.Fields.FieldByName('OTKUDA').DisplayWidth:=25;
                    dataset.Fields.FieldByName('OTKUDA').DisplayLabel:='откуда поступил';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=25;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='кто принял';
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('ID').Visible:=false;
                    dataset.Fields.FieldByName('ID_NAME').Visible:=false;
                    dataset.Fields.FieldByName('ID_RAION').Visible:=false;
   end;
    29:
      begin
     //первоначальная настройка
                    dataset.Fields.FieldByName('SNAME').DisplayWidth:=30;
                    dataset.Fields.FieldByName('SNAME').DisplayLabel:='номер';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=10;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ФИО';
                    dataset.Fields.FieldByName('DTS').DisplayWidth:=7;
                    dataset.Fields.FieldByName('DTS').DisplayLabel:='действителен с';
                    dataset.Fields.FieldByName('DTI').DisplayWidth:=7;
                    dataset.Fields.FieldByName('DTI').DisplayLabel:='дата установки';
                    dataset.Fields.FieldByName('KNAME').DisplayWidth:=15;
                    dataset.Fields.FieldByName('KNAME').DisplayLabel:='криптосредство';
                    dataset.Fields.FieldByName('SN_SB').DisplayWidth:=7;
                    dataset.Fields.FieldByName('SN_SB').DisplayLabel:='s/n системника';
                    dataset.Fields.FieldByName('INV').DisplayWidth:=7;
                    dataset.Fields.FieldByName('INV').DisplayLabel:='инвентарный системника';
                    dataset.Fields.FieldByName('STIKER').DisplayWidth:=10;
                    dataset.Fields.FieldByName('STIKER').DisplayLabel:='стикер системника';
                    dataset.Fields.FieldByName('NAMESB').DisplayWidth:=7;
                    dataset.Fields.FieldByName('NAMESB').DisplayLabel:='системник';
                    dataset.Fields.FieldByName('LOC').DisplayWidth:=20;
                    dataset.Fields.FieldByName('LOC').DisplayLabel:='расположение';
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('ID').Visible:=false;
                    //dataset.Fields.FieldByName('ID_SERTIFIKATS').Visible:=false;
                    //dataset.Fields.FieldByName('ID_SB').Visible:=false;
   end;
    30:
      begin
     //первоначальная настройка
                      dataset.Fields.FieldByName('DTR').DisplayWidth:=7;
                    dataset.Fields.FieldByName('DTR').DisplayLabel:='дата записи';
                    dataset.Fields.FieldByName('SN').DisplayWidth:=30;
                    dataset.Fields.FieldByName('SN').DisplayLabel:='s/n номер';
                    dataset.Fields.FieldByName('INV').DisplayWidth:=10;
                    dataset.Fields.FieldByName('INV').DisplayLabel:='инвентарный';
                    dataset.Fields.FieldByName('NAME').DisplayWidth:=7;
                    dataset.Fields.FieldByName('NAME').DisplayLabel:='наименование сист. блока';
                    dataset.Fields.FieldByName('STIKER').DisplayWidth:=7;
                    dataset.Fields.FieldByName('STIKER').DisplayLabel:='стикер';
                    dataset.Fields.FieldByName('LOC').DisplayWidth:=20;
                    dataset.Fields.FieldByName('LOC').DisplayLabel:='расположение';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=20;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('ID').Visible:=false;
   end;
    31:
      begin
     //первоначальная настройка
                    {  dataset.Fields.FieldByName('number_rec').DisplayWidth:=3;
                      dataset.Fields.FieldByName('number_rec').DisplayLabel:='№ записи';}
                    dataset.Fields.FieldByName('M_M_DT').DisplayWidth:=20;
                    dataset.Fields.FieldByName('M_M_DT').DisplayLabel:='дата';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=10;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ФИО';
                    dataset.Fields.FieldByName('KNAME').DisplayWidth:=7;
                    dataset.Fields.FieldByName('KNAME').DisplayLabel:='криптосредство';
                    dataset.Fields.FieldByName('NUMBER_COPY').DisplayWidth:=7;
                    dataset.Fields.FieldByName('NUMBER_COPY').DisplayLabel:='№ экз. криптосредства';
                    dataset.Fields.FieldByName('SN').DisplayWidth:=7;
                    dataset.Fields.FieldByName('SN').DisplayLabel:='s/n криптосредства';
                    dataset.Fields.FieldByName('serial').DisplayWidth:=7;
                    dataset.Fields.FieldByName('serial').DisplayLabel:='s/n сист. блок';
                    dataset.Fields.FieldByName('invent').DisplayWidth:=7;
                    dataset.Fields.FieldByName('invent').DisplayLabel:='инвент-ый сист. блок';
                    dataset.Fields.FieldByName('STIKER').DisplayWidth:=7;
                    dataset.Fields.FieldByName('STIKER').DisplayLabel:='стикер';
                    dataset.Fields.FieldByName('sbname').DisplayWidth:=7;
                    dataset.Fields.FieldByName('sbname').DisplayLabel:='наименование сист.блок';
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('ID').Visible:=false;
                    dataset.Fields.FieldByName('id_kripto').Visible:=false;
                    dataset.Fields.FieldByName('number_rec').Visible:=false;
      end;
    32:
      begin
     //первоначальная настройка
                      dataset.Fields.FieldByName('DT').DisplayWidth:=6;
                    dataset.Fields.FieldByName('DT').DisplayLabel:='дата установки';
                      dataset.Fields.FieldByName('FIO_i').DisplayWidth:=15;
                    dataset.Fields.FieldByName('FIO_i').DisplayLabel:='кто устанавливал';
                    dataset.Fields.FieldByName('FIO_sb').DisplayWidth:=15;
                    dataset.Fields.FieldByName('FIO_sb').DisplayLabel:='отв. за сист. блок';
                    dataset.Fields.FieldByName('serial').DisplayWidth:=15;
                    dataset.Fields.FieldByName('serial').DisplayLabel:='s/n';
                    dataset.Fields.FieldByName('invent').DisplayWidth:=7;
                    dataset.Fields.FieldByName('invent').DisplayLabel:='инвентарный';
                    dataset.Fields.FieldByName('name_po').DisplayWidth:=10;
                    dataset.Fields.FieldByName('name_po').DisplayLabel:='что ставилось';
                    dataset.Fields.FieldByName('dop').DisplayWidth:=25;
                    dataset.Fields.FieldByName('dop').DisplayLabel:='доп. инф-ия';
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('ID').Visible:=false;
                    dataset.Fields.FieldByName('id_sb').Visible:=false;
      end;
    33:
      begin
     //первоначальная настройка
                      dataset.Fields.FieldByName('DT').DisplayWidth:=6;
                    dataset.Fields.FieldByName('DT').DisplayLabel:='дата списания';
                      dataset.Fields.FieldByName('FIO').DisplayWidth:=15;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
                    dataset.Fields.FieldByName('serial').DisplayWidth:=15;
                    dataset.Fields.FieldByName('serial').DisplayLabel:='s/n';
                    dataset.Fields.FieldByName('invent').DisplayWidth:=7;
                    dataset.Fields.FieldByName('invent').DisplayLabel:='инвентарный';
                    dataset.Fields.FieldByName('motive').DisplayWidth:=7;
                    dataset.Fields.FieldByName('motive').DisplayLabel:='причина';
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('ID').Visible:=false;
      end;
    34:
      begin
     //первоначальная настройка
                    dataset.Fields.FieldByName('SB_SN').DisplayWidth:=6;
                    dataset.Fields.FieldByName('SB_SN').DisplayLabel:='s/n сист бл';
                    dataset.Fields.FieldByName('SB_INVENT').DisplayWidth:=15;
                    dataset.Fields.FieldByName('SB_INVENT').DisplayLabel:='инвентарный';
                    dataset.Fields.FieldByName('SB_STIKER').DisplayWidth:=15;
                    dataset.Fields.FieldByName('SB_STIKER').DisplayLabel:='стикер';
                    dataset.Fields.FieldByName('SB_TIP_WORK').DisplayWidth:=7;
                    dataset.Fields.FieldByName('SB_TIP_WORK').DisplayLabel:='направление использ сист бл';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=7;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
                    dataset.Fields.FieldByName('MNI_UCHETN').DisplayWidth:=7;
                    dataset.Fields.FieldByName('MNI_UCHETN').DisplayLabel:='уч. номер МНИ';
                    dataset.Fields.FieldByName('MNI_SN').DisplayWidth:=14;
                    dataset.Fields.FieldByName('MNI_SN').DisplayLabel:='s/n МНИ';
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('ID').Visible:=false;
      end;
    35:
      begin
     //первоначальная настройка
                    dataset.Fields.FieldByName('SB_SN').DisplayWidth:=6;
                    dataset.Fields.FieldByName('SB_SN').DisplayLabel:='s/n сист бл';
                    dataset.Fields.FieldByName('SB_INVENT').DisplayWidth:=15;
                    dataset.Fields.FieldByName('SB_INVENT').DisplayLabel:='инвентарный';
                    dataset.Fields.FieldByName('SB_STIKER').DisplayWidth:=15;
                    dataset.Fields.FieldByName('SB_STIKER').DisplayLabel:='стикер';
                    dataset.Fields.FieldByName('SB_TIP_WORK').DisplayWidth:=7;
                    dataset.Fields.FieldByName('SB_TIP_WORK').DisplayLabel:='направление использ сист бл';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=7;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
                    dataset.Fields.FieldByName('MNI_CNT').DisplayWidth:=7;
                    dataset.Fields.FieldByName('MNI_CNT').DisplayLabel:='кол-во МНИ в сист бл';
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('ID').Visible:=false;
      end;
    36:
      begin
     //первоначальная настройка
                    dataset.Fields.FieldByName('terrname').DisplayWidth:=6;
                    dataset.Fields.FieldByName('terrname').DisplayLabel:='территориальное расположение';
                    dataset.Fields.FieldByName('locname').DisplayWidth:=15;
                    dataset.Fields.FieldByName('locname').DisplayLabel:='кабинет';
                    dataset.Fields.FieldByName('SB_SN').DisplayWidth:=8;
                    dataset.Fields.FieldByName('SB_SN').DisplayLabel:='s/n сист бл';
                    dataset.Fields.FieldByName('SB_INV').DisplayWidth:=8;
                    dataset.Fields.FieldByName('SB_INV').DisplayLabel:='инв сист бл';
                    dataset.Fields.FieldByName('SB_STIKER').DisplayWidth:=8;
                    dataset.Fields.FieldByName('SB_STIKER').DisplayLabel:='стикер';
                    dataset.Fields.FieldByName('SB_TIP_WORK').DisplayWidth:=7;
                    dataset.Fields.FieldByName('SB_TIP_WORK').DisplayLabel:='направление использ сист бл';
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=7;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ответственный';
                    dataset.Fields.FieldByName('SB_CNT').DisplayWidth:=5;
                    dataset.Fields.FieldByName('SB_CNT').DisplayLabel:='кол-во сист бл';
                   //теперь то, что не видимое
                    dataset.Fields.FieldByName('pr1').Visible:=false;
                    dataset.Fields.FieldByName('pr2').Visible:=false;
                    dataset.Fields.FieldByName('pr3').Visible:=false;
      end;
    37:
      begin
     //первоначальная настройка
                    dataset.Fields.FieldByName('FIO').DisplayWidth:=15;
                    dataset.Fields.FieldByName('FIO').DisplayLabel:='ФИО';
                    dataset.Fields.FieldByName('CNT').DisplayWidth:=6;
                    dataset.Fields.FieldByName('CNT').DisplayLabel:='доступы';
                   //теперь то, что не видимое
                   dataset.Fields.FieldByName('FAM').Visible:=false;
                   dataset.Fields.FieldByName('NAM').Visible:=false;
                   dataset.Fields.FieldByName('OTCH').Visible:=false;
                    dataset.Fields.FieldByName('ID').Visible:=false;
      end;
  end;
  SettingMenu({IndexPage,} NamePage, IDPage);
end;

procedure TmainF.SettingMenu(NamePage: string; IDPage: integer);
var cmp:tcomponent;
begin
  ClearToolBar;
     //настраиваем кнопки сетки
  cmp:=self.FindComponent('AUpload');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=(not fMyClass.Query.IsEmpty);//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Выгрузить в XLS';
     end;
  case IDPage of
   0:begin
     //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('Aadding');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='добавить сотрудника';
     end;

  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Внести изменения';
     end;

  cmp:=self.FindComponent('aMoving');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Временное прекращение';
     end;

  cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='увольнение сотрудника';
     end;

  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   cmp:=self.FindComponent('Aakt');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Visible:=true;
        TAction(cmp).Hint:='выгрузить заявку';
     end;
   end;
   1:begin
                    //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;
  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Внести изменения';
     end;
   end;
   2:begin
                    //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Внести изменения';
     end;
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;
  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   end;
   3:begin
   //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('Aadding');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='добавить МНИ';
     end;

  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Внести изменения';
     end;

  cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=(not fMyClass.Query.IsEmpty){or(FcountRow>0)};
        TAction(cmp).Hint:='снятие с учета МНИ';
     end;

  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;

   cmp:=self.FindComponent('Aakt');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Visible:=true;
        TAction(cmp).Hint:='выгрузить АКТ';
     end;
   end;
   4:begin
                    //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='просмотреть';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   cmp:=self.FindComponent('Aakt');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Visible:=true;
        TAction(cmp).Hint:='выгрузить АКТ';
     end;
   end;
   5:begin
   //настраиваем кнопки и др. на форме по необходимости
  cmp:=self.FindComponent('Aadding');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='добавить сертификат';
     end;

  cmp:=self.FindComponent('Aakt');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Visible:=true;
        TAction(cmp).Hint:='выгрузить АКТ';
     end;

  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='просмотреть';
     end;

  cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=(not fMyClass.Query.IsEmpty){or(FcountRow>0)};
        TAction(cmp).Hint:='Отзыв/Удаление';
     end;

  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   end;
   6:begin
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='просмотр';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   end;
   7:begin
   //настраиваем кнопки и др. на форме по необходимости
  cmp:=self.FindComponent('Aadding');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='добавить экземпляр криптосредства';
     end;

  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='просмотреть';
     end;

  cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='уничтожение экземпляра криптосредства';
     end;

  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   cmp:=self.FindComponent('Aakt');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Visible:=true;
        TAction(cmp).Hint:='выгрузить Акт';
     end;
   end;
   8:begin
   //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('Aadding');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='добавить Системник';
     end;

  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Внести изменения';
     end;

  cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='списание с учета системника';
     end;

  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   end;
   9:begin
                      //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='просмотреть';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   cmp:=self.FindComponent('Aakt');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Visible:=true;
        TAction(cmp).Hint:='выгрузить АКТ';
     end;
   end;
   10:begin
                      //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

 { cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='просмотреть';
     end; }

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   {cmp:=self.FindComponent('Aakt');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Visible:=true;
        TAction(cmp).Hint:='выгрузка';
     end;   }
   end;
   11:begin
                      //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;

   end;
   12:begin
                      //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;

   end;
   13:begin
                      //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;

   end;
   14:begin
                      //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='просмотреть';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
  { cmp:=self.FindComponent('Aakt');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Visible:=true;
        TAction(cmp).Hint:='выгрузить АКТ';
     end; }
   end;
   15:begin
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   end;
   16:begin
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='просмотреть';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   end;
   17:begin

   cmp:=self.FindComponent('Aakt');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Visible:=true;
        TAction(cmp).Hint:='выгрузить заявку';
     end;

    cmp:=self.FindComponent('Aadding');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='добавить Разное';
     end;

  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Внести изменения';
     end;

  cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='списание/удаление';
     end;

  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   end;
   18:
     begin
      cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

      cmp:=self.FindComponent('Aadding');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Hint:='Приход расходников';
               end;

            cmp:=self.FindComponent('AEditing');
 { if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Внести изменения';
     end;  }
     cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='расход';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end
     end;
   19, 20, 26, 27, 29:
     begin

  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   end;
   {20:
     begin

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end
     end;  }
   21:
     begin
    { cmp:=self.FindComponent('Aadding');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Hint:='Приход расходников';
               end; }

           // cmp:=self.FindComponent('AEditing');
            { if cmp<>nil then
            begin
            TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
            TAction(cmp).Hint:='Внести изменения';
            end;  }
           { cmp:=self.FindComponent('ADeleting');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
                TAction(cmp).Hint:='расход';
               end; }

     cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='просмотр';
     end;

            cmp:=self.FindComponent('AExit');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Hint:='закрыть журнал';
               end
     end;
   22:begin
                    //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='просмотреть';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   cmp:=self.FindComponent('Aakt');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Visible:=true;
        TAction(cmp).Hint:='выгрузить АКТ';
     end;
   end;
   23:
     begin
     //настраиваем кнопки и др. на форме по необходимости
     //TAction(self.FindComponent('Aadding111')).Visible:=true;
     cmp:=self.FindComponent('AUpdating');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
                TAction(cmp).Hint:='Обновить данные';
               end;

            {cmp:=self.FindComponent('AEditing');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
                TAction(cmp).Hint:='просмотреть';
               end;  }

            cmp:=self.FindComponent('AExit');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Hint:='закрыть журнал';
               end;
            {cmp:=self.FindComponent('Aakt');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Visible:=true;
                TAction(cmp).Hint:='выгрузить АКТ';
               end; }
     end;
   24:
     begin
     //настраиваем кнопки и др. на форме по необходимости
     //TAction(self.FindComponent('Aadding111')).Visible:=true;
     cmp:=self.FindComponent('AUpdating');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
                TAction(cmp).Hint:='Обновить данные';
               end;

            {cmp:=self.FindComponent('AEditing');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
                TAction(cmp).Hint:='просмотреть';
               end;  }

            cmp:=self.FindComponent('AExit');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Hint:='закрыть журнал';
               end;
            cmp:=self.FindComponent('Aakt');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Visible:=true;
                TAction(cmp).Hint:='выгрузить АКТ';
               end;
     end;
   25:
     begin
     //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.FindComponent('Aadding');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='добавить лицензию';
     end;

  cmp:=self.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Просмотр';
     end;
  {
  cmp:=self.FindComponent('aMoving');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Временное прекращение';
     end;
  }
  cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='удаление лицензии';
     end;

  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
  {
   cmp:=self.FindComponent('Aakt');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Visible:=true;
        TAction(cmp).Hint:='выгрузить заявку';
     end; }
   end;
   28:
     begin
       cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

      cmp:=self.FindComponent('Aadding');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Hint:='Приход расходников';
               end;

            cmp:=self.FindComponent('AEditing');
             if cmp<>nil then
                begin
                     TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
                     TAction(cmp).Hint:='Просмотр';
                end;

     cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='расход';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end
     end;
   30:
     begin
      {cmp:=self.FindComponent('Aadding');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Hint:='Приход расходников';
               end;

            cmp:=self.FindComponent('AEditing');
             if cmp<>nil then
                begin
                     TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
                     TAction(cmp).Hint:='Просмотр';
                end;

     cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='расход';
     end;  }

     cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end
     end;
   31:
     begin
      {cmp:=self.FindComponent('Aadding');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Hint:='Приход расходников';
               end;    }

            cmp:=self.FindComponent('AEditing');
             if cmp<>nil then
                begin
                     TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
                     TAction(cmp).Hint:='Просмотр';
                end;
       {
     cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='расход';
     end;  }
  cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end
     end;
   32:
     begin
      {cmp:=self.FindComponent('Aadding');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Hint:='Приход расходников';
               end;

            cmp:=self.FindComponent('AEditing');
             if cmp<>nil then
                begin
                     TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
                     TAction(cmp).Hint:='Просмотр';
                end;
                      }
     cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='удалить установку';
     end;
     cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;
     cmp:=self.FindComponent('AExit');
             if cmp<>nil then
                begin
                     TAction(cmp).Enabled:=true;
                     TAction(cmp).Hint:='закрыть журнал';
                end
     end;
   33:
     begin
      {cmp:=self.FindComponent('Aadding');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Hint:='Приход расходников';
               end;

            cmp:=self.FindComponent('AEditing');
             if cmp<>nil then
                begin
                     TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
                     TAction(cmp).Hint:='Просмотр';
                end;

     cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='расход';
     end;  }
     cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;
     cmp:=self.FindComponent('AExit');
             if cmp<>nil then
                begin
                     TAction(cmp).Enabled:=true;
                     TAction(cmp).Hint:='закрыть журнал';
                end
     end;
   34,35,36:
     begin
      {cmp:=self.FindComponent('Aadding');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Hint:='Приход расходников';
               end;

            cmp:=self.FindComponent('AEditing');
             if cmp<>nil then
                begin
                     TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
                     TAction(cmp).Hint:='Просмотр';
                end;

     cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='расход';
     end;  }
     cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;
     cmp:=self.FindComponent('AExit');
             if cmp<>nil then
                begin
                     TAction(cmp).Enabled:=true;
                     TAction(cmp).Hint:='закрыть журнал';
                end
     end;
   37:
     begin
      cmp:=self.FindComponent('Aadding');
            if cmp<>nil then
               begin
                TAction(cmp).Enabled:=true;
                TAction(cmp).Hint:='Добавить доступ';
               end;

            {cmp:=self.FindComponent('AEditing');
             if cmp<>nil then
                begin
                     TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
                     TAction(cmp).Hint:='Просмотр';
                end;}

     cmp:=self.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='убрать доступ';
     end;
     cmp:=self.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not fMyClass.Query.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;
     cmp:=self.FindComponent('AExit');
             if cmp<>nil then
                begin
                     TAction(cmp).Enabled:=true;
                     TAction(cmp).Hint:='закрыть журнал';
                end
     end;
  end;
  cmp:=self.FindComponent('AFind');
  if cmp<>nil then
     begin
          TAction(cmp).Enabled:=true;
          TAction(cmp).Hint:='Поиск';
     end;
  cmp:=self.FindComponent('AFindNext');
  if cmp<>nil then
     begin
          TAction(cmp).Enabled:=true;
          TAction(cmp).Hint:='Найти следующее';
     end;
end;

procedure TmainF.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var dt, dt_tmp:tdate;
    diff:integer;
    //int_tmp:integer;
begin
  if (gdSelected IN State) then exit;
  if FmyClass.ActivePage.Caption='Системники' then
  begin
       if utf8copy(FmyClass.Query.FieldByName('P_R_S').AsString,1,1)='Н' then
            begin
                 TDBGrid(Sender).Canvas.Brush.Color:=clSilver;//TColor($66B3FF);//clred;
                 TDBGrid(Sender).Canvas.FillRect(Rect);
                 TDBGrid(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top+2,Column.Field.Text);
            end;
  end;
  if FmyClass.ActivePage.Caption='Сертификаты' then
  begin
      // if column.FieldName = 'DT_END' then
       //begin
            if (DaysBetween(now,self.FmyClass.Query.FieldByName('DT_END').AsDateTime{column.Field.AsDateTime})+1)<30 then
            begin
                 TDBGrid(Sender).Canvas.Brush.Color:=TColor($66B3FF);//clred;
                 TDBGrid(Sender).Canvas.FillRect(Rect);
                 TDBGrid(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top+2,Column.Field.Text);
            end;
       //end;
       exit;
  end;
  if FmyClass.ActivePage.Caption='сотрудники' then
  begin
      // if column.FieldName = 'DT_END' then
       //begin
              dt:=FmyClass.Query.FieldByName('DTB').AsDateTime;
              dt_tmp:=EncodeDateTime(yearof(now),monthof(dt),dayof(dt),0,0,0,0);
              diff:=daysbetween(now,dt_tmp);
              if ((diff<10)and(now<dt_tmp))or((diff<3)and(now>dt_tmp)) then
//            if (DaysBetween(now,self.FmyClass.Query.FieldByName('DTB').AsDateTime{column.Field.AsDateTime}))<20 then
            begin
                        if diff=0 then
                           TDBGrid(Sender).Canvas.Brush.Color:=clred
                        else
                            TDBGrid(Sender).Canvas.Brush.Color:=TColor($66B3FF);//clred;

                 TDBGrid(Sender).Canvas.FillRect(Rect);
                 TDBGrid(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top+2,Column.Field.Text);
            end;
              //подсвечиваем родителей у которых день рождения детей
              if (bdchld<>nil)and(bdchld.Count>0) then
              if bdchld.IndexOf(trim(self.FmyClass.Query.FieldByName('ID_PEOPLE').AsString))<>-1 then
              begin
                   TDBGrid(Sender).Canvas.Brush.Color:=clYellow;//TColor($66B3FF);//clred;
                   TDBGrid(Sender).Canvas.FillRect(Rect);
                   TDBGrid(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top+2,Column.Field.Text);
              end;
       //end;
       exit;
  end;
  if FmyClass.ActivePage.Caption='Временное прекращение' then
  begin
      // if column.FieldName = 'DT_END' then
       //begin
              if FmyClass.Query.FieldByName('DT_END').IsNull then
                 TDBGrid(Sender).Canvas.Brush.Color:=clCream
              else
              begin
                   if FmyClass.Query.FieldByName('DT_START').AsDateTime>now() then
                      TDBGrid(Sender).Canvas.Brush.Color:=clGreen//TColor($0000C800)
                   else
                   if FmyClass.Query.FieldByName('DT_END').AsDateTime>now() then
                      TDBGrid(Sender).Canvas.Brush.Color:=clLime
                   else
                       TDBGrid(Sender).Canvas.Brush.Color:=clMoneyGreen;
              end;
              TDBGrid(Sender).Canvas.FillRect(Rect);
              TDBGrid(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top+2,Column.Field.Text);
              //end;
              exit;
  end;
  if FmyClass.ActivePage.Caption='криптосредства' then
  begin
      // if column.FieldName = 'DT_END' then
       //begin
              if self.FmyClass.Query.FieldByName('pr_bad').AsInteger=1 then
              begin
                          //if diff=0 then
                          TDBGrid(Sender).Canvas.Brush.Color:=RGBToColor(254,136,126);//TColor(#FE887E);//clCream;
                         { else
                              TDBGrid(Sender).Canvas.Brush.Color:=TColor($66B3FF);//clred; }
                          TDBGrid(Sender).Canvas.FillRect(Rect);
                          TDBGrid(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top+2,Column.Field.Text);
              end{ else
              begin
               TDBGrid(Sender).Canvas.Brush.Color:=clMoneyGreen;
               TDBGrid(Sender).Canvas.FillRect(Rect);
               TDBGrid(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top+2,Column.Field.Text);
              end};
              exit;
  end;
end;

procedure TmainF.MyMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Y>TDBgrid(Sender).DefaultRowHeight then
  begin
       if self.ToolButton15.Enabled then
       AEditingExecute(toolbutton15);
  end;

end;

function TmainF.checkparametr(value: string): boolean;
var
    i:integer;
begin
  result:=false;
  for i:=1 to application.ParamCount do
  begin
   if application.Params[i]=value then
   begin
        result:=true;
        break;
   end;
  end;
end;

function TmainF.checkdostup(name_table: string): integer;
{var
    stmp:string;  }
begin
  result:=-1;
  pCurrentDostup:=pHeadDostup;
  while pCurrentDostup<>nil do
  begin
   //stmp:=utf8lowercase(FconnectorRead.connector.Role);
   if (utf8lowercase(pCurrentDostup^.Table)=utf8lowercase(name_table))and((utf8lowercase(pCurrentDostup^.Role)=utf8lowercase(FconnectorRead.connector.Role))or
   (pCurrentDostup^.User_ID=id_user))then
   begin
        if (result<0) then result:=pCurrentDostup^.dostup else result:=result or pCurrentDostup^.dostup;
        //result:=pCurrentDostup^.dostup;
        //break;
   end;
   pCurrentDostup:=pCurrentDostup^.Next;
  end;
  if result=-1 then result:=0;
end;

end.

