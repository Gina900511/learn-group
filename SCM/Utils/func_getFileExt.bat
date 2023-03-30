@ECHO OFF
REM Get File Extension

REM + Error Code
REM ------------------------------------
REM SET /a Err=1
REM SET /a Err=2

REM + Arguments
REM ------------------------------------
SET fileName=%1
SET mod_dbg=%2

REM + Check Arguments
REM ------------------------------------

ECHO.
ECHO @ Call func_getFileExt()
ECHO **********************************************************************

ECHO.
ECHO + Defined
ECHO ----------------------------------------------------------------------
ECHO void func_getFileExt(mod_dbg = default);

ECHO.
ECHO + Arguments
ECHO ----------------------------------------------------------------------
ECHO [FileName]: %fileName%


for /f "tokens=2 delims=." %%i in ("%fileName%") do (
    ECHO.
    ECHO + Result
    ECHO ----------------------------------------------------------------------
    ECHO [Ext]: %%i
    SET return=%%i
    goto :End
)
SET return=Folder

:End
ECHO.
ECHO ============================= [Func End] =============================
ECHO **********************************************************************
ECHO return %return%
ECHO.

Exit /b 0