@ECHO Off

ECHO.
ECHO ***********************************
ECHO          [Start To Build]         
ECHO ***********************************
ECHO.

ECHO * Check Arguments
ECHO -----------------------------------
SET str_dir_caller=%1
SET target=%2
SET tgt_name=%3

ECHO [Main-Program]: %target%

SET dir_caller=%str_dir_caller:~1,-2%
ECHO [Build-From]:   %dir_caller%

REM Project
SET dir_workspace=%~dp0..
SET dir_dev=%~dp0Develop

REM REM Build C
REM CALL %~dp0\For_c\build_c.bat %dir_dev% %target% %~dp0..\src\Lib_c %dir_caller%\%target% %tgt_name%
REM SET errCode=%return%

REM Build C++
CALL %~dp0\For_cpp\build_cpp.bat %dir_dev% %target% %~dp0..\src\Lib_cpp %dir_caller%\%target% %tgt_name%
SET errCode=%return%

if %errCode% EQU 0 (
    ECHO.
    ECHO ========= [Build Success] =========
    ECHO ***********************************
    ECHO.
) else (
    ECHO.
    ECHO =========  [Build Fail] ===========
    ECHO ***********************************
    ECHO.
    goto :End
)

ECHO .
ECHO .
ECHO .

:Start_Program
::**************************************
ECHO.
ECHO ***********************************
ECHO            Start Program           
ECHO ***********************************

ECHO.
ECHO 1. Arguments
ECHO -----------------------------------
ECHO - Null
ECHO - NUll

ECHO.
ECHO 2. Main Program [%target%] Log
ECHO -----------------------------------
ECHO.
%tgt_name%.exe

ECHO.
ECHO.
ECHO 3. Program Return
ECHO -----------------------------------
SET errCode=%ERRORLEVEL%
ECHO return %errCode%

ECHO.
ECHO ============= [Stop] ==============
ECHO ***********************************

if %errCode% EQU 0 (
    ECHO "[ ----------- Done ------------ ]"
    ECHO.
    goto :End
) else if %errCode% EQU -1073741819 (
    ECHO.
    ECHO "[ ----------- Error ----------- ]"
    ECHO "|> Return Code (-1073741819)"
    ECHO "|> [Info]: Type Incompatible !!! "
    ECHO "[ ----------- ***** ----------- ]"
    ECHO.
    goto :End
) else (
    ECHO.
    ECHO "[ ----------- Error ----------- ]"
    ECHO "|> Return Code (%errCode%)"
    ECHO "|> [Info]: Unknown ... "
    ECHO "[ ----------- ***** ----------- ]"
    ECHO.
    goto :End
)

:End
::**************************************
ECHO * End of run ...
ECHO.
