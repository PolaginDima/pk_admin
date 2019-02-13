unit addslpl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
   Buttons, sqldb;

type

  { Taddeditslpl }

  Taddeditslpl = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    NAMEPl: TMemo;
    procedure BitBtn1Click(Sender: TObject);
  private
    { private declarations }
    var addedit:boolean;
  connector:tsqlconnector;
  public
    { public declarations }
   function showmodal(add_edit:boolean;conn:tsqlconnector):integer;
  end;

var
  addeditslpl: Taddeditslpl;

implementation



{$R *.lfm}

{ Taddeditslpl }

procedure Taddeditslpl.BitBtn1Click(Sender: TObject);
var scripter:tsqlscript;
  transact:tsqltransaction;
begin
  transact:=tsqltransaction.Create(nil);
  transact.DataBase:=connector;
  scripter:=   tsqlscript.Create(nil);
  scripter.DataBase:=connector;
  scripter.Transaction:=transact;
  scripter.CommentsInSQL:=false;
  scripter.UseSetTerm:=true;
  scripter.Script.Clear;

  if addedit then
  begin
//    showmessage('добавить')
    scripter.Script.Add('insert into PLACE(id, name)values(1, '+namePl.Text+');');
    end
  else
  begin
 //   showmessage('редактировать');
     scripter.Script.Add('');
  end;
  scripter.Execute;
  transact.Commit;
end;

function Taddeditslpl.showmodal(add_edit: boolean; conn: tsqlconnector
  ): integer;
begin
  addedit:=add_edit;
  connector:=conn;
  result:=inherited showmodal;
end;

end.

