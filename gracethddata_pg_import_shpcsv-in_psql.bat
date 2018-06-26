@ECHO OFF

REM gracethd_pg_import_shpcsv-in_psql.bat
REM Owner : GraceTHD-Community - http://gracethd-community.github.io/
REM Author : stephane dot byache at aleno dot eu
REM Rev. date : 26/06/2018

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



:LAUNCH

CALL:CONF

REM Decommenter quand ca coince. 
REM CALL:DEBUG

ECHO GraceTHD-Data - Debut import CSV dans la base PostGIS %PGHOSTNAME%:%PGDB%. 
REM On n'importe que les données des tables de relations. Les données sont déjà chargées avec les SQL. Mais si besoin on peut appeler :IMPORTDATA en décommentant la ligne suivante. 
REM CALL:IMPORTDATA
CALL:IMPORTDATAREL
REM CALL:IMPORTDATATAG
CALL:IMPORTDATATAGUSER
CALL:END


:CONF
CALL config.bat
SET PGSCHEMADATA=%PGSCHEMA%data

GOTO:EOF

:DEBUG
REM Pour forcer les pauses sans modifier le config.bat
SET GLPAUSE=PAUSE
CALL config_test.bat
GOTO:EOF

:OK
REM CETTE SOUS-ROUTINE N'EST PAS APPELEE. 
REM Si on souhaite arreter l'import a un certain niveau (generalement quand ca coince), on peut placer le reste des commandes d'import deja passes dans :OK et celles qu'on ne souhaite pas encore executer dans :WAIT. Seule la sous-routine :IMPORT est appelee, pas :OK ni :WAIT. 
REM Exemple : l'import plante sur t_znro, 
REM 1. Dupliquer ce batch pour ne pas casser l'original. 
REM 2. Placer toutes les commandes d'import jusqu'a t_siteemission dans :OK pour ne pas les executer de nouveau (concretement on place déplace la ligne :IMPORT avant t_znro). 
REM 3. Placer le :WAIT avant t_zsro de sortes que la suite ne soit pas executee et que l'on puisse se concentrer sur t_znro. 
REM 4. Enregistrer et exécuter cette copie.  


REM #### PLACER LES COMMANDES OK ICI ####



GOTO:EOF


:IMPORTDATA

SET PGTBL=t_dt_organisme
SET PGCSV=%PGSHPINPATH%\%PGTBL%.csv
ECHO GraceTHD - Debut import %PGTBL%
IF EXIST "%PGCSV%" ("%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -d %PGDB% -U %PGUSER% -c "\COPY %PGSCHEMADATA%.%PGTBL% FROM '%PGCSV%' %PGCSVCONF%;") ELSE (ECHO %PGCSV% n'existe pas ! Il est probable que la suite des chargements ne fonctionne pas correctement.) 
ECHO GraceTHD-Data - Fin import %PGTBL%

%GLPAUSE%

SET PGTBL=t_dt_reference
SET PGCSV=%PGSHPINPATH%\%PGTBL%.csv
ECHO GraceTHD - Debut import %PGTBL%
IF EXIST "%PGCSV%" ("%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -d %PGDB% -U %PGUSER% -c "\COPY %PGSCHEMADATA%.%PGTBL% FROM '%PGCSV%' %PGCSVCONF%;") ELSE (ECHO %PGCSV% n'existe pas ! Il est probable que la suite des chargements ne fonctionne pas correctement.) 
ECHO GraceTHD-Data - Fin import %PGTBL%

%GLPAUSE%

GOTO:EOF

:IMPORTDATAREL

SET PGTBL=t_dt_organisme_rel
SET PGCSV=%PGSHPINPATH%\%PGTBL%.csv
ECHO GraceTHD - Debut import %PGTBL%
IF EXIST "%PGCSV%" ("%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -d %PGDB% -U %PGUSER% -c "\COPY %PGSCHEMADATA%.%PGTBL% FROM '%PGCSV%' %PGCSVCONF%;") ELSE (ECHO %PGCSV% n'existe pas ! Il est probable que la suite des chargements ne fonctionne pas correctement.) 
ECHO GraceTHD-Data - Fin import %PGTBL%

%GLPAUSE%

SET PGTBL=t_dt_reference_rel
SET PGCSV=%PGSHPINPATH%\%PGTBL%.csv
ECHO GraceTHD - Debut import %PGTBL%
IF EXIST "%PGCSV%" ("%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -d %PGDB% -U %PGUSER% -c "\COPY %PGSCHEMADATA%.%PGTBL% FROM '%PGCSV%' %PGCSVCONF%;") ELSE (ECHO %PGCSV% n'existe pas ! Il est probable que la suite des chargements ne fonctionne pas correctement.) 
ECHO GraceTHD-Data - Fin import %PGTBL%

%GLPAUSE%


GOTO:EOF

:IMPORTDATATAGUSER

SET PGTBL=t_dt_tgkey_user
SET PGCSV=%PGSHPINPATH%\%PGTBL%.csv
ECHO GraceTHD - Debut import %PGTBL%
IF EXIST "%PGCSV%" ("%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -d %PGDB% -U %PGUSER% -c "\COPY %PGSCHEMADATA%.%PGTBL% FROM '%PGCSV%' %PGCSVCONF%;") ELSE (ECHO %PGCSV% n'existe pas ! Il est probable que la suite des chargements ne fonctionne pas correctement.) 
ECHO GraceTHD-Data - Fin import %PGTBL%

%GLPAUSE%

SET PGTBL=t_dt_tag_user
SET PGCSV=%PGSHPINPATH%\%PGTBL%.csv
ECHO GraceTHD - Debut import %PGTBL%
IF EXIST "%PGCSV%" ("%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -d %PGDB% -U %PGUSER% -c "\COPY %PGSCHEMADATA%.%PGTBL% FROM '%PGCSV%' %PGCSVCONF%;") ELSE (ECHO %PGCSV% n'existe pas ! Il est probable que la suite des chargements ne fonctionne pas correctement.) 
ECHO GraceTHD-Data - Fin import %PGTBL%

%GLPAUSE%


GOTO:EOF



:WAIT
REM CETTE SOUS-ROUTINE N'EST PAS APPELEE. 
REM Si on souhaite arreter l'import a un certain niveau (generalement quand ca coince), on peut placer le reste des commandes d'import dans cette sous-routine qui n'est pas executee. Seule la sous-routine :IMPORT est appelee, pas :OK ni :WAIT. 
REM Exemple : l'import plante sur t_znro, 
REM 1. Dupliquer ce batch pour ne pas casser l'original. 
REM 2. Placer toutes les commandes d'import jusqu'a t_siteemission dans :OK pour ne pas les executer de nouveau (concretement on place déplace la ligne :IMPORT avant t_znro). 
REM 3. Placer le :WAIT avant t_zsro de sortes que la suite ne soit pas executee et que l'on puisse se concentrer sur t_znro. 
REM 4. Enregistrer et exécuter cette copie.  



:END
ECHO GraceTHD-Data - Fin import CSV dans la base PostGIS %PGHOSTNAME%:%PGDB%. 
%GLPAUSE%

EXIT /B
