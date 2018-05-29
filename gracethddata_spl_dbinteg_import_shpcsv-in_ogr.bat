@ECHO OFF

REM gracethd_spl_dbinteg_import_shpcsv-in_ogr.bat
REM Owner : GraceTHD-Community - http://gracethd-community.github.io/
REM Author : stephane dot byache at aleno dot eu
REM Rev. date : 18/05/2018

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


CALL config.bat
CALL:IMPORTDATA
CALL:END

SET GLDB=%GLDBINTEG%
SET GLDBPRAGMA=%GLDBINTEGPRAGMA%
REM FOR %%f IN ("%GLOSGEOPATH%\etc\ini\*.bat") DO CALL "%%f"

REM CHEMIN VERS ogr2ogr.exe
REM SET GLOGR2OGR=C:\Program Files\QGIS Wien\bin
REM SET GLOGR2OGR=C:\OSGeo4w\bin

REM ogr2ogr --config OGR_SQLITE_PRAGMA = "foreign_keys=on,cache_size=500000" %GLDBINTEGSKIPF% -append -f SQLite .\dbinteg\GRACETHD_integ.sqlite .\shpcsv-in\t_adresse.shp -nln t_adresse
REM ogr2ogr %GLDBINTEGSKIPF% -append .\dbinteg\GRACETHD_integ.sqlite .\shpcsv-in\t_organisme.csv -nln t_organisme

:IMPORTDATA

SET GLTBL=t_dt_organisme
SET GLFILE=%GLSHPINPATH%\%GLTBL%.csv
ECHO GRACETHD - INSERT %GLFILE%
IF EXIST "%GLFILE%" "%GLOGR2OGR%" %GLDBINTEGSKIPF% -append %GLDB% "%GLFILE%" -nln %GLTBL%
%GLPAUSE%

SET GLTBL=t_dt_reference
SET GLFILE=%GLSHPINPATH%\%GLTBL%.csv
ECHO GRACETHD - INSERT %GLFILE%
IF EXIST "%GLFILE%" "%GLOGR2OGR%" %GLDBINTEGSKIPF% -append %GLDB% "%GLFILE%" -nln %GLTBL%
%GLPAUSE%

SET GLTBL=t_dt_organisme_rel
SET GLFILE=%GLSHPINPATH%\%GLTBL%.csv
ECHO GRACETHD - INSERT %GLFILE%
IF EXIST "%GLFILE%" "%GLOGR2OGR%" %GLDBINTEGSKIPF% -append %GLDB% "%GLFILE%" -nln %GLTBL%
%GLPAUSE%

SET GLTBL=t_dt_reference_rel
SET GLFILE=%GLSHPINPATH%\%GLTBL%.csv
ECHO GRACETHD - INSERT %GLFILE%
IF EXIST "%GLFILE%" "%GLOGR2OGR%" %GLDBINTEGSKIPF% -append %GLDB% "%GLFILE%" -nln %GLTBL%
%GLPAUSE%

GOTO:EOF

:END
ECHO GraceTHD - Fin d'import de shp csv dans la base %GLDBINTEG% 
PAUSE

EXIT /B
