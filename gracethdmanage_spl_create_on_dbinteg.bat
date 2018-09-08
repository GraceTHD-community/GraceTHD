@ECHO OFF

REM gracethdmanage_spl_dbinteg_create.bat
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




:LAUNCH
CALL:CONFIG
CALL:BASE
CALL:SCHEMA
GOTO:END

:CONFIG
CALL config.bat
GOTO:EOF

:BASE
ECHO CREATION DE L'EXTENSION GRACETHD-MANAGE SUR LA BASE %GLDBINTEG%
PAUSE
REM ECHO SUPPRESSION BASE
REM IF EXIST %GLDBINTEG% DEL /s %GLDBINTEG%

%GLSPLEX% %GLDBINTEG% "PRAGMA foreign_keys = ON;"

GOTO:EOF


:SCHEMA
ECHO GRACETHD-MANAGE - CREATION DE LA STRUCTURE DE LA BASE DE DONNEES
ECHO GRACETHD-MANAGE - CREATION DES LISTES
SET FSQL=%GLDBINTEGSCHEMA%\gracethdmanage_10_lists.sql
%GLSPLEX% %GLDBINTEG% < %FSQL%
ECHO GRACETHD-MANAGE - INSERT VALEURS DANS LES LISTES
SET FSQL=%GLDBINTEGSCHEMA%\gracethdmanage_20_insert.sql
%GLSPLEX% %GLDBINTEG% < %FSQL%
ECHO GRACETHD-MANAGE - CREATION DES TABLES
SET FSQL=%GLDBINTEGSCHEMA%\gracethdmanage_30_tables.sql
%GLSPLEX% %GLDBINTEG% < %FSQL%
ECHO GRACETHD-MANAGE - CREATION DES TABLES
SET FSQL=%GLDBINTEGSCHEMA%\gracethdmanage_33_va_insert.sql
%GLSPLEX% %GLDBINTEG% < %FSQL%
REM ECHO GRACETHD-MANAGE - AJOUT DES CHAMPS GEOMETRIQUES
REM SET FSQL=%GLDBINTEGSCHEMA%\gracethdmanage_40_spatialite.sql
REM %GLSPLEX% %GLDBINTEG% < %FSQL%
ECHO GRACETHD-MANAGE - AJOUT DES INDEX
SET FSQL=%GLDBINTEGSCHEMA%\gracethdmanage_50_index.sql
%GLSPLEX% %GLDBINTEG% < %FSQL%
ECHO GRACETHD-MANAGE - AJOUT DES VUES INDICATEURS
SET FSQL=%GLDBINTEGSCHEMA%\gracethdmanage_65_views_indi.sql
%GLSPLEX% %GLDBINTEG% < %FSQL%
ECHO GRACETHD-MANAGE - AJOUT DES SPECIFICITES
SET FSQL=%GLDBINTEGSCHEMA%\gracethdmanage_90_labo.sql
%GLSPLEX% %GLDBINTEG% < %FSQL%


GOTO:EOF

:END
ECHO GRACETHD-MANAGE - TERMINE
PAUSE
