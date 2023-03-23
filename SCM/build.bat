@ECHO Off

ECHO.
ECHO ***********************************
ECHO          [Start To Build]         
ECHO ***********************************
ECHO.

ECHO 1. Check Arguments
ECHO -----------------------------------
SET dir_caller=%1
SET target=%2
SET tgt_name=%3
ECHO [Main-Program]: "%target%"
ECHO [Build-From]:   %dir_caller%

REM Project
SET dir_workspace=%~dp0..
SET dir_dev=%~dp0Develop
REM Make File
if Not exist %dir_dev% (
    MD %dir_dev%
    ECHO [Make File] ">>>>" Develop
)


REM ====================================
SET demo=program.c
SET main=main.c
REM Target: Main-Program
SET dir_demo=%~dp0..\demo
SET dir_main=%~dp0..\src
REM Select Build Target
if %target%==%demo% (
    SET tgt_build=%dir_demo%\%demo%
) else if %target%==%main% (
    SET tgt_build=%dir_main%\%main%
)
ECHO [Build-To]:     "%tgt_build%"

REM Target: Library
ECHO.
ECHO 2. Build library
ECHO -----------------------------------
SET dir_lib=%~dp0..\src
SET library=
SET library=%library% %dir_lib%\list.c
ECHO [lib-build]: list.c
SET library=%library% %dir_lib%\string.c
ECHO [lib-build]: string.c
SET library=%library% %dir_lib%\queue.c
ECHO [lib-build]: queue.c
SET library=%library% %dir_lib%\stack.c
ECHO [lib-build]: stack.c

SET library=%library% %dir_lib%\globalDef.hpp
ECHO [lib-build]: globalDef.hpp
SET library=%library% %dir_lib%\globalLib.hpp
ECHO [lib-build]: globalLib.hpp

SET dir_unitTest=%~dp0..\unitTest
SET library=%library% %dir_unitTest%\xunit.c
ECHO [lib-build]: xunit.c

REM Develop of Project
if %target%==%demo% (
    SET build=demo
) else if %target%==%main% (
    SET build=debug
)

REM Make File
if Not exist %dir_dev%\%build% (
    MD %dir_dev%\%build%
    ECHO [Make File]: %dir_dev%\%build%
)

CD %dir_dev%\%build%

REM Compile
ECHO.
ECHO Building ...
gcc %tgt_build% %library% -o %tgt_name%
SET errCode=%ERRORLEVEL%
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
