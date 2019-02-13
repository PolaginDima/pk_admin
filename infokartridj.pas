unit infokartridj;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { Tfrminfokartridj }

  Tfrminfokartridj = class(TForm)
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frminfokartridj: Tfrminfokartridj;

implementation

{$R *.lfm}

{ Tfrminfokartridj }

procedure Tfrminfokartridj.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if (key=#27)or(key=#13) then self.Close;
end;

end.

