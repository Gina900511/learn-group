@ECHO OFF

REM + 組態設定: 透過配置檔設定組態
REM + CM: Configuration Manager
REM ------------------------------------
CALL %~dp0../Utils/func_iniReader.bat Build CM
if %ERRORLEVEL% NEQ 0 ( Exit /b 10 )
if "%return%" NEQ "" ( SET CM=%return% ) else ( SET CM=temp )


REM + Arguments
REM ------------------------------------
REM For Fixed Position For Build-To
SET dir_buildTo=%1\dev_c\%CM%
SET target=%2

REM For Lib
SET dir_src=%3

REM For gcc
SET dir_caller=%4
SET fname_caller=%5


REM + 
REM ------------------------------------
SET dir_lib=%dir_src%\Lib_c


REM Make File
if Not exist %dir_buildTo% (
    MD %dir_buildTo%
    ECHO [Make File]:*** %dir_buildTo% ***
)

ECHO [Build-To]:     %dir_buildTo%


ECHO.
ECHO * Linked library
ECHO -----------------------------------
CALL %~dp0env_lib_c.bat true %dir_lib%
SET dependence=%return%


REM - Compile
REM ------------------------------------
ECHO.
ECHO Building ...
CD %dir_buildTo%
gcc %dir_caller% %dependence% -o %fname_caller%


SET return=%ERRORLEVEL%

:End
