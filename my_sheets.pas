unit my_sheets;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, my_tabsheet,dialogs,Actnlist;
 {
type

  { TmysheetEmployee }
  //Журнал сотрудников
  TmysheetEmployee=class(Tmytabsheet)
    private
    protected
    public
      constructor Create(TheOwner: TComponent);override;
      destructor Destroy;override;
      function loadDBGrid:boolean;override;
      procedure SettingPAG;override;
  end;

  { TmysheetEmployeeUv }
  //Журнал уволенных сотрудников
  TmysheetEmployeeUv=class(Tmytabsheet)
    private
    protected
    public
      constructor Create(TheOwner: TComponent);override;
      destructor Destroy;override;
      function loadDBGrid:boolean;override;
      procedure SettingPAG;override;
  end;

   { TmysheetEmployeeTMPSTOP }
   //Журнал сотрудников с временным прекращением
   TmysheetEmployeeTMPSTOP=class(Tmytabsheet)
    private
    protected
    public
      constructor Create(TheOwner: TComponent);override;
      destructor Destroy;override;
      function loadDBGrid:boolean;override;
      procedure SettingPAG;override;
  end;

   { TmysheetMNI }
   //Журнал зарегистрированных МНИ
   TmysheetMNI=class(Tmytabsheet)
     private
     protected
     public
       constructor Create(TheOwner: TComponent);override;
       destructor Destroy;override;
       function loadDBGrid:boolean;override;
       procedure SettingPAG;override;
   end;

   { TmysheetDELETEMNI }
   //Журнал списанных МНИ
   TmysheetDELETEMNI=class(Tmytabsheet)
     private
     protected
     public
       constructor Create(TheOwner: TComponent);override;
       destructor Destroy;override;
       function loadDBGrid:boolean;override;
       procedure SettingPAG;override;
   end;

   { TmysheetMOVEMNI }
   //Журнал движения МНИ
   TmysheetMOVEMNI=class(Tmytabsheet)
     private
     protected
     public
       constructor Create(TheOwner: TComponent);override;
       destructor Destroy;override;
       function loadDBGrid:boolean;override;
       procedure SettingPAG;override;
   end;

   { TmysheetSERTIFIKAT }
   //Журнал Сертификатво
   TmysheetSERTIFIKAT=class(Tmytabsheet)
     private
     protected
     public
       constructor Create(TheOwner: TComponent);override;
       destructor Destroy;override;
       function loadDBGrid:boolean;override;
       procedure SettingPAG;override;
   end;

   //Журнал Криптосредства

   { TmysheetKRIPTO }

   TmysheetKRIPTO=class(Tmytabsheet)
     private
     protected
     public
       constructor Create(TheOwner: TComponent);override;
       destructor Destroy;override;
       function loadDBGrid:boolean;override;
       procedure SettingPAG;override;
   end;       }
implementation
{
{ TmysheetKRIPTO }

constructor TmysheetKRIPTO.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

destructor TmysheetKRIPTO.Destroy;
begin
  inherited Destroy;
end;

function TmysheetKRIPTO.loadDBGrid: boolean;
begin

end;

procedure TmysheetKRIPTO.SettingPAG;
begin

end;

{ TmysheetMOVEMNI }

constructor TmysheetMOVEMNI.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

destructor TmysheetMOVEMNI.Destroy;
begin
  inherited Destroy;
end;

function TmysheetMOVEMNI.loadDBGrid: boolean;
var tSQL:string;
begin
   tSQL:='select MOVE_MNI.ID as ID, MOVE_MNI.DTR AS M_M_DT, PEOPLES.FAM, KEY_.NAME AS KEYN,PR_RASPR_MNI.NAME AS PR_R_M  from MOVE_MNI join MNI on (MOVE_MNI.ID_MNI=mni.ID)  '+lineending+
   'join START_WORK on (MOVE_MNI.ID_START_WORK=START_WORK.ID) join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
   'join KEY_ on (KEY_.ID=MOVE_MNI.ID_KEY)'+lineending+
   'join PR_RASPR_MNI on (MOVE_MNI.ID_PR_RASPR=PR_RASPR_MNI.ID)'+lineending+
   ''+lineending+
  'order by M_M_DT';
  result:=false;
  //загружаем данные в сетку
  FTrans.DataBase:=connector;
  FQuery.DataBase:=connector;
  FQuery.Transaction:=FTrans;
  FQuery.SQL.Clear;
  Fquery.SQL.Add(tSQL);
  FQuery.ReadOnly:=true;
  FQuery.Open;
  FDS.DataSet:=FQuery;
  FDBGR.DataSource:=FDS;
  //первоначальная настройка
  //сначало то, что видимое
     Fquery.Fields.FieldByName('M_M_DT').DisplayWidth:=20;
     Fquery.Fields.FieldByName('M_M_DT').DisplayLabel:='дата';
     Fquery.Fields.FieldByName('FAM').DisplayWidth:=20;
     Fquery.Fields.FieldByName('FAM').DisplayLabel:='ответственный';
     Fquery.Fields.FieldByName('KEYN').DisplayWidth:=9;
     Fquery.Fields.FieldByName('KEYN').DisplayLabel:='ключевой';
     Fquery.Fields.FieldByName('PR_R_M').DisplayWidth:=9;
     Fquery.Fields.FieldByName('PR_R_M').DisplayLabel:='распределен';
     //теперь то, что не видимое
     Fquery.Fields.FieldByName('ID').Visible:=false;
  //настраиваем кнопки данной сетки
  SettingPAG;
  result:=true;
end;

procedure TmysheetMOVEMNI.SettingPAG;
var cmp:tcomponent;
begin
   //настраиваем кнопки и др. на форме по необходимости
 { cmp:=self.parent_frm.FindComponent('Aadding');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='добавить сертификат';
     end;

  cmp:=self.parent_frm.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not FQuery.IsEmpty;
        TAction(cmp).Hint:='просмотреть';
     end;   }

  cmp:=self.parent_frm.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not FQuery.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.parent_frm.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
end;

{ TmysheetSERTIFIKAT }

constructor TmysheetSERTIFIKAT.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

destructor TmysheetSERTIFIKAT.Destroy;
begin
  inherited Destroy;
end;

function TmysheetSERTIFIKAT.loadDBGrid: boolean;
var tSQL:string;
begin
   tSQL:='select SERTIFIKATS.ID as ID, SERTIFIKATS.DT, SERTIFIKATS.NAME, SERTIFIKATS.DT_START,SERTIFIKATS.DT_END,'+lineending+
   'PEOPLES.FAM||'' ''||left(PEOPLES.NAM,1)||''. ''||left(PEOPLES.OTCH,1)||''.'' as FIO from SERTIFIKATS join START_WORK on (SERTIFIKATS.ID_START_WORK=START_WORK.ID)  '+lineending+
   'join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID) where (SERTIFIKATS.DT_END>CURRENT_DATE)'+lineending+
  'order by DT, NAME';
  result:=false;
  //загружаем данные в сетку
  FTrans.DataBase:=connector;
  FQuery.DataBase:=connector;
  FQuery.Transaction:=FTrans;
  FQuery.SQL.Clear;
  Fquery.SQL.Add(tSQL);
  FQuery.ReadOnly:=true;
  FQuery.Open;
  FDS.DataSet:=FQuery;
  FDBGR.DataSource:=FDS;
  //первоначальная настройка
  //сначало то, что видимое
     Fquery.Fields.FieldByName('NAME').DisplayWidth:=20;
     Fquery.Fields.FieldByName('NAME').DisplayLabel:='номер';
     Fquery.Fields.FieldByName('DT').DisplayWidth:=9;
     Fquery.Fields.FieldByName('DT').DisplayLabel:='дата получения';
     Fquery.Fields.FieldByName('DT_START').DisplayWidth:=9;
     Fquery.Fields.FieldByName('DT_START').DisplayLabel:='начало действия';
     Fquery.Fields.FieldByName('DT_END').DisplayWidth:=9;
     Fquery.Fields.FieldByName('DT_END').DisplayLabel:='окончание действия';
     Fquery.Fields.FieldByName('FIO').DisplayWidth:=18;
     Fquery.Fields.FieldByName('FIO').DisplayLabel:='пользователь';
     //теперь то, что не видимое
     Fquery.Fields.FieldByName('ID').Visible:=false;
  //настраиваем кнопки данной сетки
  SettingPAG;
  result:=true;
end;

procedure TmysheetSERTIFIKAT.SettingPAG;
var cmp:tcomponent;
begin
   //настраиваем кнопки и др. на форме по необходимости
  cmp:=self.parent_frm.FindComponent('Aadding');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='добавить сертификат';
     end;

  cmp:=self.parent_frm.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not FQuery.IsEmpty;
        TAction(cmp).Hint:='просмотреть';
     end;

  cmp:=self.parent_frm.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not FQuery.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.parent_frm.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
end;

{ TmysheetDELETEMNI }

constructor TmysheetDELETEMNI.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

destructor TmysheetDELETEMNI.Destroy;
begin
  inherited Destroy;
end;

function TmysheetDELETEMNI.loadDBGrid: boolean;
var tSQL:string;
begin
   tSQL:='select DELETE_MNI.ID as ID, DELETE_MNI.DT, MNI.UCHETN, MOTIVE_DELETE_MNI.NAME from DELETE_MNI JOIN MNI ON'+lineending+
   ' (DELETE_MNI.ID_MNI=MNI.ID) join MOTIVE_DELETE_MNI ON(MOTIVE_DELETE_MNI.ID=DELETE_MNI.ID_MOTIVE_DELETE_MNI)'+lineending+
  'where (MNI.ID_RAION='+inttostr(id_raion)+')'+lineending+
  'order by DELETE_MNI.DT, MNI.UCHETN';
  result:=false;
  //загружаем данные в сетку
  FTrans.DataBase:=connector;
  FQuery.DataBase:=connector;
  FQuery.Transaction:=FTrans;
  FQuery.SQL.Clear;
  Fquery.SQL.Add(tSQL);
  FQuery.ReadOnly:=true;
  FQuery.Open;
  FDS.DataSet:=FQuery;
  FDBGR.DataSource:=FDS;
  //первоначальная настройка
                   Fquery.Fields.FieldByName('DT').DisplayWidth:=8;
                   Fquery.Fields.FieldByName('DT').DisplayLabel:='дата списания';
                   Fquery.Fields.FieldByName('UCHETN').DisplayWidth:=5;
                   Fquery.Fields.FieldByName('UCHETN').DisplayLabel:='учетный номер';
                   Fquery.Fields.FieldByName('NAME').DisplayWidth:=30;
                   Fquery.Fields.FieldByName('NAME').DisplayLabel:='основание списания';
                   //теперь то, что не видимое
                   Fquery.Fields.FieldByName('ID').Visible:=false;
                   //настраиваем кнопки данной сетки
                   SettingPAG;
                   result:=true;
end;

procedure TmysheetDELETEMNI.SettingPAG;
var cmp:tcomponent;
begin
  //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.parent_frm.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.parent_frm.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not FQuery.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;
  cmp:=self.parent_frm.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   cmp:=self.parent_frm.FindComponent('Aakt');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Visible:=true;
        TAction(cmp).Hint:='выгрузить АКТ';
     end;
end;

{ TmysheetMNI }

constructor TmysheetMNI.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

destructor TmysheetMNI.Destroy;
begin
  inherited Destroy;
end;

function TmysheetMNI.loadDBGrid: boolean;
var tSQL:string;
begin
   tSQL:='select MNI.id as id, MNI_TIP.NAME as tip, PR_RASPR_MNI.NAME as raspr, MNI.UCHETN as uch, PEOPLES.FAM as fam, GROUPS.NAME as group_, MNI.SERIAL as serial,'+lineending+
   'MNI.SSIZE as ssize, MNI.DT as dt, MNI_MODEL.NAME as model_, MNI.OTKUDA as otkuda  from MNI  join MNI_TIP on (MNI.ID_TIP=MNI_TIP.ID)'+lineending+
   'join PR_RASPR_MNI on (MNI.ID_PR_RASPR=PR_RASPR_MNI.ID) join START_WORK on'+lineending+
   '(START_WORK.ID=MNI.ID_START_WORK) join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID) left join GROUPS'+lineending+
   'on (GROUPS.ID=START_WORK.ID_GROUP) left join MNI_MODEL on (MNI.ID_MODEL=MNI_MODEL.ID) where'+lineending+
   '(MNI.ID_RAION='+inttostr(id_raion)+')and'+lineending+
   '(not exists(select * from DELETE_MNI where DELETE_MNI.ID_MNI=MNI.ID))'+lineending+
  'order by MNI.DT';
  result:=false;
  //загружаем данные в сетку
  FTrans.DataBase:=connector;
  FQuery.DataBase:=connector;
  FQuery.Transaction:=FTrans;
  FQuery.SQL.Clear;
  Fquery.SQL.Add(tSQL);
  FQuery.ReadOnly:=true;
  FQuery.Open;
  FDS.DataSet:=FQuery;
  FDBGR.DataSource:=FDS;
  //первоначальная настройка
     Fquery.Fields.FieldByName('tip').DisplayWidth:=5;
     Fquery.Fields.FieldByName('raspr').DisplayWidth:=10;
     Fquery.Fields.FieldByName('uch').DisplayWidth:=8;
     Fquery.Fields.FieldByName('fam').DisplayWidth:=20;
     Fquery.Fields.FieldByName('group_').DisplayWidth:=8;
     Fquery.Fields.FieldByName('serial').DisplayWidth:=10;
     Fquery.Fields.FieldByName('ssize').DisplayWidth:=8;
     Fquery.Fields.FieldByName('dt').DisplayWidth:=8;
     Fquery.Fields.FieldByName('model_').DisplayWidth:=10;
     Fquery.Fields.FieldByName('otkuda').DisplayWidth:=20;
  //настраиваем кнопки данной сетки
  SettingPAG;
  result:=true;
end;

procedure TmysheetMNI.SettingPAG;
var cmp:tcomponent;
begin
  //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.parent_frm.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.parent_frm.FindComponent('Aadding');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='добавить МНИ';
     end;

  cmp:=self.parent_frm.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not FQuery.IsEmpty;
        TAction(cmp).Hint:='Внести изменения';
     end;

  cmp:=self.parent_frm.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not FQuery.IsEmpty;
        TAction(cmp).Hint:='снятие с учета МНИ';
     end;

  cmp:=self.parent_frm.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not FQuery.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.parent_frm.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
end;

{ TmysheetEmployeeTMPSTOP }

constructor TmysheetEmployeeTMPSTOP.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

destructor TmysheetEmployeeTMPSTOP.Destroy;
begin
  inherited Destroy;
end;

function TmysheetEmployeeTMPSTOP.loadDBGrid: boolean;
var tSQL:string;
begin
   tSQL:='select MOTIVE_TMP_STOP_SW.NAME, TMP_STOP_SW.DT_START, TMP_STOP_SW.DT_END, START_WORK.ID_PEOPLE, TMP_STOP_SW.ID as ID, RAIONS.NAME as rr, PEOPLES.FAM, PEOPLES.NAM, PEOPLES.OTCH, PEOPLES.REGISTRATION, PEOPLES.DTB, PEOPLES.PLB, POSTS.NAME as post, GROUPS.NAME as ngroup from TMP_STOP_SW JOIN START_WORK ON (TMP_STOP_SW.ID_START_WORK=START_WORK.ID) join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID) left join groups '+lineending+
  'on (START_WORK.ID_GROUP=GROUPS.ID) join POSTS ON (START_WORK.ID_POST=POSTS.ID) join RAIONS on (START_WORK.ID_RAION=RAIONS.ID) join MOTIVE_TMP_STOP_SW ON (TMP_STOP_SW.ID_MOTIVE_TMP_STOP_SW=MOTIVE_TMP_STOP_SW.ID) where ((START_WORK.ID_RAION='+
  inttostr(id_raion)+')/*and(TMP_STOP_SW.DT_END is null)*/)'+lineending+
  'order by TMP_STOP_SW.DT_START, MOTIVE_TMP_STOP_SW.NAME, ngroup, PEOPLES.FAM, PEOPLES.NAM, PEOPLES.OTCH ';
  result:=false;
  //загружаем данные в сетку
  FTrans.DataBase:=connector;
  FQuery.DataBase:=connector;
  FQuery.Transaction:=FTrans;
  FQuery.SQL.Clear;
  Fquery.SQL.Add(tSQL);
  FQuery.ReadOnly:=true;
  FQuery.Open;
  FDS.DataSet:=FQuery;
  FDBGR.DataSource:=FDS;
  //первоначальная настройка
                   Fquery.Fields.FieldByName('NAME').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('rr').DisplayWidth:=5;
                   Fquery.Fields.FieldByName('FAM').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('NAM').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('OTCH').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('post').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('ngroup').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('DTB').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('PLB').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('REGISTRATION').DisplayWidth:=20;
                   //настраиваем кнопки данной сетки
                   SettingPAG;
                   result:=true;

end;

procedure TmysheetEmployeeTMPSTOP.SettingPAG;
var cmp:tcomponent;
begin
  //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.parent_frm.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.parent_frm.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not FQuery.IsEmpty;
        TAction(cmp).Hint:='Внести изменения';
     end;
  cmp:=self.parent_frm.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not FQuery.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;
  cmp:=self.parent_frm.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
end;

{ TmysheetEmployeeUv }

constructor TmysheetEmployeeUv.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

destructor TmysheetEmployeeUv.Destroy;
begin
  inherited Destroy;
end;

function TmysheetEmployeeUv.loadDBGrid: boolean;
var tSQL:string;
begin
   tSQL:='select MOTIVE_DISCHARGE.NAME,START_WORK.ID_PEOPLE, DISCHARGE.ID as ID, RAIONS.NAME as rr, PEOPLES.FAM, PEOPLES.NAM, PEOPLES.OTCH, PEOPLES.REGISTRATION, PEOPLES.DTB, PEOPLES.PLB, POSTS.NAME as post, GROUPS.NAME as ngroup from DISCHARGE JOIN START_WORK ON (DISCHARGE.ID_START_WORK=START_WORK.ID) join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID) left join groups '+lineending+
  'on (START_WORK.ID_GROUP=GROUPS.ID) join POSTS ON (START_WORK.ID_POST=POSTS.ID) join RAIONS on (START_WORK.ID_RAION=RAIONS.ID) join MOTIVE_DISCHARGE ON (DISCHARGE.ID_MOTIVE_DISCHARGE=MOTIVE_DISCHARGE.ID) where (START_WORK.ID_RAION='+
  inttostr(id_raion)+')'+lineending+
  'order by DISCHARGE.DT, ngroup, PEOPLES.FAM, PEOPLES.NAM, PEOPLES.OTCH';
  result:=false;
  //загружаем данные в сетку
  FTrans.DataBase:=connector;
  FQuery.DataBase:=connector;
  FQuery.Transaction:=FTrans;
  FQuery.SQL.Clear;
  Fquery.SQL.Add(tSQL);
  FQuery.ReadOnly:=true;
  FQuery.Open;
  FDS.DataSet:=FQuery;
  FDBGR.DataSource:=FDS;
  //первоначальная настройка
                   Fquery.Fields.FieldByName('NAME').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('rr').DisplayWidth:=5;
                   Fquery.Fields.FieldByName('FAM').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('NAM').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('OTCH').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('post').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('ngroup').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('DTB').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('PLB').DisplayWidth:=20;
                   Fquery.Fields.FieldByName('REGISTRATION').DisplayWidth:=20;
                   //настраиваем кнопки данной сетки
                   SettingPAG;
                   result:=true;
end;

procedure TmysheetEmployeeUv.SettingPAG;
var cmp:tcomponent;
begin
  //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.parent_frm.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.parent_frm.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not FQuery.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;
  cmp:=self.parent_frm.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
   cmp:=self.parent_frm.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not FQuery.IsEmpty;
        TAction(cmp).Hint:='Внести изменения';
     end;
end;

{ TmysheetEmployee }

procedure TmysheetEmployee.SettingPAG;
var cmp:tcomponent;
begin
  //настраиваем кнопки и др. на форме по необходимости
  //TAction(self.parent_frm.FindComponent('Aadding111')).Visible:=true;
  cmp:=self.parent_frm.FindComponent('Aadding');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='добавить сотрудника';
     end;

  cmp:=self.parent_frm.FindComponent('AEditing');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not FQuery.IsEmpty;
        TAction(cmp).Hint:='Внести изменения';
     end;

  cmp:=self.parent_frm.FindComponent('aMoving');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not FQuery.IsEmpty;
        TAction(cmp).Hint:='Временное прекращение';
     end;

  cmp:=self.parent_frm.FindComponent('ADeleting');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=not FQuery.IsEmpty;
        TAction(cmp).Hint:='увольнение сотрудника';
     end;

  cmp:=self.parent_frm.FindComponent('AUpdating');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;//not FQuery.IsEmpty;
        TAction(cmp).Hint:='Обновить данные';
     end;

  cmp:=self.parent_frm.FindComponent('AExit');
  if cmp<>nil then
     begin
        TAction(cmp).Enabled:=true;
        TAction(cmp).Hint:='закрыть журнал';
     end;
end;

constructor TmysheetEmployee.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
end;

destructor TmysheetEmployee.Destroy;
begin
  inherited Destroy;
end;

function TmysheetEmployee.loadDBGrid: boolean;
var tSQL:string;
begin
   tSQL:='select START_WORK.TABNOM, START_WORK.ID_PEOPLE, START_WORK.ID as ID, RAIONS.NAME as rr,'+lineending+
   ' PEOPLES.FAM, PEOPLES.NAM, PEOPLES.OTCH, POSTS.NAME as post, GROUPS.NAME as ngroup, LOCATIONS.NAME as loc,'+lineending+
   ' PEOPLES.DTB, PEOPLES.REGISTRATION, PEOPLES.PLB'+lineending+
   ' from START_WORK  join PEOPLES ON (START_WORK.ID_PEOPLE=PEOPLES.ID) left join groups '+lineending+
  'on (START_WORK.ID_GROUP=GROUPS.ID) join POSTS ON (START_WORK.ID_POST=POSTS.ID)'+lineending+
  ' join RAIONS on (START_WORK.ID_RAION=RAIONS.ID) join LOCATIONS on (LOCATIONS.ID=START_WORK.ID_LOCATION) where (START_WORK.ID_RAION='+
  inttostr(id_raion)+')and(not exists(select * from DISCHARGE where DISCHARGE.ID_START_WORK=START_WORK.ID))'+LINEENDING+
  'and(not exists(select * from TMP_STOP_SW where ((TMP_STOP_SW.ID_START_WORK=START_WORK.ID)and(TMP_STOP_SW.DT_END is NULL))))'+lineending+
  'order by ngroup, PEOPLES.FAM, PEOPLES.NAM, PEOPLES.OTCH';
  result:=false;
  //загружаем данные в сетку
  FTrans.DataBase:=connector;
  FQuery.DataBase:=connector;
  FQuery.Transaction:=FTrans;
  FQuery.SQL.Clear;
  Fquery.SQL.Add(tSQL);
  FQuery.ReadOnly:=true;
  FQuery.Open;
  FDS.DataSet:=FQuery;
  FDBGR.DataSource:=FDS;
  //первоначальная настройка
  //сначало то, что видимое
     Fquery.Fields.FieldByName('TABNOM').DisplayWidth:=5;
     Fquery.Fields.FieldByName('TABNOM').DisplayLabel:='таб.№';
     Fquery.Fields.FieldByName('FAM').DisplayWidth:=11;
     Fquery.Fields.FieldByName('FAM').DisplayLabel:='Фамилия';
     Fquery.Fields.FieldByName('NAM').DisplayWidth:=9;
     Fquery.Fields.FieldByName('NAM').DisplayLabel:='Имя';
     Fquery.Fields.FieldByName('OTCH').DisplayWidth:=14;
     Fquery.Fields.FieldByName('OTCH').DisplayLabel:='Отчество';
     Fquery.Fields.FieldByName('post').DisplayWidth:=36;
     Fquery.Fields.FieldByName('post').DisplayLabel:='Должность';
     Fquery.Fields.FieldByName('ngroup').DisplayWidth:=20;
     Fquery.Fields.FieldByName('ngroup').DisplayLabel:='Группа';
     Fquery.Fields.FieldByName('DTB').DisplayWidth:=10;
     Fquery.Fields.FieldByName('DTB').DisplayLabel:='дата рождения';
     Fquery.Fields.FieldByName('PLB').DisplayWidth:=10;
     Fquery.Fields.FieldByName('PLB').DisplayLabel:='место рождения';
     Fquery.Fields.FieldByName('REGISTRATION').DisplayWidth:=10;
     Fquery.Fields.FieldByName('REGISTRATION').DisplayLabel:='место регистрации';
     Fquery.Fields.FieldByName('loc').DisplayWidth:=10;
     Fquery.Fields.FieldByName('loc').DisplayLabel:='местоположение';
     //теперь то, что не видимое
     Fquery.Fields.FieldByName('rr').Visible:=false;
     Fquery.Fields.FieldByName('rr').DisplayWidth:=5;
     Fquery.Fields.FieldByName('rr').DisplayLabel:='район';
     Fquery.Fields.FieldByName('id').Visible:=false;
     Fquery.Fields.FieldByName('ID_PEOPLE').Visible:=false;
  //настраиваем кнопки данной сетки
  SettingPAG;
  result:=true;
end;      }

end.

