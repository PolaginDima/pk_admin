unit findrecord;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, StdCtrls,sqldb,db, LAZUTF8;

type

  { Tfrmfindrecord }

  Tfrmfindrecord = class(TForm)
    btnFind: TButton;
    btnCancel: TButton;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    dtpIn1: TDateTimePicker;
    dtpFrom1: TDateTimePicker;
    editWhat: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnFindClick(Sender: TObject);
  private
    FQueryFind:TSQLQuery;
    const Ttip_poisk: array[1..4] of string = ('like','strtng', 'eql','neg');
    //const Ttip_poisk2: array[1..4] of string = ('like','strtng', '=','<>');
    { private declarations }
    function GetResultPoisk: TSQLQuery;
  public
    { public declarations }
    function Find(Query:TSQLQuery;conn:Tsqlconnector;trans:tsqltransaction;HiddenPoles:array of string):boolean;
    property ResultPoisk:TSQLQuery read GetResultPoisk;
  end;

{var
  frmfindrecord: Tfrmfindrecord;  }

implementation

{$R *.lfm}

{ Tfrmfindrecord }

procedure Tfrmfindrecord.btnFindClick(Sender: TObject);
begin
  {case self.ComboBox1.Text of
  '=':self.FStrokaPoiska:=self.editWhat.Text;
  end;}
end;

function Tfrmfindrecord.GetResultPoisk: TSQLQuery;
begin
  result:=self.FQueryFind;
end;

function Tfrmfindrecord.Find(Query: TSQLQuery; conn: Tsqlconnector;
  trans: tsqltransaction; HiddenPoles: array of string): boolean;
type Ttip_whatpoisk=(Ttip_number,Ttip_text);
function checkTipStroka:Ttip_whatpoisk;
var
  i:real;
  code:integer;
begin
  val(self.editWhat.Text, i, code);
    if code<>0 then //если не число, то значит дата или текст
    begin
         if 1=1 then
         result:=Ttip_whatpoisk.Ttip_text;
    end else
    result:=Ttip_whatpoisk.Ttip_number;
end;

 function ExistsPole(Pole:TField):boolean;
 var
   i:integer;
 begin
  result:=false;
  //for i:=0 to high(HiddenPoles) do
  i:=0;
  while (I<=high(HiddenPoles))and(not result) do
  begin
    result:=result or (utf8lowercase(Pole.FieldName)=utf8lowercase(HiddenPoles[i]));
    inc(i);
  end;
  //showmessage(Pole.FieldName + lineending + HiddenPoles[i]);
 end;

function tip_poisk_operator:string;
begin
 case Ttip_poisk[self.ComboBox1.ItemIndex+1] of
 'eql':result:='=';
 'like':result:='CONTAINING';//'like';
 'strtng':result:='like'
 end;
end;

function tip_poisk_znak1:string;
begin
 case Ttip_poisk[self.ComboBox1.ItemIndex+1] of
 'eql':result:='';
 'like':result:='';
 'strtng':result:='';
 end;
end;

function tip_poisk_znak2:string;
begin
 case Ttip_poisk[self.ComboBox1.ItemIndex+1] of
 'eql':result:='';
 'like':result:='';
 'strtng':result:='%';
 end;
end;

function tip_poisk_lower1:string;
begin
 case Ttip_poisk[self.ComboBox1.ItemIndex+1] of
 'eql':result:='(';
 'like':result:='(';
 'strtng':result:='(LOWER(';
 end;
end;

function tip_poisk_lower2:string;
begin
 case Ttip_poisk[self.ComboBox1.ItemIndex+1] of
 'eql':result:=' ';
 'like':result:=' ';
 'strtng':result:=') ';
 end;
end;

function proverkaTipPole(pole:tfield;whatpoisk:string;tip_whatpoisk:Ttip_whatpoisk;index:integer):string;
begin
  result:='';
  if (pole.DataType in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD])
  {and(Ttip_poisk[self.ComboBox1.ItemIndex+1]<>'like')}
  and(tip_whatpoisk=Ttip_number) then
  begin
       result:='('+utf8lowercase(Query.Fields.Fields[index].FieldName)
                            +' '+tip_poisk_operator;
       result:=result+' '+whatpoisk+')';
       if index<>(Query.Fields.Count-1)then result:=result+' or ';
  end;

  if pole.DataType in [ftString, ftFixedChar, ftMemo] then
  begin
            result:=tip_poisk_lower1+utf8lowercase(Query.Fields.Fields[index].FieldName)
                            +tip_poisk_lower2+tip_poisk_operator;
            result:=result+' '''+tip_poisk_znak1+whatpoisk+tip_poisk_znak2+''')';
            if index<>(Query.Fields.Count-1)then result:=result+' or ';
  end;
  if pole.DataType in [ftDate,  ftTime, ftDateTime] then
  begin
           { result:='('+utf8lowercase(Query.Fields.Fields[index].FieldName)
                            +' '+tip_poisk_operator;
            result:=result+' '''+tip_poisk_znak1+whatpoisk+tip_poisk_znak2+''')';
            if index<>(Query.Fields.Count-1)then result:=result+' or ';    }
  end;
end;

var
  i:integer;
  tmpstr:string;
  whatpoisk:string;
  tip:Ttip_whatpoisk;
begin
    if (Query=nil)or(Query.IsEmpty) then exit;
    if self.ShowModal=mrok then
    begin
       if FQueryFind=nil then FQueryFind:=tsqlquery.Create(self);
       FQueryFind.Transaction:=trans;
       FQueryFind.DataBase:=conn;
       whatpoisk:=utf8lowercase(self.editWhat.Text);
        //проверяем что ввели, число или текст или дату
        tip:=checkTipStroka;
       //Сформируем SQL запрос
       //Переберем столбцы набора данных в котором будем искать
       tmpstr:='select * from ('+Query.SQL.Text+') where ';
       {case Ttip_poisk[self.ComboBox1.ItemIndex+1] of
       'eql': //Если выбрано равно в окне поиска
         begin}
           for i:=0 to Query.Fields.Count-1 do
             if ExistsPole(Query.Fields.Fields[i]) //Скрытые поля в котором нужен поиск
             or (Query.Fields.Fields[i].Visible)then //Ищем в тех полях которые отображаются
             tmpstr:=tmpstr+proverkaTipPole(Query.Fields.Fields[i],whatpoisk, tip,  i);
         {end; }
      { 'like':
         begin

         end;
       end; }
         //showmessage(tmpstr);
         if copy(tmpstr,length(tmpstr)-2,2)='or' then tmpstr:=copy(tmpstr,0,length(tmpstr)-3);
         //showmessage(tmpstr);
         self.FQueryFind.Close;
         self.FQueryFind.SQL.Clear;
         self.FQueryFind.SQL.Add(tmpstr);
         self.FQueryFind.Open;
         //showmessage(inttostr(self.FQueryFind.RecordCount));
         self.FQueryFind.First;
         result:=self.FQueryFind.RecordCount>0
         //showmessage(self.FQueryFind.FieldByName('FAM').AsString);
  end else result:=false;
end;

end.

