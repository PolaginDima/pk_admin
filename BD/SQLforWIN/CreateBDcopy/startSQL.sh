#!/bin/bash
clear
rm -f $(pwd)/rezSQL
rm -f $(pwd)/../../ptk_admin.fdb
#rm -f $(pwd)/bdrodmain.sql
#:>$(pwd)/bdrodmain.sql
#echo input "$(pwd)/bdrod01.sql" >>$(pwd)/bdrodmain.sql
#echo input $(pwd)/bdrod02.sql >>$(pwd)/bdrodmain.sql
#echo input $(pwd)/bdrod03.sql >>$(pwd)/bdrodmain.sql
#echo input $(pwd)/bdrod04.sql >>$(pwd)/bdrodmain.sql
#echo input $(pwd)/bdrod05.sql >>$(pwd)/bdrodmain.sql
#echo input $(pwd)/bdrod06.sql >>$(pwd)/bdrodmain.sql
#echo input $(pwd)/bdrod07.sql >>$(pwd)/bdrodmain.sql
#echo input $(pwd)/bdrod08.sql >>$(pwd)/bdrodmain.sql
#echo >>$(pwd)/bdrodmain.sql
#echo >>$(pwd)/bdrodmain.sql
#echo >>$(pwd)/bdrodmain.sql
isql-fb -i $(pwd)/bdptk_adminmain.sql -o rezSQL
exit 0
