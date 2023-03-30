@ECHO Off

SET dir_lib=%1

REM Clear All
SET library=

REM Define:
REM SET library=%library% %dir_lib%\globalDef.hpp
REM ECHO [lib-build]: globalDef.hpp
REM SET library=%library% %dir_lib%\globalLib.hpp
REM ECHO [lib-build]: globalLib.hpp

REM Library:
REM SET library=%library% %dir_lib%\list.c
REM ECHO [lib-build]: list.c
REM SET library=%library% %dir_lib%\string.c
REM ECHO [lib-build]: string.c
REM SET library=%library% %dir_lib%\queue.c
REM ECHO [lib-build]: queue.c
REM SET library=%library% %dir_lib%\stack.c
REM ECHO [lib-build]: stack.c

REM Unit Test:
REM SET dir_unitTest=%~dp0..\..\unitTest
REM SET library=%library% %dir_unitTest%\xunit.c
REM ECHO [lib-build]: xunit.c


SET return=%library%
