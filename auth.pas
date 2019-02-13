unit auth;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  lclproc, ExtCtrls;

type

   TMyResAuth=procedure of object;
  { Tfrmauth }

  Tfrmauth = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FAnimated:integer;
    FcheckUsr: byte;
    FOnMyResAuth: TMyResAuth;
    FresultF: boolean;
    function Getlogin: string;
    function Getpwd: string;
    procedure EnableControl(Enbld:boolean);
    const checkuser:array[0..3] of string=('Идет проверка логина и пароля',
    'Идет проверка логина и пароля.','Идет проверка логина и пароля..',
    'Идет проверка логина и пароля...');
    const connuser:array[0..3] of string=('Соединение пользователем',
    'Соединение пользователем.','Соединение пользователем..',
    'Соединение пользователем...');
    const timeconnect:array[0..3] of string=('Соединение с базой',
    'Соединение с базой.','Соединение с базой..',
    'Соединение с базой...');
    { private declarations }
  public
    { public declarations }
    procedure  ExF(resultF:boolean);
    property login:string read Getlogin;
    property pwd:string read Getpwd;
    property OnMyResAuth:TMyResAuth read FOnMyResAuth write FOnMyResAuth;
    property resultF:boolean read FresultF write FresultF default false;
    property checkUsr:byte read FcheckUsr write FcheckUsr default 0;
  end;

var
  frmauth: Tfrmauth;

implementation
//uses main;
{$R *.lfm}

{ Tfrmauth }

procedure Tfrmauth.Edit1Change(Sender: TObject);
begin
  button1.Enabled:=(length(trim(edit1.Text))>0)and(length(edit2.Text)>2);
end;

procedure Tfrmauth.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  //CloseAction:=caFree;
end;

procedure Tfrmauth.FormCreate(Sender: TObject);
begin
  self.FAnimated:=0;
  FresultF:=false;
  Edit1.Text:='u02408001';//Полагин
  //Edit1.Text:='u02408002';//Батищев
  //self.Edit1.Text:='admin027';//Новоршавка
  //self.Edit2.Text:='admin027';//Новоршавка
  Edit2.Text:='26101979';//Полагин
  //Edit2.Text:='13021967';//Батищев
end;

procedure Tfrmauth.FormShow(Sender: TObject);
begin
  //self.Button1Click(self.Button1);
end;

procedure Tfrmauth.Timer1Timer(Sender: TObject);
begin
  inc(self.FAnimated);
  if self.FAnimated=4 then self.FAnimated:=0;
  case checkUsr of
       0:self.Label4.Caption:=timeconnect[self.FAnimated];
       1:self.Label4.Caption:=checkuser[self.FAnimated];
       2:self.Label4.Caption:=connuser[self.FAnimated];
  end;
end;

function Tfrmauth.Getlogin: string;
begin
  result:=edit1.Text;
end;

function Tfrmauth.Getpwd: string;
begin
  result:=edit2.Text;
end;

procedure Tfrmauth.EnableControl(Enbld: boolean);
begin
  self.Edit1.Enabled:=Enbld;
  self.Edit2.Enabled:=Enbld;
  self.Button1.Enabled:=Enbld;
  self.Button2.Enabled:=Enbld;
end;

procedure Tfrmauth.ExF(resultF: boolean);
begin
  self.Timer1.Enabled:=false;
  FresultF:=resultF;
  close;
end;

procedure Tfrmauth.Button1Click(Sender: TObject);
begin
  //mainF.connlogin:=edit1.Text;mainF.connpwd:=edit2.Text;

  self.Edit1.Text:=trim(self.Edit1.Text);
  self.Edit2.Text:=trim(self.Edit2.Text);
  if assigned(OnMyResAuth) then FOnMyResAuth
  else
    begin
      self.ModalResult:=mrCancel;
      close;
      exit;
    end;
  EnableControl(false);
  self.Timer1.Enabled:=true;
end;

procedure Tfrmauth.Button2Click(Sender: TObject);
begin
  FresultF:=false;
end;

end.

