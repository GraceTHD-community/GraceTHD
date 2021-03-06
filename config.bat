@ECHO OFF

REM ##################################################
REM ### APPELS DES FICHIERS DE CONFIG GRACETHD-CHECK
REM ##################################################

REM # GLCONF : Dossier qui accueille les fichiers de configuration. 
SET GLCONF=.\conf


:GL_CONFIG_DEBUG
REM ##################################################
REM ### CONFIG GRACETHD-CHECK - DEBOGAGE

REM Pour ne pas appliquer de pauses
SET GLPAUSE=
REM Pour appliquer des pauses et visualiser l'affichage
REM SET GLPAUSE=PAUSE


:GL_CALLCONF
REM FICHIER DE CONFIGURATION DE L'ARBORESCENCE
SET GLCF=%GLCONF%\config_tree.bat
IF NOT EXIST "%GLCF%" (
ECHO GRACETHD-CHECK - %GLCF% n'existe pas !
PAUSE
) ELSE CALL "%GLCF%"

REM FICHIER DE CONFIGURATION DES CHEMINS VERS LES APPLICATIONS
SET GLCF=%GLCONF%\config_apps.bat
IF NOT EXIST "%GLCF%" (
ECHO GRACETHD-CHECK - %GLCF% n'existe pas !
PAUSE
) ELSE CALL "%GLCF%"

REM FICHIER DE CONFIGURATION DES BASES SHP/CSV
SET GLCF=%GLCONF%\config_db_shpcsv.bat
IF NOT EXIST "%GLCF%" (
ECHO GRACETHD-CHECK - %GLCF% n'existe pas !
PAUSE
) ELSE CALL "%GLCF%"

REM FICHIER DE CONFIGURATION DES BASES SPATIALITE
SET GLCF=%GLCONF%\config_db_spl.bat
IF NOT EXIST "%GLCF%" (
ECHO GRACETHD-CHECK - %GLCF% n'existe pas !
PAUSE
) ELSE CALL "%GLCF%"

REM FICHIER DE CONFIGURATION DES BASES POSTGIS
SET GLCF=%GLCONF%\config_db_pg.bat
IF NOT EXIST "%GLCF%" (
ECHO GRACETHD-CHECK - %GLCF% n'existe pas !
PAUSE
) ELSE CALL "%GLCF%"

REM FICHIER DE CONFIGURATION DES FICHIERS GRACETHD-LAYERS
SET GLCF=%GLCONF%\config_layers.bat
IF NOT EXIST "%GLCF%" (
ECHO GRACETHD-CHECK - %GLCF% n'existe pas !
PAUSE
) ELSE CALL "%GLCF%"


:GL_CONFIG_TEST
REM FICHIER DE CONFIGURATION DES BASES POSTGIS
SET GLCF=config_test.bat
IF NOT EXIST "%GLCF%" (
ECHO GRACETHD-CHECK - %GLCF% n'existe pas !
PAUSE
) ELSE CALL "%GLCF%"

