@ECHO Off

SET lib_clr=%1
SET dir_lib=%2

REM Clear All
if "%lib_clr%" EQU "true" (
    SET library=
)

REM C++ Lib


SET return=%library%
