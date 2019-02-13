unit InstPO;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  DBGrids, StdCtrls, Grids, lazutf8;

type
  { TfrmInstPO }

  TfrmInstPO = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormResize(Sender: TObject);
  private
    //function GetQuery: TSQLQuery;
    { private declarations }
  public
    { public declarations }
   // property Query:TSQLQuery read GetQuery;
  end;

var
  frmInstPO: TfrmInstPO;

implementation
//{$R lcl_dbgrid_images.res}
{$R *.lfm}

{ TfrmInstPO }

{function TfrmInstPO.GetQuery: TSQLQuery;
begin

end; }

procedure TfrmInstPO.Button1Click(Sender: TObject);
begin
  if DBGrid1.DataSource.DataSet.State=dsEdit then
  DBGrid1.DataSource.DataSet.Post;
end;

procedure TfrmInstPO.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  C: TPixmap;
  b:TBitMap;
  XPos,YPos: Integer;
begin

  if utf8copy(DBGrid1.DataSource.DataSet.FieldByName('pr').AsString, 1, 1)='Н' then
  begin
         TDBGrid(Sender).Canvas.Brush.Color:=clSilver;
         TDBGrid(Sender).Canvas.FillRect(Rect);
    if column.Field.DataType=ftInteger then
    begin
      C := TPixmap.Create;
      try
        //'dbgriduncheckedcb'
        //'dbgridgrayedcb'
        if column.Field.AsInteger=1 then
           C.LoadFromResourceName(hInstance, 'dbgridcheckedcb')
        else
           C.LoadFromResourceName(hInstance, 'dbgriduncheckedcb');
        b:= TBitmap.Create;
        b.Assign(C);
      finally
        C.Free;
      end;
      case column.Alignment of
         taCenter: XPos := Trunc((Rect.Left+Rect.Right-b.Width)/2);
         taLeftJustify: XPos := Rect.Left + varCellPadding;
         taRightJustify: XPos := Rect.Right - b.Width - varCellPadding - 1;
      end;
      YPos := Trunc((Rect.Top+Rect.Bottom-b.Height)/2);
      TDBGrid(Sender).Canvas.Draw(XPos, YPos, b);
       //DBGrid1.DefaultDrawColumnCell(Rect,DataCol,Column, State);
       //DBGrid1.Color:=clSilver;
    end else
        TDBGrid(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top+2,Column.Field.Text); ;
  end;
  {
   if diff=0 then
                           TDBGrid(Sender).Canvas.Brush.Color:=clred
                        else
                            TDBGrid(Sender).Canvas.Brush.Color:=TColor($66B3FF);//clred;

                 TDBGrid(Sender).Canvas.FillRect(Rect);
                 TDBGrid(Sender).Canvas.TextOut(Rect.Left+2,Rect.Top+2,Column.Field.Text);}
end;

procedure TfrmInstPO.FormResize(Sender: TObject);
begin
  DBGrid1.Columns.Items[2].Width:=DBGrid1.Width-DBGrid1.Columns.Items[0].Width-35;
  DBGrid1.Height:=self.Height-72;
end;

end.

