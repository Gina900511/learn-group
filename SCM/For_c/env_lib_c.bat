@ECHO Off

SET dir_lib=%1

REM Clear All
SET library=

REM Define:
SET library=%library% %dir_lib%\globalDef.hpp
ECHO [lib-build]: globalDef.hpp
SET library=%library% %dir_lib%\globalLib.hpp
ECHO [lib-build]: globalLib.hpp

REM Library:
SET library=%library% %dir_lib%\list.c
ECHO [lib-build]: list.c
SET library=%library% %dir_lib%\string.c
ECHO [lib-build]: string.c
SET library=%library% %dir_lib%\queue.c
ECHO [lib-build]: queue.c
SET library=%library% %dir_lib%\stack.c
ECHO [lib-build]: stack.c

REM Unit Test:
SET dir_unitTest=%~dp0..\..\unitTest
SET library=%library% %dir_unitTest%\xunit.c
ECHO [lib-build]: xunit.c


SET return=%library%
