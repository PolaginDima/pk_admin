unit moveEmployee;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls;

type

  { TmoveEmpl }

  TmoveEmpl = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  moveEmpl: TmoveEmpl;

implementation

{$R *.lfm}

end.

