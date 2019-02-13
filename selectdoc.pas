unit selectDOC;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, StdCtrls, sqldb, lazutf8, dateutils;

type

  { TviborDoc }

  TviborDoc = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Fconn: TSQLconnector;
    FID: integer;
    Fnom: integer;
    FN_journal: integer;
    procedure Setconn(AValue: TSQLconnector);
    procedure SetID(AValue: integer);
    procedure Setnom(AValue: integer);
    procedure SetN_journal(AValue: integer);
    { private declarations }
  public
    { public declarations }
    property conn:TSQLconnector read Fconn write Setconn;
    property ID:integer read FID write SetID;
    property N_journal:integer read FN_journal write SetN_journal;
    property nom:integer read Fnom write Setnom;
  end;

var
  viborDoc: TviborDoc ;

implementation
 uses workbd, createDOC;
{$R *.lfm}

{ TviborDoc }

procedure TviborDoc.Button1Click(Sender: TObject);
var  myDOCS:TmyDOCS;
  Qr, qr2:TSQLQuery;
  Tr:TSQLTransaction;
  stmp:string;
   dty, dtm, dtd, dty2, dtm2, dtd2,timeH,timeM:string;
   H,M,s,ms:word;
   sdop:string;
begin
  case self.FN_journal of
        0:begin
             if ComboBox1.ItemIndex<0 then exit;
             case self.ComboBox1.ItemIndex of
                    0:begin//Заявка на регистрацию пользователя VipNet
                     try
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;

                       stmp:='select POSTS.NAME as dolj, GROUPS.NAME as gr, START_WORK.TABNOM, t1.FAM as FAM2, t1.NAM as NAM2, t1.OTCH as OTCH2, t1.SNILS,'+lineending+
                       'LEFT(t1.NAM,1) as NM2, LEFT(t1.OTCH,1) as OT2,'+lineending+
                       'RAIONS.ADDRESS, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, LEFT(t3.NAM,1) as NM1, LEFT(t3.OTCH,1) as OT1,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, RAIONS.INN as INN, RAIONS.OGRN as OGRN,'+lineending+
                       'LOCATIONS.NAME as lNAME, TERRITOR.ADDRESS as tname'+lineending+
                       ' from START_WORK  join PEOPLES as t1 on (START_WORK.ID_PEOPLE=t1.ID) '+lineending+
                       'join RAIONS on (RAIONS.ID=START_WORK.ID_RAION) '+lineending+
                       'join POSTS on (START_WORK.ID_POST=POSTS.ID)'+lineending+
                       'join LOCATIONS on (LOCATIONS.ID=START_WORK.ID_LOCATION)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'left join GROUPS on (START_WORK.ID_GROUP=GROUPS.ID)'+lineending+
                       'left join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
                       'left join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
                       'where (START_WORK.ID='+inttostr(self.FID)+')/*and*/'+lineending+
                       '';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       if qr.IsEmpty then
                       begin
                        messagedlg('информация','нет записей для сотрудника',mtInformation,[mbok],0);
                        exit;
                       end;
                       myDOCS:=TmyDOCS.Create(ttaZaiv_RP,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
                    1:begin//Заявка на добавление связи(VipNet)
                     try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;

                       stmp:='select POSTS.NAME as dolj, GROUPS.NAME as gr, START_WORK.TABNOM, t1.FAM as FAM2, t1.NAM as NAM2, t1.OTCH as OTCH2, t1.SNILS,'+lineending+
                       'LEFT(t1.NAM,1) as NM2, LEFT(t1.OTCH,1) as OT2,'+lineending+
                       'RAIONS.ADDRESS, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, LEFT(t3.NAM,1) as NM1, LEFT(t3.OTCH,1) as OT1,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, RAIONS.INN as INN, RAIONS.OGRN as OGRN,'+lineending+
                       'LOCATIONS.NAME as LNAME, TERRITOR.ADDRESS as tname'+lineending+
                       ' from START_WORK  join PEOPLES as t1 on (START_WORK.ID_PEOPLE=t1.ID) '+lineending+
                       'join RAIONS on (RAIONS.ID=START_WORK.ID_RAION) '+lineending+
                       'join POSTS on (START_WORK.ID_POST=POSTS.ID)'+lineending+
                       'join LOCATIONS on (LOCATIONS.ID=START_WORK.ID_LOCATION)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'left join GROUPS on (START_WORK.ID_GROUP=GROUPS.ID)'+lineending+
                       'left join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
                       'left join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
                       'where (START_WORK.ID='+inttostr(self.FID)+')/*and*/'+lineending+
                       '';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       if qr.IsEmpty then
                       begin
                        messagedlg('информация','нет записей для сотрудника',mtInformation,[mbok],0);
                        exit;
                       end;
                       myDOCS:=TmyDOCS.Create(ttaZaiv_Sviaz,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
                    2:begin
                     try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;

                       stmp:='select 0 as sort, ''системный блок'' as TNAME,'+lineending+
                       't4.NAME as LNAME, t3.NAME as SBNAME,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, SB.SERIAL, SB.INVENT, t2.FAM as FAM2, t2.NAM as NAM2, t2.OTCH as OTCH2'+lineending+
                       ',TERRITOR.ADDRESS as tname from START_WORK as t1  join PEOPLES as t2 on (t1.ID_PEOPLE=t2.ID) '+lineending+
                       'join RAIONS on (RAIONS.ID=t1.ID_RAION) '+lineending+
                       'join SB on (SB.ID_START_WORK=t1.ID)'+lineending+
                       'join NAME_SB as t3 on (t3.ID=SB.ID_NAME_SB)'+lineending+
                       'join LOCATIONS as t4 on (t4.ID=t1.ID_LOCATION)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'join PR_RASPR_SB on (PR_RASPR_SB.ID=SB.ID_PR_RASPR)'+lineending+
                       ''+lineending+
                       ''+lineending+
                       ''+lineending+
                       'where (t1.ID='+inttostr(self.FID)+')and'+lineending+
                       '(lower(PR_RASPR_SB.NAME) starting with ''распреде'')'+lineending+
                       'UNION ALL'+lineending+
                       'select 1 as sort, ''монитор'' as TNAME,'+lineending+
                       't4.NAME as LNAME, t3.NAME as SBNAME,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, RAZNOE.SERIAL, RAZNOE.INVENT, t2.FAM as FAM2, t2.NAM as NAM2, t2.OTCH as OTCH2'+lineending+
                       ',TERRITOR.ADDRESS as tname from START_WORK as t1  join PEOPLES as t2 on (t1.ID_PEOPLE=t2.ID) '+lineending+
                       'join RAIONS on (RAIONS.ID=t1.ID_RAION) '+lineending+
                       'join RAZNOE on (RAZNOE.ID_START_WORK=t1.ID)'+lineending+
                       'join RAZNOE_MODEL as t3 on (t3.ID=RAZNOE.ID_MODEL)'+lineending+
                       'join RAZNOE_TIP on (RAZNOE_TIP.ID=RAZNOE.ID_TIP)'+lineending+
                       'join LOCATIONS as t4 on (t4.ID=t1.ID_LOCATION)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'join PR_RASPR_RAZNOE on (PR_RASPR_RAZNOE.ID=RAZNOE.ID_PR_RASPR)'+lineending+
                       ''+lineending+
                       'where (t1.ID='+inttostr(self.FID)+')and'+lineending+
                       '(upper(RAZNOE_TIP.NAME) starting with ''МОНИТОР'')and'+lineending+
                       '(lower(PR_RASPR_RAZNOE.NAME) starting with ''распреде'')'+lineending+
                       'UNION ALL'+lineending+
                       'select 2 as sort, ''принтер'' as TNAME,'+lineending+
                       't4.NAME as LNAME, t3.NAME as SBNAME,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, RAZNOE.SERIAL, RAZNOE.INVENT, t2.FAM as FAM2, t2.NAM as NAM2, t2.OTCH as OTCH2'+lineending+
                       ',TERRITOR.ADDRESS as tname from START_WORK as t1  join PEOPLES as t2 on (t1.ID_PEOPLE=t2.ID) '+lineending+
                       'join RAIONS on (RAIONS.ID=t1.ID_RAION) '+lineending+
                       'join RAZNOE on (RAZNOE.ID_START_WORK=t1.ID)'+lineending+
                       'join RAZNOE_MODEL as t3 on (t3.ID=RAZNOE.ID_MODEL)'+lineending+
                       'join RAZNOE_TIP on (RAZNOE_TIP.ID=RAZNOE.ID_TIP)'+lineending+
                       'join LOCATIONS as t4 on (t4.ID=t1.ID_LOCATION)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'join PR_RASPR_RAZNOE on (PR_RASPR_RAZNOE.ID=RAZNOE.ID_PR_RASPR)'+lineending+
                       ''+lineending+
                       'where (t1.ID='+inttostr(self.FID)+')and'+lineending+
                       '(upper(RAZNOE_TIP.NAME) starting with ''ПРИНТЕР'')and'+lineending+
                       '(lower(PR_RASPR_RAZNOE.NAME) starting with ''распреде'')'+lineending+
                       'UNION ALL'+lineending+
                       'select 3 as sort, ''сканер'' as TNAME,'+lineending+
                       't4.NAME as LNAME, t3.NAME as SBNAME,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, RAZNOE.SERIAL, RAZNOE.INVENT, t2.FAM as FAM2, t2.NAM as NAM2, t2.OTCH as OTCH2'+lineending+
                       ',TERRITOR as tname from START_WORK as t1  join PEOPLES as t2 on (t1.ID_PEOPLE=t2.ID) '+lineending+
                       'join RAIONS on (RAIONS.ID=t1.ID_RAION) '+lineending+
                       'join RAZNOE on (RAZNOE.ID_START_WORK=t1.ID)'+lineending+
                       'join RAZNOE_MODEL as t3 on (t3.ID=RAZNOE.ID_MODEL)'+lineending+
                       'join RAZNOE_TIP on (RAZNOE_TIP.ID=RAZNOE.ID_TIP)'+lineending+
                       'join LOCATIONS as t4 on (t4.ID=t1.ID_LOCATION)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'join PR_RASPR_RAZNOE on (PR_RASPR_RAZNOE.ID=RAZNOE.ID_PR_RASPR)'+lineending+
                       ''+lineending+
                       'where (t1.ID='+inttostr(self.FID)+')and'+lineending+
                       '(upper(RAZNOE_TIP.NAME) starting with ''СКАНЕР'')and'+lineending+
                       '(lower(PR_RASPR_RAZNOE.NAME) starting with ''распреде'')'+lineending+
                       '/*UNION ALL'+lineending+
                       'select 4 as sort, RAZNOE_TIP.NAME as TNAME,'+lineending+
                       't4.NAME as LNAME, t3.NAME as SBNAME,'+lineending+
                       'RAZNOE.SERIAL, RAZNOE.INVENT, t2.FAM as FAM2, t2.NAM as NAM2, t2.OTCH as OTCH2'+lineending+
                       ',TERRITOR.ADDRESS as tname from START_WORK as t1  join PEOPLES as t2 on (t1.ID_PEOPLE=t2.ID) '+lineending+
                       'join RAZNOE on (RAZNOE.ID_START_WORK=t1.ID)'+lineending+
                       'join RAZNOE_MODEL as t3 on (t3.ID=RAZNOE.ID_MODEL)'+lineending+
                       'join RAZNOE_TIP on (RAZNOE_TIP.ID=RAZNOE.ID_TIP)'+lineending+
                       'join LOCATIONS as t4 on (t4.ID=t1.ID_LOCATION)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       ''+lineending+
                       'where (t1.ID='+inttostr(self.FID)+')and'+lineending+
                       '(not((upper(RAZNOE_TIP.NAME) starting with ''СКАНЕР'')or(upper(RAZNOE_TIP.NAME) starting with ''ПРИНТЕР'')or(upper(RAZNOE_TIP.NAME) starting with ''МОНИТОР'')))*/'+lineending+
                       '';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       if qr.IsEmpty then
                       begin
                        messagedlg('информация','нет записей для сотрудника',mtInformation,[mbok],0);
                        exit;
                       end;
                       myDOCS:=TmyDOCS.Create(ttaKART_TEHN,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
                    3:begin  //Заявка на установку криптосредства
                     try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;

                       stmp:='select POSTS.NAME as dolj, GROUPS.NAME as gr, START_WORK.TABNOM, t1.FAM as FAM2, t1.NAM as NAM2, t1.OTCH as OTCH2, t1.SNILS,'+lineending+
                       'LEFT(t1.NAM,1) as NM2, LEFT(t1.OTCH,1) as OT2,'+lineending+
                       'RAIONS.ADDRESS, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, LEFT(t3.NAM,1) as NM1, LEFT(t3.OTCH,1) as OT1,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, RAIONS.INN as INN, RAIONS.OGRN as OGRN,'+lineending+
                       'LOCATIONS.NAME as lNAME,TERRITOR.ADDRESS as tname'+lineending+
                       ' from START_WORK  join PEOPLES as t1 on (START_WORK.ID_PEOPLE=t1.ID) '+lineending+
                       'join RAIONS on (RAIONS.ID=START_WORK.ID_RAION) '+lineending+
                       'join POSTS on (START_WORK.ID_POST=POSTS.ID)'+lineending+
                       'join LOCATIONS on (LOCATIONS.ID=START_WORK.ID_LOCATION)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'left join GROUPS on (START_WORK.ID_GROUP=GROUPS.ID)'+lineending+
                       'left join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
                       'left join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
                       'where (START_WORK.ID='+inttostr(self.FID)+')/*and*/'+lineending+
                       '';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       if qr.IsEmpty then
                       begin
                        messagedlg('информация','нет записей для сотрудника',mtInformation,[mbok],0);
                        exit;
                       end;
                       myDOCS:=TmyDOCS.Create(ttaZaiv_KS,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
                    4:begin  //Заявка на изготовление сертификата
                     try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;

                       stmp:='select POSTS.NAME as dolj, GROUPS.NAME as gr, START_WORK.TABNOM, t1.FAM as FAM2, t1.NAM as NAM2, t1.OTCH as OTCH2, t1.SNILS,'+lineending+
                       'LEFT(t1.NAM, 1) as NM2, LEFT(t1.OTCH, 1) as OT2,'+lineending+
                       'RAIONS.ADDRESS, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, LEFT(t3.NAM, 1) as NM1, LEFT(t3.OTCH, 1) as OT1,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, RAIONS.FULL_NAME as fullname, RAIONS.INN as INN, RAIONS.OGRN as OGRN,'+lineending+
                       'LOCATIONS.NAME as lNAME,TERRITOR.ADDRESS as tname'+lineending+
                       ' from START_WORK  join PEOPLES as t1 on (START_WORK.ID_PEOPLE=t1.ID) '+lineending+
                       'join RAIONS on (RAIONS.ID=START_WORK.ID_RAION) '+lineending+
                       'join POSTS on (START_WORK.ID_POST=POSTS.ID)'+lineending+
                       'join LOCATIONS on (LOCATIONS.ID=START_WORK.ID_LOCATION)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'left join GROUPS on (START_WORK.ID_GROUP=GROUPS.ID)'+lineending+
                       'left join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
                       'left join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
                       'where (START_WORK.ID='+inttostr(self.FID)+')/*and*/'+lineending+
                       '';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       if qr.IsEmpty then
                       begin
                        messagedlg('информация','нет записей для сотрудника',mtInformation,[mbok],0);
                        exit;
                       end;
                       myDOCS:=TmyDOCS.Create(ttaZaiv_SERT,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
                    5:begin
                     try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;

                       stmp:='select t1.FAM as FAM2, t1.NAM as NAM2, t1.OTCH as OTCH2,'+lineending+
                       'MNI.UCHETN as UN,MNI_MODEL.NAME as MNAME, MNI_TIP.NAME as TNAME,MNI.SSIZE as SZ,'+lineending+
                       'MNI.DT as DTP, POSTS.NAME as dolj'+lineending+
                       ''+lineending+
                       ' from START_WORK  join PEOPLES as t1 on (START_WORK.ID_PEOPLE=t1.ID) '+lineending+
                       'join MNI on (MNI.ID_START_WORK=START_WORK.ID)'+lineending+
                       'join MNI_TIP on (MNI_TIP.ID=MNI.ID_TIP)'+lineending+
                       'join PR_RASPR_MNI on (PR_RASPR_MNI.ID=MNI.ID_PR_RASPR)'+lineending+
                       'join POSTS on (POSTS.ID=START_WORK.ID_POST)'+lineending+
                       'left join MNI_MODEL on (MNI_MODEL.ID=MNI.ID_MODEL)'+lineending+
                       'where (START_WORK.ID='+inttostr(self.FID)+')and (PR_RASPR_MNI.name starting with ''Р'')'+lineending+
                       '';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       if qr.IsEmpty then
                       begin
                        messagedlg('информация','нет записей для сотрудника',mtInformation,[mbok],0);
                        exit;
                       end;
                       myDOCS:=TmyDOCS.Create(ttaOpis_mni,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
                    6:begin
                     try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;

                       stmp:='select t1.FAM as FAM2, t1.NAM as NAM2, t1.OTCH as OTCH2,'+lineending+
                       'MNI.UCHETN as UN,MNI_MODEL.NAME as MNAME, MNI_TIP.NAME as TNAME,MNI.SSIZE as SZ,'+lineending+
                       'POSTS.NAME as dolj'+lineending+
                       ''+lineending+
                       ' from START_WORK  join PEOPLES as t1 on (START_WORK.ID_PEOPLE=t1.ID) '+lineending+
                       'join MNI on (MNI.ID_START_WORK=START_WORK.ID)'+lineending+
                       'join MNI_TIP on (MNI_TIP.ID=MNI.ID_TIP)'+lineending+
                       'join PR_RASPR_MNI on (PR_RASPR_MNI.ID=MNI.ID_PR_RASPR)'+lineending+
                       'join POSTS on (POSTS.ID=START_WORK.ID_POST)'+lineending+
                       'left join MNI_MODEL on (MNI_MODEL.ID=MNI.ID_MODEL)'+lineending+
                       'where (START_WORK.ID='+inttostr(self.FID)+')and (PR_RASPR_MNI.name starting with ''Р'')'+lineending+
                       '';
                       //showmessage(stmp);
                       qr.SQL.Add(stmp);
                       qr.Open;
                       if qr.IsEmpty then
                       begin
                        messagedlg('информация','нет записей для сотрудника',mtInformation,[mbok],0);
                        exit;
                       end;
                       myDOCS:=TmyDOCS.Create(ttaLic_schet_mni,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
                    7:begin//Карточка выдачи МНИ
                     try
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;

                       stmp:='select t1.FAM as FAM2, t1.NAM as NAM2, t1.OTCH as OTCH2,'+lineending+
                       'MNI.UCHETN as UN,MNI_MODEL.NAME as MODEL, MNI_TIP.NAME as TNAME,MNI.SSIZE as SIZE,'+lineending+
                       'MNI.SERIAL as SERIAL, POSTS.NAME as dolj'+lineending+
                       ''+lineending+
                       ' from START_WORK  join PEOPLES as t1 on (START_WORK.ID_PEOPLE=t1.ID) '+lineending+
                       'join MNI on (MNI.ID_START_WORK=START_WORK.ID)'+lineending+
                       'join MNI_TIP on (MNI_TIP.ID=MNI.ID_TIP)'+lineending+
                       'join PR_RASPR_MNI on (PR_RASPR_MNI.ID=MNI.ID_PR_RASPR)'+lineending+
                       'join POSTS on (POSTS.ID=START_WORK.ID_POST)'+lineending+
                       'left join MNI_MODEL on (MNI_MODEL.ID=MNI.ID_MODEL)'+lineending+
                       'where (START_WORK.ID='+inttostr(self.FID)+')and (MNI_TIP.NAME=''НЖМД'')/*(PR_RASPR_MNI.name starting with ''Р'')*/'+lineending+
                       '';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       if qr.IsEmpty then
                       begin
                        messagedlg('информация','нет записей для сотрудника',mtInformation,[mbok],0);
                        exit;
                       end;
                       myDOCS:=TmyDOCS.Create(ttakartmni,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
                    8:begin  //Заполнение произвольного шаблона
                     try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;

                       stmp:='select POSTS.NAME as dolj, GROUPS.NAME as gr, START_WORK.TABNOM, t1.FAM as FAM2, t1.NAM as NAM2, t1.OTCH as OTCH2, t1.SNILS,'+lineending+
                       'LEFT(t1.NAM,1) as NM2, LEFT(t1.OTCH,1) as OT2,'+lineending+
                       'RAIONS.ADDRESS, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, LEFT(t3.NAM,1) as NM1, LEFT(t3.OTCH,1) as OT1, t3.PHONE_WORK as PHONE_WORK,'+lineending+
                       'RAIONS.FULL_NAME as FULLNAME, RAIONS.FULL_KR_NAME as krname, RAIONS.INN as INN, RAIONS.OGRN as OGRN,'+lineending+
                       'LOCATIONS.NAME as lNAME,TERRITOR.ADDRESS as tname'+lineending+
                       ' from START_WORK  join PEOPLES as t1 on (START_WORK.ID_PEOPLE=t1.ID) '+lineending+
                       'join RAIONS on (RAIONS.ID=START_WORK.ID_RAION) '+lineending+
                       'join POSTS on (START_WORK.ID_POST=POSTS.ID)'+lineending+
                       'join LOCATIONS on (LOCATIONS.ID=START_WORK.ID_LOCATION)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'left join GROUPS on (START_WORK.ID_GROUP=GROUPS.ID)'+lineending+
                       'left join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
                       'left join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
                       'where (START_WORK.ID='+inttostr(self.FID)+')/*and*/'+lineending+
                       '';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       if qr.IsEmpty then
                       begin
                        messagedlg('информация','нет записей для сотрудника',mtInformation,[mbok],0);
                        exit;
                       end;
                       myDOCS:=TmyDOCS.Create(ttaFillSW,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
             end;
         end;
         3:begin
          if ComboBox1.ItemIndex<0 then exit;
             case self.ComboBox1.ItemIndex of
                    0:begin //AKT проверки наличия машинных носителей информации
                     try
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
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
                       if qr.IsEmpty then
                       begin
                        messagedlg('информация','нет записей для сотрудника',mtInformation,[mbok],0);
                        exit;
                       end;
                       myDOCS:=TmyDOCS.Create(ttaAkt_MNI,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                      end;
                    1:begin  //Карточка выдачи МНИ
                     try
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;

                       stmp:='select DISTINCT t1.FAM as FAM2, t1.NAM as NAM2, t1.OTCH as OTCH2,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname,'+lineending+
                       'MNI.UCHETN as UCHETN,MNI_MODEL.NAME as MODEL, MNI_TIP.NAME as TNAME,'+
                       'case MNI.SSIZE when 0 then '''' else TRUNC(MNI.SSIZE)||'' Гб'' end as SIZE,'+lineending+
                       'MNI.SERIAL as SERIAL/*, POSTS.NAME as dolj*/'+lineending+
                       ''+lineending+
                       ' from MNI join move_mni on (move_mni.id_mni=mni.id)'+
                       'join START_WORK on (MOVE_MNI.ID_START_WORK=START_WORK.ID)  join PEOPLES as t1 on (START_WORK.ID_PEOPLE=t1.ID) '+lineending+
                       'join RAIONS on (RAIONS.ID=MNI.ID_RAION)'+lineending+
                       'join MNI_TIP on (MNI_TIP.ID=MNI.ID_TIP)'+lineending+
                       '/*join PR_RASPR_MNI on (PR_RASPR_MNI.ID=MNI.ID_PR_RASPR)*/'+lineending+
                       'join POSTS on (POSTS.ID=START_WORK.ID_POST)'+lineending+
                       'left join MNI_MODEL on (MNI_MODEL.ID=MNI.ID_MODEL)'+lineending+
                       'where (MNI.ID='+inttostr(FID)+')/*and (MNI_TIP.NAME=''НЖМД'')*//*(PR_RASPR_MNI.name starting with ''Р'')*/'+lineending+
                       'order by move_mni.id ASC';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       if qr.IsEmpty then
                       begin
                        messagedlg('информация','нет записей для сотрудника',mtInformation,[mbok],0);
                        exit;
                       end;
                       myDOCS:=TmyDOCS.Create(ttakartmni,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
                    2:begin  //Карточки выдачи на все МНИ
                     try
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       qr2:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       Qr2.Transaction:=tr;
                       qr2.DataBase:=fconn;
                       qr2.SQL.Clear;
                       QR2.SQL.Add('select mni.ID as ID, mni.uchetn as un from MNI join mni_tip on (mni_tip.id=mni.id_tip)'+lineending+
                       ' where'+'(MNI.ID_RAION='+inttostr(id_raion)+')and(MNI.HIDE=0)and(UPPER(MNI_TIP.name)=''НЖМД'') order by mni.uchetn');
                       qr2.Open;
                       qr2.First;qr2.Last;
                       if not qr2.IsEmpty then
                          if QuestionDlg('карточки МНИ','У вас '+inttostr(qr2.RecordCount)+' НЖМД.'+lineending+
                          'Операция может занять продолжительное время. В это время программа не будет реагировать на ваши действия.'+lineending
                          +'Продолжить?',mtConfirmation,[mrYes,'Начать',mrNo,'Прекратить','isdefault'],'')=mryes then
                          begin
                       qr2.First;
                       while not qr2.EOF do
                       begin
                        //showmessage(qr2.FieldByName('id').AsString+lineending+qr2.FieldByName('un').AsString);
                        stmp:='select DISTINCT t1.FAM as FAM2, t1.NAM as NAM2, t1.OTCH as OTCH2,'+lineending+
                        'RAIONS.FULL_KR_NAME as krname,'+lineending+
                        'MNI.UCHETN as UCHETN,MNI_MODEL.NAME as MODEL, MNI_TIP.NAME as TNAME,'+
                        'case MNI.SSIZE when 0 then '''' else TRUNC(MNI.SSIZE)||'' Гб'' end as SIZE,'+lineending+
                        'MNI.SERIAL as SERIAL/*, POSTS.NAME as dolj*/'+lineending+
                        ''+lineending+
                        ' from MNI join move_mni on (move_mni.id_mni=mni.id)'+
                        'join START_WORK on (MOVE_MNI.ID_START_WORK=START_WORK.ID)  join PEOPLES as t1 on (START_WORK.ID_PEOPLE=t1.ID) '+lineending+
                        'join RAIONS on (RAIONS.ID=MNI.ID_RAION)'+lineending+
                        'join MNI_TIP on (MNI_TIP.ID=MNI.ID_TIP)'+lineending+
                        '/*join PR_RASPR_MNI on (PR_RASPR_MNI.ID=MNI.ID_PR_RASPR)*/'+lineending+
                        'join POSTS on (POSTS.ID=START_WORK.ID_POST)'+lineending+
                        'left join MNI_MODEL on (MNI_MODEL.ID=MNI.ID_MODEL)'+lineending+
                        'where (MNI.ID='+qr2.FieldByName('id').AsString+')/*and (MNI_TIP.NAME=''НЖМД'')*//*(PR_RASPR_MNI.name starting with ''Р'')*/'+lineending+
                        'order by move_mni.id ASC';
                        qr.SQL.Clear;
                        qr.SQL.Add(stmp);
                        qr.Open;
                        qr2.Next;
                           if qr.IsEmpty then continue;
                           myDOCS:=TmyDOCS.Create(ttakartmni,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);//Тут всякие действия
                           myDOCS.Free;
                           qr.Close;
                           //freeandnil(qr);
                       end;
                     end;
                     except
                       on E: Exception do
                       begin
                            if (pos('No Found file shablon',lowercase( e.message))>-1) then
                                begin
                                     MessageDlg('Ошибка','Не найден файл шаблона '+UTF8Copy(e.message,20,UTF8Length(e.message)-18),mtInformation,[mbOK],0)
                                end else
                           {if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else}  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                     if qr2<>nil then freeandnil(qr2);
                    end;
             end;
             if qr<>nil then freeandnil(qr);
         end;

         4:begin
             if self.ComboBox1.ItemIndex<0 then exit;
             case self.ComboBox1.ItemIndex of
                    0:begin
                        try
                     // AKTT;
              //Создадим документ
              tr:=tSQLTransaction.Create(self);
              qr:=TSQLQuery.Create(self);
              Tr.DataBase:=fconn;
              Qr.Transaction:=tr;
              qr.DataBase:=fconn;
              qr.SQL.Clear;
              dtd:=datetimetostr(DateTimePicker1.Date);
              dty:=utf8copy(dtd,7,4);
              dtm:=utf8copy(dtd,4,2);
              dtd:=utf8copy(dtd,1,2);
              dtd2:=datetimetostr(DateTimePicker2.Date);
              dty2:=utf8copy(dtd2,7,4);
              dtm2:=utf8copy(dtd2,4,2);
              dtd2:=utf8copy(dtd2,1,2);
              stmp:='select MNI.UCHETN as UCHETN, MNI_TIP.NAME as tNAME, MNI.SERIAL as SERIAL,'+lineending+
              't3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, RAIONS.FULL_KR_NAME as krname'+lineending+
              'from DELETE_MNI JOIN MNI ON  (DELETE_MNI.ID_MNI=MNI.ID)'+lineending+
              'join MNI_TIP on (MNI_TIP.ID=MNI.ID_TIP)'+lineending+
              'join RAIONS on (RAIONS.ID=MNI.ID_RAION)'+lineending+
              'left join START_WORK on (RAIONS.ID_BOSS=START_WORK.ID)'+lineending+
              'left join PEOPLES as t3 on (START_WORK.ID_PEOPLE=t3.ID)'+lineending+
              ''+lineending+
              ''+lineending+
              ''+lineending+
              'where ((MNI.ID_RAION='+inttostr(id_raion)+')and (DELETE_MNI.DT>='''+dty+'-'+dtm+'-'+dtd+''')and'+lineending+
              '(DELETE_MNI.DT<='''+dty2+'-'+dtm2+'-'+dtd2+''')) order by MNI_TIP.NAME';
              qr.SQL.Add(stmp);
              qr.Open;
              myDOCS:=TmyDOCS.Create(ttaAKT_DELMNI,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
              //Тут всякие действия
              myDOCS.Free;

         except
           on E: Exception do
               begin
                       if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                      begin
                       MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                      end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
               end;
         end;
                    end;
             end;

         end;
         5:
           begin
            if self.ComboBox1.ItemIndex<0 then exit;
             case self.ComboBox1.ItemIndex of
                    0:begin
                     try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;
                        dtd:=datetimetostr(DateTimePicker1.Date);
                       dty:=utf8copy(dtd,7,4);
                       dtm:=utf8copy(dtd,4,2);
                       dtd:=utf8copy(dtd,1,2);
                       sdop:=InputBox('основание','основание для установки','???');
                       if utf8length(sdop)<3 then sdop:='???';
                       stmp:='select '''+sdop+''' as osnovanie, KRIPTO.NAME as kNAME, PEOPLES.FAM AS FAM2, PEOPLES.NAM AS NAM2, PEOPLES.OTCH AS OTCH2,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, '+lineending+
                       'POSTS.NAME as DOLJ, GROUPS.NAME as GR, RAIONS.ADDRESS as ADDRESS,'+lineending+
                       'SB.SERIAL as SERIAL, LOCATIONS.NAME as loc, MNI.UCHETN as UCHETN, SB.STIKER as STIKER,'+lineending+
                       'SERTIFIKATS.NAME as sert, '+dtd+' as dtd,'+dtm+' as dtm,'+dty+' as dty,'+lineending+
                       'tt2.FAM as FAM3, tt2.NAM as NAM3, tt2.OTCH as OTCH3,TERRITOR.ADDRESS as tname'+lineending+
                       ' from COPY_KRIPTO join KRIPTO on (KRIPTO.ID=COPY_KRIPTO.ID_KRIPTO)'+lineending+
                       'join RAIONS on (RAIONS.ID=COPY_KRIPTO.ID_RAION)'+lineending+
                       'join SB on (COPY_KRIPTO.ID_SB=SB.ID)'+lineending+
                       'join START_WORK as tt1 on (SB.ID_START_WORK=tt1.ID)'+lineending+
                       'join PEOPLES as tt2 on (tt1.ID_PEOPLE=tt2.ID)'+lineending+
                       'join SERTIFIKATS on (SERTIFIKATS.ID=COPY_KRIPTO.ID_SERTIFIKATS)'+lineending+
                       'join START_WORK on (SERTIFIKATS.ID_START_WORK=START_WORK.ID)'+lineending+
                       'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
                       'join POSTS on (START_WORK.ID_POST=POSTS.ID)'+lineending+
                       'join LOCATIONS on (SB.ID_LOCATION=LOCATIONS.ID)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'left join MNI on (COPY_KRIPTO.ID_MNI=MNI.ID)'+lineending+
                       'left join GROUPS on (START_WORK.ID_GROUP=GROUPS.ID)'+lineending+
                       'left join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
                       'left join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
                       ''+lineending+
                       'where (SERTIFIKATS.ID='+inttostr(self.FID)+')and'+lineending+
                       '(not exists('+lineending+
                       'select * from DELETE_KRIPTO where'+lineending+
                       '(DELETE_KRIPTO.id_KRIPTO=COPY_KRIPTO.ID)'+lineending+
                       '))'+lineending+
                       '';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       if qr.IsEmpty then messagedlg('предупреждение','Сертификат не установлен ни на одной машине',mtInformation,[mbok],0);;
                       myDOCS:=TmyDOCS.Create(ttaAkt_KRIPT,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;
                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
                    1:
                      begin//Заявка на приостановку'
                       try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;
                        dtd:=datetimetostr(DateTimePicker1.Date);
                       dty:=utf8copy(dtd,7,4);
                       dtm:=utf8copy(dtd,4,2);
                       dtd:=utf8copy(dtd,1,2);
                       stmp:='select PEOPLES.FAM AS FAM2, PEOPLES.NAM AS NAM2, PEOPLES.OTCH AS OTCH2,'+lineending+
                       'LEFT(PEOPLES.NAM,1) as NM2, LEFT(PEOPLES.OTCH,1) as OT2,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, LEFT(t3.NAM,1) as NM1, LEFT(t3.OTCH,1) as OT1,'+lineending+
                       'POSTS.NAME as DOLJ, GROUPS.NAME as GR, RAIONS.ADDRESS as ADDRESS,'+lineending+
                       'START_WORK.TABNOM as TABNOM, '+lineending+
                       'SERTIFIKATS.NAME as sert, '+dtd+' as dtd,'+dtm+' as dtm,'+dty+' as dty, '+lineending+
                       'LOCATIONS.NAME as LNAME,TERRITOR.ADDRESS as tname'+lineending+
                       ' from SERTIFIKATS '+lineending+
                       'join RAIONS on (RAIONS.ID=SERTIFIKATS.ID_RAION)'+lineending+
                       'join START_WORK on (SERTIFIKATS.ID_START_WORK=START_WORK.ID)'+lineending+
                       'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
                       'join POSTS on (START_WORK.ID_POST=POSTS.ID)'+lineending+
                       ''+lineending+
                       'join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
                       'join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
                       'join LOCATIONS on (LOCATIONS.ID=START_WORK.ID_LOCATION)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'left join GROUPS on (START_WORK.ID_GROUP=GROUPS.ID)'+lineending+
                       'where (SERTIFIKATS.ID='+inttostr(self.FID)+')'+lineending+
                       ''+lineending+
                       '';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       myDOCS:=TmyDOCS.Create(ttaZaiv_Pause,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;
                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                      end;
                    2:begin//Заявка на отзыв
                       try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;
                        dtd:=datetimetostr(DateTimePicker1.Date);
                       dty:=utf8copy(dtd,7,4);
                       dtm:=utf8copy(dtd,4,2);
                       dtd:=utf8copy(dtd,1,2);
                       stmp:='select PEOPLES.FAM AS FAM2, PEOPLES.NAM AS NAM2, PEOPLES.OTCH AS OTCH2,'+lineending+
                       'LEFT(PEOPLES.NAM,1) as NM2, LEFT(PEOPLES.OTCH,1) as OT2,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, LEFT(t3.NAM,1) as NM1, LEFT(t3.OTCH,1) as OT1,'+lineending+
                       'POSTS.NAME as DOLJ, GROUPS.NAME as GR, RAIONS.ADDRESS as ADDRESS,'+lineending+
                       'START_WORK.TABNOM as TABNOM, '+lineending+
                       'SERTIFIKATS.NAME as sert, '+dtd+' as dtd,'+dtm+' as dtm,'+dty+' as dty, '+lineending+
                       'LOCATIONS.NAME as LNAME,TERRITOR.ADDRESS as tname'+lineending+
                       ' from SERTIFIKATS '+lineending+
                       'join RAIONS on (RAIONS.ID=SERTIFIKATS.ID_RAION)'+lineending+
                       'join START_WORK on (SERTIFIKATS.ID_START_WORK=START_WORK.ID)'+lineending+
                       'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
                       'join POSTS on (START_WORK.ID_POST=POSTS.ID)'+lineending+
                       'join LOCATIONS on (LOCATIONS.ID=START_WORK.ID_LOCATION)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
                       'join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
                       'left join GROUPS on (START_WORK.ID_GROUP=GROUPS.ID)'+lineending+
                       ''+lineending+
                       'where (SERTIFIKATS.ID='+inttostr(self.FID)+')'+lineending+
                       ''+lineending+
                       '';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       myDOCS:=TmyDOCS.Create(ttaZaiv_Otziv,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;
                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                      end;
                    3:
                      begin//Заявка на возобновление
                       try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;
                        dtd:=datetimetostr(DateTimePicker1.Date);
                       dty:=utf8copy(dtd,7,4);
                       dtm:=utf8copy(dtd,4,2);
                       dtd:=utf8copy(dtd,1,2);
                       stmp:='select PEOPLES.FAM AS FAM2, PEOPLES.NAM AS NAM2, PEOPLES.OTCH AS OTCH2,'+lineending+
                       'LEFT(PEOPLES.NAM,1) as NM2, LEFT(PEOPLES.OTCH,1) as OT2,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, LEFT(t3.NAM,1) as NM1, LEFT(t3.OTCH,1) as OT1,'+lineending+
                       'POSTS.NAME as DOLJ, GROUPS.NAME as GR, RAIONS.ADDRESS as ADDRESS,'+lineending+
                       'START_WORK.TABNOM as TABNOM, '+lineending+
                       'SERTIFIKATS.NAME as sert, '+dtd+' as dtd,'+dtm+' as dtm,'+dty+' as dty, '+lineending+
                       'LOCATIONS.NAME as LNAME,TERRITOR.ADDRESS as tname'+lineending+
                       ' from SERTIFIKATS '+lineending+
                       'join RAIONS on (RAIONS.ID=SERTIFIKATS.ID_RAION)'+lineending+
                       'join START_WORK on (SERTIFIKATS.ID_START_WORK=START_WORK.ID)'+lineending+
                       'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
                       'join POSTS on (START_WORK.ID_POST=POSTS.ID)'+lineending+
                       ''+lineending+
                       'join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
                       'join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
                       'join LOCATIONS on (LOCATIONS.ID=START_WORK.ID_LOCATION)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'left join GROUPS on (START_WORK.ID_GROUP=GROUPS.ID)'+lineending+
                       'where (SERTIFIKATS.ID='+inttostr(self.FID)+')'+lineending+
                       ''+lineending+
                       '';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       myDOCS:=TmyDOCS.Create(ttaZaiv_Voz,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;
                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                      end;
             end;
           end;
         7:begin
             if self.ComboBox1.ItemIndex<0 then exit;
             case self.ComboBox1.ItemIndex of
                    0:begin
                     try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;
                       dtd:=datetimetostr(DateTimePicker1.Date);
                       dty:=utf8copy(dtd,7,4);
                       dtm:=utf8copy(dtd,4,2);
                       dtd:=utf8copy(dtd,1,2);
                       sdop:=InputBox('основание','основание для установки','???');
                       if utf8length(sdop)<3 then sdop:='???';
                       stmp:='select '''+sdop+''' as osnovanie, SERTIFIKATS.name as sert, KRIPTO.NAME as kNAME, COPY_KRIPTO.NUMBER_COPY as NCOPY,'+
                       'PEOPLES.FAM AS FAM2, PEOPLES.NAM AS NAM2, PEOPLES.OTCH AS OTCH2,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, '+lineending+
                       'POSTS.NAME as DOLJ, GROUPS.NAME as GR, RAIONS.ADDRESS as ADDRESS,'+lineending+
                       'SB.SERIAL as SERIAL, LOCATIONS.NAME as loc, MNI.UCHETN as UCHETN, SB.STIKER as STIKER,'+lineending+
                       'tt2.FAM as FAM3, tt2.NAM as NAM3, tt2.OTCH as OTCH3,'+dtd+' as dtd,'+dtm+' as dtm,'+dty+' as dty'+lineending+
                       ',TERRITOR.ADDRESS as tname from COPY_KRIPTO join KRIPTO on (KRIPTO.ID=COPY_KRIPTO.ID_KRIPTO)'+lineending+
                       'join RAIONS on (RAIONS.ID=COPY_KRIPTO.ID_RAION)'+lineending+
                       'join START_WORK on (COPY_KRIPTO.ID_START_WORK=START_WORK.ID)'+lineending+
                       'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
                       'join POSTS on (START_WORK.ID_POST=POSTS.ID)'+lineending+
                       'join SB on (COPY_KRIPTO.ID_SB=SB.ID)'+lineending+
                       'join START_WORK as tt1 on (SB.ID_START_WORK=tt1.ID)'+lineending+
                       'join PEOPLES as tt2 on (tt1.ID_PEOPLE=tt2.ID)'+lineending+
                       'join LOCATIONS on (SB.ID_LOCATION=LOCATIONS.ID)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'left join SERTIFIKATS on (SERTIFIKATS.ID=COPY_KRIPTO.ID_SERTIFIKATS)'+lineending+
                       'left join MNI on (COPY_KRIPTO.ID_MNI=MNI.ID)'+lineending+
                       'left join GROUPS on (START_WORK.ID_GROUP=GROUPS.ID)'+lineending+
                       'left join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
                       'left join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
                       ''+lineending+
                       ''+lineending+
                       ''+lineending+
                       'where (COPY_KRIPTO.ID='+inttostr(self.FID)+')'+lineending+
                       ''+lineending+
                       '';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       myDOCS:=TmyDOCS.Create(ttaAkt_KRIPT,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
                    1:begin
                     try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;

                       stmp:='select * from ('+lineending+
                       'select DISTINCT 0 as nom, KRIPTO.NAME as kNAME, ''s/n: ''||SB.SERIAL AS SERIAL, PEOPLES.FAM AS FAM2, PEOPLES.NAM AS NAM2, PEOPLES.OTCH AS OTCH2,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname '+lineending+
                       ' from COPY_KRIPTO join KRIPTO on (KRIPTO.ID=COPY_KRIPTO.ID_KRIPTO)'+lineending+
                       'join RAIONS on (RAIONS.ID=COPY_KRIPTO.ID_RAION)'+lineending+
                       'join START_WORK on (COPY_KRIPTO.ID_START_WORK=START_WORK.ID)'+lineending+
                       'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
                       'join SB on (COPY_KRIPTO.ID_SB=SB.ID)'+lineending+
                       'where ((COPY_KRIPTO.ID_RAION='+inttostr(ID_RAION)+')and'+lineending+
                       '(not exists(select ID from DELETE_KRIPTO where DELETE_KRIPTO.ID_KRIPTO=COPY_KRIPTO.ID)))'+lineending+
                       'union all'+lineending+
                       'select DISTINCT 1 as nom, MNI_TIP.NAME as kNAME, MNI.UCHETN AS SERIAL, '+lineending+
                       'PEOPLES.FAM AS FAM2, PEOPLES.NAM AS NAM2, PEOPLES.OTCH AS OTCH2,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname'+lineending+
                       'from MNI join MNI_TIP on (MNI.ID_TIP=MNI_TIP.ID)'+lineending+
                       'join RAIONS on (RAIONS.ID=MNI.ID_RAION)'+lineending+
                       'join START_WORK on (MNI.ID_START_WORK=START_WORK.ID)'+lineending+
                       'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
                       'join KEY_ on (MNI.ID_KEY=KEY_.ID)'+lineending+
                       'join PR_RASPR_MNI on (PR_RASPR_MNI.ID=MNI.ID_PR_RASPR)'+lineending+
                       'left join SB on (MNI.ID_SB=SB.ID)'+lineending+
                       'where ((MNI.ID_RAION='+inttostr(ID_RAION)+')and'+lineending+
                       '(not exists(select * from DELETE_MNI where DELETE_MNI.ID_MNI=MNI.ID))and'+lineending+
                       '(KEY_.NAME starting with ''КЛЮЧ'')and'+lineending+
                       '(PR_RASPR_MNI.NAME starting with ''РАСПР''))'+lineending+
                       ')'+lineending+
                       'order by FAM2, NAM2, nom, kNAME';
                       qr.SQL.Add(stmp);
                       qr.Open;
                       myDOCS:=TmyDOCS.Create(ttaSved_KRIPT,ExtractFilePath(Application.ExeName), Qr);
                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
                    2:begin
                     if self.ComboBox1.ItemIndex<0 then exit;
                     try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;
                       dtd:=datetimetostr(DateTimePicker1.Date);
                       dty:=utf8copy(dtd,7,4);
                       dtm:=utf8copy(dtd,4,2);
                       dtd:=utf8copy(dtd,1,2);
                       {dtd2:=datetimetostr(DateTimePicker2.Date);
                       dty2:=utf8copy(dtd2,7,4);
                       dtm2:=utf8copy(dtd2,4,2);
                       dtd2:=utf8copy(dtd2,1,2); }
                        {if self.ComboBox1.ItemIndex=0 then
                        sdop:='where ((t1.kDT>='''+dty+'-'+dtm+'-'+dtd+
                        ''')and(t1.kDT<='''+dty2+'-'+dtm2+'-'+dtd2+'''))order by t1.nom, t1.DT, t1.SERIAL'
                        else }
                             sdop:='where ((t1.nom=0)and(t1.ID='+inttostr(self.FID)+')'+lineending+
                             ')order by t1.nom, t1.DT, t1.SERIAL';
                        stmp:='select t1.kDT, t1.nom, t1.ID_RAION, t1.ID, t1.DT, t1.kNAME, t1.kSERIAL, t1.FIO, t1.SERIAL, RAIONS.FULL_KR_NAME as krname, t3.FAM AS FAM1, t3.NAM AS NAM1, t3.OTCH AS OTCH1, t1.STIKER from ('+lineending+
                        'select 0 as nom, '''+dtd+''' as kDT, COPY_KRIPTO.ID_RAION as ID_RAION, COPY_KRIPTO.ID as ID,  '''+dtd+''' as DT, KRIPTO.NAME AS kNAME, COPY_KRIPTO.SERIAL as kSERIAL,  PEOPLES.FAM as FIO, '+lineending+
                        'SB.SERIAL as SERIAL, SB.STIKER as STIKER,TERRITOR.ADDRESS as tname from COPY_KRIPTO '+lineending+
                        ''+lineending+
                        'join KRIPTO on (KRIPTO.ID=COPY_KRIPTO.ID_KRIPTO) join START_WORK on (START_WORK.ID=COPY_KRIPTO.ID_START_WORK) join PEOPLES'+lineending+
                        'on (PEOPLES.ID=START_WORK.ID_PEOPLE) '+lineending+
                        'join SB on (COPY_KRIPTO.ID_SB=SB.ID)'+lineending+
                        'join LOCATIONS on (LOCATIONS.ID=SB.ID_LOCATION)'+lineending+
                        'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                        'left join MNI on (COPY_KRIPTO.ID_MNI=MNI.ID)'+lineending+
                        'where (COPY_KRIPTO.ID_RAION='+inttostr(id_raion)+') and'+lineending+
                        '(COPY_KRIPTO.ID='+inttostr(self.FID)+')'+lineending+
                        ''+lineending+
                        '/*union all'+lineending+
                        'select 1 as nom, '''+dtd+''' as kDT, MNI.ID_RAION as ID_RAION, MNI.ID as ID,  DELETE_MNI.DT, MNI_TIP.NAME as kNAME, MNI.UCHETN as kSERIAL, PEOPLES.FAM as FIO, MOTIVE_DELETE_MNI.NAME, '+lineending+
                        'SB.SERIAL as SERIAL, SB.STIKER as STIKER'+lineending+
                        'from DELETE_MNI join MNI on (DELETE_MNI.ID_MNI=MNI.ID) join MNI_TIP on (MNI.ID_TIP=MNI_TIP.ID)'+lineending+
                        'join START_WORK on (MNI.ID_START_WORK=START_WORK.ID)'+lineending+
                        'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
                        'join MOTIVE_DELETE_MNI on (MOTIVE_DELETE_MNI.ID=DELETE_MNI.ID_MOTIVE_DELETE_MNI)'+lineending+
                        'join KEY_ on (MNI.ID_KEY=KEY_.ID)'+lineending+
                        'left join SB on (MNI.ID_SB=SB.ID)'+lineending+
                        ''+lineending+
                        '*/) as t1'+lineending+
                        'join RAIONS on (RAIONS.ID=t1.ID_RAION)'+lineending+
                        'left join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
                        'left join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+sdop;
                        qr.SQL.Add(stmp);
                        qr.Open;
                        //showmessage(stmp);//inttostr(qr.RecordCount));
                        myDOCS:=TmyDOCS.Create(ttaDel_KRIPT,ExtractFilePath(Application.ExeName), Qr);
                     except
                       on E: Exception do
                       begin
                        if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                        MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                        else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;
                    end;
             end;
         end;
         9:begin
             if self.ComboBox1.ItemIndex<0 then exit;
                     try
                       // AKTT;
                       //Создадим документ
                       tr:=tSQLTransaction.Create(self);
                       qr:=TSQLQuery.Create(self);
                       Tr.DataBase:=fconn;
                       Qr.Transaction:=tr;
                       qr.DataBase:=fconn;
                       qr.SQL.Clear;
                        dtd:=datetimetostr(DateTimePicker1.Date);
                       dty:=utf8copy(dtd,7,4);
                       dtm:=utf8copy(dtd,4,2);
                       dtd:=utf8copy(dtd,1,2);
                       dtd2:=datetimetostr(DateTimePicker2.Date);
                       dty2:=utf8copy(dtd2,7,4);
                       dtm2:=utf8copy(dtd2,4,2);
                       dtd2:=utf8copy(dtd2,1,2);
                       case self.ComboBox1.ItemIndex of
                              3:begin
                               stmp:='select '+dtd+' as dtd1,'+dtm+' as dtm1,'+dty+' as dty1,'+
                               dtd2+' as dtd2,'+dtm2+' as dtm2,'+dty2+' as dty2,'+
                               't1.nom, t1.DT, t1.kNAME, t1.kSERIAL, t1.FIO, t1.NAME , '+lineending+
         'RAIONS.FULL_KR_NAME as krname, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1 from ('+lineending+
      'select DISTINCT 0 as nom, COPY_KRIPTO.ID_RAION, DELETE_KRIPTO.DT, KRIPTO.NAME AS kNAME, COPY_KRIPTO.NUMBER_COPY as kSERIAL,  PEOPLES.FAM as FIO, MOTIVE_DEL_KRIPTO.NAME,'+lineending+
       'SB.SERIAL as SERIAL,TERRITOR.ADDRESS as tname from DELETE_KRIPTO JOIN COPY_KRIPTO ON'+lineending+
   ' (DELETE_KRIPTO.ID_KRIPTO=COPY_KRIPTO.ID) join MOTIVE_DEL_KRIPTO ON (MOTIVE_DEL_KRIPTO.ID=DELETE_KRIPTO.ID_MOTIVE_DEL_KR)'+lineending+
  'join KRIPTO on (KRIPTO.ID=COPY_KRIPTO.ID_KRIPTO) join START_WORK on (START_WORK.ID=COPY_KRIPTO.ID_START_WORK) join PEOPLES'+lineending+
  'on (PEOPLES.ID=START_WORK.ID_PEOPLE) '+lineending+
  'join SB on (COPY_KRIPTO.ID_SB=SB.ID)'+lineending+
  'join LOCATIONS on (LOCATIONS.ID=SB.ID_LOCATION)'+lineending+
  'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
  'left join MNI on (COPY_KRIPTO.ID_MNI=MNI.ID)'+lineending+
  'where (COPY_KRIPTO.ID_RAION='+inttostr(id_raion)+')'+lineending+
  ''+lineending+
  '/*order by DELETE_KRIPTO.DT*/'+lineending+
  'union all'+lineending+
  'select DISTINCT 1 as nom, MNI.ID_RAION, DELETE_MNI.DT, MNI_TIP.NAME as kNAME, MNI.UCHETN as kSERIAL, PEOPLES.FAM as FIO, MOTIVE_DELETE_MNI.NAME, '+lineending+
  'SB.SERIAL as SERIAL, '' '' as tname'+lineending+
  'from DELETE_MNI join MNI on (DELETE_MNI.ID_MNI=MNI.ID) join MNI_TIP on (MNI.ID_TIP=MNI_TIP.ID)'+lineending+
  'join START_WORK on (MNI.ID_START_WORK=START_WORK.ID)'+lineending+
  'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
  'join MOTIVE_DELETE_MNI on (MOTIVE_DELETE_MNI.ID=DELETE_MNI.ID_MOTIVE_DELETE_MNI)'+lineending+
  'join KEY_ on (MNI.ID_KEY=KEY_.ID)'+lineending+
  'left join SB on (MNI.ID_SB=SB.ID)'+lineending+
  'where ((MNI.ID_RAION='+inttostr(id_raion)+')and'+lineending+
  '(KEY_.NAME starting with ''КЛЮЧ''))'+lineending+
  ') as t1'+lineending+
  'join RAIONS on (RAIONS.ID=t1.ID_RAION)'+lineending+
  'left join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
  'left join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
  ''+lineending+
  ''+lineending+
  'where ((t1.DT>='''+dty+'-'+dtm+'-'+dtd+''')and(t1.DT<='''+dty2+'-'+dtm2+'-'+dtd2+'''))'+lineending+
  'order by t1.nom, t1.DT';
                                qr.SQL.Add(stmp);
                               qr.Open;
                       if not qr.IsEmpty then
                       myDOCS:=TmyDOCS.Create(ttaOtchet_Del_KRIPT,ExtractFilePath(Application.ExeName), Qr)
                              end;
                              2:begin
                               stmp:='select KRIPTO.NAME as kNAME, PEOPLES.FAM AS FAM2, PEOPLES.NAM AS NAM2, PEOPLES.OTCH AS OTCH2,'+lineending+
                       'RAIONS.FULL_KR_NAME as krname, t3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, '+lineending+
                       'POSTS.NAME as DOLJ, GROUPS.NAME as GR, RAIONS.ADDRESS as ADDRESS,'+lineending+
                       'SB.SERIAL as SERIAL, LOCATIONS.NAME as loc, MNI.UCHETN as UCHETN, SB.STIKER as STIKER'+lineending+
                       ',TERRITOR.ADDRESS as tname from COPY_KRIPTO join KRIPTO on (KRIPTO.ID=COPY_KRIPTO.ID_KRIPTO)'+lineending+
                       'join RAIONS on (RAIONS.ID=COPY_KRIPTO.ID_RAION)'+lineending+
                       'join START_WORK on (COPY_KRIPTO.ID_START_WORK=START_WORK.ID)'+lineending+
                       'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
                       'join POSTS on (START_WORK.ID_POST=POSTS.ID)'+lineending+
                       'join SB on (COPY_KRIPTO.ID_SB=SB.ID)'+lineending+
                       'join LOCATIONS on (COPY_KRIPTO.ID_LOCATION=LOCATIONS.ID)'+lineending+
                       'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
                       'join DELETE_KRIPTO on (DELETE_KRIPTO.ID_KRIPTO=COPY_KRIPTO.ID)'+lineending+
                       'left join MNI on (COPY_KRIPTO.ID_MNI=MNI.ID)'+lineending+
                       'left join GROUPS on (START_WORK.ID_GROUP=GROUPS.ID)'+lineending+
                       'left join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
                       'left join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+
                       ''+lineending+
                       ''+lineending+
                       ''+lineending+
                       'where (DELETE_KRIPTO.ID='+inttostr(self.FID)+')'+lineending+
                       ''+lineending+
                       '';
                                qr.SQL.Add(stmp);
                       qr.Open;
                       if not qr.IsEmpty then
                       myDOCS:=TmyDOCS.Create(ttaAkt_KRIPT,ExtractFilePath(Application.ExeName), Qr)
                       else
                            MessageDlg('информация','Нет информации для Акта!',mtInformation,[mbOK],0);
                              end
                              else
                                begin
                                 if self.ComboBox1.ItemIndex=0 then
                            sdop:='where ((t1.kDT>='''+dty+'-'+dtm+'-'+dtd+
                            ''')and(t1.kDT<='''+dty2+'-'+dtm2+'-'+dtd2+'''))order by t1.nom, t1.DT, t1.SERIAL'
                       else
                            sdop:='where ((t1.nom='+inttostr(self.Fnom)+')and(t1.ID='+inttostr(self.FID)+')'+lineending+
                            ')order by t1.nom, t1.DT, t1.SERIAL';
                       stmp:='select t1.kDT, t1.nom, t1.ID_RAION, t1.ID_COPY_KRIPTO, t1.ID, t1.DT, t1.kNAME, t1.kSERIAL, t1.FIO, t1.NAME, t1.SERIAL, RAIONS.FULL_KR_NAME as krname, t3.FAM AS FAM1, t3.NAM AS NAM1, t3.OTCH AS OTCH1, t1.STIKER from ('+lineending+
      'select 0 as nom, DELETE_KRIPTO.DT as kDT, COPY_KRIPTO.ID_RAION as ID_RAION, COPY_KRIPTO.ID as ID_COPY_KRIPTO, DELETE_KRIPTO.ID as ID, DELETE_KRIPTO.DT, KRIPTO.NAME AS kNAME, COPY_KRIPTO.SERIAL as kSERIAL,  PEOPLES.FAM as FIO, MOTIVE_DEL_KRIPTO.NAME,'+lineending+
       'SB.SERIAL as SERIAL, SB.STIKER as STIKER,TERRITOR.ADDRESS as tname from DELETE_KRIPTO JOIN COPY_KRIPTO ON'+lineending+
   ' (DELETE_KRIPTO.ID_KRIPTO=COPY_KRIPTO.ID) join MOTIVE_DEL_KRIPTO ON (MOTIVE_DEL_KRIPTO.ID=DELETE_KRIPTO.ID_MOTIVE_DEL_KR)'+lineending+
  'join KRIPTO on (KRIPTO.ID=COPY_KRIPTO.ID_KRIPTO) join START_WORK on (START_WORK.ID=COPY_KRIPTO.ID_START_WORK) join PEOPLES'+lineending+
  'on (PEOPLES.ID=START_WORK.ID_PEOPLE) '+lineending+
  'join SB on (COPY_KRIPTO.ID_SB=SB.ID)'+lineending+
  'join LOCATIONS on (LOCATIONS.ID=SB.ID_LOCATION)'+lineending+
  'join TERRITOR on (LOCATIONS.id_TERRITOR=TERRITOR.ID)'+lineending+
  'left join MNI on (COPY_KRIPTO.ID_MNI=MNI.ID)'+lineending+
  'where (COPY_KRIPTO.ID_RAION='+inttostr(id_raion)+')'+lineending+
  ''+lineending+
  ''+lineending+
  'union all'+lineending+
  'select 1 as nom, DELETE_MNI.DT as kDT, MNI.ID_RAION as ID_RAION, MNI.ID as ID_COPY_KRIPTO, DELETE_MNI.ID as ID, DELETE_MNI.DT, MNI_TIP.NAME as kNAME, MNI.UCHETN as kSERIAL, PEOPLES.FAM as FIO, MOTIVE_DELETE_MNI.NAME, '+lineending+
  'SB.SERIAL as SERIAL, SB.STIKER as STIKER, '''' as tname'+lineending+
  'from DELETE_MNI join MNI on (DELETE_MNI.ID_MNI=MNI.ID) join MNI_TIP on (MNI.ID_TIP=MNI_TIP.ID)'+lineending+
  'join START_WORK on (MNI.ID_START_WORK=START_WORK.ID)'+lineending+
  'join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
  'join MOTIVE_DELETE_MNI on (MOTIVE_DELETE_MNI.ID=DELETE_MNI.ID_MOTIVE_DELETE_MNI)'+lineending+
  'join KEY_ on (MNI.ID_KEY=KEY_.ID)'+lineending+
  'left join SB on (MNI.ID_SB=SB.ID)'+lineending+
  ''+lineending+
  ') as t1'+lineending+
  'join RAIONS on (RAIONS.ID=t1.ID_RAION)'+lineending+
  'left join START_WORK as t2 on (RAIONS.ID_BOSS=t2.ID)'+lineending+
  'left join PEOPLES as t3 on (t2.ID_PEOPLE=t3.ID)'+lineending+sdop;
                        qr.SQL.Add(stmp);
                       qr.Open;
                       myDOCS:=TmyDOCS.Create(ttaDel_KRIPT,ExtractFilePath(Application.ExeName), Qr);
                                end;
                       end;


                       //Тут всякие действия
                       myDOCS.Free;

                     except
                       on E: Exception do
                       begin
                           if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                           begin
                            MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                           end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
                       end;
                     end;

         end;
         17:begin//Заявка на ремонт
             if ComboBox1.ItemIndex<0 then exit;
             case ComboBox1.ItemIndex of
                    0:begin
                        try
                     // AKTT;
              //Создадим документ
                          stmp:=inputbox('текст','укажите неисправность','');
                          if utf8length(stmp)<=0 then exit;
              tr:=tSQLTransaction.Create(self);
              qr:=TSQLQuery.Create(self);
              Tr.DataBase:=fconn;
              Qr.Transaction:=tr;
              qr.DataBase:=fconn;
              qr.SQL.Clear;
              dtd:=datetimetostr(date());//DateTimePicker1.Date);
              //showmessage(dtd);
              dty:=utf8copy(dtd,9,2);
              dtm:=utf8copy(dtd,4,2);
              DecodeTime(time(),H,M,s,ms);
              timeH:=inttostr(H);
              timeM:=inttostr(M);
              dtd:=utf8copy(dtd,1,2);
              //showmessage(dty+lineending+timeH+lineending+timeM);
              //exit;
             { dtd2:=datetimetostr(DateTimePicker2.Date);
              dty2:=utf8copy(dtd2,7,4);
              dtm2:=utf8copy(dtd2,4,2);
              dtd2:=utf8copy(dtd2,1,2);  }
              stmp:='select '''+stmp+''' as text_remont, Raznoe.DT as dt,  Raznoe_TIP.NAME as tip, PEOPLES.FAM AS FAM2, PEOPLES.NAM AS NAM2, PEOPLES.OTCH AS OTCH2, GROUPS.NAME as group_, '+lineending+
              'LEFT(PEOPLES.NAM,1) as NM2, LEFT(PEOPLES.OTCH,1) as OT2,'+lineending+
              'PR_RASPR_Raznoe.NAME as raspr, Raznoe.SERIAL as SERIAL, Raznoe.id as id,'+lineending+
              ' Raznoe_MODEL.NAME as model_r, SB.SERIAL as sNAME, tP.FAM as FIOR, Raznoe.OTKUDA as otkuda,'+lineending+
              'RAZNOE.INVENT as INVENT, LOCATIONS.NAME as LNAME, TERRITOR.NAME as TNAME, Raznoe.DOP as DOP,'+dtd+' as dtd,'+dtm+' as dtm,'+dty+' as dty,'+lineending+
              timeH+' as tmh, '+timeM+' as tmm,'+lineending+
              't3.FAM as FAM1, t3.NAM as NAM1, t3.OTCH as OTCH1, RAIONS.FULL_KR_NAME as krname,RAIONS.ADDRESS as ADDRESS,'+lineending+
              'LEFT(t3.NAM,1) as NM1,LEFT(t3.OTCH,1) as OT1'+lineending+
              ' from Raznoe  join Raznoe_TIP on (Raznoe.ID_TIP=Raznoe_TIP.ID)'+lineending+
              'join PR_RASPR_Raznoe on (Raznoe.ID_PR_RASPR=PR_RASPR_Raznoe.ID) join START_WORK on'+lineending+
              '(START_WORK.ID=Raznoe.ID_START_WORK)'+lineending+
              ' join LOCATIONS on (LOCATIONS.ID=Raznoe.ID_LOCATION)'+lineending+
              ' join TERRITOR on (TERRITOR.ID=LOCATIONS.ID_TERRITOR)'+lineending+
              ' join PEOPLES on (START_WORK.ID_PEOPLE=PEOPLES.ID)'+lineending+
              'join RAIONS on (RAIONS.ID=Raznoe.ID_RAION)'+lineending+
              'left join START_WORK as ttt3 on (RAIONS.ID_BOSS=ttt3.ID)'+lineending+
              'left join PEOPLES as t3 on (ttt3.ID_PEOPLE=t3.ID)'+lineending+
              ' left join GROUPS'+lineending+
              'on (GROUPS.ID=START_WORK.ID_GROUP) left join Raznoe_MODEL on (Raznoe.ID_MODEL=Raznoe_MODEL.ID)'+lineending+
              'left join SB on (Raznoe.ID_SB=SB.ID) '+lineending+
              'left join START_WORK as tSW on (tSW.ID=SB.ID_START_WORK)'+lineending+
              'left join PEOPLES as tP on (tP.ID=tSW.ID_PEOPLE)'+lineending+
              'where (Raznoe.ID_RAION='+inttostr(id_raion)+')and'+lineending+
              '(Raznoe.ID='+inttostr(self.FID)+')'+lineending+
              ''+lineending+
              ''+lineending+
              ''+lineending+
              'order by Raznoe.DT';
              qr.SQL.Add(stmp);
              qr.Open;
              myDOCS:=TmyDOCS.Create(ttaZaiv_Remont,ExtractFilePath(Application.ExeName),{Fmyclass.Query}Qr);
              //Тут всякие действия
              myDOCS.Free;

         except
           on E: Exception do
               begin
                       if (utf8pos('файл не найден',UTF8lowercase( e.message))>0) then
                      begin
                       MessageDlg('Ошибка',e.Message,mtError,[mbOK],0)
                      end else  MessageDlg('неизвестная ошибка',e.Message,mtError,[mbOK],0) ;
               end;
         end;
                    end;
             end;

         end;
  end;
end;

procedure TviborDoc.ComboBox1Change(Sender: TObject);
begin
  case self.FN_journal of
         4:begin
          case self.ComboBox1.ItemIndex of
                0:begin
                 label1.Visible:=true;
                 self.DateTimePicker1.Visible:=true;
                 label2.Visible:=true;
                 self.DateTimePicker2.Visible:=true;
                end;
          end;
      end;
         5:
           begin
            case self.ComboBox1.ItemIndex of
                  0:
                    begin
                         label1.Visible:=true;
                         label1.Caption:='дата акта';
                         self.DateTimePicker1.Date:=now;
                         self.DateTimePicker1.Visible:=true;
                         label2.Visible:=false;
                         self.DateTimePicker2.Visible:=false;
                    end;
            end;
           end;
         7:begin
          case self.ComboBox1.ItemIndex of
                0:begin
                 self.DateTimePicker1.Date:=now;
             label1.Visible:=true;
             label1.Caption:='дата акта';
             self.DateTimePicker1.Visible:=true;
             label2.Visible:=false;
             self.DateTimePicker2.Visible:=false;
                 {label1.Visible:=false;
                 self.DateTimePicker1.Visible:=false;
                 label2.Visible:=false;
                 self.DateTimePicker2.Visible:=false;}
                end;
                1:begin
                 label1.Visible:=false;
                 self.DateTimePicker1.Visible:=false;
                 label2.Visible:=false;
                 self.DateTimePicker2.Visible:=false;
                end;
                2:begin
                 label1.Visible:=true;
                 label1.Caption:='дата акта';
                 self.DateTimePicker1.Visible:=true;
                 label2.Visible:=false;
                 self.DateTimePicker2.Visible:=false;
                end;
          end;
         end;
         9:begin
          case self.ComboBox1.ItemIndex of
                0:begin
                 label1.Visible:=true;
                 self.DateTimePicker1.Visible:=true;
                 label2.Visible:=true;
                 self.DateTimePicker2.Visible:=true;
                end;
                1:begin
                 label1.Visible:=false;
                 self.DateTimePicker1.Visible:=false;
                 label2.Visible:=false;
                 self.DateTimePicker2.Visible:=false;
                end;
                2:begin
                 label1.Visible:=false;
                 self.DateTimePicker1.Visible:=false;
                 label2.Visible:=false;
                 self.DateTimePicker2.Visible:=false;
                end;
                3:begin
                 label1.Visible:=true;
                 self.DateTimePicker1.Visible:=true;
                 label2.Visible:=true;
                 self.DateTimePicker2.Visible:=true;
                 self.DateTimePicker1.Date:=incYear(now,-1);
                 self.DateTimePicker2.Date:=now;
                end;
          end;
         end;
  end;
end;

procedure TviborDoc.FormCreate(Sender: TObject);
begin
  self.Fnom:=-1;
  self.FN_journal:=-1;
  self.FID:=-1;
end;

procedure TviborDoc.Setconn(AValue: TSQLconnector);
begin
  if Fconn=AValue then Exit;
  Fconn:=AValue;
end;

procedure TviborDoc.SetID(AValue: integer);
begin
  if FID=AValue then Exit;
  FID:=AValue;
end;

procedure TviborDoc.Setnom(AValue: integer);
begin
  if Fnom=AValue then Exit;
  Fnom:=AValue;
end;

procedure TviborDoc.SetN_journal(AValue: integer);
begin
  if FN_journal=AValue then Exit;
  FN_journal:=AValue;
   case self.FN_journal of
         0:begin
             label1.Visible:=false;
             self.DateTimePicker1.Visible:=false;
             label2.Visible:=false;
             self.DateTimePicker2.Visible:=false;
         end;
         3:begin
             label1.Visible:=false;
             self.DateTimePicker1.Visible:=false;
             label2.Visible:=false;
             self.DateTimePicker2.Visible:=false;
         end;
         4:begin
             self.DateTimePicker1.Date:=incYear(now,-1);
             self.DateTimePicker2.Date:=now;
         end;
         5:begin
             self.DateTimePicker1.Date:=now;
             label1.Visible:=true;
             label1.Caption:='дата акта';
             self.DateTimePicker1.Visible:=true;
             label2.Visible:=false;
             self.DateTimePicker2.Visible:=false;
         end;
         7:begin
                self.DateTimePicker1.Date:=now;
             label1.Visible:=true;
             label1.Caption:='дата акта';
             self.DateTimePicker1.Visible:=true;
             label2.Visible:=false;
             self.DateTimePicker2.Visible:=false;
             {label1.Visible:=false;
             self.DateTimePicker1.Visible:=false;
             label2.Visible:=false;
             self.DateTimePicker2.Visible:=false; }
         end;
         9:begin
             {self.DateTimePicker1.Date:=incYear(now,-1);
             self.DateTimePicker2.Date:=now;  }
             label1.Visible:=false;
             self.DateTimePicker1.Visible:=false;
             label2.Visible:=false;
             self.DateTimePicker2.Visible:=false;
         end;
         17:begin
             self.DateTimePicker1.Date:=now;
             label1.Visible:=true;
             label1.Caption:='дата заявки';
             self.DateTimePicker1.Visible:=true;
             label2.Visible:=false;
             self.DateTimePicker2.Visible:=false;
         end;
  end;
end;

end.

