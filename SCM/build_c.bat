@ECHO Off

SET dir_dev=%1
SET target=%2

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
    ECHO [Make File]: %dir_buildTo%
)


SET return=%dir_buildTo%

