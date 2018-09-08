@ECHO OFF

REM gracethdmanage_pg_create_tables.bat
REM Owner : GraceTHD-Community - http://gracethd-community.github.io/
REM Author : stephane dot byache at aleno dot eu
REM Rev. date : 18/08/2018

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

	
REM Appel de la config
CALL config.bat
REM Appel de la sous-routine de CTCALL qui appelle toutes les sous-routines. 
REM CALL :MGCALL

CALL :MGLISTS
CALL :MGTABLES
REM Chargement apres la creation des tables, les cascades vident les listes. 
CALL :MGINSLIST
REM CALL :MGINSFILL
CALL :MGINSVAR
CALL :MGINDEX
CALL :MGSQLVIEWS

REM Appel de la sous-routine END pour terminer l'execution ici. 
CALL :END
EXIT /B


REM GOTO:EOF


:MGLISTS
ECHO GraceTHD-Manage - %~nx0 - Postgis - Creation des listes
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\gracethdmanage_10_lists.sql" -d %GLCTPGDB% -U %PGUSER%
ECHO GraceTHD-Manage - %~nx0 - Postgis - Fin de creation des listes

%GLPAUSE% 

GOTO:EOF

:MGTABLES
ECHO GraceTHD-Manage - %~nx0 - Postgis - Creation des tables
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\gracethdmanage_30_tables.sql" -d %GLCTPGDB% -U %PGUSER%
ECHO GraceTHD-Manage - %~nx0 - Postgis - Fin de creation des tables

%GLPAUSE%

GOTO:EOF

:MGINSLIST
ECHO GraceTHD-Manage - %~nx0 - Postgis - Insertion dans les listes
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\gracethdmanage_20_insert.sql" -d %GLCTPGDB% -U %PGUSER%
ECHO GraceTHD-Manage - %~nx0 - Postgis - Fin d'insertion dans les listes

%GLPAUSE%

GOTO:EOF

:MGINSFILL
ECHO GraceTHD-Manage - %~nx0 - Postgis - Insertion t_mg_filltab
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\gracethdmanage_31_filltab_insert.sql" -d %GLCTPGDB% -U %PGUSER% 
ECHO GraceTHD-Manage - %~nx0 - Postgis - Fin d'insertion t_ct_conf_filltab

%GLPAUSE%

ECHO GraceTHD-Manage - %~nx0 - Postgis - Insertion t_mg_fillatt
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\gracethdmanage_32_fillatt_insert.sql" -d %GLCTPGDB% -U %PGUSER%
ECHO GraceTHD-Manage - %~nx0 - Postgis - Fin d'insertion t_ct_conf_fillatt

%GLPAUSE%

ECHO GraceTHD-Manage - %~nx0 - Postgis - Update t_mg_fillatt
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\gracethdmanage_32_fillatt_update.sql" -d %GLCTPGDB% -U %PGUSER%
ECHO GraceTHD-Manage - %~nx0 - Postgis - Fin d'update t_ct_conf_fillatt

%GLPAUSE%

GOTO:EOF


:MGINSVAR
ECHO GraceTHD-Manage - %~nx0 - Postgis - Insertion t_mg_va
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\gracethdmanage_33_va_insert.sql" -d %GLCTPGDB% -U %PGUSER%
ECHO GraceTHD-Manage - %~nx0 - Postgis - Fin d'insertion t_mg_va

%GLPAUSE%

GOTO:EOF


:MGINDEX
ECHO GraceTHD-Manage - %~nx0 - Postgis - Creation des indexes
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\gracethdmanage_50_index.sql" -d %GLCTPGDB% -U %PGUSER%
ECHO GraceTHD-Manage - %~nx0 - Postgis - Fin de creation des indexes

%GLPAUSE%

GOTO:EOF


:MGSQLVIEWS
REM Vues qui vont generer le code SQL pour generer les vues unitaires et anomalies. 


ECHO GraceTHD-Manage - %~nx0 - Postgis - Creation des vues d'indicateurs
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\gracethdmanage_65_views_indi.sql" -d %GLCTPGDB% -U %PGUSER%
ECHO GraceTHD-Manage - %~nx0 - Postgis - Fin de creation des vues d'indicateurs

%GLPAUSE%

GOTO:EOF


:END
ECHO GraceTHD-Manage - %~nx0 - Postgis - Fin de creation des tables GraceTHD-Manage. 

%GLPAUSE%
REM TODO: trouver une alernative au EXIT qui arrête tout. 


GOTO:EOF
