@ECHO OFF

REM gracethddata_pg_create_db.bat
REM Owner : GraceTHD-Community - http://gracethd-community.github.io/
REM Author : stephane dot byache at aleno dot eu
REM Rev. date : 16/11/2017

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
REM Lecture du fichier de configuration. 
CALL :CONF

REM Decommenter quand ca coince. 
CALL:DEBUG

REM ECHO Gracepg - CREATION DE LA BASE. 
REM CALL:BASE
REM PAUSE
ECHO GraceTHD-DATA - PostGIS - CREATION DU SCHEMA
CALL :SCHEMA_GRACETHDDATA
CALL :TABLES_GRACETHDDATA
CALL :INSERT_GRACETHDDATA
CALL :INSERT_GRACETHDDATAREL
CALL :VIEWS_GRACETHDDATA
CALL :GRANT_GRACETHDDATA

CALL :END

GOTO:EOF


:CONF
CALL config.bat
SET PGSCHEMADATA=%PGSCHEMA%data

GOTO:EOF

:DEBUG
REM Pour forcer les pauses sans modifier le config.bat
SET GLPAUSE=PAUSE
CALL config_test.bat
GOTO:EOF


:BASE
REM Inutilise avec GraceTHD-Data
ECHO GraceTHD-Data - Postgis - Creation de la base de donnees %PGHOSTNAME%:%PGDB%. 
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -c "CREATE DATABASE %PGDB%;" -d %PGTEMPLATE% -U %PGUSER%
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -c "CREATE EXTENSION postgis;" -d %PGDB% -U %PGUSER%
REM "%GL_PSQL%" -d %PGDB% -c "CREATE EXTENSION postgis_topology;"
%GLPAUSE%

GOTO:EOF

:SCHEMA_GRACETHDDATA
ECHO GraceTHD-Data - Postgis - Creation du schema %PGSCHEMADATA%. 
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -c "CREATE SCHEMA IF NOT EXISTS %PGSCHEMADATA% AUTHORIZATION %PGROLE%;" -d %PGDB% -U %PGUSER% 
REM "%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -c "ALTER DATABASE %GLCTPGDB% SET search_path = %GLCTPGSCHEMACHECK%, %GLCTPGSCHEMA%, public;" -U %PGUSER% 
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -c "ALTER DATABASE %GLCTPGDB% SET search_path = %PGSCHEMADATA%, public;" -d %GLCTPGDB% -U %PGUSER% 
%GLPAUSE%

GOTO:EOF

:TABLES_GRACETHDDATA

SET FSQL=gracethddata_30_tables.sql
ECHO GraceTHD-Data - Postgis - %FSQL%
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\%FSQL%" -d %PGDB% -U %PGUSER%
%GLPAUSE%

GOTO:EOF

:INSERT_GRACETHDDATA

SET FSQL=gracethddata_31_insert_or.sql
ECHO GraceTHD-Data - Postgis - %FSQL%
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\%FSQL%" -d %PGDB% -U %PGUSER%

SET FSQL=gracethddata_32_insert_rf.sql
ECHO GraceTHD-Data - Postgis - %FSQL%
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\%FSQL%" -d %PGDB% -U %PGUSER%

REM Les données des tables _rel sont renseignées par l'import de fichiers t_organisme_rel.csv et t_reference_rel.csv
REM Donc déclenchement du script d'import gracethddata_pg_import.bat
%GLPAUSE%

GOTO:EOF

:INSERT_GRACETHDDATAREL

ECHO GraceTHD-Data - Postgis - Import des données des tables de relations gracethd / gracethddata dans les tables _rel. 
CALL gracethddata_pg_import_shpcsv-in_psql.bat

GOTO:EOF

:VIEWS_GRACETHDDATA

SET FSQL=gracethddata_60_views.sql
ECHO GraceTHD-Data - Postgis - %FSQL%
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\%FSQL%" -d %PGDB% -U %PGUSER%
%GLPAUSE%

GOTO:EOF

:GRANT_GRACETHDDATA

SET FSQL=gracethddata_99_grant.sql
ECHO GraceTHD-Data - Postgis - %FSQL%
"%GL_PSQL%" -h %PGHOSTNAME% -p %PGPORT% -f "%GLCTPGSQLPATH%\%FSQL%" -d %PGDB% -U %PGUSER%
%GLPAUSE%

GOTO:EOF

:END

%GLPAUSE%
GOTO:EOF
