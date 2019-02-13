program ptk_admin;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, main, workBD, Zastavka,
  TDBSlovariTemplateForm, tdbeditslovari, myDBGrid, forslovari, auth, addEmploy,
  moveEmployee, my_tabsheet, uvolnenieEmployee, tmpstopSW, addmni, spisaniemni,
  createDOC, workinooandms, addsertifikat, addkripto, deletekripto, addsb2,
  RAIONS, selectDOC, addraznoe, spisaniesb, Add_rashodnik, Edit_Rash_For, 
findrecord, infokartridj, InstPO, add_dostup;

{$R *.res}

begin
  Application.Title:='ptk_admin v1.0';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TmainF, mainF);
  {Application.CreateForm(TmoveEmpl, moveEmpl);
  Application.CreateForm(TviborDoc, viborDoc);
  Application.CreateForm(TfrmRashodnik, frmRashodnik);
  Application.CreateForm(TfrmRashFor, frmRashFor);
  Application.CreateForm(Tfrminfokartridj, frminfokartridj);
  Application.CreateForm(TfrmInstPO, frmInstPO);
  Application.CreateForm(TfrmDostup, frmDostup); }
  //Application.CreateForm(Tfrmfindrecord, frmfindrecord);
 // Application.CreateForm(TFormRaion, FormRaion);
  //Application.CreateForm(TForm2, Form2);
 // Application.CreateForm(TForm1, Form1);
  //Application.CreateForm(Tzastavka1, zastavka1);
  //Application.CreateForm(TDBEditSlovar, DBEditSlovar);
   //Application.CreateForm(TDBTemplateForm, DBTemplateForm);
  //Application.CreateForm(TForm1, Form1);
  //Application.CreateForm(TslovariF, slovariF);
  Application.Run;
end.

