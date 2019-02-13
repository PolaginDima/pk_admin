unit forslovari;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, TDBSlovariTemplateForm,{TDBSlovariTemplateForm2,} forms, dialogs,sqldb,db,
  controls,graphics,dbgrids, grids;



procedure slovaripeople(var f:TForm);
procedure slovaripeople2(var f:TForm;var o:TObject);
procedure slovaripeople3(var f:TForm;var o:TObject);
function QUERYSLOVAR(var Q:Tsqlquery;var T:Tsqltransaction;const zapros:string):boolean;
implementation
uses workBD, myDBGrid,main;
procedure slovaripeople(var f: TForm);

begin
  TDBTemplateForm(f).DBGR.Columns.Items[TDBTemplateForm(f).DBGR.Columns.Count-1].ButtonStyle:= cbsButton;
  TDBTemplateForm(f).DBGR.Columns.Items[TDBTemplateForm(f).DBGR.Columns.Count-2].ButtonStyle:= cbsButton;
end;

procedure slovaripeople2(var f: TForm; var o: TObject);
type
  setqr=record
  //setgr=record
    width:integer;
    DisplayLabel:string;
    Visible:boolean;
  end;

var queryworks, Qtmp:tsqlquery;
  tmpDS:Tdatasource;
  transworks:tsqltransaction;
  DBTemplateForm_: TDBTemplateForm;
 { qr:tsqlquery;
  tr:tsqltransaction;  }
  Fld:TField;
  FieldDef: TFieldDef;
  i, j:integer;
  stqr:array of setqr;
begin
  if (Tdbgrid(o).SelectedColumn.Index=(Tdbgrid(o).Columns.Count-2)) then
  //Предыдущая(ие) работы
  begin
  if TDBTemplateForm(f).DBGR.DataSource.DataSet.IsEmpty then exit;
  DBTemplateForm_:=TDBTemplateForm.Create(application);
   transworks:=tsqltransaction.Create(DBTemplateForm_.Owner);
     queryworks:=tsqlquery.Create(DBTemplateForm_.Owner);
     QUERYSLOVAR( queryworks,transworks, 'select * from works where (id_people='+TDBTemplateForm(f).DBGR.DataSource.DataSet.FieldByName('ID').AsString+')');
    { queryworks.Fields.Fields[0].Visible:=false;
     queryworks.Fields.Fields[0].ProviderFlags:=queryworks.Fields.Fields[0].ProviderFlags+[pfInKey];
     queryworks.Fields.FieldByName('name').DisplayLabel:='название локации';
     queryworks.Fields.FieldByName('name').DisplayWidth:=80;  }
     queryworks.Active:=false;
     /////
     FieldDef:=queryworks.FieldDefs.Find('ID');
     fld:=FieldDef.CreateField(queryworks);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     fld.ProviderFlags:=fld.ProviderFlags+[pfInKey];
     //---------------------
     FieldDef:=queryworks.FieldDefs.Find('NAME');
     fld:=FieldDef.CreateField(queryworks);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='место работы';
     fld.DisplayWidth:=40;
     //-----------------------
      FieldDef:=queryworks.FieldDefs.Find('ID_PEOPLE');
     fld:=FieldDef.CreateField(queryworks);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     /////////////////
     queryworks.Active:=true;
  tmpDS:=tdatasource.Create(DBTemplateForm_.Owner);
  tmpDS.DataSet:=queryworks;

 // with  DBTemplateForm_ do
 // begin
  try
  //Создадим таймер
  //Загрузим наборы данных
  //если форма загружена для выбора, то отобразим кнопку выбора
  DBTemplateForm_.Aselect.visible:=false;
  DBTemplateForm_.Aadding.Enabled:=true;
  DBTemplateForm_.Caption:='предыдущие места работы';
  DBTemplateForm_.Generator:='GEN_SLOVAR_ID';
  DBTemplateForm_.IDPole:='ID,'+TDBTemplateForm(f).DBGR.DataSource.DataSet.FieldByName('ID').AsString;
  DBTemplateForm_.ProcGenerator:=@Zapolnenie2;
  //DBTemplateForm.Name:='form'+inttostr(nomerF);
  /////////////
   //Создадим свой компонент потомок от DBGRID
   //с возможностью разукрашивать заголовки
   DBTemplateForm_.DBGR:=TMydbgrid.Create(DBTemplateForm_.Owner);
  DBTemplateForm_.dbgr.Parent:=DBTemplateForm_;
  DBTemplateForm_.dbgr.Align:=alTop;
  DBTemplateForm_.DSV:=tmpDS;

  //DBTemplateForm.dbgr.DataSource:=QUERY.DataSource;//ds;
  ////////////
  DBTemplateForm_.trr:=transworks;
  {tr:=tsqltransaction.Create(f.Owner);
  tr:=DBTemplateForm_.trr; //????}
  //Обнулим фильтр
  queryworks.Filtered:=false;
  queryworks.Filter:='';
  DBTemplateForm_.qrr:=queryworks;
  DBTemplateForm_.qrrV:=queryworks;
  DBTemplateForm_.DSV.DataSet:=DBTemplateForm_.qrrV;
  DBTemplateForm_.dbgr.DataSource:=DBTemplateForm_.DSV;
  {qr:= DBTemplateForm_.qrr;
   //Обнулим фильтр
  qr.Filtered:=false;
  qr.Filter:='';//???  }
  DBTemplateForm_.dbgr.Height:=200;
  DBTemplateForm_.dbgr.Top:=30;;
  DBTemplateForm_.dbgr.ReadOnly:=false;
  DBTemplateForm_.dbgr.Visible:=true;
  DBTemplateForm_.dbgr.FiltrMarkColor:=clBlue;//Цвет разукрашенного заголовка
  DBTemplateForm_.dbgr.FiltrMarkFontColor:=clwhite;//Цвет букв разукрашенного заголовка
  DBTemplateForm_.dbgr.EnabledMarkFiltr:=true;//Включаем фльтрацию и подсветку
 { for i:=0 to  DBTemplateForm_.qrr.FieldCount-1 do
  begin
    showmessage(DBTemplateForm_.qrr.Fields.Fields[i].FieldName);
  end;  }
  i:=TDBTemplateForm(f).qrrV.FieldByName('ID').AsInteger;
  DBTemplateForm_.showmodal;
  TDBTemplateForm(f).qrrV.DisableControls;
  setlength(stqr,TDBTemplateForm(f).qrrV.FieldCount);
  for j:=0 to TDBTemplateForm(f).qrrV.FieldCount-1 do
  begin
    stqr[j].width:=TDBTemplateForm(f).qrrV.Fields.Fields[j].DisplayWidth;
    stqr[j].DisplayLabel:=TDBTemplateForm(f).qrrV.Fields.Fields[j].DisplayLabel;
    stqr[j].Visible:=TDBTemplateForm(f).qrrV.Fields.Fields[j].Visible;
  end;
  TDBTemplateForm(f).trr.Rollback;
  //TDBTemplateForm(f).qrr.Close;TDBTemplateForm(f).qrrv.Close;
  TDBTemplateForm(f).qrr.Open;TDBTemplateForm(f).qrrv.Open;
  TDBTemplateForm(f).qrrV.Locate('ID',i,[]);
  for j:=0 to TDBTemplateForm(f).qrrV.FieldCount-1 do
  begin
   TDBTemplateForm(f).qrrV.Fields.Fields[j].DisplayWidth:=stqr[j].width;
   TDBTemplateForm(f).qrrV.Fields.Fields[j].DisplayLabel:=stqr[j].DisplayLabel;
   TDBTemplateForm(f).qrrV.Fields.Fields[j].Visible:=stqr[j].Visible;
  end;
  TDBTemplateForm(f).qrrV.EnableControls;
  finally
  DBTemplateForm_.free;
end;
  end else
  //Дети
  begin
   if TDBTemplateForm(f).DBGR.DataSource.DataSet.IsEmpty then exit;
  DBTemplateForm_:=TDBTemplateForm.Create(application);
   transworks:=tsqltransaction.Create(DBTemplateForm_.Owner);
     queryworks:=tsqlquery.Create(DBTemplateForm_.Owner);
     Qtmp:=tsqlquery.Create(DBTemplateForm_.Owner);
     QUERYSLOVAR( queryworks,transworks, 'select * from childrens where (id_people='+TDBTemplateForm(f).DBGR.DataSource.DataSet.FieldByName('ID').AsString+')');
     QUERYSLOVAR( Qtmp,transworks, 'select * from (select 1 as ID, ''мальчик'' as name from rdb$database'+lineending+
     'union all select 2 as ID, ''девочка'' as name from rdb$database) order by name DESC');
     queryworks.Active:=false;
     /////
     FieldDef:=queryworks.FieldDefs.Find('ID');
     fld:=FieldDef.CreateField(queryworks);
     //Тут если надо настраиваем fld
     fld.Visible:=false;
     fld.ProviderFlags:=fld.ProviderFlags+[pfInKey];
     //---------------------
     FieldDef:=queryworks.FieldDefs.Find('FAM');
     fld:=FieldDef.CreateField(queryworks);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='фамилия';
     fld.DisplayWidth:=40;
     //---------------------
     FieldDef:=queryworks.FieldDefs.Find('NAM');
     fld:=FieldDef.CreateField(queryworks);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='имя';
     fld.DisplayWidth:=40;
     //---------------------
     FieldDef:=queryworks.FieldDefs.Find('OTCH');
     fld:=FieldDef.CreateField(queryworks);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='отчество';
     fld.DisplayWidth:=40;
     //---------------------
     FieldDef:=queryworks.FieldDefs.Find('DTB');
     fld:=FieldDef.CreateField(queryworks);
     //Тут если надо настраиваем fld
     fld.DisplayLabel:='дата рождения';
     fld.DisplayWidth:=40;
     //-----------------------
      FieldDef:=queryworks.FieldDefs.Find('ID_PEOPLE');
     fld:=FieldDef.CreateField(queryworks);
     //Тут если надо настраиваем fld
     fld.Visible:=false;

      //-----------------------
      FieldDef:=queryworks.FieldDefs.Find('ID_SEX');
     fld:=FieldDef.CreateField(queryworks);
     //Тут если надо настраиваем fld
     fld.Visible:=false;

      //-----------------------
      FieldDef:=queryworks.FieldDefs.Find('ID_USER');
     fld:=FieldDef.CreateField(queryworks);
     //Тут если надо настраиваем fld
     fld.Visible:=false;

      //-----------------------
      FieldDef:=queryworks.FieldDefs.Find('ID_RAION');
     fld:=FieldDef.CreateField(queryworks);
     //Тут если надо настраиваем fld
     fld.Visible:=false;

     //Ниже создаем lookup поле
     fld:=TStringField.Create(queryworks);
     fld.FieldKind:=fkLookup;
     fld.KeyFields:='ID_SEX';
     fld.LookupDataSet:=Qtmp;
     fld.LookupKeyFields:='ID';
     fld.LookupResultField:='NAME';
     fld.DataSet:=queryworks;
     fld.DisplayLabel:='пол';
     fld.ProviderFlags:=[];
     fld.Name:='sex';
     fld.Required:=true;
     fld.FieldName:='sex';
     fld.DisplayWidth:=5;

     /////////////////
     queryworks.Active:=true;
  tmpDS:=tdatasource.Create(DBTemplateForm_.Owner);
  tmpDS.DataSet:=queryworks;

 // with  DBTemplateForm_ do
 // begin
  try

  //Загрузим наборы данных
  //если форма загружена для выбора, то отобразим кнопку выбора
  DBTemplateForm_.Aselect.visible:=false;
  DBTemplateForm_.Aadding.Enabled:=true;
  DBTemplateForm_.Caption:='Дети';
  DBTemplateForm_.Generator:='GEN_SLOVAR_ID';
  DBTemplateForm_.IDPole:='ID,'+TDBTemplateForm(f).DBGR.DataSource.DataSet.FieldByName('ID').AsString;
  DBTemplateForm_.ProcGenerator:=@Zapolnenie2;
  //DBTemplateForm.Name:='form'+inttostr(nomerF);
  /////////////
   //Создадим свой компонент потомок от DBGRID
   //с возможностью разукрашивать заголовки
   DBTemplateForm_.DBGR:=TMydbgrid.Create(DBTemplateForm_.Owner);
  DBTemplateForm_.dbgr.Parent:=DBTemplateForm_;
  DBTemplateForm_.dbgr.Align:=alTop;
  DBTemplateForm_.DSV:=tmpDS;

  //DBTemplateForm.dbgr.DataSource:=QUERY.DataSource;//ds;
  ////////////
  DBTemplateForm_.trr:=transworks;
  {tr:=tsqltransaction.Create(f.Owner);
  tr:=DBTemplateForm_.trr; //????}
  //Обнулим фильтр
  queryworks.Filtered:=false;
  queryworks.Filter:='';
  DBTemplateForm_.qrr:=queryworks;
  DBTemplateForm_.qrrV:=queryworks;
  DBTemplateForm_.DSV.DataSet:=DBTemplateForm_.qrrV;
  DBTemplateForm_.dbgr.DataSource:=DBTemplateForm_.DSV;
  {qr:= DBTemplateForm_.qrr;
   //Обнулим фильтр
  qr.Filtered:=false;
  qr.Filter:='';//???  }
  DBTemplateForm_.dbgr.Height:=200;
  DBTemplateForm_.dbgr.Top:=30;;
  DBTemplateForm_.dbgr.ReadOnly:=false;
  DBTemplateForm_.dbgr.Visible:=true;
  DBTemplateForm_.dbgr.FiltrMarkColor:=clBlue;//Цвет разукрашенного заголовка
  DBTemplateForm_.dbgr.FiltrMarkFontColor:=clwhite;//Цвет букв разукрашенного заголовка
  DBTemplateForm_.dbgr.EnabledMarkFiltr:=true;//Включаем фльтрацию и подсветку

  i:=TDBTemplateForm(f).qrrV.FieldByName('ID').AsInteger;
  DBTemplateForm_.showmodal;
  //Теперь обновим сетку предварительно запомнив положение курсора
  TDBTemplateForm(f).qrrV.DisableControls;
  setlength(stqr,TDBTemplateForm(f).qrrV.FieldCount);
  for j:=0 to TDBTemplateForm(f).qrrV.FieldCount-1 do
  begin
    stqr[j].width:=TDBTemplateForm(f).qrrV.Fields.Fields[j].DisplayWidth;
    stqr[j].DisplayLabel:=TDBTemplateForm(f).qrrV.Fields.Fields[j].DisplayLabel;
    stqr[j].Visible:=TDBTemplateForm(f).qrrV.Fields.Fields[j].Visible;
  end;
  TDBTemplateForm(f).trr.Rollback;
  //TDBTemplateForm(f).qrr.Close;TDBTemplateForm(f).qrrv.Close;
  TDBTemplateForm(f).qrr.Open;TDBTemplateForm(f).qrrv.Open;
  TDBTemplateForm(f).qrrV.Locate('ID',i,[]);
  for j:=0 to TDBTemplateForm(f).qrrV.FieldCount-1 do
  begin
   TDBTemplateForm(f).qrrV.Fields.Fields[j].DisplayWidth:=stqr[j].width;
   TDBTemplateForm(f).qrrV.Fields.Fields[j].DisplayLabel:=stqr[j].DisplayLabel;
   TDBTemplateForm(f).qrrV.Fields.Fields[j].Visible:=stqr[j].Visible;
  end;
  TDBTemplateForm(f).qrrV.EnableControls;
  finally
  DBTemplateForm_.free;
end;
  end;
  //end;
end;

procedure slovaripeople3(var f: TForm; var o: TObject);
var query:tsqlquery;
  trans:tsqltransaction;
begin
  trans:=tsqltransaction.Create(application);
  trans.DataBase:=mainf.connector;
  query:=tsqlquery.Create(application);
  query.DataBase:=mainf.connector;
   query.SQL.Clear;
   query.SQL.Add('select idcount(id) from works where (id_peoples=:id)');
   query.Transaction:=trans;
//  TDataSet(o).FieldByName;
end;

function QUERYSLOVAR(var Q: Tsqlquery; var T: Tsqltransaction;
  const zapros: string): boolean;
begin
   result:=false;
   T.DataBase:=mainf.connector;
   Q.Transaction:=T;
   Q.DataBase:=mainf.connector;
   Q.Active:=false;
   Q.SQL.Clear;
   Q.SQL.Add(zapros);
   try
          Q.Active:=true;
          result:=true;
   except
     on E: Exception do
      begin
        if (pos('no permission for read/select',e.message)>0) then
        MessageDlg('Предупреждение','Операция отменена. У вас нет доступа на чтение'{+lineending+'Ошибка'+lineending+
        'Exception: '+E.ClassName+': '+E.Message}, mtError, [mbOk],0);
      end;
   end;
end;


end.

