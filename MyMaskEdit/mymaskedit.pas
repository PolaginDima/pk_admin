unit MyMaskEdit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, MaskEdit;

type

  { TMyMaskEdit }
   TMyEventErrorEditMask = procedure(Sender: TObject;Text:string;TextMask:string) of object;
  TMyMaskEdit = class(TMaskEdit)
  private
    FOnMyErrorEditMask: TMyEventErrorEditMask;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure ValidateEdit;override;
  published
    { Published declarations }
    property OnMyErrorEditMask:TMyEventErrorEditMask read FOnMyErrorEditMask write FOnMyErrorEditMask;
  end;

procedure Register;

implementation

procedure Register;
begin
  {$I mymaskedit_icon.lrs}
  RegisterComponents('MyComponents',[TMyMaskEdit]);
end;

{ TMyMaskEdit }

procedure TMyMaskEdit.ValidateEdit;
begin
  try
    inherited ValidateEdit;
  except
    on E: Exception do
      begin
        if assigned(OnMyErrorEditMask) then  OnMyErrorEditMask(self,text,editmask);
        text:='';
      end;
  end;
end;

end.
