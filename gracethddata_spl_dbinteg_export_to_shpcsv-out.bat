@ECHO OFF

REM gracethd_spl_dbinteg_export_to_shpcsv-out.bat
REM Owner : GraceTHD-Community - http://gracethd-community.github.io/
REM Author : stephane dot byache at aleno dot eu
REM Rev. date : 12/10/2017

    REM This file is part of GraceTHD.

    REM GraceTHD is free software: you can redistribute it and/or modify
    REM it under the terms of the GNU General Public License as published by
    REM the Free Software Foundation, either version 3 of the License, or
    REM (at your option) any later version.

    REM GraceTHD is distributed in the hope that it will be useful,
    REM but WITHOUT ANY WARRANTY; without even the implied warranty of
    REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    REM GNU General Public License for more details.

    REM You should have received a copy of the GNU General Public License
    REM along with GraceTHD.  If not, see <http://www.gnu.org/licenses/>.

ECHO EXPORT DANS SHPCSV-OUT DES TABLES DE gracelite_integ.sqlite
%GLPAUSE%

:LAUNCH
CALL:CONFIG

CALL:EXPORTCSVDATA

REM CALL:SFK
REM APPEL UNE SECONDE FOIS CAR BUG, DES " RESTENT EN FIN DE LA LIGNE LA 1ERE FOIS
REM CALL:SFK

CALL:END

GOTO:EOF

:CONFIG
ECHO Configuration des variables. 
CALL config.bat
GOTO:EOF


:EXPORTCSVDATA
ECHO Gracelite - GraceTHD-Data - Export des tables en csv. 
SET CSVTBL=t_organisme_rel
SET CSVOUT=%GLSHPOUTPATH%\%CSVTBL%.csv
ECHO Gracelite - GraceTHD-Data - Suppression %CSVOUT%
IF EXIST %CSVOUT% DEL %CSVOUT%
ECHO Gracelite - GraceTHD-Data - Export %CSVOUT%
REM -silent 
%GLSPLEX% -header -csv -separator ';' %GLDBINTEG% "SELECT * FROM %CSVTBL%;" > %CSVOUT%

SET CSVTBL=t_reference_rel
SET CSVOUT=%GLSHPOUTPATH%\%CSVTBL%.csv
ECHO Gracelite - GraceTHD-Data - Suppression %CSVOUT%
IF EXIST %CSVOUT% DEL %CSVOUT%
ECHO Gracelite - GraceTHD-Data - Export %CSVOUT%
REM -silent 
%GLSPLEX% -header -csv -separator ';' %GLDBINTEG% "SELECT * FROM %CSVTBL%;" > %CSVOUT%

GOTO:EOF

%GLPAUSE%

:SFK
REM Cette solution est beaucoup trop lente. 
ECHO Gracelite - GraceTHD-Data - Suppression des délimiteurs quotes et double quotes 
%GLSFK% replace -text "_;'_;_" -dir %GLSHPOUTPATH%\ -file .csv -yes
%GLSFK% replace -text "_';_;_" -dir %GLSHPOUTPATH%\ -file .csv -yes
REM Bug apparemment sur le suivant. A marché lance à la main !?
%GLSFK% replace -text "_;\"_;_" -dir %GLSHPOUTPATH%\ -file .csv -yes
%GLSFK% replace -text "_\";_;_" -dir %GLSHPOUTPATH%\ -file .csv -yes
GOTO:EOF

%GLPAUSE%

:END

ECHO Gracelite - GraceTHD-Data - Export TERMINE
%GLPAUSE%

