unit createDOC;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DIALOGS, VARIANTS, comobj, workinooandms, lazutf8,sqldb, fileutil, dateutils, Controls;
type

  //Главный предок всех классов для вывода актов
//В нем соберем все основные свойства, методы общие для всех классов

 { TmyDOCS }

 TmyDOCS=class(TmyWordWriteExcelCalc)
  type Ttip_doc=(ttaAKT_DELMNI, ttaZaiv_RP,ttaZaiv_SERT,ttaZaiv_KS, ttaAkt_MNI, ttaAkt_KRIPT, ttaSved_KRIPT, ttaDel_KRIPT,
  ttaOtchet_Del_KRIPT, ttaKart_Slovar, ttaZaiv_Sviaz, ttaKART_TEHN, ttaZaiv_Otziv, ttaZaiv_Pause,ttaZaiv_Voz,
  ttaZaiv_Remont,ttaLic_schet_mni, ttaOpis_mni, ttakartmni, ttaFillSW);
   private
     FQuery: Tsqlquery;
     DopInfo:string;
     const          stringmonth:array[1..12] of string=('январь','февраль','март','апрель','май','июнь',
         'июль','август','сентябрь','октябрь','ноябрь','декабрь');
     procedure SetQuery(AValue: Tsqlquery);
     procedure selectAction(const tip_doc: Ttip_doc;const filepath: string);
     function MonthIntToStr(nMonth:integer):string;
     procedure CreateDoc;
     procedure CreateDocs(const tip_doc: Ttip_doc;nameShablon, sdir:string);
   protected
   public
     constructor Create(const tip_doc:Ttip_doc;const exefilepath:string;Qr:Tsqlquery;dop:string='');
     //constructor OpenDOC(tip_doc:Ttip_doc);override;
     destructor Destroy;override;
     property Query:Tsqlquery read FQuery write SetQuery;
 end;

implementation
uses workbd;
{ TmyDOCS }

procedure TmyDOCS.SetQuery(AValue: Tsqlquery);
begin
  if FQuery=AValue then Exit;
  FQuery:=AValue;
end;

procedure TmyDOCS.selectAction(const tip_doc: Ttip_doc; const filepath: string);
var
  oTable:variant;
  oTables:variant;
  oTblColSeps:variant;
  oInsertPoint:variant;
  rows{,row, cols,col}:variant;
  cell:variant;
  //cellcursor:variant;
  //oTblColSeps:variant;  //Массив разделителей столбцов таблицы
  i,j:integer;
  w:widestring;//ansistring;
  oDescriptor:variant;
  stmp, stmp1, stmp2:string;
begin
  stmp:='';stmp1:='';stmp2:='';
  case  tip_doc of
  ttaAkt_MNI:begin
                     //Вставим таблицу
                     //REM Позволим документу создать текстовую таблицу
                     oTable:=Document.createinstance('com.sun.star.text.TextTable');
                     oTable.initialize(2,3);
  //REM Если есть закладка по имени "InsertTableHere", то вставим таблицу
// в том месте. Если эта закладка не существует, то просто выберем
// самый конец документа.


//---------
//Способ вставки в нужное место через слово в тексте
oDescriptor:=Document.createSearchDescriptor;
      oDescriptor.searchString:='TABLE1';
      oInsertPoint:=Document.findfirst(oDescriptor);
      if VarIsEmpty(oInsertPoint) then
      begin
        oInsertPoint:= Document.Text.getEnd;
      end else oInsertPoint.setstring('');

//-------------

                         {if self.Document.getbookmarks.hasbyname('TABLE') then
                         oInsertPoint:=self.Document.getbookmarks.getbyname('TABLE').getanchor
                         else
                           oInsertPoint:= self.Document.Text.getEnd;  }

                         // Теперь вставим текстовую таблицу .
// Отметьте, что используется текстовый объект oInsertPoint текстовый
// диапазон, а не текстовый объект документ.
oInsertPoint.getText.insertTextContent(oInsertPoint , oTable, False);
// Метод объекта setData() работает ТОЛЬКО с числовыми данными.
// Метод объекта setDataArray(), однако, также допускает строки.
//oTable.setDataArray(Array(Array(0, "One", 2), Array(3, "Four", 5)))
oTable.setName('MNI');
{
//Получим строки
rows:=oTable.getrows;
//Переберем строки и отформатируем
rows.getbyindex(0).backcolor:='&HDDDDDD';
for i:=1 to rows.getcount-1 do
begin
                   row:=rows.getbyindex(i);
                   row.backcolor:='&HFFFFFF';
end;  }
//Заполним таблицу
//Получим строки
rows:=oTable.getrows;
//Получим столбцы
//cols:=oTable.getcolumns;
//Переберем ячейки таблицы
//Заполним шапку
//первый столбец первая строка
cell:=oTable.getCellByPosition(0,0);
w:=utf8toansi('№ п/п');
cell.setstring(w);
//второй столбец первая строка
cell:=oTable.getCellByPosition(1,0);
w:=utf8toansi('Учетный номер МНИ');
cell.setstring(w);
//и т.д.
cell:=oTable.getCellByPosition(2,0);
w:=utf8toansi('тип МНИ');
cell.setstring(w);
//Проверим есть ли что писать в таблицу
if FQuery.IsEmpty then
begin
  //Если нечего писать, то удалим последнюю строку
//  и выйдем из процедуры
  rows.removebyindex(1,1);
  exit;
end;
//добавим нужное количество строк
FQuery.First;
FQuery.Last;
if FQuery.RecordCount>1 then rows.insertbyindex(2,FQuery.RecordCount-1);
FQuery.First;
for i:=1 to rows.getcount-1 do
//for j:=0 to cols.getcount-1 do
begin
//Заполняем ячейки строки
                   //первая ячейка
                   cell:=oTable.getCellByPosition(0,i);
                   w:=utf8toansi(inttostr(i));
                   cell.setstring(w);
                   //Вторая ячейка
                   cell:=oTable.getCellByPosition(1,i);
                   w:=utf8toansi(FQuery.FieldByName('UCHETN').AsString);
                   cell.setstring(w);
                   //и т.д.
                   cell:=oTable.getCellByPosition(2,i);
                   w:=utf8toansi(FQuery.FieldByName('tNAME').AsString);
                   cell.setstring(w);

                   FQuery.Next;
end;
//  //Начальник
ReplaceAll('FAM1',FQuery.FieldByName('FAM1').AsString);
                     ReplaceAll('NAM1',FQuery.FieldByName('NAM1').AsString);
                     ReplaceAll('OTCH1',FQuery.FieldByName('OTCH1').AsString);
                     //Инициалы начальника
                     ReplaceAll('NM1',utf8copy(FQuery.FieldByName('NAM1').AsString,1,1)+'.');
                     ReplaceAll('OT1',utf8copy(FQuery.FieldByName('OTCH1').AsString,1,1)+'.');
                     // данные организации
                     ReplaceAll('krname',FQuery.FieldByName('krname').AsString);
                     //дата
                      stmp:=datetimetostr(now);
                       stmp2:=utf8copy(stmp,7,4);
                       stmp:=utf8copy(stmp,1,2);
                       ReplaceAll('dtd',stmp);
                       ReplaceAll('dtm', MonthIntToStr(monthof(now)));
                       ReplaceAll('dty', stmp2);
end;
  ttaKart_Slovar:begin
                     //Вставим таблицу
                     //REM Позволим документу создать текстовую таблицу
                     oTable:=self.Document.createinstance('com.sun.star.text.TextTable');
                     oTable.initialize(1,3);
  //REM Если есть закладка по имени "InsertTableHere", то вставим таблицу
// в том месте. Если эта закладка не существует, то просто выберем
// самый конец документа.



                        { if self.Document.getbookmarks.hasbyname('TABLE') then
                         oInsertPoint:=self.Document.getbookmarks.getbyname('TABLE').getanchor
                         else }
                           oInsertPoint:= self.Document.Text.getEnd;

                         // Теперь вставим текстовую таблицу .
// Отметьте, что используется текстовый объект oInsertPoint текстовый
// диапазон, а не текстовый объект документ.
oInsertPoint.getText.insertTextContent(oInsertPoint , oTable, False);
// Метод объекта setData() работает ТОЛЬКО с числовыми данными.
// Метод объекта setDataArray(), однако, также допускает строки.
//oTable.setDataArray(Array(Array(0, "One", 2), Array(3, "Four", 5)))
oTable.setName('KARTOCHKA');
{
//Получим строки
rows:=oTable.getrows;
//Переберем строки и отформатируем
rows.getbyindex(0).backcolor:='&HDDDDDD';
for i:=1 to rows.getcount-1 do
begin
                   row:=rows.getbyindex(i);
                   row.backcolor:='&HFFFFFF';
end;  }
//Заполним таблицу
//Получим строки
rows:=oTable.getrows;
//Получим столбцы
//cols:=oTable.getcolumns;
//Переберем ячейки таблицы
//Заполним шапку
//первый столбец первая строка
cell:=oTable.getCellByPosition(0,0);
w:=utf8toansi('№ п/п');
cell.setstring(w);
//второй столбец первая строка
cell:=oTable.getCellByPosition(1,0);
w:=utf8toansi('наименование'+#13+'поля');
cell.setstring(w);
//и т.д.
cell:=oTable.getCellByPosition(2,0);
w:=utf8toansi('значение'+#13+'поля');
cell.setstring(w);
//  Наименование словаря
    ReplaceAll('nameSl', DopInfo);
//Проверим есть ли что писать в таблицу
if FQuery.IsEmpty then
begin
  //Если нечего писать, то удалим последнюю строку
//  и выйдем из процедуры
  //rows.removebyindex(0,1);
  exit;
end;
//добавим нужное количество строк
//if self.FQuery.FieldCount>1 then rows.insertbyindex(2,self.FQuery.FieldCount-1);
j:=0;
for i:=0 to self.FQuery.FieldCount-1 do
begin
    if not self.FQuery.Fields.Fields[i].Visible then continue;
    j:=j+1;
    rows.insertbyindex(j,1);
//Заполняем ячейки строки
                   //первая ячейка
                   cell:=oTable.getCellByPosition(0,j);
                   w:=utf8toansi(inttostr(j));
                   cell.setstring(w);
                   //Вторая ячейка
                   cell:=oTable.getCellByPosition(1,j);
                   w:=utf8toansi(FQuery.Fields.Fields[i].DisplayLabel);
                   cell.setstring(w);
                   //и т.д.
                   cell:=oTable.getCellByPosition(2,j);
                   w:=utf8toansi(FQuery.Fields.Fields[i].AsString);
                   cell.setstring(w);
end;

end;
  ttaOpis_mni:begin
                     //Вставим таблицу
                     //REM Позволим документу создать текстовую таблицу
                     oTable:=Document.createinstance('com.sun.star.text.TextTable');
                     oTable.initialize(2,6);
                     //oTblColSeps[1].position:=7000;
  //REM Если есть закладка по имени "InsertTableHere", то вставим таблицу
// в том месте. Если эта закладка не существует, то просто выберем
// самый конец документа.
                         if Document.getbookmarks.hasbyname('MNI') then
                         oInsertPoint:=Document.getbookmarks.getbyname('MNI').getanchor
                         else
                           oInsertPoint:= Document.Text.getEnd;
                         // Теперь вставим текстовую таблицу .
// Отметьте, что используется текстовый объект oInsertPoint текстовый
// диапазон, а не текстовый объект документ.
oInsertPoint.getText.insertTextContent(oInsertPoint , oTable, False);
// Метод объекта setData() работает ТОЛЬКО с числовыми данными.
// Метод объекта setDataArray(), однако, также допускает строки.
//oTable.setDataArray(Array(Array(0, "One", 2), Array(3, "Four", 5)))
oTable.setName('MNI');
oTblColSeps:=oTable.TableColumnSeparators;
//showmessage(inttostr(oTblColSeps.getcount));
//showmessage(inttostr(oTblColSeps[0].position));
//showmessage(inttostr(oTblColSeps[1].position));
//showmessage(inttostr(oTblColSeps[2].position));
oTable.leftmargin:=-530;
oTable.rightmargin:=0;//220;
oTable.horiorient:=0;
                    oTblColSeps[0].position:=722;
                    oTblColSeps[1].position:=2311;
                    oTblColSeps[2].position:=3772;
                    oTblColSeps[3].position:=5199;
                    oTblColSeps[4].position:=7510;
                    {oTblColSeps[5].position:=7011;
                    oTblColSeps[6].position:=8553; }
                    //oTblColSeps[7].position:=1447;
                    oTable.TableColumnSeparators:=oTblColSeps;
{
//Получим строки
rows:=oTable.getrows;
//Переберем строки и отформатируем
rows.getbyindex(0).backcolor:='&HDDDDDD';
for i:=1 to rows.getcount-1 do
begin
                   row:=rows.getbyindex(i);
                   row.backcolor:='&HFFFFFF';
end;  }
//Заполним таблицу
//Получим строки
rows:=oTable.getrows;
//Получим столбцы
//cols:=oTable.getcolumns;
//Переберем ячейки таблицы
//Заполним шапку
//первый столбец первая строка
cell:=oTable.getCellByPosition(0,0);
w:=utf8toansi('№ п/п');
cell.setstring(w);
//второй столбец первая строка
cell:=oTable.getCellByPosition(1,0);
w:=utf8toansi('Дата получения');
cell.setstring(w);
//и т.д.
cell:=oTable.getCellByPosition(2,0);
w:=utf8toansi('Учетный номер носителя');
cell.setstring(w);
cell:=oTable.getCellByPosition(3,0);
w:=utf8toansi('тип носителя');
cell.setstring(w);
cell:=oTable.getCellByPosition(4,0);
w:=utf8toansi('Дата и роспись в обратном приеме');
cell.setstring(w);
cell:=oTable.getCellByPosition(5,0);
w:=utf8toansi('Фамилия и инициалы');
cell.setstring(w);
//Проверим есть ли что писать в таблицу
if self.FQuery.IsEmpty then
begin
  //Если нечего писать, то удалим последнюю строку
//  и выйдем из процедуры
  rows.removebyindex(1,1);
  exit;
end;
//добавим нужное количество строк
self.FQuery.First;
self.FQuery.Last;
if self.FQuery.RecordCount>1 then rows.insertbyindex(2,self.FQuery.RecordCount-1);
self.FQuery.First;
for i:=1 to rows.getcount-1 do
//for j:=0 to cols.getcount-1 do
begin
//Заполняем ячейки строки
                   //первая ячейка
                   cell:=oTable.getCellByPosition(0,i);
                   w:=utf8toansi(inttostr(i));
                   cell.setstring(w);
                   //Вторая ячейка
                   cell:=oTable.getCellByPosition(1,i);
                   w:=utf8toansi(self.FQuery.FieldByName('DTP').AsString);
                   cell.setstring(w);
                   //и т.д.
                   cell:=oTable.getCellByPosition(2,i);
                   w:=utf8toansi(self.FQuery.FieldByName('UN').AsString);
                   cell.setstring(w);
                   //-----
                   cell:=oTable.getCellByPosition(3,i);
                   w:=utf8toansi(self.FQuery.FieldByName('tNAME').AsString);
                   cell.setstring(w);
                   self.FQuery.Next;
end;
                                    //Пользователь
                     self.ReplaceAll('FAM2',self.FQuery.FieldByName('FAM2').AsString);
                     self.ReplaceAll('NAM2',self.FQuery.FieldByName('NAM2').AsString);
                     self.ReplaceAll('OTCH2',self.FQuery.FieldByName('OTCH2').AsString);
                     //self.ReplaceAll('DOLJ',self.FQuery.FieldByName('dolj').AsString);
end;
  ttaLic_schet_mni:begin
                     //Вставим таблицу
                     //REM Позволим документу создать текстовую таблицу
                     oTable:=self.Document.createinstance('com.sun.star.text.TextTable');
                     oTable.initialize(2,8);
                     //oTblColSeps[1].position:=7000;
  //REM Если есть закладка по имени "InsertTableHere", то вставим таблицу
// в том месте. Если эта закладка не существует, то просто выберем
// самый конец документа.
                         if self.Document.getbookmarks.hasbyname('MNI') then
                         oInsertPoint:=self.Document.getbookmarks.getbyname('MNI').getanchor
                         else
                           oInsertPoint:= self.Document.Text.getEnd;
                         // Теперь вставим текстовую таблицу .
// Отметьте, что используется текстовый объект oInsertPoint текстовый
// диапазон, а не текстовый объект документ.
oInsertPoint.getText.insertTextContent(oInsertPoint , oTable, False);
// Метод объекта setData() работает ТОЛЬКО с числовыми данными.
// Метод объекта setDataArray(), однако, также допускает строки.
//oTable.setDataArray(Array(Array(0, "One", 2), Array(3, "Four", 5)))
oTable.setName('MNI');
oTblColSeps:=oTable.TableColumnSeparators;
//showmessage(inttostr(oTblColSeps.getcount));
//showmessage(inttostr(oTblColSeps[0].position));
//showmessage(inttostr(oTblColSeps[1].position));
//showmessage(inttostr(oTblColSeps[2].position));
oTable.leftmargin:=-550;
oTable.rightmargin:=-290;
oTable.horiorient:=0;
                    oTblColSeps[0].position:=701;
                    oTblColSeps[1].position:=1913;
                    oTblColSeps[2].position:=3085;
                    oTblColSeps[3].position:=4627;
                    oTblColSeps[4].position:=5749;
                    oTblColSeps[5].position:=7011;
                    oTblColSeps[6].position:=8553;
                    //oTblColSeps[7].position:=1447;
                    oTable.TableColumnSeparators:=oTblColSeps;
{
//Получим строки
rows:=oTable.getrows;
//Переберем строки и отформатируем
rows.getbyindex(0).backcolor:='&HDDDDDD';
for i:=1 to rows.getcount-1 do
begin
                   row:=rows.getbyindex(i);
                   row.backcolor:='&HFFFFFF';
end;  }
//Заполним таблицу
//Получим строки
rows:=oTable.getrows;
//Получим столбцы
//cols:=oTable.getcolumns;
//Переберем ячейки таблицы
//Заполним шапку
//первый столбец первая строка
cell:=oTable.getCellByPosition(0,0);
w:=utf8toansi('№ п/п');
cell.setstring(w);
//второй столбец первая строка
cell:=oTable.getCellByPosition(1,0);
w:=utf8toansi('Учетный номер носителя');
cell.setstring(w);
//и т.д.
cell:=oTable.getCellByPosition(2,0);
w:=utf8toansi('тип носителя');
cell.setstring(w);
cell:=oTable.getCellByPosition(3,0);
w:=utf8toansi('модель носителя');
cell.setstring(w);
cell:=oTable.getCellByPosition(4,0);
w:=utf8toansi('объем носителя');
cell.setstring(w);
cell:=oTable.getCellByPosition(5,0);
w:=utf8toansi('дата получения');
cell.setstring(w);
cell:=oTable.getCellByPosition(6,0);
w:=utf8toansi('подпись пользователя');
cell.setstring(w);
cell:=oTable.getCellByPosition(7,0);
w:=utf8toansi('дата и подпись об обратном приеме');
cell.setstring(w);
//Проверим есть ли что писать в таблицу
if self.FQuery.IsEmpty then
begin
  //Если нечего писать, то удалим последнюю строку
//  и выйдем из процедуры
  rows.removebyindex(1,1);
  exit;
end;
//добавим нужное количество строк
self.FQuery.First;
self.FQuery.Last;
if self.FQuery.RecordCount>1 then rows.insertbyindex(2,self.FQuery.RecordCount-1);
self.FQuery.First;
for i:=1 to rows.getcount-1 do
//for j:=0 to cols.getcount-1 do
begin
//Заполняем ячейки строки
                   //первая ячейка
                   cell:=oTable.getCellByPosition(0,i);
                   w:=utf8toansi(inttostr(i));
                   cell.setstring(w);
                   //Вторая ячейка
                   cell:=oTable.getCellByPosition(1,i);
                   w:=utf8toansi(self.FQuery.FieldByName('UN').AsString);
                   cell.setstring(w);
                   //и т.д.
                   cell:=oTable.getCellByPosition(2,i);
                   w:=utf8toansi(self.FQuery.FieldByName('tNAME').AsString);
                   cell.setstring(w);
                   //-----
                   cell:=oTable.getCellByPosition(3,i);
                   if self.FQuery.FieldByName('mNAME').IsNull then
                   w:=utf8toansi('-') else w:=utf8toansi(self.FQuery.FieldByName('mNAME').AsString);
                   cell.setstring(w);
                   //-----
                   cell:=oTable.getCellByPosition(4,i);
                   w:=utf8toansi(self.FQuery.FieldByName('sz').AsString);
                   cell.setstring(w);

                   self.FQuery.Next;
end;
                                    //Пользователь
                     self.ReplaceAll('FAM2',self.FQuery.FieldByName('FAM2').AsString);
                     self.ReplaceAll('NAM2',self.FQuery.FieldByName('NAM2').AsString);
                     self.ReplaceAll('OTCH2',self.FQuery.FieldByName('OTCH2').AsString);
                     self.ReplaceAll('DOLJ',self.FQuery.FieldByName('dolj').AsString);
end;
  ttakartmni:begin
                    { //Вставим таблицу
                     //REM Позволим документу создать текстовую таблицу
                     oTable:=Document.createinstance('com.sun.star.text.TextTable');
                     oTable.initialize(2,8);
                     //oTblColSeps[1].position:=7000;
  //REM Если есть закладка по имени "InsertTableHere", то вставим таблицу
// в том месте. Если эта закладка не существует, то просто выберем
// самый конец документа.
                         if Document.getbookmarks.hasbyname('MNI') then
                         oInsertPoint:=Document.getbookmarks.getbyname('MNI').getanchor
                         else
                           oInsertPoint:= Document.Text.getEnd;
                         // Теперь вставим текстовую таблицу .
// Отметьте, что используется текстовый объект oInsertPoint текстовый
// диапазон, а не текстовый объект документ.
oInsertPoint.getText.insertTextContent(oInsertPoint , oTable, False);
// Метод объекта setData() работает ТОЛЬКО с числовыми данными.
// Метод объекта setDataArray(), однако, также допускает строки.
//oTable.setDataArray(Array(Array(0, "One", 2), Array(3, "Four", 5)))
oTable.setName('MNI'); }
oTables:=Document.GetTextTables;//Получаем все таблицы
oTable:=oTables.getByIndex(0);//Получаем конкретную таблицу по индексу
//oTblColSeps:=oTable.TableColumnSeparators;
//showmessage(inttostr(oTblColSeps.getcount));
//showmessage(inttostr(oTblColSeps[0].position));
//showmessage(inttostr(oTblColSeps[1].position));
//showmessage(inttostr(oTblColSeps[2].position));
//oTable.leftmargin:=-550;
//oTable.rightmargin:=-290;
//oTable.horiorient:=0;
                   { oTblColSeps[0].position:=701;
                    oTblColSeps[1].position:=1913;
                    oTblColSeps[2].position:=3085;
                    oTblColSeps[3].position:=4627;
                    oTblColSeps[4].position:=5749;
                    oTblColSeps[5].position:=7011;
                    oTblColSeps[6].position:=8553;
                    //oTblColSeps[7].position:=1447;
                    oTable.TableColumnSeparators:=oTblColSeps;    }
{
//Получим строки
rows:=oTable.getrows;
//Переберем строки и отформатируем
rows.getbyindex(0).backcolor:='&HDDDDDD';
for i:=1 to rows.getcount-1 do
begin
                   row:=rows.getbyindex(i);
                   row.backcolor:='&HFFFFFF';
end;  }
//Заполним таблицу
//Получим строки
rows:=oTable.getrows;
//Получим столбцы
//cols:=oTable.getcolumns;
//Переберем ячейки таблицы
//Заполним шапку
//первый столбец первая строка
{cell:=oTable.getCellByPosition(1,8);
w:=utf8toansi('11111111111');
cell.setstring(w);
exit;
//второй столбец первая строка
cell:=oTable.getCellByPosition(1,0);
w:=utf8toansi('Учетный номер носителя');
cell.setstring(w);
//и т.д.
cell:=oTable.getCellByPosition(2,0);
w:=utf8toansi('тип носителя');
cell.setstring(w);
cell:=oTable.getCellByPosition(3,0);
w:=utf8toansi('модель носителя');
cell.setstring(w);
cell:=oTable.getCellByPosition(4,0);
w:=utf8toansi('объем носителя');
cell.setstring(w);
cell:=oTable.getCellByPosition(5,0);
w:=utf8toansi('дата получения');
cell.setstring(w);
cell:=oTable.getCellByPosition(6,0);
w:=utf8toansi('подпись пользователя');
cell.setstring(w);
cell:=oTable.getCellByPosition(7,0);
w:=utf8toansi('дата и подпись об обратном приеме');
cell.setstring(w);}
//Проверим есть ли что писать в таблицу
if FQuery.IsEmpty then
begin
  //Если нечего писать, то удалим последнюю строку
//  и выйдем из процедуры
  rows.removebyindex(1,8);
  exit;
end;
//добавим нужное количество строк
FQuery.First;
FQuery.Last;
if FQuery.RecordCount>7 then rows.insertbyindex(8,FQuery.RecordCount-1);
FQuery.First;
for i:=1 to FQuery.RecordCount do// rows.getcount-1 do
//for j:=0 to cols.getcount-1 do
begin
//Заполняем ячейки строки
                   //первая ячейка
                   cell:=oTable.getCellByPosition(0,7+i);
                   w:=utf8toansi(inttostr(i));
                   cell.setstring(w);
                   //Вторая ячейка
                   cell:=oTable.getCellByPosition(1,7+i);
                   w:=utf8toansi(FQuery.FieldByName('FAM2').AsString+' '+FQuery.FieldByName('NAM2').AsString+' '+FQuery.FieldByName('OTCH2').AsString);
                   cell.setstring(w);
                   FQuery.Next;
end;
                     CreateDoc;
end;

  ttaAKT_DELMNI:begin
                     //Вставим таблицу
                     //REM Позволим документу создать текстовую таблицу
                     oTable:=self.Document.createinstance('com.sun.star.text.TextTable');
                     oTable.initialize(2,5);
  //REM Если есть закладка по имени "InsertTableHere", то вставим таблицу
// в том месте. Если эта закладка не существует, то просто выберем
// самый конец документа.
                         if self.Document.getbookmarks.hasbyname('MNI') then
                         oInsertPoint:=self.Document.getbookmarks.getbyname('MNI').getanchor
                         else
                           oInsertPoint:= self.Document.Text.getEnd;
                         // Теперь вставим текстовую таблицу .
// Отметьте, что используется текстовый объект oInsertPoint текстовый
// диапазон, а не текстовый объект документ.
oInsertPoint.getText.insertTextContent(oInsertPoint , oTable, False);
// Метод объекта setData() работает ТОЛЬКО с числовыми данными.
// Метод объекта setDataArray(), однако, также допускает строки.
//oTable.setDataArray(Array(Array(0, "One", 2), Array(3, "Four", 5)))
oTable.setName('MNI');
{
//Получим строки
rows:=oTable.getrows;
//Переберем строки и отформатируем
rows.getbyindex(0).backcolor:='&HDDDDDD';
for i:=1 to rows.getcount-1 do
begin
                   row:=rows.getbyindex(i);
                   row.backcolor:='&HFFFFFF';
end;  }
//Заполним таблицу
//Получим строки
rows:=oTable.getrows;
//Получим столбцы
//cols:=oTable.getcolumns;
//Переберем ячейки таблицы
//Заполним шапку
//первый столбец первая строка
cell:=oTable.getCellByPosition(0,0);
w:=utf8toansi('№ п/п');
cell.setstring(w);
//второй столбец первая строка
cell:=oTable.getCellByPosition(1,0);
w:=utf8toansi('Учетный номер МНИ');
cell.setstring(w);
//и т.д.
cell:=oTable.getCellByPosition(2,0);
w:=utf8toansi('тип МНИ');
cell.setstring(w);
cell:=oTable.getCellByPosition(3,0);
w:=utf8toansi('инвентарный номер');
cell.setstring(w);
cell:=oTable.getCellByPosition(4,0);
w:=utf8toansi('Заводской (серийный) номер');
cell.setstring(w);
//Проверим есть ли что писать в таблицу
if self.FQuery.IsEmpty then
begin
  //Если нечего писать, то удалим последнюю строку
//  и выйдем из процедуры
  rows.removebyindex(1,1);
  exit;
end;
//добавим нужное количество строк
self.FQuery.First;
self.FQuery.Last;
if self.FQuery.RecordCount>1 then rows.insertbyindex(2,self.FQuery.RecordCount-1);
self.FQuery.First;
for i:=1 to rows.getcount-1 do
//for j:=0 to cols.getcount-1 do
begin
//Заполняем ячейки строки
                   //первая ячейка
                   cell:=oTable.getCellByPosition(0,i);
                   w:=utf8toansi(inttostr(i));
                   cell.setstring(w);
                   //Вторая ячейка
                   cell:=oTable.getCellByPosition(1,i);
                   w:=utf8toansi(self.FQuery.FieldByName('UCHETN').AsString);
                   cell.setstring(w);
                   //и т.д.
                   cell:=oTable.getCellByPosition(2,i);
                   w:=utf8toansi(self.FQuery.FieldByName('tNAME').AsString);
                   cell.setstring(w);
                   //-----
                   cell:=oTable.getCellByPosition(3,i);
                   w:=utf8toansi('-');
                   cell.setstring(w);
                   //-----
                   cell:=oTable.getCellByPosition(4,i);
                   w:=utf8toansi(self.FQuery.FieldByName('SERIAL').AsString);
                   cell.setstring(w);

                   self.FQuery.Next;
end;
//  //Начальник
self.ReplaceAll('FAM1',self.FQuery.FieldByName('FAM1').AsString);
                     self.ReplaceAll('NAM1',self.FQuery.FieldByName('NAM1').AsString);
                     self.ReplaceAll('OTCH1',self.FQuery.FieldByName('OTCH1').AsString);
                     //Инициалы начальника
                     self.ReplaceAll('NM1',utf8copy(self.FQuery.FieldByName('NAM1').AsString,1,1)+'.');
                     self.ReplaceAll('OT1',utf8copy(self.FQuery.FieldByName('OTCH1').AsString,1,1)+'.');
                     // данные организации
                     self.ReplaceAll('krname',self.FQuery.FieldByName('krname').AsString);

end;
  ttaZaiv_RP,ttaZaiv_SERT,ttaZaiv_KS,ttaZaiv_Otziv,ttaZaiv_Pause,ttaZaiv_Voz,ttaZaiv_Sviaz:begin
                     CreateDoc;
  end;
  {ttaZaiv_Sviaz:begin
                     //Произведем необходимые замены
                     //Начальник
                     self.ReplaceAll('FAM1',self.FQuery.FieldByName('FAM1').AsString);
                     //self.ReplaceAll('NAM1',self.FQuery.FieldByName('NAM1').AsString);
                    // self.ReplaceAll('OTCH1',self.FQuery.FieldByName('OTCH1').AsString);
                     //Инициалы начальника
                     self.ReplaceAll('NM1',utf8copy(self.FQuery.FieldByName('NAM1').AsString,1,1)+'.');
                     self.ReplaceAll('OT1',utf8copy(self.FQuery.FieldByName('OTCH1').AsString,1,1)+'.');
                     //Пользователь
                     self.ReplaceAll('FAM2',self.FQuery.FieldByName('FAM2').AsString);
                     self.ReplaceAll('NAM2',self.FQuery.FieldByName('NAM2').AsString);
                     self.ReplaceAll('OTCH2',self.FQuery.FieldByName('OTCH2').AsString);
                     //self.ReplaceAll('TABN',self.FQuery.FieldByName('TABNOM').AsString);
                     //Инициалы пользователя
                     //self.ReplaceAll('NM2',utf8copy(self.FQuery.FieldByName('NAM2').AsString,1,1)+'.');
                     //self.ReplaceAll('OT2',utf8copy(self.FQuery.FieldByName('OTCH2').AsString,1,1)+'.');
                     //self.ReplaceAll('SNILS',self.FQuery.FieldByName('SNILS').AsString);
                     //self.ReplaceAll('TABN',self.FQuery.FieldByName('TABNOM').AsString);
                     self.ReplaceAll('GRP',self.FQuery.FieldByName('gr').AsString);
                     // данные организации
                     self.ReplaceAll('krname',self.FQuery.FieldByName('krname').AsString);
                     //self.ReplaceAll('OGRN',self.FQuery.FieldByName('OGRN').AsString);
                     //self.ReplaceAll('INN',self.FQuery.FieldByName('INN').AsString);
                     {self.ReplaceAll('ADDRESS',self.FQuery.FieldByName('ADDRESS').AsString+', '+
                     self.FQuery.FieldByName('lNAME').AsString); }
                     self.ReplaceAll('DOLJ',self.FQuery.FieldByName('dolj').AsString);

                      stmp:=datetimetostr(now);
                      stmp2:=utf8copy(stmp,7,4);
                      stmp:=utf8copy(stmp,1,2);
                      self.ReplaceAll('dtd',stmp);
                      self.ReplaceAll('dtm', MonthIntToStr(monthof(now)));
                      self.ReplaceAll('dty', stmp2);


  end;            }
  ttaFillSW:Begin
                     CreateDoc;
                 end;
  ttaAkt_KRIPT:begin
                     //Произведем необходимые замены
                     //Начальник
                     self.ReplaceAll('FAM1',self.FQuery.FieldByName('FAM1').AsString);
                     self.ReplaceAll('NAM1',self.FQuery.FieldByName('NAM1').AsString);
                     self.ReplaceAll('OTCH1',self.FQuery.FieldByName('OTCH1').AsString);
                     //Инициалы начальника
                     self.ReplaceAll('NM1',utf8copy(self.FQuery.FieldByName('NAM1').AsString,1,1)+'.');
                     self.ReplaceAll('OT1',utf8copy(self.FQuery.FieldByName('OTCH1').AsString,1,1)+'.');
                     //Пользователь
                     self.ReplaceAll('FAM2',self.FQuery.FieldByName('FAM2').AsString);
                     self.ReplaceAll('NAM2',self.FQuery.FieldByName('NAM2').AsString);
                     self.ReplaceAll('OTCH2',self.FQuery.FieldByName('OTCH2').AsString);
                     //Инициалы пользователя
                     self.ReplaceAll('NM2',utf8copy(self.FQuery.FieldByName('NAM2').AsString,1,1)+'.');
                     self.ReplaceAll('OT2',utf8copy(self.FQuery.FieldByName('OTCH2').AsString,1,1)+'.');
                     self.ReplaceAll('GR',self.FQuery.FieldByName('gr').AsString);
                    // if self.FQuery.FindField('FAM3')<>nil then
                    // begin
                       //Пользователь компьютера
                       self.ReplaceAll('FAM3',self.FQuery.FieldByName('FAM3').AsString);
                       self.ReplaceAll('NAM3',self.FQuery.FieldByName('NAM3').AsString);
                       self.ReplaceAll('OTCH3',self.FQuery.FieldByName('OTCH3').AsString);
                       //Инициалы пользователя компьютера
                       self.ReplaceAll('NM3',utf8copy(self.FQuery.FieldByName('NAM3').AsString,1,1)+'.');
                       self.ReplaceAll('OT3',utf8copy(self.FQuery.FieldByName('OTCH3').AsString,1,1)+'.');
                    // end;
                     // данные организации
                     self.ReplaceAll('krname',self.FQuery.FieldByName('krname').AsString);
                     self.ReplaceAll('ADDRESS',self.FQuery.FieldByName('ADDRESS').AsString);
                      self.ReplaceAll('tname',self.FQuery.FieldByName('tname').AsString);
                     self.ReplaceAll('DOLJ',self.FQuery.FieldByName('dolj').AsString);
                     //местоположение
                     self.ReplaceAll('loc',self.FQuery.FieldByName('loc').AsString);
                     //Системный блок
                     self.ReplaceAll('SERIAL',self.FQuery.FieldByName('SERIAL').AsString);
                     if self.FQuery.FieldByName('UCHETN').IsNull then
                       self.ReplaceAll('UCHETN','')
                     else
                       self.ReplaceAll('UCHETN','CD – диск № '+self.FQuery.FieldByName('UCHETN').AsString);
                     if self.FQuery.FieldByName('UCHETN').IsNull then
                       self.ReplaceAll('STIKER','')
                     else
                       self.ReplaceAll('STIKER',self.FQuery.FieldByName('STIKER').AsString);
                     //Криптосредство
                      ReplaceAll('kNAME',self.FQuery.FieldByName('kNAME').AsString);
                      ReplaceAll('nCopy',self.FQuery.FieldByName('NCOPY').AsString);
                      //Сертификат
                      if self.FQuery.FindField('sert')<>nil then
                         self.ReplaceAll('sert',self.FQuery.FieldByName('sert').AsString)
                      else
                        self.ReplaceAll('sert','');
                      //Номер акта
                      self.ReplaceAll('osnovanie',self.FQuery.FieldByName('osnovanie').AsString);
                         self.ReplaceAll('NA',inttostr(workbd.GET_NUMBER_AKT('kripto',self.FQuery.DataBase)));
                        //self.ReplaceAll('NA',self.FQuery.FieldByName('NA').AsString);
                      //Дата акта
                      if self.FQuery.FindField('dtd')<>nil then
                      begin
                        stmp:=self.FQuery.FieldByName('dtd').AsString;
                        if utf8length(stmp)<2 then stmp:='0'+stmp;
                        self.ReplaceAll('dtd',stmp)
                      end
                      else
                        self.ReplaceAll('dtd','___');
                      if self.FQuery.FindField('dtm')<>nil then
                         self.ReplaceAll('dtm',stringmonth[self.FQuery.FieldByName('dtm').AsInteger])
                      else
                        self.ReplaceAll('dtm','________');
                      if self.FQuery.FindField('dty')<>nil then
                         self.ReplaceAll('dty',self.FQuery.FieldByName('dty').AsString)
                      else
                        self.ReplaceAll('dty',inttostr(yearof(now())));


  end;
  ttaZaiv_Remont:begin
                       CreateDoc;
                      //Номер акта
                         ReplaceAll('NA',inttostr(workbd.GET_NUMBER_AKT('remont',FQuery.DataBase)));
  end;
   ttaDel_KRIPT:begin
                      self.FQuery.First;
                      self.FQuery.Last;
                      self.FQuery.First;
                       //Произведем необходимые замены
                     //Начальник
                     self.ReplaceAll('FAM1',self.FQuery.FieldByName('FAM1').AsString);
                     self.ReplaceAll('NAM1',self.FQuery.FieldByName('NAM1').AsString);
                     self.ReplaceAll('OTCH1',self.FQuery.FieldByName('OTCH1').AsString);
                     //Инициалы начальника
                     self.ReplaceAll('NM1',utf8copy(self.FQuery.FieldByName('NAM1').AsString,1,1)+'.');
                     self.ReplaceAll('OT1',utf8copy(self.FQuery.FieldByName('OTCH1').AsString,1,1)+'.');
                     // данные организации
                     self.ReplaceAll('krname',self.FQuery.FieldByName('krname').AsString);

                      for i:=1 to self.FQuery.RecordCount do
                      begin
                     //Системный блок
                      if not self.FQuery.FieldByName('SERIAL').IsNull then
                     stmp:=stmp + self.FQuery.FieldByName('SERIAL').AsString+', ';
                      if not self.FQuery.FieldByName('STIKER').IsNull then
                     stmp1:=stmp1+self.FQuery.FieldByName('STIKER').AsString+', ';
                     //Криптосредство
                      stmp2:=stmp2+self.FQuery.FieldByName('kNAME').AsString+
                      ' '+self.FQuery.FieldByName('kSERIAL').AsString+#13;
                      self.FQuery.Next;
                      end;
                      //количество экземпляров
                      self.ReplaceAll('COUNT',inttostr(self.FQuery.RecordCount));

                      if utf8length(stmp)<=0 then
                      self.ReplaceAll('SERIAL','')
                      else
                        self.ReplaceAll('SERIAL',stmp);
                       if utf8length(stmp1)<=0 then
                      self.ReplaceAll('STIKER','')
                      else
                        self.ReplaceAll('STIKER',stmp1);
                       if utf8length(stmp2)<=0 then
                      self.ReplaceAll('kNAME','')
                      else
                        self.ReplaceAll('kNAME',stmp2);
                      //дата уничтожения
                      stmp:=datetimetostr(self.FQuery.FieldByName('kDT').AsDateTime);
                       //stmp:=inttostr(yearof(self.FQuery.FieldByName('kDT').AsDateTime));
                       stmp2:=utf8copy(stmp,7,4);
                       //stmp1:=strtoint(utf8copy(stmp,4,2));
                       stmp:=utf8copy(stmp,1,2);
                       self.ReplaceAll('dtd',stmp);
                       self.ReplaceAll('dtm', MonthIntToStr(monthof(self.FQuery.FieldByName('kDT').AsDateTime)));
                       self.ReplaceAll('dty', stmp2);
  end;
   ttaSved_KRIPT:begin
                     //Вставим таблицу
                     //REM Позволим документу создать текстовую таблицу
                     oTable:=self.Document.createinstance('com.sun.star.text.TextTable');
                     oTable.initialize(2,5);
  //REM Если есть закладка по имени "InsertTableHere", то вставим таблицу
// в том месте. Если эта закладка не существует, то просто выберем
// самый конец документа.
                         if self.Document.getbookmarks.hasbyname('TABL_KRIPTO') then
                         oInsertPoint:=self.Document.getbookmarks.getbyname('TABL_KRIPTO').getanchor
                         else
                           oInsertPoint:= self.Document.Text.getEnd;
                         // Теперь вставим текстовую таблицу .
// Отметьте, что используется текстовый объект oInsertPoint текстовый
// диапазон, а не текстовый объект документ.
oInsertPoint.getText.insertTextContent(oInsertPoint , oTable, False);
// Метод объекта setData() работает ТОЛЬКО с числовыми данными.
// Метод объекта setDataArray(), однако, также допускает строки.
//oTable.setDataArray(Array(Array(0, "One", 2), Array(3, "Four", 5)))
oTable.setName('TABL_KRIPTO');
{
//Получим строки
rows:=oTable.getrows;
//Переберем строки и отформатируем
rows.getbyindex(0).backcolor:='&HDDDDDD';
for i:=1 to rows.getcount-1 do
begin
                   row:=rows.getbyindex(i);
                   row.backcolor:='&HFFFFFF';
end;  }
//Заполним таблицу
//Получим строки
rows:=oTable.getrows;
//Получим столбцы
//cols:=oTable.getcolumns;
//Переберем ячейки таблицы
//Заполним шапку
//первый столбец первая строка
cell:=oTable.getCellByPosition(0,0);
w:=utf8toansi('№ п/п');
cell.setstring(w);
//второй столбец первая строка
cell:=oTable.getCellByPosition(1,0);
w:=utf8toansi('Наименование криптосредств, документации, ключевых документов');
cell.setstring(w);
//и т.д.
cell:=oTable.getCellByPosition(2,0);
w:=utf8toansi('Серийный/заводской номер аппаратного устройства с установленным криптосредством');
cell.setstring(w);
cell:=oTable.getCellByPosition(3,0);
w:=utf8toansi('Фамилия и инициалы пользователя криптосредства, владельца ключевых документов');
cell.setstring(w);
cell:=oTable.getCellByPosition(4,0);
w:=utf8toansi('Примечание');
cell.setstring(w);
//Проверим есть ли что писать в таблицу
if self.FQuery.IsEmpty then
begin
  //Если нечего писать, то удалим последнюю строку
//  и выйдем из процедуры
  rows.removebyindex(1,1);
  exit;
end;
//добавим нужное количество строк
self.FQuery.First;
self.FQuery.Last;
if self.FQuery.RecordCount>1 then rows.insertbyindex(2,self.FQuery.RecordCount-1);
self.FQuery.First;
for i:=1 to rows.getcount-1 do
//for j:=0 to cols.getcount-1 do
begin
//Заполняем ячейки строки
                   //первая ячейка
                   cell:=oTable.getCellByPosition(0,i);
                   w:=utf8toansi(inttostr(i));
                   cell.setstring(w);
                   //Вторая ячейка
                   cell:=oTable.getCellByPosition(1,i);
                   w:=utf8toansi(self.FQuery.FieldByName('kNAME').AsString);
                   cell.setstring(w);
                   //и т.д.
                   cell:=oTable.getCellByPosition(2,i);
                   w:=utf8toansi(self.FQuery.FieldByName('SERIAL').AsString);
                   cell.setstring(w);
                   //-----
                   cell:=oTable.getCellByPosition(3,i);
                   w:=utf8toansi(self.FQuery.FieldByName('FAM2').AsString+' '+
                   UTF8COPY(self.FQuery.FieldByName('NAM2').AsString,1,1)+'. '+
                   UTF8COPY(self.FQuery.FieldByName('OTCH2').AsString,1,1)+'. ');
                   cell.setstring(w);

                   self.FQuery.Next;
end;
                     // данные организации
                     self.ReplaceAll('krname',self.FQuery.FieldByName('krname').AsString);
                     //дата отчета и за какой год отчет
                     stmp:=datetimetostr(now);
                       //stmp:=inttostr(yearof(self.FQuery.FieldByName('kDT').AsDateTime));
                       stmp2:=utf8copy(stmp,7,4);
                       //stmp1:=strtoint(utf8copy(stmp,4,2));
                       stmp:=utf8copy(stmp,1,2);
                       self.ReplaceAll('dtd',stmp);
                       self.ReplaceAll('dtm', MonthIntToStr(monthof(now)));
                       self.ReplaceAll('dty', stmp2);
                       self.ReplaceAll('dtold',inttostr(yearof(now)-1));
end;
   //*************************
   ttaKART_TEHN:begin
                     //Вставим таблицу
                     //REM Позволим документу создать текстовую таблицу
                      if self.Document.texttables.hasbyname('KART_TEHN') then
                      begin
                        oTable:=self.Document.texttables.getbyname('KART_TEHN')
                      end else
                      begin
                           oInsertPoint:= self.Document.Text.getEnd;
                           oTable:=self.Document.createinstance('com.sun.star.text.TextTable');
                           oTable.initialize(1,2);
                           oInsertPoint.getText.insertTextContent(oInsertPoint , oTable, False);
                           oTable.setName('KART_TEHN');
                      end;
                     { exit;
                     oTable:=self.Document.createinstance('com.sun.star.text.TextTable');
                     oTable.initialize(1,2);
  //REM Если есть закладка по имени "InsertTableHere", то вставим таблицу
// в том месте. Если эта закладка не существует, то просто выберем
// самый конец документа.
                         if self.Document.getbookmarks.hasbyname('TABL_KART_TEHN') then
                         oInsertPoint:=self.Document.getbookmarks.getbyname('TABL_KART_TEHN').getanchor
                         else
                           oInsertPoint:= self.Document.Text.getEnd;
                         // Теперь вставим текстовую таблицу .
// Отметьте, что используется текстовый объект oInsertPoint текстовый
// диапазон, а не текстовый объект документ.
oInsertPoint.getText.insertTextContent(oInsertPoint , oTable, False);
// Метод объекта setData() работает ТОЛЬКО с числовыми данными.
// Метод объекта setDataArray(), однако, также допускает строки.
//oTable.setDataArray(Array(Array(0, "One", 2), Array(3, "Four", 5)))
oTable.setName('TABL_KART_TEHN');
}

{
//Получим строки
rows:=oTable.getrows;
//Переберем строки и отформатируем
rows.getbyindex(0).backcolor:='&HDDDDDD';
for i:=1 to rows.getcount-1 do
begin
                   row:=rows.getbyindex(i);
                   row.backcolor:='&HFFFFFF';
end;  }
//Заполним таблицу
//Получим строки
rows:=oTable.getrows;
//Получим столбцы
//cols:=oTable.getcolumns;
//Переберем ячейки таблицы
{//Заполним шапку
//первый столбец первая строка
cell:=oTable.getCellByPosition(0,0);
w:=utf8toansi('№ п/п');
cell.setstring(w);
//второй столбец первая строка
cell:=oTable.getCellByPosition(1,0);
w:=utf8toansi('Наименование криптосредств, документации, ключевых документов');
cell.setstring(w);
//и т.д.
cell:=oTable.getCellByPosition(2,0);
w:=utf8toansi('Серийный/заводской номер аппаратного устройства с установленным криптосредством');
cell.setstring(w);
cell:=oTable.getCellByPosition(3,0);
w:=utf8toansi('Фамилия и инициалы пользователя криптосредства, владельца ключевых документов');
cell.setstring(w);
cell:=oTable.getCellByPosition(4,0);
w:=utf8toansi('Примечание');
cell.setstring(w); }
//Проверим есть ли что писать в таблицу
if self.FQuery.IsEmpty then
begin
  //Если нечего писать, то удалим последнюю строку
//  и выйдем из процедуры
  //rows.removebyindex(1,1);
  exit;
end;
//добавим нужное количество строк
self.FQuery.First;
self.FQuery.Last;
if self.FQuery.RecordCount>0 then rows.insertbyindex(1,self.FQuery.RecordCount*6);
rows.removebyindex(0,1);
self.FQuery.First;
//for i:=1 to rows.getcount-1 do
for i:=0 to self.FQuery.RecordCount-1 do
//for j:=0 to cols.getcount-1 do
begin
//Заполняем ячейки строки
                   //первая строка
                   cell:=oTable.getCellByPosition(0,i*6);
                   w:=utf8toansi('наименование');
                   cell.setstring(w);

                   cell:=oTable.getCellByPosition(1,i*6);
                   w:=utf8toansi(self.FQuery.FieldByName('TNAME').AsString);
                   cell.setstring(w);

                   //Вторая строка
                   cell:=oTable.getCellByPosition(0,i*6+1);
                   w:=utf8toansi('местоположение');
                   cell.setstring(w);

                   cell:=oTable.getCellByPosition(1,i*6+1);
                   w:=utf8toansi(self.FQuery.FieldByName('LNAME').AsString);
                   cell.setstring(w);

                   //Третья строка
                   cell:=oTable.getCellByPosition(0,i*6+2);
                   w:=utf8toansi('модель');
                   cell.setstring(w);

                   cell:=oTable.getCellByPosition(1,i*6+2);
                   w:=utf8toansi(self.FQuery.FieldByName('SBNAME').AsString);
                   cell.setstring(w);

                   //Четвертая строка
                   cell:=oTable.getCellByPosition(0,i*6+3);
                   w:=utf8toansi('серийный');
                   cell.setstring(w);

                   cell:=oTable.getCellByPosition(1,i*6+3);
                   w:=utf8toansi(self.FQuery.FieldByName('SERIAL').AsString);
                   cell.setstring(w);

                   //Пятая строка
                   cell:=oTable.getCellByPosition(0,i*6+4);
                   w:=utf8toansi('инвентарный');
                   cell.setstring(w);

                   cell:=oTable.getCellByPosition(1,i*6+4);
                   w:=utf8toansi(self.FQuery.FieldByName('INVENT').AsString);
                   cell.setstring(w);


                   //-----
                   self.FQuery.Next;
end;
                   //Пользователь
                     self.ReplaceAll('FAM2',self.FQuery.FieldByName('FAM2').AsString);
                     self.ReplaceAll('NAM2',self.FQuery.FieldByName('NAM2').AsString);
                     self.ReplaceAll('OTCH2',self.FQuery.FieldByName('OTCH2').AsString);
                   //Инициалы пользователя
                    self.ReplaceAll('NM2',utf8copy(self.FQuery.FieldByName('NAM2').AsString,1,1)+'.');
                    self.ReplaceAll('OT2',utf8copy(self.FQuery.FieldByName('OTCH2').AsString,1,1)+'.');
                    //self.ReplaceAll('GR',self.FQuery.FieldByName('gr').AsString);
                    // данные организации
                     self.ReplaceAll('krname',self.FQuery.FieldByName('krname').AsString);
                  {
                     //дата отчета и за какой год отчет
                     stmp:=datetimetostr(now);
                       //stmp:=inttostr(yearof(self.FQuery.FieldByName('kDT').AsDateTime));
                       stmp2:=utf8copy(stmp,7,4);
                       //stmp1:=strtoint(utf8copy(stmp,4,2));
                       stmp:=utf8copy(stmp,1,2);
                       self.ReplaceAll('dtd',stmp);
                       self.ReplaceAll('dtm', MonthIntToStr(monthof(now)));
                       self.ReplaceAll('dty', stmp2);
                       self.ReplaceAll('dtold',inttostr(yearof(now)-1));  }
end;
   //*************************
   ttaOtchet_Del_KRIPT:begin
                     //Вставим таблицу
                     //REM Позволим документу создать текстовую таблицу
                     oTable:=self.Document.createinstance('com.sun.star.text.TextTable');
                     oTable.initialize(2,6);
  //REM Если есть закладка по имени "InsertTableHere", то вставим таблицу
// в том месте. Если эта закладка не существует, то просто выберем
// самый конец документа.
                         if self.Document.getbookmarks.hasbyname('TABL') then
                         oInsertPoint:=self.Document.getbookmarks.getbyname('TABL').getanchor
                         else
                           oInsertPoint:= self.Document.Text.getEnd;
                         // Теперь вставим текстовую таблицу .
// Отметьте, что используется текстовый объект oInsertPoint текстовый
// диапазон, а не текстовый объект документ.
oInsertPoint.getText.insertTextContent(oInsertPoint , oTable, False);
{//массив разделителей
                       oTblColSeps:=oTable.TableColumnSeparators;
                       // Меняем позицию двух разделителей.
                       oTblColSeps[0].Position:= 50;
                       oTblColSeps[1].Position:= 7000;
                       // Нужно вернуть этот массив обратно в таблицу
                       oTable.TableColumnSeparators:= oTblColSeps; }
// Метод объекта setData() работает ТОЛЬКО с числовыми данными.
// Метод объекта setDataArray(), однако, также допускает строки.
//oTable.setDataArray(Array(Array(0, "One", 2), Array(3, "Four", 5)))
oTable.setName('TABL');
{
//Получим строки
rows:=oTable.getrows;
//Переберем строки и отформатируем
rows.getbyindex(0).backcolor:='&HDDDDDD';
for i:=1 to rows.getcount-1 do
begin
                   row:=rows.getbyindex(i);
                   row.backcolor:='&HFFFFFF';
end;  }
//Заполним таблицу
//Получим строки
rows:=oTable.getrows;
//Получим столбцы
//cols:=oTable.getcolumns;
//Переберем ячейки таблицы
//Заполним шапку
//первый столбец первая строка
cell:=oTable.getCellByPosition(0,0);
w:=utf8toansi('№ п/п');
cell.setstring(w);
//второй столбец первая строка
cell:=oTable.getCellByPosition(1,0);
w:=utf8toansi('Рег. номер МНКИ с'+#13+'криптосредства'+
'(учетные номера тех.'+#13+'документации и правил'+#13+'пользования)');
cell.setstring(w);
//и т.д.
cell:=oTable.getCellByPosition(2,0);
w:=utf8toansi('Вид'+#13+'уничтоженных'+#13+'криптосредств');
cell.setstring(w);
cell:=oTable.getCellByPosition(3,0);
w:=utf8toansi('Кол-во'+#13+'единиц'+#13+'учета');
cell.setstring(w);
cell:=oTable.getCellByPosition(4,0);
w:=utf8toansi('Дата и основание'+#13+'для уничтожения');
cell.setstring(w);
cell:=oTable.getCellByPosition(5,0);
w:=utf8toansi('Способ'+#13+'Уничтожения');
cell.setstring(w);
//Проверим есть ли что писать в таблицу
if self.FQuery.IsEmpty then
begin
  //Если нечего писать, то удалим последнюю строку
//  и выйдем из процедуры
  rows.removebyindex(1,1);
  exit;
end;
//добавим нужное количество строк
self.FQuery.First;
self.FQuery.Last;
if self.FQuery.RecordCount>1 then rows.insertbyindex(2,self.FQuery.RecordCount-1);
self.FQuery.First;
for i:=1 to rows.getcount-1 do
//for j:=0 to cols.getcount-1 do
begin
//Заполняем ячейки строки
                   //первая ячейка
                   cell:=oTable.getCellByPosition(0,i);
                   w:=utf8toansi(inttostr(i));
                   cell.setstring(w);
                   //Вторая ячейка
                   cell:=oTable.getCellByPosition(1,i);
                   w:=utf8toansi(self.FQuery.FieldByName('kSERIAL').AsString);
                   cell.setstring(w);
                   //и т.д.
                   cell:=oTable.getCellByPosition(2,i);
                   w:=utf8toansi(self.FQuery.FieldByName('kNAME').AsString);
                   cell.setstring(w);
                   //-----
                   cell:=oTable.getCellByPosition(3,i);
                   w:=utf8toansi('1');
                   cell.setstring(w);
                   //-----
                   cell:=oTable.getCellByPosition(4,i);
                   w:=utf8toansi(self.FQuery.FieldByName('DT').AsString);
                   cell.setstring(w);
                   //-----
                   cell:=oTable.getCellByPosition(5,i);
                   w:=utf8toansi('Физическое уничтожение'+#13+'деинсталяция ПО');
                   cell.setstring(w);

                   self.FQuery.Next;
end;
                                    //Начальник
                     self.ReplaceAll('FAM1',self.FQuery.FieldByName('FAM1').AsString);
                     self.ReplaceAll('NAM1',self.FQuery.FieldByName('NAM1').AsString);
                     self.ReplaceAll('OTCH1',self.FQuery.FieldByName('OTCH1').AsString);
                     //Инициалы начальника
                     self.ReplaceAll('NM1',utf8copy(self.FQuery.FieldByName('NAM1').AsString,1,1)+'.');
                     self.ReplaceAll('OT1',utf8copy(self.FQuery.FieldByName('OTCH1').AsString,1,1)+'.');
                     // данные организации
                     self.ReplaceAll('krname',self.FQuery.FieldByName('krname').AsString);
                     //за какой период отчет
                     stmp:=datetimetostr(now);
                       //stmp:=inttostr(yearof(self.FQuery.FieldByName('kDT').AsDateTime));
                       stmp2:=utf8copy(stmp,7,4);
                       //stmp1:=strtoint(utf8copy(stmp,4,2));
                       stmp:=utf8copy(stmp,1,2);
                       self.ReplaceAll('dtd3', stmp);
                       self.ReplaceAll('dty3', stmp2);
                       self.ReplaceAll('dtm3', MonthIntToStr(monthof(now)));

                       stmp:=self.FQuery.FieldByName('dtd1').AsString;
                       if length(stmp)<2 then stmp:='0'+stmp;
                       self.ReplaceAll('dtd1',stmp);
                       self.ReplaceAll('dtm1', MonthIntToStr(self.FQuery.FieldByName('dtm1').AsInteger));
                       self.ReplaceAll('dty1', self.FQuery.FieldByName('dty1').AsString);
                       stmp:=self.FQuery.FieldByName('dtd2').AsString;
                       if length(stmp)<2 then stmp:='0'+stmp;
                       self.ReplaceAll('dtd2',stmp);
                       self.ReplaceAll('dtm2', MonthIntToStr(self.FQuery.FieldByName('dtm2').AsInteger));
                       self.ReplaceAll('dty2', self.FQuery.FieldByName('dty2').AsString);
end;

  end;
end;

function TmyDOCS.MonthIntToStr(nMonth: integer): string;
const
     strMonth:array [1..12] of string=('января','февраля','марта','апреля','мая'
     ,'июня','июля','августа','сентября','октября','ноября','декабря');
begin
  result:='';
  if (nMonth>0)and(nMonth<13) then
  result:=strMonth[nMonth];
end;

procedure TmyDOCS.CreateDoc;
var
  stmp, stmp2:string;
  i:integer;
const
     poleSQL:array[1..30] of string=('FAM1','NAM1','OTCH1','NM1','OT1','FAM2','NAM2','OTCH2','NM2','OT2','DOLJ','SNILS','TABNOM','GR','SERT',
     'FULLNAME','KRNAME','OGRN','INN','TNAME','LNAME','ADDRESS','INVENT','SERIAL','MODEL_R','text_remont','model','size','UCHETN','PHONE_WORK');
     poleInShablon:array[1..30] of string=('FAM1','NAM1','OTCH1','NM1','OT1','FAM2','NAM2','OTCH2','NM2','OT2','DOLJ','SNILS','TABN','GRP','SERT',
     'FULLNAME','KRNAME','OGRN','INN','TNAME','KABINET','ADDRESS','inv_n','SERIAL','MODEL_R','text_remont','model','size','UCHETN','PHONE_WORK');
begin
  //Произведем необходимые замены
                           for i:=1 to HIGH(poleSQL) do
                           begin
                                if FQuery.FindField(poleSQL[i])<>nil then
                                ReplaceAll(poleInShablon[i], FQuery.FieldByName(poleSQL[i]).AsString);
                           end;
                     //дата
                     stmp:=datetimetostr(now);
                       //месяц
                       ReplaceAll('dtmmmm', MonthIntToStr(monthof(now)));
                       ReplaceAll('dtm', utf8copy(stmp,4,2));
                       //год
                       ReplaceAll('dty', utf8copy(stmp,7,4));
                       stmp2:=utf8copy(stmp,1,2);
                       //день
                       ReplaceAll('dtd',stmp2);
                      //Время
                      ReplaceAll('th',utf8copy(stmp,12,2));
                       ReplaceAll('tm',utf8copy(stmp,15,2));
end;

procedure TmyDOCS.CreateDocs(const tip_doc: Ttip_doc; nameShablon, sdir: string
  );
var
  spath:string;
begin
  spath:=sdir + inttostr(SecondOfTheWeek(now))+'.doc';
  if not fileexists(nameShablon) then raise exception.create('No Found file shablon'+nameShablon);
  copyfile(nameShablon, spath);
  OpenDOCwriter(spath);
  //Заполним документ
  selectAction(tip_doc, sdir);
  Query.Next;
end;

constructor TmyDOCS.Create(const tip_doc: Ttip_doc;
  const exefilepath: string; Qr: Tsqlquery;dop:string='');
var sdir{, spath}:string;
  sl:tstringlist;
  i:integer;
  nr:integer;
  od:TOpenDialog;
begin
  //создадим нужный нам документ
   //получим путь до нашего шаблона
    sdir:=exefilepath + 'data' + DirectorySeparator+'out'+DirectorySeparator;
    //почистим директорию от старых файлов
    if DirectoryExists(sdir) then
  begin
    sl:=FindAllFiles(sdir,'');
    for i:=0 to sl.Count-1 do     DeleteFile(sl.ValueFromIndex[i]);
  end else CreateDir(sdir);
  if dop<>'' then self.DopInfo:=dop;

  //Получим Query
   self.Query:=Qr;
   nr:=self.Query.RecNo;
   self.Query.Last;
   self.Query.First;
              for i:=1 to self.Query.RecordCount do
              begin
                   //spath:=sdir + inttostr(SecondOfTheWeek(now))+'.doc';
                   try
                   case tip_doc of
                    ttaAKT_DELMNI:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'delmni.doc',sdir);
                              //copyfile(exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'delmni.doc', spath);
                              break;
                         end;
                    ttaZaiv_SERT:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'zaiav_SERT.doc',sdir);
                              //copyfile(exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'zaiav_SERT.doc', spath);
                         end;
                    ttaZaiv_RP:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'zaiav_RP.doc',sdir);
                              //copyfile(exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'zaiav_SERT.doc', spath);
                         end;
                    ttaZaiv_KS:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'zaiav_ks.odt',sdir);
                              //copyfile(exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'zaiav_SERT.doc', spath);
                         end;
                    ttaAkt_MNI:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'akt_mni.doc',sdir);
                              //copyfile(exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'akt_mni.doc', spath);
                              break;
                         end;
                    ttaAkt_KRIPT:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'akt_kript.doc',sdir);
                              //copyfile(exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'akt_kript.doc', spath);
                              //break;
                         end;
                    ttaSved_KRIPT:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'sved_kripto.doc',sdir);
                              //copyfile(exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'sved_kripto.doc', spath);
                              break;
                         end;
                    ttaKART_TEHN:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'kart_tehn.odt',sdir);
                              //copyfile(exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'kart_tehn.odt', spath);                         end;
                              break;
                         end;
                    ttaOtchet_Del_KRIPT:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'otchet_del_kript.doc',sdir);
                              //copyfile(exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'otchet_del_kript.doc', spath);
                              break;
                         end;
                    ttaDel_KRIPT:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'del_kripto.doc',sdir);
                              //copyfile(exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'del_kripto.doc', spath);
                         end;
                    ttaKart_Slovar:
                         begin
                              self.Query.RecNo:=nr;
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'kart_slovar.doc',sdir);
                              //copyfile(exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'kart_slovar.doc', spath);
                              break;
                         end;
                    ttaZaiv_Sviaz:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'zaiv_sviaz.doc',sdir);
                              //copyfile(exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'zaiv_sviaz.doc', spath);
                              break;
                         end;
                    ttaZaiv_Pause:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'zaiav_pause.doc',sdir);
                              break;
                         end;
                    ttaZaiv_Voz:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'zaiav_voz.doc',sdir);
                              break;
                         end;
                    ttaZaiv_Otziv:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'zaiav_otziv.doc',sdir);
                              break;
                         end;
                    ttaLic_schet_mni:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'lic_schet_mni.doc',sdir);
                              break;
                         end;
                    ttakartmni:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'kart_mni.doc',sdir);
                              break;
                         end;
                    ttaOpis_mni:
                         begin
                              CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'opis_mni.doc',sdir);
                              break;
                         end;
                    ttaZaiv_Remont:
                                    begin
                                         CreateDocs(tip_doc,exefilepath + 'data' + DirectorySeparator+'shablon'+DirectorySeparator+'zaiv_remont.doc',sdir);
                                         break;
                                    end;
                    ttaFillSW:
                                    begin
                                         //окно выбора шаблона
                                         od:=TOpenDialog.Create(nil);
                                         //Заголовок окна
                                         od.Title:='Выбор шаблона';
                                         //Установка начального каталога
                                         //sd.InitialDir:=getcurrentdir;
                                         //GetEnvironmentVariable;
                                         // Разрешаем сохранять файлы типа .txt и .doc
                                         od.Filter:='текстовые документы|*.odt;*doc';
                                         //od.Filter:='текстовые документы OO(*.odt)|*.odt|текстовые документы MS(*.doc)|*.doc';
                                         // Установка расширения по умолчанию
                                         od.DefaultExt := 'doc';
                                         // Выбор стартового типа фильтра
                                         od.FilterIndex := 1;
                                         if not  od.Execute then exit;
                                         CreateDocs(ttaFillSW,od.FileName,sdir);
                                         break;
                                    end;
                   end;
                   except
                        on E: Exception do
                        begin
                             raise exception.create(e.message);
                             {if (pos('No Found file shablon',lowercase( e.message))>-1) then
                                begin
                                     MessageDlg('Ошибка','Не найден файл шаблона '+UTF8Copy(e.message,20,UTF8Length(e.message)-18),mtInformation,[mbOK],0)
                                end;                                                     }
                        end;
                   end;

                   {self.OpenDOCwriter(spath);
                   //Заполним документ
                   selectAction(tip_doc, sdir);
                   self.Query.Next;}
              end;
              try
                if not Query.IsEmpty then self.Query.RecNo:=nr;
              finally
              end;
end;

destructor TmyDOCS.Destroy;
begin
  inherited Destroy;
end;

end.

