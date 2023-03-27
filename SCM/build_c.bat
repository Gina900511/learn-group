@ECHO Off

REM Arguments
REM ------------------------------------
REM For Fixed Position For Build-To
SET dir_dev=%1
SET target=%2

REM For Lib
SET dir_lib=%3

REM For gcc
SET dir_caller=%4
SET fname_caller=%5


REM - Fixed Position
REM ------------------------------------

REM Clear All
SET dir_buildTo=
SET buildTo=

REM Select Build Target

REM Debug
if %target%==debug.c (
    SET buildTo=debug

REM Release
) else if %target%==main.c (
    SET buildTo=release

REM Program
) else if %target%==program.c (
    SET buildTo=demo

REM Main
) else if %target%==main.c (
    SET buildTo=debug
) 

SET dir_buildTo=%dir_dev%\%buildTo%

REM Make File
if Not exist %dir_buildTo% (
    MD %dir_buildTo%
    ECHO [Make File]:*** %dir_buildTo% ***
)

ECHO [Build-To]:     %dir_buildTo%


ECHO.
ECHO * Linked library
ECHO -----------------------------------
CALL %~dp0env_lib_c.bat %dir_lib%
SET dependence=%return%


REM - Compile
REM ------------------------------------
ECHO.
ECHO Building ...
CD %dir_buildTo%
gcc %dir_caller% %dependence% -o %fname_caller%


SET return=%ERRORLEVEL%
