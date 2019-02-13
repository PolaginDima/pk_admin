unit Zastavka;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, DBGrids, Grids;

type

  { Tzastavka1 }

  Tzastavka1 = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
    TOCHKA:INTEGER;
    stmp:string;
  public
    { public declarations }
  end;

var
  zastavka1: Tzastavka1;

implementation

{$R *.lfm}

{ Tzastavka1 }

procedure Tzastavka1.Timer1Timer(Sender: TObject);
{var i:integer;
  sstmp:string; }
begin
{  sstmp:='';
  tochka:=tochka+1;
  if tochka>4 then tochka:=1;
  for i:=1 to tochka do
  begin
    sstmp:=sstmp+'.';
  end;
  label1.Caption:=stmp+' '+sstmp;
  application.ProcessMessages;  }
end;

procedure Tzastavka1.FormCreate(Sender: TObject);
begin
 { tochka:=1;
  stmp:=label1.Caption;
  timer1.Enabled:=true;   }
end;

procedure Tzastavka1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

end;

end.

