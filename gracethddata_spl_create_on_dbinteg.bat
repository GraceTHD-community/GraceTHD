@ECHO OFF

REM gracethddata_spl_create_on_dbinteg.bat
REM Owner : GraceTHD-Community - http://gracethd-community.github.io/
REM Author : stephane dot byache at aleno dot eu
REM Rev. date : 20/11/2017

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
CALL:CONFIG
REM CALL:BASE
CALL:SCHEMADATA
GOTO:END

:CONFIG
CALL config.bat
GOTO:EOF

:BASE
ECHO CREATION DE LA BASE %GLDBINTEG%
PAUSE
ECHO SUPPRESSION BASE
IF EXIST %GLDBINTEG% DEL /s %GLDBINTEG%

%GLSPLEX% %GLDBINTEG% "PRAGMA foreign_keys = ON;"

GOTO:EOF


:SCHEMADATA
ECHO GRACELITE - CREATION DE LA STRUCTURE GRACETHD-DATA : TABLES
SET FSQL=%GLDBINTEGSCHEMA%\gracethddata_30_tables.sql
%GLSPLEX% %GLDBINTEG% < %FSQL%

ECHO GRACELITE - CREATION DE LA STRUCTURE GRACETHD-DATA : VALEURS OR
SET FSQL=%GLDBINTEGSCHEMA%\gracethddata_31_insert_or.sql
%GLSPLEX% %GLDBINTEG% < %FSQL%

ECHO GRACELITE - CREATION DE LA STRUCTURE GRACETHD-DATA : VALEURS RF
SET FSQL=%GLDBINTEGSCHEMA%\gracethddata_32_insert_rf.sql
%GLSPLEX% %GLDBINTEG% < %FSQL%

ECHO GRACELITE - CREATION DE LA STRUCTURE GRACETHD-DATA : VUES
SET FSQL=%GLDBINTEGSCHEMA%\gracethddata_60_views.sql
%GLSPLEX% %GLDBINTEG% < %FSQL%

GOTO:EOF

:END
ECHO GRACELITE - DEPLOIEMENT STRUCTURE GRACETHD-DATA TERMINE
PAUSE
